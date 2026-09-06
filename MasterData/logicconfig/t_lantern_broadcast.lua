-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_lantern_broadcast.lua

module("logicconfig.config.t_lantern_broadcast", package.seeall)

local title = {
	duration = 9,
	priority = 5,
	showLocation = 10,
	linkType = 3,
	content = 4,
	triggerType = 2,
	endTime = 7,
	id = 1,
	frequency = 8,
	startTime = 6
}
local dataList = {
	{
		1,
		1,
		0,
		"每天5:00将重置挑战次数、玩法进度等数据，距离今日重置还有5分钟~",
		0,
		"2020-04-01T04:55:00",
		"2031-04-01T04:55:00",
		86400,
		315360000
	},
	{
		2,
		1,
		0,
		"每天5:00将重置挑战次数、玩法进度等数据，距离今日重置只剩1分钟咯~",
		0,
		"2020-04-01T04:59:00",
		"2031-04-01T04:59:00",
		86400,
		315360000
	},
	{
		3,
		1,
		0,
		"今日挑战次数、玩法进度等数据已被重置",
		0,
		"2020-04-01T05:00:00",
		"2031-04-01T05:00:00",
		86400,
		315360000
	},
	{
		4,
		1,
		0,
		"今天的<color=#C54949>世界魔王</color>挑战已经开启，快去试试吧~",
		0,
		"2020-04-01T20:00:00",
		"2031-04-01T20:00:00",
		86400,
		315360000
	},
	{
		5,
		1,
		0,
		"今天中午的<color=#C54949>家族护送</color>时段已经开启，快去试试吧~",
		0,
		"2020-04-01T12:00:00",
		"2031-04-01T12:00:00",
		86400,
		315360000
	},
	{
		6,
		1,
		0,
		"今天傍晚的<color=#C54949>家族护送</color>时段已经开启，快去试试吧~",
		0,
		"2020-04-01T18:00:00",
		"2031-04-01T18:00:00",
		86400,
		315360000
	},
	{
		7,
		1,
		0,
		"<color=#C54949>排位赛</color>已开启，还不快去升段~",
		0,
		"2020-04-01T18:00:00",
		"2031-04-01T18:00:00",
		86400,
		315360000
	}
}
local t_lantern_broadcast = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7]
}

t_lantern_broadcast.dataList = dataList

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

return t_lantern_broadcast
