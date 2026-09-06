-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_dragon_boss_buff_plan.lua

module("logicconfig.config.t_king_dragon_boss_buff_plan", package.seeall)

local title = {
	text = 3,
	buffId = 4,
	dailyBuffPlanId = 1,
	days = 2
}
local dataList = {
	{
		1,
		1,
		"己阵全属性+20%",
		21
	},
	{
		1,
		2,
		"敌阵受到的光系伤害+20%",
		22
	},
	{
		1,
		3,
		"敌阵受到的暗系伤害+20%",
		23
	},
	{
		1,
		4,
		"每回合结束时气势+30",
		24
	},
	{
		1,
		5,
		"己阵暴击率+40%",
		25
	},
	{
		1,
		6,
		"敌阵受到暴击伤害增加100%",
		26
	},
	{
		1,
		7,
		"己阵首次受击时必定闪避",
		27
	},
	{
		1,
		8,
		"己阵全属性+20%",
		21
	},
	{
		1,
		9,
		"敌阵受到的光系伤害+20%",
		22
	},
	{
		1,
		10,
		"敌阵受到的暗系伤害+20%",
		23
	},
	{
		1,
		11,
		"每回合结束时气势+30",
		24
	},
	{
		1,
		12,
		"己阵暴击率+40%",
		25
	},
	{
		1,
		13,
		"敌阵受到暴击伤害增加100%",
		26
	},
	{
		1,
		14,
		"己阵首次受击时必定闪避",
		27
	}
}
local t_king_dragon_boss_buff_plan = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14]
	}
}

t_king_dragon_boss_buff_plan.dataList = dataList

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

return t_king_dragon_boss_buff_plan
