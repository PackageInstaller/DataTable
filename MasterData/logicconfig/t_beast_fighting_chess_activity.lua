-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_beast_fighting_chess_activity.lua

module("logicconfig.config.t_beast_fighting_chess_activity", package.seeall)

local title = {
	robotZone = 8,
	roundSec = 5,
	roundSecAfterHangUp = 6,
	openTime = 10,
	startMatchRobotSec = 3,
	hangUpBanSec = 11,
	robotName = 7,
	waitingMatchSec = 4,
	redPointId = 9,
	stepLimit = 2,
	activityId = 1
}
local dataList = {
	{
		412001,
		30,
		5,
		300,
		20,
		5,
		"机器人",
		"奥奇城",
		628,
		"8-24",
		600
	},
	{
		412002,
		30,
		5,
		300,
		20,
		5,
		"机器人",
		"奥奇城",
		628,
		"8-24",
		600
	},
	{
		412003,
		30,
		5,
		300,
		20,
		5,
		"机器人",
		"奥奇城",
		628,
		"8-24",
		300
	},
	{
		412004,
		30,
		5,
		300,
		20,
		5,
		"机器人",
		"奥奇城",
		628,
		"8-24",
		300
	}
}
local t_beast_fighting_chess_activity = {
	[412001] = dataList[1],
	[412002] = dataList[2],
	[412003] = dataList[3],
	[412004] = dataList[4]
}

t_beast_fighting_chess_activity.dataList = dataList

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

return t_beast_fighting_chess_activity
