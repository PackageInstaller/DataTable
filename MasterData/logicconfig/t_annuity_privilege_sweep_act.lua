-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_annuity_privilege_sweep_act.lua

module("logicconfig.config.t_annuity_privilege_sweep_act", package.seeall)

local title = {
	refuseSweepActivityIds = 3,
	passTips = 4,
	sweepPlanId = 1,
	canSweepActivityType = 2
}
local dataList = {
	{
		1,
		349,
		nil,
		"首次通关后即可按最高成绩扫荡"
	},
	{
		1,
		325,
		nil,
		"首次通关对应难度后即可扫荡"
	},
	{
		1,
		370,
		nil,
		"首次通关对应难度后即可扫荡"
	},
	{
		1,
		279,
		{
			279001
		},
		"首次通关对应难度后即可扫荡"
	},
	{
		1,
		458,
		nil,
		"首次通关后即可按最高成绩扫荡"
	},
	{
		1,
		394,
		{
			394001
		},
		"首次通关后即可按最高成绩扫荡"
	},
	{
		1,
		507,
		nil,
		"首次通关后即可按最高成绩扫荡"
	},
	{
		1,
		479,
		nil,
		"首次通关后即可按最高成绩扫荡"
	},
	{
		1,
		228,
		nil,
		"首次通关后即可按最高成绩扫荡"
	},
	{
		1,
		554,
		nil,
		"首次通关后即可按最高成绩扫荡"
	},
	{
		1,
		220,
		nil,
		"首次通关后即可按最高成绩扫荡"
	},
	{
		1,
		454,
		nil,
		"首次通关对应难度后即可扫荡"
	},
	{
		1,
		590,
		nil,
		"首次通关对应难度后即可扫荡"
	},
	{
		1,
		607,
		nil,
		"首次通关后即可按最高成绩扫荡"
	},
	{
		1,
		622,
		nil,
		"成为年费即可享受一键合成特权"
	}
}
local t_annuity_privilege_sweep_act = {
	{
		[349] = dataList[1],
		[325] = dataList[2],
		[370] = dataList[3],
		[279] = dataList[4],
		[458] = dataList[5],
		[394] = dataList[6],
		[507] = dataList[7],
		[479] = dataList[8],
		[228] = dataList[9],
		[554] = dataList[10],
		[220] = dataList[11],
		[454] = dataList[12],
		[590] = dataList[13],
		[607] = dataList[14],
		[622] = dataList[15]
	}
}

t_annuity_privilege_sweep_act.dataList = dataList

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

return t_annuity_privilege_sweep_act
