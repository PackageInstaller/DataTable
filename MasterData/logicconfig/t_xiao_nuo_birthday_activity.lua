-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_xiao_nuo_birthday_activity.lua

module("logicconfig.config.t_xiao_nuo_birthday_activity", package.seeall)

local title = {
	freeNum = 6,
	activityId = 1,
	buyNum = 7,
	buyCost = 8,
	giftPrize = 5,
	giftProgressMax = 3,
	gamePrizePlan = 2,
	giftProgress = 4
}
local dataList = {
	{
		220001,
		1,
		300,
		50,
		"4:31:10",
		2,
		2,
		"105:6050:100"
	},
	{
		220002,
		1,
		300,
		50,
		"4:31:10",
		2,
		2,
		"105:6050:100"
	},
	{
		220003,
		3,
		300,
		50,
		"8:1:100000",
		2,
		2,
		"105:6050:100"
	},
	{
		220004,
		4,
		300,
		50,
		"4:31:5",
		2,
		2,
		"105:6050:100"
	},
	{
		220005,
		5,
		300,
		50,
		"8:1:1000",
		3,
		1,
		"105:6050:100"
	}
}
local t_xiao_nuo_birthday_activity = {
	[220001] = dataList[1],
	[220002] = dataList[2],
	[220003] = dataList[3],
	[220004] = dataList[4],
	[220005] = dataList[5]
}

t_xiao_nuo_birthday_activity.dataList = dataList

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

return t_xiao_nuo_birthday_activity
