-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_seek_food_prize.lua

module("logicconfig.config.t_seek_food_prize", package.seeall)

local title = {
	prizeId = 2,
	seekNum = 3,
	activityId = 1,
	prize = 4
}
local dataList = {
	{
		282001,
		1,
		2,
		"10:17076:1200"
	},
	{
		282001,
		2,
		4,
		"10:17076:1200"
	},
	{
		282001,
		3,
		6,
		"10:17076:1200"
	},
	{
		282001,
		4,
		8,
		"10:17076:1200"
	}
}
local t_seek_food_prize = {
	[282001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_seek_food_prize.dataList = dataList

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

return t_seek_food_prize
