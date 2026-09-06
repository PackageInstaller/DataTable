-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_dakinos_clg_phase.lua

module("logicconfig.config.t_divine_dakinos_clg_phase", package.seeall)

local title = {
	stagePlanId = 4,
	prize = 5,
	phaseId = 2,
	openDays = 3,
	activityId = 1
}
local dataList = {
	{
		400001,
		1,
		1,
		1,
		"4:31:10"
	},
	{
		400001,
		2,
		1,
		2,
		"4:36:10"
	},
	{
		400001,
		3,
		1,
		3,
		"4:246:100"
	},
	{
		400002,
		1,
		1,
		4000021,
		"4:510638:30"
	},
	{
		400002,
		2,
		1,
		4000022,
		"4:510638:30"
	},
	{
		400002,
		3,
		1,
		4000023,
		"4:510638:40"
	}
}
local t_divine_dakinos_clg_phase = {
	[400001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[400002] = {
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_divine_dakinos_clg_phase.dataList = dataList

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

return t_divine_dakinos_clg_phase
