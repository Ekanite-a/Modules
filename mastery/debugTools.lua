-- dump --
local dumper = {}
function dumper:_table(value, settings, opDepth, opVisited)
    local depth = opDepth or 1
    local visited = opVisited or {}

    local cut = settings.MaxLen

    if depth == 6 then return "<max depth exceed>" end
    if visited[value] then return "<circular>" end

    if type(value) == "table" then
        visited[value] = true
    else
        local p = type(value) == "string" and '"' or ""
        local elem = `{p}{tostring(value):gsub("%z", "\\0")}{p}`
        if settings.ShowType then elem = `{typeof(value)}: {elem}` end

        return elem
    end

    local dumped = "{"
    for i, v in next, value do
        local indent = string.rep("    ", depth)
        local key = typeof(i) == "number" and `[{tostring(i):sub(1, cut)}]` or tostring(i):sub(1, cut)
        local val = self:_table(v, settings, depth + 1, visited)
        local current = `{indent}{key} = {val},`

        dumped = `{dumped}\n{current}`
    end
    local indent = string.rep("    ", depth - 1)
    if dumped ~= "{" then dumped = `{dumped}\n`
    else indent = ""
    end
    dumped = `{dumped}{indent}}`

    if getmetatable(value) then
        local metaDumped = "{"
        for i, v in next, getmetatable(value) do
            local indent = string.rep("    ", depth)
            local key = typeof(i) == "number" and `[{tostring(i):sub(1, cut)}]` or tostring(i):sub(1, cut)
            local val = self:_table(v, settings, depth + 1, visited)
            local current = `{indent}{key} = {val},`

            metaDumped = `{metaDumped}\n{current}`
        end
        if metaDumped ~= "{" then metaDumped = `{metaDumped}\n` end

        local indent = string.rep("    ", depth - 1)
        dumped = `setmetatable({dumped}, {metaDumped}{indent}})`
    end

    visited[value] = nil
    return dumped
end
function dumper:_instance(instance, settings, opDepth)
    local depth = opDepth or 0
    local elem = ""
    if settings.ShowType then elem = `{instance.ClassName}: ` end

    local dumped = `{string.rep("    ", depth)}{elem}{instance.Name}`

    if depth > 0 then dumped = `\n{dumped}` end
    for _, v in instance:GetChildren() do
        dumped = `{dumped}{self:_instance(v, settings, depth + 1)}`
    end

    return dumped
end
function dumper:Dump(item, opSettings)
    local settings = opSettings or {ShowType = true, MaxLen = 25}

    if typeof(item) == "table" then return self:_table(item, settings) end
    if typeof(item) == "Instance" then return self:_instance(item, settings) end

    return tostring(item)
end


-- find --
local finder = {}
finder._cache = {
    game = game,
    workspace = workspace or game:GetService("Workspace"),
}
finder._alias = setmetatable({
    ["UserInputService"] = "UIS",
    ["ReplicatedStorage"] = "RS",
}, {__index = function(self, key) return key end})
function finder._createSafeProxy(object)
    return setmetatable({}, {
        __index = function(self, key)
            if object ~= nil then
                local suc, result = pcall(function() return object[key] end)
                if suc then return self._createSafeProxy(result) end
            end
            return finder._createSafeProxy(nil)
        end,
        __call = function(self, ...)
            if object ~= nil then return object end
            return ...
        end
    })
end
function finder:Register(ctx, alias)
    if ctx == game:GetService("Players").LocalPlayer then
        self._cache["player"] = ctx
        return ctx
    end
    if self._cache[ctx.Name] then return ctx end

    self._cache[ctx.Name] = ctx
    self._cache[self._alias[ctx.Name]] = ctx

    if alias and self._cache[alias] and ctx ~= self._cache[alias] then
        error(`alias {alias} already exists: ({self._cache[alias]})`)
    end
    if alias and type(alias) == "string" then
        self._cache[alias] = ctx
    end
    return ctx
end
function finder:Destroy()
    table.clear(self._cache)
end
function finder:Find(path, opSettings)
    local settings = opSettings or {}
    local iter = path:gmatch("[^%.]+")

    local raw_result = settings.Origin or self._cache[iter()]
    local wrap_result = settings.SafeNavigation and self._createSafeProxy(nil)
    if not raw_result then return wrap_result end

    for v in iter do
        if settings.Wait then raw_result = raw_result:WaitForChild(v, settings.Wait)
        else raw_result = raw_result:FindFirstChild(v) end

        if not raw_result then
            if settings.Fallback then return settings.Fallback() end
            return wrap_result
        end
    end

    if settings.OnFound then return settings.OnFound(raw_result) end
    if wrap_result then return self._createSafeProxy(raw_result) end

    return raw_result
end
function finder:Check(path)
    local iter = path:gmatch("[^%.]+")
    local result = self._cache[iter()]

    local suc
    for v in iter do
        suc, result = pcall(function() return result[v] end)
        if not suc or result == nil then return false end
    end

    return true
end



-- sender --
local sender = {_currentChannel = nil}
sender._channels = {}
function sender:AddChannel(name, url)
    if self._channels[name] then error(`{name} already exists`) end

    self._channels[name] = url
