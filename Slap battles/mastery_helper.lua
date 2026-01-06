local tab = setmetatable({
    [1] = {
        Name = "Obby",
        SlapEvent = "GeneralHit",
        icon = {"blueprint"},
        help = true,
        supported_gloves = {
            recipient = {
                [2] = {
                    "Replica",
                },
            },
            helper = {
                [1] = {
                    "Null",
                    "Replica",
                    "Cherry",
                },
                [2] = {
                    "Replica",
                },
            },
        },
        prior_task = {
            2,
            1,
        },
    },
    [2] = {
        Name = "Cloud",
        icon = {"cloud-x"},
        help = true,
    },
    [3] = {
        Name = "Brick",
        icon = {"lego"},
        help = true,
        HelperPosOffset = Vector3.new(2, -10, -4),
    },
    [4] = {
        Name = "Wormhole",
        SlapEvent = "WormHit",
        icon = {"aperture"},
        help = true,
        supported_gloves = {
            recipient = {
                [1] = {
                    "Null",
                },
            },
            helper = {
                [1] = {
                    "Null",
                    "Replica",
                },
            },
        },
        prior_task = {
            1,
        },
    },
    [5] = {
        Name = "Killstreak",
        SlapEvent = "KSHit",
        icon = {"pentagram"},
        help = true,
    },
    [6] = {
        Name = "Ultra Instinct",
        SlapEvent = "GeneralHit",
        icon = {"sunglasses"},
        help = true,
        supported_gloves = {
            helper = {
                [1] = {
                    "Default",
                },
            },
        },
        prior_task = {
            1,
        },
    },
    [7] = {
        Name = "Run",
        icon = {"skull"},
        help = true,
        HelperPosOffset = Vector3.new(0, 5, -10),
        supported_gloves = {
            helper = {
                [2] = {
                    "L.O.L.B.O.M.B",
                },
            },
        },
        prior_task = {
            2,
        },
    },
    [8] = {
        Name = "Glovel",
        SlapEvent = "GeneralHit",
        icon = {"shovel"},
        help = true,
        supported_gloves = {
            helper = {
                [2] = {
                    "Replica",
                    "Cherry",
                    -- "Pillow",
                },
            },
        },
        prior_task = {
            2,
        },
    },
    [9] = {
        Name = "bus",
        SlapEvent = "hitbus",
        icon = {"bus"},
        help = true,
        -- HelperPosOffset = Vector3.new(10, 0, 0),
        supported_gloves = {
            helper = {
                [1] = {
                    "Null",
                    "Cherry",
                },
            },
        },
        prior_task = {
            1,
        },
    },
    [10] = {
        Name = "[REDACTED]",
        icon = {"eye-slash"},
    },
    [11] = {
        Name = "🗿",
        SlapEvent = "GeneralHit",
        icon = {"diamond"},
        help = true,
        supported_gloves = {
            helper = {
                [3] = {
                    "Null",
                },
            },
        },
        prior_task = {
            3,
        },
    },
    [12] = {
        Name = "Bomb",
        icon = {"bomb"},
    },
    [13] = {
        Name = "rob",
        icon = {"user-circle"},
        help = true,
        HelperPosOffset = Vector3.new(0, 0, -5),
        supported_gloves = {
            helper = {
                [1] = {
                    "Cherry",
                },
            },
        },
        prior_task = {
            1,
        },
    },
    [14] = {
        Name = "spin",
        icon = {"arrows-clockwise"},
    },
    [15] = {
        Name = "Fort",
        icon = {"wall"},
    },
    [16] = {
        Name = "Engineer",
        icon = {"hammer"},
        help = true,
        supported_gloves = {
            recipient = {
                [1] = {
                    "Null",
                },
                [2] = {
                    "Null",
                }
            },
            helper = {
                [1] = {
                    "Replica",
                    "Null",
                },
                [2] = {
                    "Null",
                },
            },
        },
        prior_task = {
            2,
            1,
        },
    },
    [17] = {
        Name = "Flash",
        SlapEvent = "FlashHit",
        icon = {"lightning"},
        help = true,
    },
    [18] = {
        Name = "Booster",
        SlapEvent = "GeneralHit",
        icon = {"rocket-launch"},
        help = true,
        supported_gloves = {
            helper = {
                [1] = {
                    "Replica",
                    -- "Pillow",
                },
            },
        },
        prior_task = {
            1,
        },
    },
    [19] = {
        Name = "Space",
        SlapEvent = "HtSpace",
        icon = {"planet"},
        help = true,
    },
    [20] = {
        Name = "Shard",
        SlapEvent = "ShardHIT",
        icon = {"currency-eth"},
        help = true,
        HelperPosOffset = Vector3.new(0, 0, -160),
    },
    [21] = {
        Name = "Phase",
        SlapEvent = "PhaseH",
        icon = {"heart"},
        help = true,
        supported_gloves = {
            helper = {
                [1] = {
                    "Null",
                    "Replica",
                    "Cherry",
                    -- "Pillow",
                },
            },
        },
        prior_task = {
            1,
        },
    },
    [22] = {
        Name = "Tycoon",
        SlapEvent = "GeneralHit",
        icon = {"currency-circle-dollar"},
        help = true,
        --[[supported_gloves = {
            helper = {
            "Null",
            "Replica",
            "Cherry",
            "Pillow"
            }
        },
        prior_task = {
            helper = {
                
            },
        },]]
    },
    [23] = {
        Name = "Hive",
        SlapEvent = "GeneralHit",
        icon = {"hive", "Symbols"},
        help = true,
    },
    [24] = {
        Name = "Defense",
        SlapEvent = "DefenseHit",
        icon = {"shield"},
        help = true,
    },
    [25] = {
        Name = "Car Keys",
        icon = {"car-profile"},
        help = true,
        HelperPosOffset = Vector3.new(0, 0, -25),
    },
    [26] = {
        Name = "Voodoo",
        SlapEvent = "GeneralHit",
        icon = {"person-simple-circle"},
        help = true,
    },
    [27] = {
        Name = "Cherry",
        icon = {"cherries"},
        help = true,
        supported_gloves = {
            -- helper = {
            --     [1] = {
            --         "Null",
            --     },
            -- },
        },
        prior_task = {
            1,
        },
    },
    [28] = {
        Name = "Stick",
        SlapEvent = "GeneralHit",
        icon = {"needle"},
        help = true,
        supported_gloves = {
            recipient = {
                [1] = {
                    "Null",
                },
            },
            helper = {
                [1] = {
                    "Null",
                    "Replica",
                },
            },
        },
        prior_task = {
            1,
        },
    },
    [29] = {
        Name = "BONK",
        SlapEvent = "GeneralHit",
        icon = {"gavel"},
        help = true,
    },
    [30] = {
        Name = "Moon",
        SlapEvent = "CelestialHit",
        icon = {"moon"},
        help = true,
        supported_gloves = {
            helper = {
                [1] = {
                    "Replica",
                    "Null",
                },
            },
        },
        prior_task = {
            1,
        },
    },
    [31] = {
        Name = "Stalker",
        SlapEvent = "GeneralHit",
        icon = {"detective"},
        help = true,
    },
    [32] = {
        Name = "Rage",
        SlapEvent = "GRRRR",
        icon = {"smiley-angry"},
        help = true,
        supported_gloves = {
            recipient = {
                [3] = {
                    "Null",
                },
                [4] = {
                    "Null",
                },
            },
            helper = {
                [3] = {
                    "Replica",
                    "Null",
                },
                [4] = {
                    "Replica",
                    "Null",
                },
            },
        },
        prior_task = {
            3,
            4,
        },
    },
    [33] = {
        Name = "Tinkerer",
        SlapEvent = "TinkererHit",
        icon = {"robot"},
        help = true,
        HelperPosOffset = Vector3.new(0, -10, -6),
    },
    [34] = {
        Name = "Plank",
        SlapEvent = "GeneralHit",
        icon = {"rectangle"},
        help = true,
    },
    GetSupportedGloves = function(self, glove)
        local gloves = {
            helper = {},
            recipient = {},
        }
        if not self[glove].supported_gloves then
            return gloves
        end

        if self[glove].supported_gloves.recipient then
            for i = 1, 7 do
                if self[glove].supported_gloves.recipient[i] then
                    table.insert(
                        gloves.recipient,
                        self[glove].supported_gloves.recipient[i]
                    )
                end
            end
        end
        
        if self[glove].prior_task then
            for i, v in ipairs(self[glove].prior_task) do
                table.insert(
                    gloves.helper,
                    self[glove].supported_gloves.helper[v]
                )
            end
        end

        return gloves
    end,
}, {
    __index = function(t, val)
        for i, v in ipairs(t) do
            if v.Name == val then
                return v
            end
        end
    end
})

for i, v in ipairs(tab) do
    if not v.HelperPosOffset then
        v.HelperPosOffset = Vector3.new(0, 0, -10)
    end
end

return tab
