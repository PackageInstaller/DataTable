-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_golden_dragon_clg_score_rate.lua

module("logicconfig.config.t_origin_golden_dragon_clg_score_rate", package.seeall)

local title = {
	activityId = 1,
	preStageHitCount = 2,
	scoreRate = 3
}
local dataList = {
	{
		617001,
		0,
		10000
	},
	{
		617001,
		1,
		11000
	},
	{
		617001,
		2,
		12000
	},
	{
		617001,
		3,
		14000
	},
	{
		617001,
		4,
		16000
	},
	{
		617001,
		5,
		19000
	},
	{
		617001,
		6,
		22000
	},
	{
		617001,
		7,
		25000
	}
}
local t_origin_golden_dragon_clg_score_rate = {
	[617001] = {
		[0] = dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	}
}

t_origin_golden_dragon_clg_score_rate.dataList = dataList

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

return t_origin_golden_dragon_clg_score_rate
