-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_big_cast_challenge_buff.lua

module("logicconfig.config.t_big_cast_challenge_buff", package.seeall)

local title = {
	buffRes = 5,
	name = 3,
	buffId = 1,
	type = 2,
	desc = 4
}
local dataList = {
	{
		1001,
		1,
		"生命强化",
		"生命+5%",
		"icon_expedition_chaoshahuixue"
	},
	{
		1002,
		1,
		"力量强化",
		"攻击+4%",
		"icon_expedition_chaoshahoumianyi"
	},
	{
		1003,
		1,
		"物理防御",
		"物防+8%",
		"icon_expedition_dikang_quan"
	},
	{
		1004,
		1,
		"魔法防御",
		"魔防+8%",
		"icon_expedition_dikang_quan"
	},
	{
		1005,
		1,
		"弱点专攻",
		"暴击率+10%",
		"icon_expedition_jingzhun01"
	},
	{
		1006,
		1,
		"重击",
		"物理伤害提升8%",
		"icon_expedition_wugongtisheng"
	},
	{
		1007,
		2,
		"聚能",
		"魔法伤害提升8%",
		"icon_expedition_xieli01"
	},
	{
		2001,
		2,
		"大爆破",
		"敌阵精灵死亡时，会自爆伤害友军",
		"icon_expedition_zengshang"
	},
	{
		2002,
		2,
		"无限火力",
		"己方精灵每次出手后满气势",
		"icon_expedition_yuzhanyuyong"
	},
	{
		2003,
		2,
		"坚如磐石",
		"己方5号位精灵前10次受击几乎不受伤害",
		"icon_expedition_guijia01"
	},
	{
		2004,
		2,
		"同生共死",
		"己方精灵平均抗伤",
		"icon_expedition_yadao"
	},
	{
		2005,
		2,
		"有如神助",
		"己方所有精灵必定暴击",
		"icon_expedition_yisun"
	}
}
local t_big_cast_challenge_buff = {
	[1001] = dataList[1],
	[1002] = dataList[2],
	[1003] = dataList[3],
	[1004] = dataList[4],
	[1005] = dataList[5],
	[1006] = dataList[6],
	[1007] = dataList[7],
	[2001] = dataList[8],
	[2002] = dataList[9],
	[2003] = dataList[10],
	[2004] = dataList[11],
	[2005] = dataList[12]
}

t_big_cast_challenge_buff.dataList = dataList

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

return t_big_cast_challenge_buff
