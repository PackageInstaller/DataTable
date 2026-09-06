-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ling_shen_convene_progress_prize.lua

module("logicconfig.config.t_ling_shen_convene_progress_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 4,
	activityId = 1,
	unlockCount = 3
}
local dataList = {
	{
		376001,
		1,
		1,
		"4:90316:1"
	},
	{
		376001,
		2,
		2,
		"8:1:250000"
	},
	{
		376001,
		3,
		3,
		"4:510022:2"
	},
	{
		376001,
		4,
		4,
		"8:1:250000"
	},
	{
		376001,
		5,
		5,
		"4:90316:1"
	},
	{
		376001,
		6,
		6,
		"8:1:250000"
	},
	{
		376001,
		7,
		7,
		"4:510022:3"
	},
	{
		376001,
		8,
		8,
		"8:1:250000"
	},
	{
		376001,
		9,
		9,
		"4:400002:100"
	}
}
local t_ling_shen_convene_progress_prize = {
	[376001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9]
	}
}

t_ling_shen_convene_progress_prize.dataList = dataList

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

return t_ling_shen_convene_progress_prize
