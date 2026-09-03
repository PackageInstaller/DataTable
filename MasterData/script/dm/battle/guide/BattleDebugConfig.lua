-- chunkname: @/tmp/or_script/lua_compile/dm/battle/guide/BattleDebugConfig.lua

local pipline = {}

pipline.units = {
	unitB4 = "ADHWShi",
	unitA9 = "YDZZong",
	unitA4 = "WEDe",
	masterB = "First_Battle_Master2",
	unitB7 = "PNCao",
	unitA1 = "FLYDe",
	unitA2 = "ZTXCun",
	unitB2 = "HLDNan",
	unitB1 = "JDCZhang",
	unitA5 = "YFZZhu",
	unitA6 = "HLMGen",
	unitB3 = "YKDMLai",
	unitA3 = "DFQi",
	unitB6 = "WTXXuan",
	unitB5 = "HLMGen",
	unitA7 = "WTXXuan",
	unitB9 = "SGHQShou",
	masterA = "First_Battle_Master1"
}
pipline.unitsPos = {
	unitB4 = -4,
	unitA9 = 9,
	unitA4 = 4,
	masterB = -8,
	unitB7 = -7,
	unitA1 = 5,
	unitA2 = 2,
	unitB2 = -2,
	unitB1 = -1,
	unitA5 = 5,
	unitA6 = 6,
	unitB3 = -3,
	unitA3 = 3,
	unitB6 = -6,
	unitB5 = -5,
	unitA7 = 7,
	unitB9 = -9,
	masterA = 8
}
pipline.unitsSpawn = {
	"masterB",
	"unitA1"
}
pipline.unitsSkills = {
	unitA1 = {
		{
			skill = "skill1",
			target = "masterB"
		},
		{
			skill = "skill2",
			target = "masterB"
		},
		{
			skill = "skill3",
			target = "masterB",
			skillextra = {
				{
					skill = "skill4",
					delayFrame = 20
				},
				{
					skill = "skill5",
					delayFrame = 20
				}
			}
		}
	}
}

return pipline
