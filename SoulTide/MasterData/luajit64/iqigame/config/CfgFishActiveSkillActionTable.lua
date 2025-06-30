-- chunkname: @IQIGame\\Config\\CfgFishActiveSkillActionTable.lua

local CfgFishActiveSkillActionTable = {
	{
		Group = 1,
		EffectID = 9001973,
		Skillid = 1001,
		Id = 1,
		Icon = "/Skill/BattleSkillIcon_102110.png",
		LevelMax = 10,
		SkillActionGroup = {
			1001,
			1002,
			1003,
			1004,
			1005,
			1006,
			1007,
			1008,
			1009,
			1010
		},
		SkillName = getI18NValue(181198457)
	},
	{
		Group = 1,
		EffectID = 9001974,
		Skillid = 2001,
		Id = 2,
		Icon = "/Skill/BattleSkillIcon_102120.png",
		LevelMax = 10,
		SkillActionGroup = {
			2001,
			2002,
			2003,
			2004,
			2005,
			2006,
			2007,
			2008,
			2009,
			2010
		},
		SkillName = getI18NValue(181198458)
	},
	{
		Group = 1,
		EffectID = 9001975,
		Skillid = 3001,
		Id = 3,
		Icon = "/Skill/BattleSkillIcon_102210.png",
		LevelMax = 10,
		SkillActionGroup = {
			3001,
			3002,
			3003,
			3004,
			3005,
			3006,
			3007,
			3008,
			3009,
			3010
		},
		SkillName = getI18NValue(181198459)
	},
	{
		Group = 1,
		EffectID = 9001976,
		Skillid = 4001,
		Id = 4,
		Icon = "/Skill/BattleSkillIcon_102220.png",
		LevelMax = 10,
		SkillActionGroup = {
			4001,
			4002,
			4003,
			4004,
			4005,
			4006,
			4007,
			4008,
			4009,
			4010
		},
		SkillName = getI18NValue(181198460)
	},
	{
		Group = 1,
		EffectID = 9001977,
		Skillid = 5001,
		Id = 5,
		Icon = "/Skill/BattleSkillIcon_102310.png",
		LevelMax = 10,
		SkillActionGroup = {
			5001,
			5002,
			5003,
			5004,
			5005,
			5006,
			5007,
			5008,
			5009,
			5010
		},
		SkillName = getI18NValue(181198461)
	},
	{
		IsUnLock = true,
		Id = 6,
		Group = 1,
		Icon = "/Skill/BattleSkillIcon_102320.png",
		EffectID = 9001978,
		LevelMax = 1,
		SkillActionGroup = {
			6001
		},
		SkillName = getI18NValue(181198462),
		NeedSkillID = {
			1,
			10,
			2,
			10,
			3,
			10,
			4,
			10,
			5,
			10
		}
	}
}

setmetatable(CfgFishActiveSkillActionTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgFishActiveSkillActionTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Group = 0,
		IsUnLock = false,
		Icon = "",
		EffectID = 0,
		Skillid = 0,
		LevelMax = 0,
		SkillName = "",
		SkillActionGroup = {},
		NeedSkillID = {}
	}
}

for i, data in pairs(CfgFishActiveSkillActionTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgFishActiveSkillActionTable
