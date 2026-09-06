-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_flip_touch_global_prize.lua

module("logicconfig.config.t_flip_touch_global_prize", package.seeall)

local title = {
	id = 2,
	prize = 4,
	planId = 1,
	globalGainNum = 3
}
local dataList = {
	{
		1,
		1,
		250000,
		"100:10344:1:1"
	},
	{
		1,
		2,
		660000,
		"4:31:5"
	},
	{
		2,
		1,
		66666,
		"8:1:20000"
	},
	{
		2,
		2,
		99999,
		"4:25:1"
	},
	{
		3,
		1,
		66666,
		"8:1:100000"
	},
	{
		3,
		2,
		99999,
		"8:1:100000"
	},
	{
		4,
		1,
		660000,
		"8:1:100000"
	},
	{
		5,
		1,
		660000,
		"8:1:100000"
	},
	{
		6,
		1,
		660000,
		"8:1:1000000"
	},
	{
		7,
		1,
		660000,
		"8:1:100000"
	}
}
local t_flip_touch_global_prize = {
	{
		dataList[1],
		dataList[2]
	},
	{
		dataList[3],
		dataList[4]
	},
	{
		dataList[5],
		dataList[6]
	},
	{
		dataList[7]
	},
	{
		dataList[8]
	},
	{
		dataList[9]
	},
	{
		dataList[10]
	}
}

t_flip_touch_global_prize.dataList = dataList

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

return t_flip_touch_global_prize
