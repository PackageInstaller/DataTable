-- chunkname: @IQIGame\\Config\\CfgFishActiveSkillTable.lua

local CfgFishActiveSkillTable = {
	{
		Group = 1,
		LevelMax = 20,
		Skillid = 1001,
		Id = 1,
		Icon = "/Activity/FishingActivity/FishingActivitySkillUI/FishingActivitySkillUI_20.png",
		SkillGroup = {
			1001,
			1002,
			1003,
			1004,
			1005,
			1006,
			1007,
			1008,
			1009,
			1010,
			1011,
			1012,
			1013,
			1014,
			1015,
			1016,
			1017,
			1018,
			1019,
			1020
		},
		SkillName = getI18NValue(181198454)
	},
	{
		Group = 1,
		LevelMax = 20,
		Skillid = 2001,
		Id = 2,
		Icon = "/Activity/FishingActivity/FishingActivitySkillUI/FishingActivitySkillUI_21.png",
		SkillGroup = {
			2001,
			2002,
			2003,
			2004,
			2005,
			2006,
			2007,
			2008,
			2009,
			2010,
			2011,
			2012,
			2013,
			2014,
			2015,
			2016,
			2017,
			2018,
			2019,
			2020
		},
		SkillName = getI18NValue(181198455)
	},
	{
		Group = 1,
		LevelMax = 20,
		Skillid = 3001,
		Id = 3,
		Icon = "/Activity/FishingActivity/FishingActivitySkillUI/FishingActivitySkillUI_22.png",
		SkillGroup = {
			3001,
			3002,
			3003,
			3004,
			3005,
			3006,
			3007,
			3008,
			3009,
			3010,
			3011,
			3012,
			3013,
			3014,
			3015,
			3016,
			3017,
			3018,
			3019,
			3020
		},
		SkillName = getI18NValue(181198456)
	}
}

setmetatable(CfgFishActiveSkillTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgFishActiveSkillTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Group = 0,
		Icon = "",
		Skillid = 0,
		LevelMax = 0,
		SkillName = "",
		SkillGroup = {}
	}
}

for i, data in pairs(CfgFishActiveSkillTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgFishActiveSkillTable
