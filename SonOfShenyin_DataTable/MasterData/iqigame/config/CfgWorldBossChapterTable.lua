-- chunkname: @IQIGame\\Config\\CfgWorldBossChapterTable.lua

local CfgWorldBossChapterTable = {
	[1001] = {
		MonsterTeam = 14501010,
		BossType = 1,
		BossOrder = 2,
		Id = 1001,
		ActivityId = 60010001,
		Name = getI18NValue(180230416)
	},
	[1002] = {
		MonsterTeam = 14503010,
		BossType = 1,
		BossOrder = 1,
		Id = 1002,
		ActivityId = 60010001,
		Name = getI18NValue(180261082)
	},
	[1003] = {
		MonsterTeam = 14502010,
		BossType = 1,
		BossOrder = 3,
		Id = 1003,
		ActivityId = 60010001,
		Name = getI18NValue(180261087)
	},
	[1004] = {
		MonsterTeam = 14504010,
		BossType = 1,
		Id = 1004,
		ActivityId = 60010001,
		Name = getI18NValue(180261420)
	},
	[1005] = {
		MonsterTeam = 14501010,
		BossType = 1,
		Id = 1005,
		ActivityId = 60010001,
		Name = getI18NValue(180263001)
	},
	[1006] = {
		MonsterTeam = 14501010,
		BossType = 1,
		Id = 1006,
		ActivityId = 60010001,
		Name = getI18NValue(180263002)
	},
	[1007] = {
		MonsterTeam = 14504010,
		BossType = 1,
		Id = 1007,
		ActivityId = 60010001,
		Name = getI18NValue(180263598)
	},
	[1008] = {
		MonsterTeam = 14505010,
		BossType = 1,
		Id = 1008,
		ActivityId = 60010001,
		Name = getI18NValue(180263599)
	},
	[1009] = {
		MonsterTeam = 14503010,
		BossType = 1,
		Id = 1009,
		ActivityId = 60010001,
		Name = getI18NValue(180265158)
	},
	[1010] = {
		MonsterTeam = 14509010,
		BossType = 1,
		Id = 1010,
		ActivityId = 60010001,
		Name = getI18NValue(180267385)
	},
	[1011] = {
		MonsterTeam = 14509010,
		BossType = 1,
		Id = 1011,
		ActivityId = 60010001,
		Name = getI18NValue(180267386)
	},
	[1012] = {
		MonsterTeam = 14508010,
		BossType = 1,
		Id = 1012,
		ActivityId = 60010001,
		Name = getI18NValue(180267387)
	},
	[1013] = {
		MonsterTeam = 14508010,
		BossType = 1,
		Id = 1013,
		ActivityId = 60010001,
		Name = getI18NValue(180267388)
	},
	[1014] = {
		MonsterTeam = 14508010,
		BossType = 1,
		Id = 1014,
		ActivityId = 60010001,
		Name = getI18NValue(180267578)
	},
	[1015] = {
		MonsterTeam = 14510010,
		BossType = 1,
		Id = 1015,
		ActivityId = 60010001,
		Name = getI18NValue(180268899)
	},
	[1016] = {
		MonsterTeam = 14510010,
		BossType = 1,
		Id = 1016,
		ActivityId = 60010001,
		Name = getI18NValue(180268900)
	},
	[1017] = {
		MonsterTeam = 14510010,
		BossType = 1,
		Id = 1017,
		ActivityId = 60010001,
		Name = getI18NValue(180268901)
	},
	[1018] = {
		MonsterTeam = 14511010,
		BossType = 1,
		Id = 1018,
		ActivityId = 60010001,
		Name = getI18NValue(180268902)
	},
	[1019] = {
		MonsterTeam = 14511010,
		BossType = 1,
		Id = 1019,
		ActivityId = 60010001,
		Name = getI18NValue(180268903)
	},
	[1020] = {
		MonsterTeam = 14511010,
		BossType = 1,
		Id = 1020,
		ActivityId = 60010001,
		Name = getI18NValue(180268904)
	}
}

setmetatable(CfgWorldBossChapterTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgWorldBossChapterTable]")
	end
})

local defaultMetaTable = {
	__index = {
		EntityID = 0,
		UnlockConditionId = 0,
		BossType = 0,
		MonsterTeam = 0,
		UIBg = "",
		RecommendPower = 0,
		BossOrder = 0,
		Name = "",
		ActivityId = 0
	}
}

for i, data in pairs(CfgWorldBossChapterTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgWorldBossChapterTable
