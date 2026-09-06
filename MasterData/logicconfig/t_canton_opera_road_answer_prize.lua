-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_canton_opera_road_answer_prize.lua

module("logicconfig.config.t_canton_opera_road_answer_prize", package.seeall)

local title = {
	prize = 3,
	answerPrizeId = 2,
	planId = 1
}
local dataList = {
	{
		1,
		1,
		"10:17017:25#8:1:7500"
	},
	{
		1,
		2,
		"10:17017:25#8:1:7500"
	},
	{
		1,
		3,
		"10:17017:25#8:1:7500"
	},
	{
		1,
		4,
		"10:17017:25#8:1:7500"
	},
	{
		1,
		5,
		"10:17017:25#8:1:7500"
	},
	{
		1,
		6,
		"10:17017:25#8:1:7500"
	},
	{
		1,
		7,
		"10:17017:25#8:1:7500"
	},
	{
		1,
		8,
		"10:17017:25#8:1:7500"
	},
	{
		1,
		9,
		"10:17017:25#8:1:7500"
	},
	{
		1,
		10,
		"10:17017:25#8:1:7500"
	},
	{
		1,
		11,
		"10:17017:25#8:1:7500"
	},
	{
		1,
		12,
		"10:17017:25#8:1:7500"
	},
	{
		1,
		13,
		"10:17017:25#8:1:7500"
	},
	{
		1,
		14,
		"10:17017:25#8:1:7500"
	},
	{
		1,
		15,
		"10:17017:25#8:1:7500"
	},
	{
		1,
		16,
		"10:17017:25#8:1:7500"
	},
	{
		1,
		17,
		"10:17017:25#8:1:7500"
	},
	{
		1,
		18,
		"10:17017:25#8:1:7500"
	},
	{
		1,
		19,
		"10:17017:25#8:1:7500"
	},
	{
		1,
		20,
		"10:17017:25#8:1:7500"
	}
}
local t_canton_opera_road_answer_prize = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20]
	}
}

t_canton_opera_road_answer_prize.dataList = dataList

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

return t_canton_opera_road_answer_prize
