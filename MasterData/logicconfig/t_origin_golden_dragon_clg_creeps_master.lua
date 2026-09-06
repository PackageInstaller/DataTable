-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_golden_dragon_clg_creeps_master.lua

module("logicconfig.config.t_origin_golden_dragon_clg_creeps_master", package.seeall)

local title = {
	creepsMasterId = 1,
	name = 2,
	WinDesc = 6,
	skipTime = 3,
	formCondition = 9,
	btlBg = 4,
	selfBuffProviderId = 10,
	winId = 7,
	perfectWinId = 8,
	heroSkillId = 5
}
local dataList = {
	{
		1001,
		"源起黄金圣龙挑战-1",
		5,
		"",
		"",
		"",
		0,
		0,
		0,
		0
	},
	{
		1002,
		"源起黄金圣龙挑战-2",
		5,
		"",
		"",
		"",
		0,
		0,
		0,
		0
	},
	{
		1003,
		"源起黄金圣龙挑战-3",
		5,
		"",
		"",
		"",
		0,
		0,
		0,
		0
	},
	{
		1004,
		"源起黄金圣龙挑战-4",
		5,
		"",
		"",
		"",
		0,
		0,
		0,
		0
	},
	{
		1005,
		"源起黄金圣龙挑战-5",
		5,
		"",
		"",
		"",
		0,
		0,
		0,
		0
	},
	{
		1006,
		"源起黄金圣龙挑战-6",
		5,
		"",
		"",
		"",
		0,
		0,
		0,
		0
	},
	{
		1007,
		"源起黄金圣龙挑战-7",
		5,
		"",
		"",
		"",
		0,
		0,
		0,
		0
	},
	{
		1008,
		"源起黄金圣龙挑战-8",
		5,
		"",
		"",
		"",
		0,
		0,
		0,
		0
	}
}
local t_origin_golden_dragon_clg_creeps_master = {
	[1001] = dataList[1],
	[1002] = dataList[2],
	[1003] = dataList[3],
	[1004] = dataList[4],
	[1005] = dataList[5],
	[1006] = dataList[6],
	[1007] = dataList[7],
	[1008] = dataList[8]
}

t_origin_golden_dragon_clg_creeps_master.dataList = dataList

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

return t_origin_golden_dragon_clg_creeps_master
