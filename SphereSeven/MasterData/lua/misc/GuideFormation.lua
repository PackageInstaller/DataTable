
local GuideFormation = {}

local Formation = {
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
            ["skin"] = 102601,
            ["equipments"] = {
            },
            ["character_id"] = 1026,
            ["star"] = 1,
            ["skills"] = {
                ["ultimate"] = 10263,
                ["skill"] = 10262,
                ["attack"] = 10261,
                ["passive_skill"] = 0,
            },
            ["level"] = 1,
            ["formation_postion"] = 1,
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
            ["skin"] = 102701,
            ["equipments"] = {
            },
            ["character_id"] = 1027,
            ["star"] = 1,
            ["skills"] = {
                ["ultimate"] = 10273,
                ["skill"] = 10272,
                ["attack"] = 10271,
                ["passive_skill"] = 0,
            },
            ["level"] = 1,
            ["formation_postion"] = 4,
            ["intimacy"] = 0,
            ["constellation"] = 0,
            ["bead"] = 0,
        },
        [3] = {
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
}

local SelectedCharacter = {
    [1001] = {
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
        ["formation_postion"] = 3,
        ["intimacy"] = 0,
        ["constellation"] = 0,
        ["bead"] = 0,
    },
    [1002] = {
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
    }
}

GuideFormation.Formation = Formation
GuideFormation.SelectedCharacter = SelectedCharacter

return GuideFormation