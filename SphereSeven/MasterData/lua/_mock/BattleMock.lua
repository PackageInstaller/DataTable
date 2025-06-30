local BattleMock = BaseClass("BattleMock", Singleton);

local UNIT_IDS = {0,1001,1003,0,0,0}
local function CreateUnit()
    local unit = {
        ["fight_soul"] = {
            ["id"] = 0,
            ["merge_level"] = 0,
            ["level"] = 0,
        },
        ["skin"] = 0,
        ["equipments"] = {
        },
        ["character_id"] = 0,
        ["star"] = 1,
        ["skills"] = {
            ["ultimate"] = 0,
            ["skill"] = 0,
            ["attack"] = 0,
            ["passive_skill"] = 0,
        },
        ["level"] = 1,
        ["formation_postion"] = 2,
        ["intimacy"] = 0,
        ["constellation"] = 0,
        ["bead"] = 0,
    }
    return unit
end

local units = {}
for i, id in ipairs(UNIT_IDS) do
    if id ~= 0 then
        local unit = CreateUnit()
        unit["skin"] = id * 100 + 1
        unit["character_id"] = id
        unit["skills"]["ultimate"] = id * 10 + 3
        unit["skills"]["skill"] = id * 10 + 2
        unit["skills"]["attack"] = id * 10 + 1
        unit["formation_postion"] = i
        table.insert(units, unit)
    end
end

---@param reqMsg protocol.BattleStartReq
local function BattleStartReq(reqMsg)
    local rspMsg
    if reqMsg.level_type ~= LevelType.LevelTypeArena then
        -- 非竞技场
        rspMsg = 
        {
            ["seed"] = 1705550131,
            ["level_type"] = reqMsg.level_type,
            ["level_id"] = reqMsg.level_id,
            ["battle_id"] = 1705550131,
            ["teams"] = {
                [1] = {
                    ["side"] = 1,
                    ["formation"] = {
                        ["encyclopedia_enhance"] = {
                            ["def_enhance"] = 261,
                            ["hp_enhance"] = 166,
                            ["atk_enhance"] = 131,
                            ["speed_enhance"] = 176,
                            ["mdef_enhance"] = 226,
                        },
                        ["units"] = units,
                    },
                },
            },             
        }
    else
        -- 竞技场
        rspMsg = 
        {
            ["seed"] = 1705550131,
            ["level_type"] = reqMsg.level_type,
            ["level_id"] = reqMsg.level_id,
            ["battle_id"] = 1705550131,
            ["teams"] = {
                [1] = {
                    ["side"] = 1,
                    ["formation"] = {
                        ["encyclopedia_enhance"] = {
                            ["def_enhance"] = 261,
                            ["hp_enhance"] = 166,
                            ["atk_enhance"] = 131,
                            ["speed_enhance"] = 176,
                            ["mdef_enhance"] = 226,
                        },
                        ["units"] = {
                            [1] = {
                                ["fight_soul"] = {
                                    ["id"] = 0,
                                    ["merge_level"] = 0,
                                    ["level"] = 0,
                                },
                                ["skin"] = 100101,
                                ["equipments"] = {
                                },
                                ["character_id"] = 1001,
                                ["star"] = 1,
                                ["skills"] = {
                                    ["ultimate"] = 10013,
                                    ["skill"] = 10012,
                                    ["attack"] = 10011,
                                    ["passive_skill"] = 0,
                                },
                                ["level"] = 1,
                                ["formation_postion"] = 2,
                                ["intimacy"] = 0,
                                ["constellation"] = 0,
                                ["bead"] = 0,
                            },
                            [2] = {
                                ["fight_soul"] = {
                                    ["id"] = 0,
                                    ["merge_level"] = 0,
                                    ["level"] = 0,
                                },
                                ["skin"] = 100201,
                                ["equipments"] = {
                                },
                                ["character_id"] = 1002,
                                ["star"] = 1,
                                ["skills"] = {
                                    ["ultimate"] = 10023,
                                    ["skill"] = 10022,
                                    ["attack"] = 10021,
                                    ["passive_skill"] = 0,
                                },
                                ["level"] = 1,
                                ["formation_postion"] = 3,
                                ["intimacy"] = 0,
                                ["constellation"] = 0,
                                ["bead"] = 0,
                            },
                        },
                    },
                },
                [2] = {
                    ["side"] = 2,
                    ["formation"] = {
                        ["encyclopedia_enhance"] = {
                            ["def_enhance"] = 261,
                            ["hp_enhance"] = 166,
                            ["atk_enhance"] = 131,
                            ["speed_enhance"] = 176,
                            ["mdef_enhance"] = 226,
                        },
                        ["units"] = {
                            [1] = {
                                ["fight_soul"] = {
                                    ["id"] = 0,
                                    ["merge_level"] = 0,
                                    ["level"] = 0,
                                },
                                ["skin"] = 100101,
                                ["equipments"] = {
                                },
                                ["character_id"] = 1001,
                                ["star"] = 1,
                                ["skills"] = {
                                    ["ultimate"] = 10013,
                                    ["skill"] = 10012,
                                    ["attack"] = 10011,
                                    ["passive_skill"] = 0,
                                },
                                ["level"] = 1,
                                ["formation_postion"] = 2,
                                ["intimacy"] = 0,
                                ["constellation"] = 0,
                                ["bead"] = 0,
                            },
                            [2] = {
                                ["fight_soul"] = {
                                    ["id"] = 0,
                                    ["merge_level"] = 0,
                                    ["level"] = 0,
                                },
                                ["skin"] = 100301,
                                ["equipments"] = {
                                },
                                ["character_id"] = 1003,
                                ["star"] = 1,
                                ["skills"] = {
                                    ["ultimate"] = 10033,
                                    ["skill"] = 10032,
                                    ["attack"] = 10031,
                                    ["passive_skill"] = 0,
                                },
                                ["level"] = 1,
                                ["formation_postion"] = 5,
                                ["intimacy"] = 0,
                                ["constellation"] = 0,
                                ["bead"] = 0,
                            },
                        },
                    },
                },
            },             
        }
    end
   
    return rspMsg
end

local function __init(self)
    MockManager:GetInstance():RegisterMsgHandler(PROTOCOL.BattleStartReq, BattleStartReq)
end

local function __delete(self)
end

BattleMock.__init = __init
BattleMock.__delete = __delete


return BattleMock;