-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_chen_clg_normal_prize.lua

module("logicconfig.config.t_divine_chen_clg_normal_prize", package.seeall)

local title = {
	prizeId = 2,
	stageNum = 3,
	activityId = 1,
	prize = 4
}
local dataList = {
	{
		457001,
		1,
		3,
		"4:90004:1"
	},
	{
		457001,
		2,
		5,
		"4:267:5"
	},
	{
		457001,
		3,
		7,
		"8:1:1000000"
	},
	{
		457001,
		4,
		9,
		"4:267:5"
	},
	{
		457001,
		5,
		11,
		"4:267:10"
	},
	{
		457002,
		1,
		3,
		"4:90004:1"
	},
	{
		457002,
		2,
		5,
		"4:267:5"
	},
	{
		457002,
		3,
		7,
		"8:1:1000000"
	},
	{
		457002,
		4,
		9,
		"4:267:5"
	},
	{
		457002,
		5,
		11,
		"4:267:10"
	}
}
local t_divine_chen_clg_normal_prize = {
	[457001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	},
	[457002] = {
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	}
}

t_divine_chen_clg_normal_prize.dataList = dataList

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

return t_divine_chen_clg_normal_prize
