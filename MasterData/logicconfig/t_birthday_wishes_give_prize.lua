-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_birthday_wishes_give_prize.lua

module("logicconfig.config.t_birthday_wishes_give_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 4,
	activityId = 1,
	times = 3
}
local dataList = {
	{
		223008,
		1,
		1,
		"8:1:250000"
	},
	{
		223008,
		2,
		2,
		"4:36:5"
	},
	{
		223008,
		3,
		3,
		"8:1:250000"
	},
	{
		223008,
		4,
		4,
		"4:36:5"
	},
	{
		223008,
		5,
		5,
		"8:1:500000"
	}
}
local t_birthday_wishes_give_prize = {
	[223008] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_birthday_wishes_give_prize.dataList = dataList

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

return t_birthday_wishes_give_prize
