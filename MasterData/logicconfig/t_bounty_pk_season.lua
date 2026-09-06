-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_bounty_pk_season.lua

module("logicconfig.config.t_bounty_pk_season", package.seeall)

local title = {
	taskPlan = 4,
	seasonName = 2,
	seasonId = 5,
	activityId = 1,
	buffPlan = 3
}
local dataList = {
	{
		204001,
		82053991,
		1,
		1,
		1
	},
	{
		204002,
		82053992,
		1,
		2,
		2
	},
	{
		204003,
		82053993,
		1,
		3,
		3
	},
	{
		204004,
		82053994,
		1,
		4,
		4
	},
	{
		204005,
		82053995,
		1,
		5,
		5
	},
	{
		204006,
		82053996,
		1,
		6,
		6
	},
	{
		204007,
		82053997,
		1,
		7,
		7
	},
	{
		204008,
		82053998,
		1,
		8,
		8
	},
	{
		204009,
		82053999,
		1,
		9,
		9
	},
	{
		204010,
		82054000,
		2,
		10,
		10
	},
	{
		204011,
		82054001,
		1,
		11,
		11
	},
	{
		204012,
		82056459,
		1,
		12,
		12
	},
	{
		204013,
		82058251,
		2,
		13,
		13
	}
}
local t_bounty_pk_season = {
	[204001] = dataList[1],
	[204002] = dataList[2],
	[204003] = dataList[3],
	[204004] = dataList[4],
	[204005] = dataList[5],
	[204006] = dataList[6],
	[204007] = dataList[7],
	[204008] = dataList[8],
	[204009] = dataList[9],
	[204010] = dataList[10],
	[204011] = dataList[11],
	[204012] = dataList[12],
	[204013] = dataList[13]
}

t_bounty_pk_season.dataList = dataList

local multiLanguageCells = {
	seasonName = true
}
local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			local value = rawget(t, index)

			if multiLanguageCells[key] then
				value = lang(value)
			end

			return value
		else
			printWarn(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_bounty_pk_season
