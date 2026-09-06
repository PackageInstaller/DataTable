-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_gift_box_gain_luck_prize.lua

module("logicconfig.config.t_gift_box_gain_luck_prize", package.seeall)

local title = {
	prizeId = 2,
	peopleNum = 3,
	activityId = 1,
	prize = 4
}
local dataList = {
	{
		318001,
		1,
		1,
		"8:1:250000"
	},
	{
		318001,
		2,
		2,
		"8:1:250000"
	},
	{
		318001,
		3,
		3,
		"8:1:250000"
	},
	{
		318001,
		4,
		4,
		"8:1:250000"
	},
	{
		318001,
		5,
		5,
		"8:1:250000"
	},
	{
		318001,
		6,
		6,
		"8:1:350000"
	}
}
local t_gift_box_gain_luck_prize = {
	[318001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_gift_box_gain_luck_prize.dataList = dataList

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

return t_gift_box_gain_luck_prize
