-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_sky_peak_stage_round_circle.lua

module("logicconfig.config.t_sky_peak_stage_round_circle", package.seeall)

local title = {
	score = 3,
	minCircle = 2,
	circleScorePlanId = 1
}
local dataList = {
	{
		1,
		1,
		200
	},
	{
		1,
		2,
		180
	},
	{
		1,
		3,
		150
	},
	{
		1,
		4,
		100
	},
	{
		1,
		6,
		50
	},
	{
		1,
		8,
		10
	}
}
local t_sky_peak_stage_round_circle = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		[6] = dataList[5],
		[8] = dataList[6]
	}
}

t_sky_peak_stage_round_circle.dataList = dataList

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

return t_sky_peak_stage_round_circle
