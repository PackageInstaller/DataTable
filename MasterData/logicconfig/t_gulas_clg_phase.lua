-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_gulas_clg_phase.lua

module("logicconfig.config.t_gulas_clg_phase", package.seeall)

local title = {
	stagePlanId = 4,
	prize = 3,
	phaseId = 2,
	matchBuffId = 5,
	activityId = 1,
	notMatchBuffId = 6
}
local dataList = {
	{
		437001,
		1,
		"4:420:10",
		1,
		2,
		1
	},
	{
		437001,
		2,
		"4:420:10",
		2,
		2,
		1
	},
	{
		437001,
		3,
		"4:420:20",
		3,
		2,
		1
	},
	{
		437001,
		4,
		"4:420:20",
		4,
		2,
		1
	},
	{
		437001,
		5,
		"4:420:30",
		5,
		2,
		1
	},
	{
		437001,
		6,
		"4:420:30",
		6,
		2,
		1
	},
	{
		437002,
		1,
		"4:510680:10",
		7,
		4,
		3
	},
	{
		437002,
		2,
		"4:510680:10",
		8,
		4,
		3
	},
	{
		437002,
		3,
		"4:510680:15",
		9,
		4,
		3
	},
	{
		437002,
		4,
		"4:510680:15",
		10,
		4,
		3
	},
	{
		437002,
		5,
		"4:510680:25",
		11,
		4,
		3
	},
	{
		437002,
		6,
		"4:510680:25",
		12,
		4,
		3
	}
}
local t_gulas_clg_phase = {
	[437001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	},
	[437002] = {
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	}
}

t_gulas_clg_phase.dataList = dataList

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

return t_gulas_clg_phase
