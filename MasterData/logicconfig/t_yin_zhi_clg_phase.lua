-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_yin_zhi_clg_phase.lua

module("logicconfig.config.t_yin_zhi_clg_phase", package.seeall)

local title = {
	activityId = 1,
	targetValue = 4,
	phaseId = 2,
	prize = 3
}
local dataList = {
	{
		486001,
		1,
		"4:294:20",
		1
	},
	{
		486001,
		2,
		"4:294:40",
		2
	},
	{
		486001,
		3,
		"4:294:60",
		4
	},
	{
		486002,
		1,
		"8:1:20000",
		1
	},
	{
		486002,
		2,
		"8:1:30000",
		2
	},
	{
		486002,
		3,
		"4:510725:100",
		3
	}
}
local t_yin_zhi_clg_phase = {
	[486001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[486002] = {
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_yin_zhi_clg_phase.dataList = dataList

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

return t_yin_zhi_clg_phase
