-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_dragon_login_task_plan.lua

module("logicconfig.config.t_king_dragon_login_task_plan", package.seeall)

local title = {
	loginTaskPlanId = 1,
	name = 4,
	days = 2,
	prize = 3,
	desc = 5
}
local dataList = {
	{
		1,
		1,
		"4:150:400",
		"累计登录",
		"活动期间内，累计登录1天"
	},
	{
		1,
		2,
		"4:150:400",
		"累计登录",
		"活动期间内，累计登录2天"
	},
	{
		1,
		3,
		"4:150:400",
		"累计登录",
		"活动期间内，累计登录3天"
	},
	{
		1,
		5,
		"4:150:400",
		"累计登录",
		"活动期间内，累计登录4天"
	},
	{
		1,
		7,
		"4:150:400",
		"累计登录",
		"活动期间内，累计登录5天"
	},
	{
		1,
		9,
		"4:150:400",
		"累计登录",
		"活动期间内，累计登录6天"
	},
	{
		1,
		10,
		"4:150:400",
		"累计登录",
		"活动期间内，累计登录7天"
	},
	{
		2,
		1,
		"4:158:400",
		"累计登录",
		"活动期间内，累计登录1天"
	},
	{
		2,
		2,
		"4:158:400",
		"累计登录",
		"活动期间内，累计登录2天"
	},
	{
		2,
		3,
		"4:158:400",
		"累计登录",
		"活动期间内，累计登录3天"
	},
	{
		2,
		4,
		"4:158:400",
		"累计登录",
		"活动期间内，累计登录4天"
	},
	{
		2,
		5,
		"4:158:400",
		"累计登录",
		"活动期间内，累计登录5天"
	},
	{
		2,
		6,
		"4:158:400",
		"累计登录",
		"活动期间内，累计登录6天"
	},
	{
		2,
		7,
		"4:158:400",
		"累计登录",
		"活动期间内，累计登录7天"
	}
}
local t_king_dragon_login_task_plan = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		[5] = dataList[4],
		[7] = dataList[5],
		[9] = dataList[6],
		[10] = dataList[7]
	},
	{
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14]
	}
}

t_king_dragon_login_task_plan.dataList = dataList

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

return t_king_dragon_login_task_plan
