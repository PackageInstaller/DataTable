-- chunkname: @IQIGame\\Config\\CfgGuildChallengeChestRewardTable.lua

local CfgGuildChallengeChestRewardTable = {
	{
		NeedPoints = 50,
		Sort = 1,
		Id = 1,
		Stage = getI18NValue(180521107),
		Reward = {
			122,
			300,
			11501,
			100
		}
	},
	{
		NeedPoints = 110,
		Sort = 2,
		Id = 2,
		Stage = getI18NValue(180521108),
		Reward = {
			122,
			300,
			11501,
			100
		}
	},
	{
		NeedPoints = 180,
		Sort = 3,
		Id = 3,
		Stage = getI18NValue(180521109),
		Reward = {
			122,
			300,
			11501,
			100
		}
	},
	{
		NeedPoints = 260,
		Sort = 4,
		Id = 4,
		Stage = getI18NValue(180521110),
		Reward = {
			122,
			300,
			11501,
			100
		}
	},
	{
		NeedPoints = 350,
		Sort = 5,
		Id = 5,
		Stage = getI18NValue(180521111),
		Reward = {
			122,
			300,
			11501,
			100
		}
	},
	{
		NeedPoints = 450,
		Sort = 6,
		Id = 6,
		Stage = getI18NValue(180521112),
		Reward = {
			122,
			300,
			11501,
			100
		}
	},
	{
		NeedPoints = 560,
		Sort = 7,
		Id = 7,
		Stage = getI18NValue(180521113),
		Reward = {
			122,
			300,
			11501,
			100
		}
	},
	{
		NeedPoints = 680,
		Sort = 8,
		Id = 8,
		Stage = getI18NValue(180521114),
		Reward = {
			122,
			300,
			11501,
			100
		}
	},
	{
		NeedPoints = 810,
		Sort = 9,
		Id = 9,
		Stage = getI18NValue(180521115),
		Reward = {
			122,
			300,
			11501,
			100
		}
	},
	{
		NeedPoints = 950,
		Sort = 10,
		Id = 10,
		Stage = getI18NValue(180521116),
		Reward = {
			122,
			300,
			11501,
			100
		}
	}
}

setmetatable(CfgGuildChallengeChestRewardTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgGuildChallengeChestRewardTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Sort = 0,
		NeedPoints = 0,
		Stage = "",
		Reward = {}
	}
}

for i, data in pairs(CfgGuildChallengeChestRewardTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgGuildChallengeChestRewardTable
