-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_tun_tian_help_prize.lua

module("logicconfig.config.t_tun_tian_help_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 3,
	lotteryDesc = 4,
	maskType = 5,
	activityId = 1
}
local dataList = {
	{
		290001,
		1,
		"10:17081:200",
		"",
		0
	},
	{
		290001,
		2,
		"10:17081:60",
		"",
		0
	},
	{
		290001,
		3,
		"10:17081:70",
		"",
		0
	},
	{
		290001,
		4,
		"10:17081:90",
		"",
		0
	},
	{
		290001,
		5,
		"10:17081:100",
		"",
		0
	},
	{
		290001,
		6,
		"10:17081:120",
		"",
		0
	},
	{
		290001,
		7,
		"10:17081:80",
		"",
		0
	},
	{
		290001,
		8,
		"10:17081:150",
		"",
		0
	},
	{
		290001,
		9,
		"10:17081:100",
		"",
		0
	},
	{
		290002,
		1,
		"10:17087:75",
		"小吉",
		0
	},
	{
		290002,
		2,
		"10:17087:75",
		"小吉",
		0
	},
	{
		290002,
		3,
		"10:17087:100",
		"中吉",
		1
	},
	{
		290002,
		4,
		"10:17087:75",
		"小吉",
		0
	},
	{
		290002,
		5,
		"10:17087:200",
		"大吉",
		2
	},
	{
		290002,
		6,
		"10:17087:100",
		"中吉",
		1
	},
	{
		290002,
		7,
		"10:17087:75",
		"小吉",
		0
	},
	{
		290002,
		8,
		"10:17087:100",
		"中吉",
		1
	},
	{
		290002,
		9,
		"10:17087:75",
		"小吉",
		0
	}
}
local t_tun_tian_help_prize = {
	[290001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9]
	},
	[290002] = {
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18]
	}
}

t_tun_tian_help_prize.dataList = dataList

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

return t_tun_tian_help_prize
