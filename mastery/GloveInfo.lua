local RS = game:GetService("ReplicatedStorage")

local function AutoArgsWrap(func, settings)
    return function(...)
        local kwIndex = settings.index or 1
        local kwargsTemplate = settings.template

        local args = select(kwIndex, ...)
        local kwargs = {}

        for i, k in ipairs(kwargsTemplate) do
            kwargs[k] = args[i]
        end

        for k, v in pairs(args) do
            if typeof(k) == "string" then
                kwargs[k] = v
            end
        end

        return func(kwargs)
    end
end

local function createInfo(settings)
    local t = {}
    t.Name = settings.Name
    t.RequireHelper = settings.RequireHelper and true or false

    if settings.SlapRemote then
        t.SlapRemote = RS:FindFirstChild(settings.SlapRemote)
    end

    if settings.AbilityRemote then
        t.AbilityRemote = {}

        for i, v in settings.AbilityRemote do
            t.AbilityRemote[i] = RS:FindFirstChild(v, true)
        end
    end

    local helperOffset = settings.HelperOffset or {0, 0, -10}
    t.HelperOffset = Vector3.new(unpack(helperOffset))

    return t
end
createInfo = AutoArgsWrap(createInfo, {template = {"Name", "RequireHelper", "SlapRemote", "AbilityRemote", "HelperOffset"}})

local raw_data = {
    {"Obby", true, "GeneralHit", {"GeneralAbility"}},
    {"Cloud", true},
    {"Brick", true, AbilityRemote = {"lbrick"}, HelperOffset = {2, -10, -4}},
    {"Wormhole", true, "WormHit", {"WormholePlace", "WormholeTP"}},
    {"Killstreak", true, "KSHit"},
    {"Ultra Instinct", true, "GeneralHit"},
    {"Run", true, AbilityRemote = {"GeneralAbility"}, HelperOffset = {0, 5, -10}},
    {"Glovel", true, "GeneralHit", {"GlovelFunc"}},
    {"bus", true, "hitbus", {"busmoment"}},
    {"[REDACTED]", false, AbilityRemote = {"Well", "WellCapture"}},
    {"🗿", true, "GeneralHit", {"GeneralAbility"}},
    {"Bomb", false, AbilityRemote = {"BombThrow"}},
    {"rob", true, AbilityRemote = {"rob"}, HelperOffset = {0, 0, -5}},
    {"spin", false},
    {"Fort", false, AbilityRemote = {"Fortlol"}},
    {"Engineer", true, AbilityRemote = {"Sentry"}},
    {"Flash", true, "FlashHit", {"FlashTeleport"}},
    {"Booster", true, "GeneralHit"},
    {"Space", true, "HtSpace", {"ZeroGSound"}},
    {"Shard", true, "ShardHIT", {"Shards"}, {0, 0, -160}},
    {"Phase", true, "PhaseH", {"PhaseA"}},
    {"Tycoon", true, "GeneralHit", {"GeneralAbility"}},
    {"Hive", true, "GeneralHit", {"GeneralAbility"}},
    {"Defense", true, "DefenseHit", {"Barrier"}},
    {"Car Keys", true, HelperOffset = {0, 0, -25}},
    {"Voodoo", true, "GeneralHit", {"GeneralAbility"}},
    {"Cherry", true, AbilityRemote = {"GeneralAbility"}},
    {"Stick", true, "GeneralHit"},
    {"BONK", true, "GeneralHit", {"BONK"}},
    {"Moon", true, "CelestialHit"},
    {"Stalker", true, "GeneralHit"},
    {"Rage", true, "GRRRR", {"GRRRRR"}},
    {"Tinkerer", true, "TinkererHit", {"GeneralAbility"}, {0, -10, -6}},
    {"Plank", true, "GeneralHit", {"GeneralAbility"}},
    {"Bubble", true, "BubbleHit", {"BubbleThrow"}, {0, 0, -15}},
    {"Phantom", true, "PhantomHit", {"PhantomDash"}},
    {"Acrobat", true, "AcHit"},
    {"Spring", true, "springhit", HelperOffset = {0, 0, -1}},
    {"Soul", true, "GeneralHit", {"GeneralAbility", "soul"}},
    {"Thanos", true, "GeneralHit", {"GeneralAbility"}},
    {"Eggler", true, "GeneralHit", {"GeneralAbility", "EgglerRAbility"}, {0, 0, -5}},
    {"Hexa", true, "GeneralHit", {"GeneralAbility"}},
    {"Frostbite", true, "GeneralHit", {"GeneralAbility"}, {0, -5, 0}},
    {"Mace", true, "GeneralHit"},
    {"Dice", true, "DiceHit"},
    {"Gummy", true, "GeneralHit"},
    {"Firework", true, "GeneralHit", {"GeneralAbility"}, {0, 0, -20}},
    {"Pinwheel", true, "GeneralHit", {"GeneralAbility"}},
}


local tmp = {}
for i, v in ipairs(raw_data) do
    tmp[i] = createInfo(v)
end

local GloveInfo = setmetatable(tmp, {
    __index = function(self, key)
        for i = 1, #tmp do
            if tmp[i].Name == key then
                return tmp[i]
            end
        end
    end,
})


return GloveInfo