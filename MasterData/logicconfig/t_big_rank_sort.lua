-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_big_rank_sort.lua

module("logicconfig.config.t_big_rank_sort", package.seeall)

local title = {
	rankTypeString = 2,
	index = 1,
	sortId = 3
}
local dataList = {
	{
		1,
		"4",
		1
	},
	{
		2,
		"AchievementRank",
		3
	},
	{
		3,
		"32",
		4
	},
	{
		4,
		"6",
		5
	},
	{
		5,
		"7",
		6
	},
	{
		6,
		"FamilyTeamPlay",
		7
	},
	{
		7,
		"1",
		8
	},
	{
		8,
		"2",
		9
	},
	{
		9,
		"3",
		10
	},
	{
		10,
		"9",
		11
	},
	{
		11,
		"GloryTowerRank",
		12
	},
	{
		12,
		"SENDFLOWER_RANK",
		13
	},
	{
		13,
		"33",
		2
	},
	{
		14,
		"34",
		14
	}
}
local t_big_rank_sort = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9],
	dataList[10],
	dataList[11],
	dataList[12],
	dataList[13],
	dataList[14]
}

t_big_rank_sort.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_big_rank_sort
