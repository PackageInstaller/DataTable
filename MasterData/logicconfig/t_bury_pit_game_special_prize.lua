-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_bury_pit_game_special_prize.lua

module("logicconfig.config.t_bury_pit_game_special_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 3,
	planId = 1
}
local dataList = {
	{
		1,
		1,
		"8:1:1000"
	},
	{
		1,
		2,
		"4:2:3"
	},
	{
		1,
		3,
		"4:30001:3"
	},
	{
		1,
		4,
		"4:501:3"
	},
	{
		1,
		5,
		"4:5100:1"
	},
	{
		1,
		6,
		"4:601:1"
	},
	{
		1,
		7,
		"4:30:1"
	}
}
local t_bury_pit_game_special_prize = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	}
}

t_bury_pit_game_special_prize.dataList = dataList

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

return t_bury_pit_game_special_prize
