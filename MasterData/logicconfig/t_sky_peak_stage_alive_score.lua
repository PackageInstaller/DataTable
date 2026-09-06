-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_sky_peak_stage_alive_score.lua

module("logicconfig.config.t_sky_peak_stage_alive_score", package.seeall)

local title = {
	score = 3,
	aliveScorePlanId = 1,
	aliveNum = 2
}
local dataList = {
	{
		1,
		6,
		200
	},
	{
		1,
		5,
		180
	},
	{
		1,
		4,
		150
	},
	{
		1,
		3,
		100
	},
	{
		1,
		2,
		50
	},
	{
		1,
		1,
		10
	}
}
local t_sky_peak_stage_alive_score = {
	{
		[6] = dataList[1],
		[5] = dataList[2],
		[4] = dataList[3],
		[3] = dataList[4],
		[2] = dataList[5],
		dataList[6]
	}
}

t_sky_peak_stage_alive_score.dataList = dataList

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

return t_sky_peak_stage_alive_score
