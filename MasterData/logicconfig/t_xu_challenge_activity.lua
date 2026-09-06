-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_xu_challenge_activity.lua

module("logicconfig.config.t_xu_challenge_activity", package.seeall)

local title = {
	jumpStrTwo = 7,
	skinId = 5,
	jumpStrOne = 6,
	jumpStrThree = 8,
	jumpRedIdOne = 11,
	jumpRedIdThree = 13,
	prize = 2,
	jumpRedIdTwo = 12,
	jumpRedIdFive = 15,
	jumpRedIdFour = 14,
	ruletips = 3,
	jumpStrFive = 10,
	jumpStrFour = 9,
	ruleKeyMain = 4,
	activityId = 1
}
local dataList = {
	{
		613001,
		"4:510842:120",
		"1、按照关卡顺序写入精灵\r\n2、该精灵必须满足每关条件\r\n3、放置后该精灵不可更改",
		"xu_rule",
		14048,
		"func#618#14048",
		"event#gotofirstpassrankview#613001",
		"mibao#jinglingyangcheng",
		"func#1374",
		"func#95#Skin#all#14048",
		"",
		"",
		"",
		"",
		""
	}
}
local t_xu_challenge_activity = {
	[613001] = dataList[1]
}

t_xu_challenge_activity.dataList = dataList

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

return t_xu_challenge_activity
