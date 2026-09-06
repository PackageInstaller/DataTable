-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_jiu_normal_clg_phase.lua

module("logicconfig.config.t_jiu_normal_clg_phase", package.seeall)

local title = {
	activityId = 1,
	name = 3,
	phaseId = 2,
	openTime = 4
}
local dataList = {
	{
		386001,
		1,
		"万灵",
		"2024-07-02T05:00:00"
	},
	{
		386001,
		2,
		"始祖",
		"2024-07-03T05:00:00"
	},
	{
		386001,
		3,
		"幻化",
		"2024-07-04T05:00:00"
	},
	{
		386002,
		1,
		"万灵",
		"2024-07-02T05:00:00"
	},
	{
		386002,
		2,
		"始祖",
		"2024-07-03T05:00:00"
	},
	{
		386002,
		3,
		"幻化",
		"2024-07-04T05:00:00"
	}
}
local t_jiu_normal_clg_phase = {
	[386001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[386002] = {
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_jiu_normal_clg_phase.dataList = dataList

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

return t_jiu_normal_clg_phase
