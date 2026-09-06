-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_flip_touch_activity.lua

module("logicconfig.config.t_flip_touch_activity", package.seeall)

local title = {
	id = 1,
	isCanBuyTime = 5,
	redPointId = 4,
	isHideExit = 6,
	dailyTimes = 3,
	planId = 2,
	closeTipsDesc = 7
}
local dataList = {
	{
		24001,
		1,
		2,
		91,
		true,
		false,
		"你确定退出游戏吗？\r\n退出游戏扣除次数，并且结算目前消除的应援能量"
	},
	{
		24002,
		2,
		2,
		91,
		true,
		false,
		"你确定退出游戏吗？\r\n退出游戏扣除次数，并且结算目前消除的应援能量"
	},
	{
		24003,
		3,
		2,
		91,
		true,
		false,
		"你确定退出游戏吗？\r\n退出游戏扣除次数，并且结算目前消除的应援能量"
	},
	{
		24005,
		4,
		99,
		531,
		true,
		true,
		"你确定退出游戏吗？\r\n退出游戏将不保存当前进度"
	},
	{
		24006,
		5,
		99,
		531,
		false,
		true,
		"你确定退出游戏吗？\r\n退出游戏将不保存当前进度"
	},
	{
		24007,
		6,
		2,
		91,
		true,
		false,
		"你确定退出游戏吗？\r\n退出游戏扣除次数，并且结算目前消除的应援能量"
	},
	{
		24008,
		7,
		99,
		531,
		false,
		true,
		"你确定退出游戏吗？\r\n退出游戏将不保存当前进度"
	}
}
local t_flip_touch_activity = {
	[24001] = dataList[1],
	[24002] = dataList[2],
	[24003] = dataList[3],
	[24005] = dataList[4],
	[24006] = dataList[5],
	[24007] = dataList[6],
	[24008] = dataList[7]
}

t_flip_touch_activity.dataList = dataList

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

return t_flip_touch_activity
