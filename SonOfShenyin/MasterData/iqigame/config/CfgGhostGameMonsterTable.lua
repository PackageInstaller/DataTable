-- chunkname: @IQIGame\\Config\\CfgGhostGameMonsterTable.lua

local CfgGhostGameMonsterTable = {
	[60200101] = {
		Reward = 31202011,
		MonsterProbability = 0.5,
		Entity = "10840011",
		MonsterSpeed = 1,
		MaxNum = 100,
		MonsterHP = 20,
		MonsterType = 1,
		Id = 60200101,
		Name = getI18NValue(180190636),
		MonsterBuff = {
			60200202,
			60200203
		},
		MonsterBuffProbability = {
			0.05,
			0.05
		}
	},
	[60200102] = {
		Reward = 31202012,
		MonsterProbability = 0.25,
		Entity = "10840010",
		MonsterSpeed = 1,
		MaxNum = 15,
		MonsterHP = 30,
		MonsterType = 2,
		Id = 60200102,
		Name = getI18NValue(180190637),
		MonsterBuff = {
			60200204,
			60200205
		},
		MonsterBuffProbability = {
			0.1,
			0.05
		}
	},
	[60200103] = {
		Reward = 31202013,
		MonsterProbability = 0.15,
		Entity = "10840012",
		MonsterSpeed = 1,
		MaxNum = 10,
		MonsterHP = 40,
		MonsterType = 3,
		Id = 60200103,
		Name = getI18NValue(180190638),
		MonsterBuff = {
			60200201,
			60200202,
			60200203
		},
		MonsterBuffProbability = {
			0.2,
			0.1,
			0.05
		}
	},
	[60200104] = {
		Reward = 31202014,
		MonsterProbability = 0.1,
		Entity = "10840013",
		MonsterSpeed = 1,
		MaxNum = 5,
		MonsterHP = 60,
		MonsterType = 4,
		Id = 60200104,
		Name = getI18NValue(180190639),
		MonsterBuff = {
			60200201,
			60200203,
			60200205
		},
		MonsterBuffProbability = {
			0.2,
			0.1,
			0.05
		}
	}
}

setmetatable(CfgGhostGameMonsterTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgGhostGameMonsterTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Reward = 0,
		Name = "",
		MonsterProbability = 0,
		MonsterType = 0,
		MonsterSpeed = 0,
		MaxNum = 0,
		MonsterHP = 0,
		Entity = "",
		MonsterBuffProbability = {},
		MonsterBuff = {}
	}
}

for i, data in pairs(CfgGhostGameMonsterTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgGhostGameMonsterTable
