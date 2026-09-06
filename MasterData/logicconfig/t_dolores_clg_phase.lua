-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dolores_clg_phase.lua

module("logicconfig.config.t_dolores_clg_phase", package.seeall)

local title = {
	stagePlanId = 4,
	openDay = 3,
	phaseId = 2,
	passNum = 5,
	activityId = 1
}
local dataList = {
	{
		524001,
		1,
		1,
		1,
		3
	},
	{
		524001,
		2,
		1,
		2,
		5
	},
	{
		524001,
		3,
		1,
		3,
		7
	},
	{
		524002,
		1,
		1,
		4,
		3
	},
	{
		524002,
		2,
		1,
		5,
		5
	},
	{
		524002,
		3,
		1,
		6,
		7
	}
}
local t_dolores_clg_phase = {
	[524001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[524002] = {
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_dolores_clg_phase.dataList = dataList

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

return t_dolores_clg_phase
