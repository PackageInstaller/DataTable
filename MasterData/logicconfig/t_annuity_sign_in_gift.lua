-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_annuity_sign_in_gift.lua

module("logicconfig.config.t_annuity_sign_in_gift", package.seeall)

local title = {
	cost = 4,
	times = 5,
	showTag = 6,
	showCost = 7,
	id = 2,
	iconName = 8,
	activityId = 1,
	gainDays = 3
}
local dataList = {
	{
		8004,
		1,
		1,
		"204:100002:18",
		30,
		"",
		"",
		"board_nfl_57"
	},
	{
		8004,
		2,
		10,
		"204:100003:138",
		3,
		"7.6折",
		"204:100003:180",
		"board_nfl_58"
	},
	{
		8004,
		3,
		30,
		"204:100004:298",
		1,
		"5.5折",
		"204:100004:540",
		"board_nfl_59"
	},
	{
		8005,
		1,
		1,
		"204:100007:10",
		30,
		"",
		"",
		"board_nfl_97"
	},
	{
		8005,
		2,
		10,
		"204:100008:100",
		3,
		"",
		"",
		"board_nfl_97"
	},
	{
		8005,
		3,
		30,
		"204:100009:288",
		1,
		"",
		"",
		"board_nfl_97"
	},
	{
		8006,
		1,
		1,
		"204:100007:10",
		30,
		"",
		"",
		"board_nfl_97"
	},
	{
		8006,
		2,
		10,
		"204:100008:100",
		3,
		"",
		"",
		"board_nfl_97"
	},
	{
		8006,
		3,
		30,
		"204:100009:288",
		1,
		"",
		"",
		"board_nfl_97"
	}
}
local t_annuity_sign_in_gift = {
	[8004] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[8005] = {
		dataList[4],
		dataList[5],
		dataList[6]
	},
	[8006] = {
		dataList[7],
		dataList[8],
		dataList[9]
	}
}

t_annuity_sign_in_gift.dataList = dataList

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

return t_annuity_sign_in_gift
