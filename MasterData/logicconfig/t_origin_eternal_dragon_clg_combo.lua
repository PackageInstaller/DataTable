-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_eternal_dragon_clg_combo.lua

module("logicconfig.config.t_origin_eternal_dragon_clg_combo", package.seeall)

local title = {
	name = 5,
	comboId = 2,
	typeIds = 3,
	matStr = 6,
	activityId = 1,
	desc = 4
}
local dataList = {
	{
		551001,
		1,
		{
			1,
			2
		},
		"敌阵精灵每次死亡时，敌阵全体获得10点气势",
		"春夏",
		"1004:1596:1"
	},
	{
		551001,
		2,
		{
			1,
			3
		},
		"敌阵精灵每次攻击若未击杀目标，则对该目标造成攻击力*200%的伤害",
		"春秋",
		"1004:1597:1"
	},
	{
		551001,
		3,
		{
			1,
			4
		},
		"敌阵精灵暴击率及命中率+50%",
		"春冬",
		"1004:1598:1"
	},
	{
		551001,
		4,
		{
			2,
			3
		},
		"敌阵精灵击杀目标后，获得一次立即出手（每只精灵每个大回合限1次）",
		"夏秋",
		"1004:1599:1"
	},
	{
		551001,
		5,
		{
			2,
			4
		},
		"每个大回合结束时，令敌阵随机一只死亡精灵复活恢复满血并获得50气势",
		"夏冬",
		"1004:1600:1"
	},
	{
		551001,
		6,
		{
			3,
			4
		},
		"己阵生命值最低的精灵会被标记，该精灵死亡时会对己阵全阵造成自身生命上限*50%的伤害",
		"秋冬",
		"1004:1601:1"
	}
}
local t_origin_eternal_dragon_clg_combo = {
	[551001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_origin_eternal_dragon_clg_combo.dataList = dataList

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

return t_origin_eternal_dragon_clg_combo
