-- chunkname: @IQIGame\\Config\\CfgSurvivalChallengeFeaturesTable.lua

local CfgSurvivalChallengeFeaturesTable = {
	{
		Interval = 25,
		Id = 1,
		Type = 1,
		Duration = 8,
		Skill = getI18NValue(180918163)
	},
	{
		Interval = 25,
		Duration = 10,
		Type = 6,
		Parameter = 5,
		Id = 2,
		Skill = getI18NValue(180918164)
	},
	{
		Interval = 25,
		Duration = 10,
		Type = 4,
		Parameter = 101,
		Id = 3,
		Skill = getI18NValue(180918165)
	},
	{
		Interval = 15,
		Duration = 1,
		Type = 2,
		Parameter = 2000,
		Id = 4,
		Skill = getI18NValue(181195476)
	},
	{
		Id = 5,
		Parameter = 200,
		Type = 5,
		Skill = getI18NValue(181195477)
	},
	{
		Interval = 20,
		Id = 6,
		Type = 1,
		Duration = 10,
		Skill = getI18NValue(181195478)
	},
	{
		Id = 7,
		Parameter = 200,
		Type = 5,
		Skill = getI18NValue(181195479)
	},
	{
		Id = 8,
		Parameter = 200,
		Type = 5,
		Skill = getI18NValue(181195480)
	},
	{
		Id = 9,
		Parameter = 200,
		Type = 5,
		Skill = getI18NValue(181195481)
	},
	{
		Interval = 10,
		Duration = 1,
		Type = 2,
		Parameter = 3000,
		Id = 10,
		Skill = getI18NValue(181198327)
	}
}

setmetatable(CfgSurvivalChallengeFeaturesTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgSurvivalChallengeFeaturesTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Interval = 0,
		Skill = "",
		Parameter = 0,
		Type = 0,
		Duration = 0
	}
}

for i, data in pairs(CfgSurvivalChallengeFeaturesTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgSurvivalChallengeFeaturesTable
