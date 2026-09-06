-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_dual_dragon_clg_phase.lua

module("logicconfig.config.t_divine_dual_dragon_clg_phase", package.seeall)

local title = {
	stagePlanId = 4,
	phasePlanId = 1,
	phaseId = 2,
	prize = 3
}
local dataList = {
	{
		1,
		1,
		"4:282:5",
		1
	},
	{
		1,
		2,
		"4:282:10",
		2
	},
	{
		1,
		3,
		"4:282:10",
		3
	},
	{
		1,
		4,
		"4:282:35",
		4
	},
	{
		1,
		5,
		"4:282:40",
		5
	},
	{
		2,
		1,
		"8:1:1",
		6
	},
	{
		2,
		2,
		"8:1:1",
		7
	},
	{
		2,
		3,
		"8:1:1",
		8
	},
	{
		2,
		4,
		"8:1:1",
		9
	},
	{
		2,
		5,
		"8:1:1",
		10
	}
}
local t_divine_dual_dragon_clg_phase = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	},
	{
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	}
}

t_divine_dual_dragon_clg_phase.dataList = dataList

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

return t_divine_dual_dragon_clg_phase
