-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_form_prediction_rank_prize.lua

module("logicconfig.config.t_form_prediction_rank_prize", package.seeall)

local title = {
	rankList = 3,
	rankPrizeId = 2,
	rankPrizePlanId = 1,
	prize = 4
}
local dataList = {
	{
		1,
		1,
		{
			1,
			100
		},
		"104:2:500#8:1:500000"
	},
	{
		1,
		2,
		{
			101,
			500
		},
		"104:2:300#8:1:300000"
	},
	{
		1,
		3,
		{
			501,
			1000
		},
		"104:2:200#8:1:200000"
	},
	{
		1,
		4,
		{
			1001,
			10000
		},
		"104:2:100#8:1:100000"
	},
	{
		2,
		1,
		{
			1,
			100
		},
		"104:2:500#8:1:500000"
	},
	{
		2,
		2,
		{
			101,
			500
		},
		"104:2:300#8:1:300000"
	},
	{
		2,
		3,
		{
			501,
			1000
		},
		"104:2:200#8:1:200000"
	},
	{
		2,
		4,
		{
			1001,
			10000
		},
		"104:2:100#8:1:100000"
	}
}
local t_form_prediction_rank_prize = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	},
	{
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	}
}

t_form_prediction_rank_prize.dataList = dataList

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

return t_form_prediction_rank_prize
