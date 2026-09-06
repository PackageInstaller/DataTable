-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pet_card_lottery_prize.lua

module("logicconfig.config.t_pet_card_lottery_prize", package.seeall)

local title = {
	prize = 5,
	matchCount = 3,
	id = 2,
	activityId = 1,
	dec = 4
}
local dataList = {
	{
		271001,
		1,
		0,
		"三等奖",
		"8:1:200000"
	},
	{
		271001,
		2,
		3,
		"二等奖",
		"8:1:2200000"
	},
	{
		271001,
		3,
		5,
		"一等奖",
		"8:1:10000000"
	},
	{
		271002,
		1,
		0,
		"三等奖",
		"4:30006:30"
	},
	{
		271002,
		2,
		3,
		"二等奖",
		"4:30006:32"
	},
	{
		271002,
		3,
		5,
		"一等奖",
		"4:30006:36"
	}
}
local t_pet_card_lottery_prize = {
	[271001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[271002] = {
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_pet_card_lottery_prize.dataList = dataList

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

return t_pet_card_lottery_prize
