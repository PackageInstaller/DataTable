-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_goddess_trial_rank_prize.lua

module("logicconfig.config.t_goddess_trial_rank_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 4,
	rankPrizePlanId = 1,
	rankRange = 3
}
local dataList = {
	{
		1,
		1,
		{
			1,
			1
		},
		"104:2:1000#8:1:1000000"
	},
	{
		1,
		2,
		{
			2,
			50
		},
		"104:2:800#8:1:800000"
	},
	{
		1,
		3,
		{
			51,
			100
		},
		"104:2:600#8:1:600000"
	},
	{
		1,
		4,
		{
			101,
			500
		},
		"104:2:400#8:1:400000"
	},
	{
		1,
		5,
		{
			501,
			1000
		},
		"104:2:200#8:1:200000"
	},
	{
		1,
		6,
		{
			1001,
			2000
		},
		"104:2:100#8:1:100000"
	}
}
local t_goddess_trial_rank_prize = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_goddess_trial_rank_prize.dataList = dataList

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

return t_goddess_trial_rank_prize
