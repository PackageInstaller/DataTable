-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_chop_king_first_clg_buff.lua

module("logicconfig.config.t_chop_king_first_clg_buff", package.seeall)

local title = {
	buffDesc = 4,
	quality = 6,
	buffId = 2,
	buffName = 3,
	iconPath = 5,
	activityId = 1
}
local dataList = {
	{
		470001,
		1,
		"起始气势",
		"己阵起始气势+50点",
		"icon_expedition_kaichangqishi",
		3
	},
	{
		470001,
		2,
		"恢复生命",
		"每个大回合结束时，恢复己阵存活精灵20%生命值",
		"icon_expedition_kaichanghuixue",
		3
	},
	{
		470001,
		3,
		"增伤",
		"造成的伤害+20%",
		"icon_expedition_shanghaitisheng",
		3
	},
	{
		470001,
		4,
		"减伤",
		"受到的伤害-20%",
		"icon_expedition_dikang_quan",
		3
	},
	{
		470001,
		5,
		"回气",
		"每个大回合结束时，己阵存活精灵气势+30点",
		"icon_expedition_yadao01",
		3
	},
	{
		470001,
		6,
		"吸血",
		"攻击时吸血40%",
		"icon_expedition_chaoshahuixue",
		3
	},
	{
		470001,
		7,
		"暴击伤害",
		"暴击伤害+50%",
		"icon_expedition_baojilv1",
		3
	},
	{
		470001,
		8,
		"攻击降气",
		"攻击后，降低目标30气势",
		"icon_expedition_suijidebuff",
		3
	},
	{
		470001,
		9,
		"受击降气",
		"受击后，降低目标30气势",
		"icon_expedition_6huihezhongjie",
		3
	},
	{
		470001,
		10,
		"全属性",
		"全属性（不包括生命上限）+20%",
		"icon_expedition_yuzhanyuyong",
		3
	}
}
local t_chop_king_first_clg_buff = {
	[470001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	}
}

t_chop_king_first_clg_buff.dataList = dataList

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

return t_chop_king_first_clg_buff
