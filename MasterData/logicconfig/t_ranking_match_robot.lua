-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ranking_match_robot.lua

module("logicconfig.config.t_ranking_match_robot", package.seeall)

local title = {
	creepsMasterId = 1,
	name = 2,
	btlBg = 3,
	heroSkillId = 4
}
local dataList = {
	{
		1001,
		"量产型机器人",
		"",
		""
	},
	{
		1002,
		"量产型机器人",
		"",
		""
	},
	{
		1003,
		"量产型机器人",
		"",
		""
	},
	{
		1004,
		"量产型机器人",
		"",
		""
	},
	{
		1005,
		"量产型机器人",
		"",
		""
	},
	{
		2001,
		"量产型机器人",
		"",
		""
	},
	{
		2002,
		"量产型机器人",
		"",
		""
	},
	{
		2003,
		"量产型机器人",
		"",
		""
	},
	{
		2004,
		"量产型机器人",
		"",
		""
	},
	{
		2005,
		"量产型机器人",
		"",
		""
	}
}
local t_ranking_match_robot = {
	[1001] = dataList[1],
	[1002] = dataList[2],
	[1003] = dataList[3],
	[1004] = dataList[4],
	[1005] = dataList[5],
	[2001] = dataList[6],
	[2002] = dataList[7],
	[2003] = dataList[8],
	[2004] = dataList[9],
	[2005] = dataList[10]
}

t_ranking_match_robot.dataList = dataList

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

return t_ranking_match_robot
