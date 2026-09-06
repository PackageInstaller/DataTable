-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_welfare_item.lua

module("logicconfig.config.t_welfare_item", package.seeall)

local title = {
	activityType = 5,
	funcId = 3,
	behaviorId = 4,
	id = 1,
	activityId = 6,
	path = 2
}
local dataList = {
	{
		1,
		"周年蛋糕\r\n<size=20><color=#EFD99FFF>钻石 体力 召唤券</color></size>",
		207,
		200325,
		26,
		26001
	},
	{
		2,
		"幸运神宠\r\n<size=20><color=#EFD99FFF>真龙 狄丝 镭拉</color></size>",
		209,
		200324,
		25,
		25001
	},
	{
		3,
		"时间宝库\r\n<size=20><color=#EFD99FFF>洛世琦 召唤券</color></size>",
		191,
		200323,
		17,
		17003
	},
	{
		4,
		"时轮夺宝\r\n<size=20><color=#EFD99FFF>钻石 体力 头像</color></size>",
		109,
		200322,
		3,
		3001
	},
	{
		5,
		"诺亚送礼\r\n<size=20><color=#EFD99FFF>召唤券 体力</color></size>",
		212,
		200310,
		18,
		18002
	}
}
local t_welfare_item = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5]
}

t_welfare_item.dataList = dataList

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

return t_welfare_item