end
function sender:ChangeChannel(name)
    if not self._channels[name] then error(`{name} doesn't exists`) end

    self._currentChannel = self._channels[name]
end
function sender.Send(ctx)
    ctx = {content = tostring(ctx)}

    request({
        Url = sender._currentChannel,
        Method = "POST",
        Headers = {["Content-Type"] = "application/json"},
        Body = game:GetService("HttpService"):JSONEncode(ctx)
    })
end


-- loadUrl --
local function loadurl(url)
    math.randomseed(time())
    local cachebust = `{math.random(-1000, 1000)}{time()}`
    url = `{url}/?cachebust={cachebust}`

    local body
    if request then body = loadstring(request({Url = url}).Body)
    else body = loadstring(game:HttpGet(url))
    end

    return body and body()
end


-- conns --
local conns = {list = {}}
function conns:init(id, event, func)
    self.list[id] = event:Connect(func)
end
function conns:destroy()
    for i, v in next, self.list do v:Disconnect() end

    table.clear(self)
    conns = nil
end


-- args --
local function AutoArgsWrap(func, settings)
    return function(...)
        local originArgs = {...}
        local kwIndex = settings.Index or 1
        local kwargsTemplate = settings.Template

        local args = originArgs[kwIndex]
        if not args then return func() end
        local kwargs = {}

        for i, k in ipairs(kwargsTemplate) do
            kwargs[k] = args[i]
        end

        for k, v in pairs(args) do
            if typeof(k) == "string" then
                kwargs[k] = v
            end
        end

        originArgs[kwIndex] = kwargs
        return func(unpack(originArgs))
    end
end
local function CheckArgs(kwarg, template)
    for key, _ in kwarg do
        if not table.find(template, key) then
            local wkey = type(key) == "string" and `"{key}"` or key
            error(`Unexpected keyworkd: {wkey}`)
        end
    end
end


-- clone --
local function deepcopy(item)
    if type(item) == "table" then
        local tmp = {}
        for i, v in item do
            tmp[i] = deepcopy(v)
        end
        local mt = getmetatable(item)

        return setmetatable(tmp, mt)
    end

    return item
end


-- instance --
local function initialInstance(settings)
    local instance = Instance.new(settings.Instance)

    if settings.Settings then
        for k, v in next, settings.Settings do
            instance[k] = v
        end
    end

    instance.Parent = settings.Parent
    return instance
end


-- log --
local function initialLog(len)
    local log = {
        len = len,
        first = 0,
        count = 0,
        data = table.create(10, ""),
    }
    function log:Add(...)
        local args = {...}
        for i, v in next, args do args[i] = tostring(v) end

        local message = table.concat(args, ' ')
        self.first = (self.first % len) + 1
        self.data[self.first] = message

        self.count = self.count + 1
    end
    function log:Get()
        local logs = {tostring(self.count)}
        for i = 1, 10 do
            local curLog = self.data[((self.first - i) % self.len) + 1]

            if curLog == "" then continue end
            table.insert(logs, curLog)
        end

        return table.concat(logs, '\n')
    end

    return log
end


-- proxy --
local function createProxy(realTable, opName, opSettings)
    local name = opName or ""
    local settings = opSettings or {}
    local proxy = {}

    local writeLog = settings.WriteLog

    local mt = {
        __index = function(self, key)
            local path
            if type(key) == "number" then
                path = name .. '[' .. tostring(key) .. ']'
            else
                path = name .. '.' .. tostring(key)
            end
            local realValue = realTable[key]

            if type(realValue) == "table" then
                return createProxy(realValue, path)
            elseif type(realValue) == "function" then
                return function(...)
                    writeLog("CALL START", path)
                    local results = table.pack(realValue(...))
                    writeLog("CALL END", path)

                    return table.unpack(results, 1, results.n)
                end
            end

            if not path:match("Task") and path ~= "GloveSettings.Killing" then
                writeLog("READ", path, " Result:", realValue)
            end
            return realValue
        end,

        __newindex = function(self, key, value)
            local path
            if type(key) == "number" then
                path = name .. '[' .. tostring(key) .. ']'
            else
                path = name .. '.' .. tostring(key)
            end

            writeLog("ASSIGN", path, "Value: ", value)
            realTable[key] = value
        end,

        __iter = function(self)
            writeLog("ITERATION", name)

            local function luau_next(tbl, k)
                local nextKey, nextVal = next(realTable, k)
                if nextVal ~= nil then
                    if type(nextVal) == "table" then
                        nextVal = createProxy(nextVal, name .. '.' .. tostring(nextKey))
                    end
                end
                return nextKey, nextVal
            end

            return luau_next, self, nil
        end,
    }

    return setmetatable(proxy, mt)
end


return {
    finder = finder,
    find = function(...) return finder:Find(...) end,
    dumper = dumper,
    dump = function(...) return dumper:Dump(...) end,
    sender = sender,
    AutoArgsWrap = AutoArgsWrap,
    CheckArgs = CheckArgs,
    deepcopy = deepcopy,
    initialInstance = initialInstance,
    initialLog = initialLog,
}