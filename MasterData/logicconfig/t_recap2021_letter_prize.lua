-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_recap2021_letter_prize.lua

module("logicconfig.config.t_recap2021_letter_prize", package.seeall)

local title = {
	letterPrizeId = 1,
	prize = 2
}
local dataList = {
	{
		1,
		"4:90190:1"
	},
	{
		2,
		"4:90191:1"
	},
	{
		3,
		"4:90192:1"
	},
	{
		4,
		"4:90193:1"
	},
	{
		5,
		"4:90194:1"
	},
	{
		6,
		"4:90195:1"
	}
}
local t_recap2021_letter_prize = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6]
}

t_recap2021_letter_prize.dataList = dataList

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

return t_recap2021_letter_prize
