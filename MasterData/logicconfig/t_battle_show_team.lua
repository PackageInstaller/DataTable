-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_battle_show_team.lua

module("logicconfig.config.t_battle_show_team", package.seeall)

local title = {
	btlBg = 3,
	name = 2,
	retreatMsgType = 5,
	creepsMasterId = 1,
	heroSkillId = 4
}
local dataList = {
	{
		98,
		"芒展示战斗-己方",
		"",
		"",
		2
	},
	{
		99,
		"芒展示战斗-敌方",
		"",
		"",
		2
	},
	{
		100,
		"诺亚",
		"",
		"",
		2
	},
	{
		101,
		"圣光飞龙",
		"",
		"",
		2
	},
	{
		123,
		"魔魂·暗影之子",
		"",
		"",
		2
	},
	{
		124,
		"暗怪怪",
		"",
		"",
		2
	},
	{
		125,
		"圣翼·光天使",
		"",
		"",
		2
	},
	{
		126,
		"暗怪怪",
		"",
		"",
		2
	},
	{
		127,
		"湮灭·时空圣龙",
		"",
		"",
		2
	},
	{
		3010,
		"烈阳·龙君焰",
		"",
		"",
		2
	},
	{
		3011,
		"暗怪怪",
		"",
		"",
		2
	},
	{
		3020,
		"寒战·空无流",
		"",
		"",
		2
	},
	{
		3021,
		"暗怪怪",
		"",
		"",
		2
	},
	{
		3030,
		"无畏·苍零式",
		"",
		"",
		2
	},
	{
		3031,
		"暗怪怪",
		"",
		"",
		2
	},
	{
		3040,
		"审判天神·诺亚",
		"",
		"",
		2
	},
	{
		3041,
		"暗怪怪",
		"",
		"",
		2
	},
	{
		3050,
		"炼狱魔神·修尔",
		"",
		"",
		2
	},
	{
		3051,
		"暗怪怪",
		"",
		"",
		2
	},
	{
		3060,
		"森罗灵王·阿瑞斯",
		"",
		"",
		2
	},
	{
		3061,
		"暗怪怪",
		"",
		"",
		2
	},
	{
		3070,
		"力量之王·龙炎",
		"",
		"",
		2
	},
	{
		3071,
		"暗怪怪",
		"",
		"",
		2
	},
	{
		3080,
		"苍穹圣王·帝释天",
		"",
		"",
		2
	},
	{
		3081,
		"暗怪怪",
		"",
		"",
		2
	},
	{
		3082,
		"光明·圣麒麟",
		"",
		"",
		2
	},
	{
		3083,
		"暗怪怪",
		"",
		"",
		2
	},
	{
		3084,
		"天威雷神·星格",
		"",
		"",
		2
	},
	{
		3085,
		"暗怪怪",
		"",
		"",
		2
	},
	{
		3086,
		"沙之王者·洛萨",
		"",
		"",
		2
	},
	{
		3087,
		"暗怪怪",
		"",
		"",
		2
	},
	{
		3088,
		"砂隐尊主·阿米尔",
		"",
		"",
		2
	},
	{
		3089,
		"暗怪怪",
		"",
		"",
		2
	},
	{
		3090,
		"千钧万盾·尤烈",
		"",
		"",
		2
	},
	{
		3091,
		"暗怪怪",
		"",
		"",
		2
	},
	{
		3092,
		"裁决圣者·谜",
		"",
		"",
		2
	},
	{
		3093,
		"暗怪怪",
		"",
		"",
		2
	},
	{
		3094,
		"食神·米淇淋",
		"",
		"",
		2
	},
	{
		3095,
		"暗怪怪",
		"",
		"",
		2
	},
	{
		3096,
		"魔魂·暗影之子",
		"",
		"",
		2
	},
	{
		3097,
		"暗怪怪",
		"",
		"",
		2
	},
	{
		3098,
		"圣翼·光天使",
		"",
		"",
		2
	},
	{
		3099,
		"暗怪怪",
		"",
		"",
		2
	},
	{
		3100,
		"湮灭·时空圣龙",
		"",
		"",
		2
	},
	{
		3101,
		"暗怪怪",
		"",
		"",
		2
	},
	{
		3102,
		"不败传说·星蓝龙",
		"",
		"",
		2
	},
	{
		3103,
		"暗怪怪",
		"",
		"",
		2
	},
	{
		3104,
		"记忆之神·弥梦离",
		"",
		"",
		2
	},
	{
		3105,
		"暗怪怪",
		"",
		"",
		2
	},
	{
		3106,
		"食神·米淇淋",
		"",
		"",
		2
	},
	{
		3107,
		"暗怪怪",
		"",
		"",
		2
	},
	{
		3108,
		"魄月·炽辰光",
		"",
		"",
		2
	},
	{
		3109,
		"暗怪怪",
		"",
		"",
		2
	},
	{
		3110,
		"黯墨·夜无忧",
		"",
		"",
		2
	},
	{
		3111,
		"暗怪怪",
		"",
		"",
		2
	}
}
local t_battle_show_team = {
	[98] = dataList[1],
	[99] = dataList[2],
	[100] = dataList[3],
	[101] = dataList[4],
	[123] = dataList[5],
	[124] = dataList[6],
	[125] = dataList[7],
	[126] = dataList[8],
	[127] = dataList[9],
	[3010] = dataList[10],
	[3011] = dataList[11],
	[3020] = dataList[12],
	[3021] = dataList[13],
	[3030] = dataList[14],
	[3031] = dataList[15],
	[3040] = dataList[16],
	[3041] = dataList[17],
	[3050] = dataList[18],
	[3051] = dataList[19],
	[3060] = dataList[20],
	[3061] = dataList[21],
	[3070] = dataList[22],
	[3071] = dataList[23],
	[3080] = dataList[24],
	[3081] = dataList[25],
	[3082] = dataList[26],
	[3083] = dataList[27],
	[3084] = dataList[28],
	[3085] = dataList[29],
	[3086] = dataList[30],
	[3087] = dataList[31],
	[3088] = dataList[32],
	[3089] = dataList[33],
	[3090] = dataList[34],
	[3091] = dataList[35],
	[3092] = dataList[36],
	[3093] = dataList[37],
	[3094] = dataList[38],
	[3095] = dataList[39],
	[3096] = dataList[40],
	[3097] = dataList[41],
	[3098] = dataList[42],
	[3099] = dataList[43],
	[3100] = dataList[44],
	[3101] = dataList[45],
	[3102] = dataList[46],
	[3103] = dataList[47],
	[3104] = dataList[48],
	[3105] = dataList[49],
	[3106] = dataList[50],
	[3107] = dataList[51],
	[3108] = dataList[52],
	[3109] = dataList[53],
	[3110] = dataList[54],
	[3111] = dataList[55]
}

t_battle_show_team.dataList = dataList

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

return t_battle_show_team
