---@class SurvivorSkillTable
---@field public id integer
---@field public skillName LocalStrEnum
---@field public skillDesc LocalStrEnum
---@field public trigger table
---@field public skillType integer
---@field public skillTypeParam table
---@field public bullet string
---@field public effectType integer
---@field public effectParameter table
---@field public cd integer

---@type SurvivorSkillTable[]
local SurvivorSkillTable = {
                [10001] = {
                        id = 10001,
                        skillName = LocalStrEnum.survivorSkillName_10001,
                        skillDesc = LocalStrEnum.survivorSkillDesc_10001,
                        trigger = {1},
                        skillType = 2,
                        skillTypeParam = nil,
                        bullet = "Bullet_Y",
                        effectType = 1,
                        effectParameter = {{A10=3,A2=2,A16=5,A14=0.1,A9=1},{A1=1.5},{1,1,{{3,{71}}}},1},
                        cd = 1,
                },

                [20001] = {
                        id = 20001,
                        skillName = LocalStrEnum.survivorSkillName_20001,
                        skillDesc = LocalStrEnum.survivorSkillDesc_20001,
                        trigger = {1},
                        skillType = 2,
                        skillTypeParam = nil,
                        bullet = "Bullet_Y",
                        effectType = 1,
                        effectParameter = {{A10=3,A2=100,A16=5,A14=0.2,A9=1},{A1=1.5},{1,3,{{3,{71}}}},2},
                        cd = 1,
                },

                [30001] = {
                        id = 30001,
                        skillName = LocalStrEnum.survivorSkillName_30001,
                        skillDesc = LocalStrEnum.survivorSkillDesc_30001,
                        trigger = {1},
                        skillType = 2,
                        skillTypeParam = nil,
                        bullet = "Bullet_Y",
                        effectType = 1,
                        effectParameter = {{A10=3,A2=100,A16=5,A14=0.2,A9=1},{A1=1.5},{1,1,{{3,{71}}}},3},
                        cd = 1,
                },

                [40001] = {
                        id = 40001,
                        skillName = LocalStrEnum.survivorSkillName_40001,
                        skillDesc = LocalStrEnum.survivorSkillDesc_40001,
                        trigger = {1},
                        skillType = 2,
                        skillTypeParam = nil,
                        bullet = "Bullet_Y",
                        effectType = 1,
                        effectParameter = {{A10=3,A2=100,A16=5,A14=0.2,A9=1},{A1=1.5},{1,1,{{3,{71}}}},4},
                        cd = 1,
                },

                [50001] = {
                        id = 50001,
                        skillName = LocalStrEnum.survivorSkillName_50001,
                        skillDesc = LocalStrEnum.survivorSkillDesc_50001,
                        trigger = {1},
                        skillType = 2,
                        skillTypeParam = nil,
                        bullet = "Bullet_Y",
                        effectType = 1,
                        effectParameter = {{A10=3,A2=100,A16=5,A14=0.2,A9=1},{A1=1.5},{1,1,{{3,{71}}}},1},
                        cd = 1,
                },

                [60001] = {
                        id = 60001,
                        skillName = LocalStrEnum.survivorSkillName_60001,
                        skillDesc = LocalStrEnum.survivorSkillDesc_60001,
                        trigger = {1},
                        skillType = 2,
                        skillTypeParam = nil,
                        bullet = "Bullet_Y",
                        effectType = 1,
                        effectParameter = {{A10=3,A2=100,A16=5,A14=0.2,A9=1},{A1=1.5},{1,1,{{3,{71}}}},1},
                        cd = 1,
                },

                [101] = {
                        id = 101,
                        skillName = LocalStrEnum.survivorSkillName_101,
                        skillDesc = LocalStrEnum.survivorSkillDesc_101,
                        trigger = nil,
                        skillType = 1,
                        skillTypeParam = nil,
                        bullet = "Bullet_Y",
                        effectType = 1,
                        effectParameter = {{A10=4,A2=20,A16=5,A14=1,A9=1,A15 = 999},{A1=1.5},{1,2,{{3,{71}}}},1},
                        cd = 2,
                },

                [102] = {
                        id = 102,
                        skillName = LocalStrEnum.survivorSkillName_102,
                        skillDesc = LocalStrEnum.survivorSkillDesc_102,
                        trigger = nil,
                        skillType = 1,
                        skillTypeParam = nil,
                        bullet = "Bullet_Y",
                        effectType = 1,
                        effectParameter = {{A10=4,A2=20,A16=5,A14=0.4,A9=3,A11 = 20,A15 = 1},{A1=1.5},{1,2,{{3,{71}}}},1},
                        cd = 2,
                },

                [103] = {
                        id = 103,
                        skillName = LocalStrEnum.survivorSkillName_103,
                        skillDesc = LocalStrEnum.survivorSkillDesc_103,
                        trigger = nil,
                        skillType = 1,
                        skillTypeParam =  {time = 3, bonus = {A2 = 4.5}, canMove = 0},
                        bullet = "Bullet_Y",
                        effectType = 1,
                        effectParameter = {{A10=4,A2=20,A16=5,A14=1,A9=1,A15 = 999},{A1=1.5},{1,2,{{3,{71}}}},1},
                        cd = 2,
                },

                [104] = {
                        id = 104,
                        skillName = LocalStrEnum.survivorSkillName_104,
                        skillDesc = LocalStrEnum.survivorSkillDesc_104,
                        trigger = nil,
                        skillType = 1,
                        skillTypeParam = nil,
                        bullet = "Bullet_Y",
                        effectType = 1,
                        effectParameter = {{A10=4,A2=20,A16=2,A14=0.4,A9=3,A11 = 20,A15 = 1},{A1=1.5},{1,2,{{3,{71}}}},1,{track = 1,trackRange = 2,turnSpeed = 180}},
                        cd = 0,
                },

                [105] = {
                        id = 105,
                        skillName = LocalStrEnum.survivorSkillName_105,
                        skillDesc = LocalStrEnum.survivorSkillDesc_105,
                        trigger = nil,
                        skillType = 1,
                        skillTypeParam = nil,
                        bullet = "Torpedo",
                        effectType = 1,
                        effectParameter = {{A10=4,A2=50,A16=3,A14=0.4,A9=3,A11 = 20},{A1=1.5},{1,2,{{3,{71}}}},1,{track = 1,trackRange = 2,turnSpeed = 180,startPos = 1}},
                        cd = 0,
                },

                [5001] = {
                        id = 5001,
                        skillName = LocalStrEnum.survivorSkillName_5001,
                        skillDesc = LocalStrEnum.survivorSkillDesc_5001,
                        trigger = {1},
                        skillType = 2,
                        skillTypeParam = nil,
                        bullet = "circleAreaRed",
                        effectType = 2,
                        effectParameter = {{A2=30,A14=5},{A1=1.5},{1,0,{{3,{71}}}},1,{settle=1,expandMaxTime=1,sustainTime=1,shape = 1}},
                        cd = 1,
                },

                [5002] = {
                        id = 5002,
                        skillName = LocalStrEnum.survivorSkillName_5002,
                        skillDesc = LocalStrEnum.survivorSkillDesc_5002,
                        trigger = {1},
                        skillType = 2,
                        skillTypeParam = nil,
                        bullet = "circleAreaRed",
                        effectType = 2,
                        effectParameter = {{A2=30,A14=3},{A1=1.5},{3,3,{{3,{71}}}},1,{settle=2,expandMaxTime=0.35, knockbackSpeed = 4, knockbackDuration = 0.5,shape = 1}},
                        cd = 1,
                },

                [5003] = {
                        id = 5003,
                        skillName = LocalStrEnum.survivorSkillName_5003,
                        skillDesc = LocalStrEnum.survivorSkillDesc_5003,
                        trigger = {1},
                        skillType = 2,
                        skillTypeParam = nil,
                        bullet = "circleAreaRed",
                        effectType = 2,
                        effectParameter = {{A2=10,A14=5},{A1=1.5},{2,0,{{3,{71}}}},1,{settle=3,sustainTime=2,interval = 0.3,shape = 1}},
                        cd = 1,
                },

                [5004] = {
                        id = 5004,
                        skillName = LocalStrEnum.survivorSkillName_5004,
                        skillDesc = LocalStrEnum.survivorSkillDesc_5004,
                        trigger = {1},
                        skillType = 2,
                        skillTypeParam = nil,
                        bullet = "circleAreaRed",
                        effectType = 2,
                        effectParameter = {{A2=10,A14=5},{A1=1.5},{3,2,{{3,{71}}}},1,{settle=3,expandMaxTime=1,sustainTime=2,interval = 0.3,shape = 1}},
                        cd = 1,
                },

                [5006] = {
                        id = 5006,
                        skillName = LocalStrEnum.survivorSkillName_5006,
                        skillDesc = LocalStrEnum.survivorSkillDesc_5006,
                        trigger = {1},
                        skillType = 2,
                        skillTypeParam = nil,
                        bullet = "circleAreaRed",
                        effectType = 2,
                        effectParameter = {{A2=5,A14=7},{A1=1.5},{2,0,{{3,{71}}}},1,{settle=3,expandMaxTime=1,sustainTime=2,interval = 0.1,shape = 1}},
                        cd = 1,
                },

                [6001] = {
                        id = 6001,
                        skillName = LocalStrEnum.survivorSkillName_6001,
                        skillDesc = LocalStrEnum.survivorSkillDesc_6001,
                        trigger = {3,50},
                        skillType = 0,
                        skillTypeParam = nil,
                        bullet = "circleAreaRed",
                        effectType = 2,
                        effectParameter = {{A2=30,A14=5},{A1=1.5},{1,0,{{3,{71}}}},1,{settle=1,expandMaxTime=1,sustainTime=1,shape = 1}},
                        cd = 0,
                },

                [7001] = {
                        id = 7001,
                        skillName = LocalStrEnum.survivorSkillName_7001,
                        skillDesc = LocalStrEnum.survivorSkillDesc_7001,
                        trigger = {1},
                        skillType = 2,
                        skillTypeParam = nil,
                        bullet = "LayzerEffect",
                        effectType = 2,
                        effectParameter = {{A2=30,A14=5,A17=8,A18=1},{A1=1.5},{1,1,{{3,{71}}}},1,{settle=3,sustainTime=2,shape = 2,interval = 0.3}},
                        cd = 3,
                },

                [7002] = {
                        id = 7002,
                        skillName = LocalStrEnum.survivorSkillName_7002,
                        skillDesc = LocalStrEnum.survivorSkillDesc_7002,
                        trigger = {1},
                        skillType = 2,
                        skillTypeParam = nil,
                        bullet = "LayzerEffect",
                        effectType = 2,
                        effectParameter = {{A2=30,A14=5,A17=8,A18=1},{A1=1.5},{2,2,{{3,{71}}}},1,{settle=3,sustainTime=1,shape = 2,interval = 0.3}},
                        cd = 2,
                },

                [7003] = {
                        id = 7003,
                        skillName = LocalStrEnum.survivorSkillName_7003,
                        skillDesc = LocalStrEnum.survivorSkillDesc_7003,
                        trigger = nil,
                        skillType = 1,
                        skillTypeParam = nil,
                        bullet = "LayzerEffect",
                        effectType = 2,
                        effectParameter = {{A2=30,A14=5,A17=8,A18=1},{A1=1.5},{1,1,{{3,{71}}}},1,{settle=1,sustainTime=1,shape = 2}},
                        cd = 0,
                },

                [8001] = {
                        id = 8001,
                        skillName = LocalStrEnum.survivorSkillName_8001,
                        skillDesc = LocalStrEnum.survivorSkillDesc_8001,
                        trigger = {0},
                        skillType = 0,
                        skillTypeParam = nil,
                        bullet = "",
                        effectType = 3,
                        effectParameter = {{A2 = 1}},
                        cd = 0,
                },

                [8002] = {
                        id = 8002,
                        skillName = LocalStrEnum.survivorSkillName_8002,
                        skillDesc = LocalStrEnum.survivorSkillDesc_8002,
                        trigger = {0},
                        skillType = 0,
                        skillTypeParam = nil,
                        bullet = "",
                        effectType = 3,
                        effectParameter = {{A1 = 10}},
                        cd = 0,
                },

}
return SurvivorSkillTable