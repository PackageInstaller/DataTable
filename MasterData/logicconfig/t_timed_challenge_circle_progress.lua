-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_timed_challenge_circle_progress.lua

module("logicconfig.config.t_timed_challenge_circle_progress", package.seeall)

local title = {
	challengeId = 1,
	prize = 3,
	progressPercent = 2
}
local dataList = {
	{
		1,
		300,
		"4:81:20"
	},
	{
		1,
		1000,
		"4:81:20"
	},
	{
		1,
		3000,
		"4:81:20"
	},
	{
		1,
		6000,
		"4:81:20"
	},
	{
		1,
		10000,
		"4:81:20#4:82:1"
	},
	{
		3,
		300,
		"4:84:20"
	},
	{
		3,
		1000,
		"4:84:20"
	},
	{
		3,
		3000,
		"4:84:20"
	},
	{
		3,
		6000,
		"4:84:20"
	},
	{
		3,
		10000,
		"4:84:20#4:85:1"
	},
	{
		5,
		300,
		"4:87:20"
	},
	{
		5,
		1000,
		"4:87:20"
	},
	{
		5,
		3000,
		"4:87:20"
	},
	{
		5,
		6000,
		"4:87:20"
	},
	{
		5,
		10000,
		"4:87:20#4:88:1"
	},
	{
		12,
		300,
		"4:97:20"
	},
	{
		12,
		1000,
		"4:97:20"
	},
	{
		12,
		3000,
		"4:97:20"
	},
	{
		12,
		6000,
		"4:97:20"
	},
	{
		12,
		10000,
		"4:97:20#4:98:1"
	},
	{
		14,
		300,
		"4:103:20"
	},
	{
		14,
		1000,
		"4:103:20"
	},
	{
		14,
		3000,
		"4:103:20"
	},
	{
		14,
		6000,
		"4:103:20"
	},
	{
		14,
		10000,
		"4:103:20#4:104:1"
	},
	{
		22,
		300,
		"4:121:20"
	},
	{
		22,
		1000,
		"4:121:20"
	},
	{
		22,
		3000,
		"4:121:20"
	},
	{
		22,
		6000,
		"4:121:20"
	},
	{
		22,
		10000,
		"4:121:20#4:122:1"
	},
	{
		147,
		300,
		"4:222:20"
	},
	{
		147,
		1000,
		"4:222:20"
	},
	{
		147,
		3000,
		"4:222:20"
	},
	{
		147,
		6000,
		"4:222:20"
	},
	{
		147,
		10000,
		"4:222:20"
	}
}
local t_timed_challenge_circle_progress = {
	{
		[300] = dataList[1],
		[1000] = dataList[2],
		[3000] = dataList[3],
		[6000] = dataList[4],
		[10000] = dataList[5]
	},
	[3] = {
		[300] = dataList[6],
		[1000] = dataList[7],
		[3000] = dataList[8],
		[6000] = dataList[9],
		[10000] = dataList[10]
	},
	[5] = {
		[300] = dataList[11],
		[1000] = dataList[12],
		[3000] = dataList[13],
		[6000] = dataList[14],
		[10000] = dataList[15]
	},
	[12] = {
		[300] = dataList[16],
		[1000] = dataList[17],
		[3000] = dataList[18],
		[6000] = dataList[19],
		[10000] = dataList[20]
	},
	[14] = {
		[300] = dataList[21],
		[1000] = dataList[22],
		[3000] = dataList[23],
		[6000] = dataList[24],
		[10000] = dataList[25]
	},
	[22] = {
		[300] = dataList[26],
		[1000] = dataList[27],
		[3000] = dataList[28],
		[6000] = dataList[29],
		[10000] = dataList[30]
	},
	[147] = {
		[300] = dataList[31],
		[1000] = dataList[32],
		[3000] = dataList[33],
		[6000] = dataList[34],
		[10000] = dataList[35]
	}
}

t_timed_challenge_circle_progress.dataList = dataList

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

return t_timed_challenge_circle_progress
