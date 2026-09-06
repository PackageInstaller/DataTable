-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_welfare_redgod_jumpto.lua

module("logicconfig.config.t_origin_welfare_redgod_jumpto", package.seeall)

local title = {
	id = 2,
	jumpToName = 5,
	jumpTo = 3,
	jumpToTipStr = 4,
	activityId = 1
}
local dataList = {
	{
		538001,
		1,
		"event#Enter_Teen_Champion_King_Schedule#501001",
		"xx时间可得xxxx1",
		"跳转1"
	},
	{
		538001,
		2,
		"event#Enter_Teen_Champion_King_Schedule#501001",
		"xx时间可得xxxx2",
		"跳转2"
	},
	{
		538001,
		3,
		"event#Enter_Teen_Champion_King_Schedule#501001",
		"xx时间可得xxxx3",
		"跳转3"
	},
	{
		538001,
		4,
		"event#Enter_Teen_Champion_King_Schedule#501001",
		"xx时间可得xxxx4",
		"跳转4"
	},
	{
		538001,
		5,
		"event#Enter_Teen_Champion_King_Schedule#501001",
		"xx时间可得xxxx5",
		"跳转5"
	},
	{
		538001,
		6,
		"event#Enter_Teen_Champion_King_Schedule#501001",
		"xx时间可得xxxx6",
		"跳转6"
	},
	{
		538001,
		7,
		"event#Enter_Teen_Champion_King_Schedule#501001",
		"xx时间可得xxxx7",
		"跳转7"
	},
	{
		538001,
		8,
		"event#Enter_Teen_Champion_King_Schedule#501001",
		"xx时间可得xxxx8",
		"跳转8"
	}
}
local t_origin_welfare_redgod_jumpto = {
	[538001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	}
}

t_origin_welfare_redgod_jumpto.dataList = dataList

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

return t_origin_welfare_redgod_jumpto
