-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ace_team_holy_stripe_suit.lua

module("logicconfig.config.t_ace_team_holy_stripe_suit", package.seeall)

local title = {
	suitDesc = 4,
	buffs = 2,
	suitIcon = 5,
	suitName = 3,
	suitId = 1,
	cfgIds = 6
}
local dataList = {
	{
		1,
		"20032211:99",
		"噬电之纹",
		"对手剩余生命百分比越高，伤害加深越多，最高25%",
		"icon_xitong_lingwen_01",
		{
			100151,
			100152,
			100153,
			100154,
			100155
		}
	},
	{
		2,
		"20032212:99",
		"破刃刻印",
		"无视目标25%防御",
		"icon_xitong_lingwen_02",
		{
			100251,
			100252,
			100253,
			100254,
			100255
		}
	},
	{
		3,
		"20032213:99",
		"亘古鸣雷",
		"每次出手后，永久提升伤害5%，最高可叠加6次",
		"icon_xitong_lingwen_03",
		{
			100351,
			100352,
			100353,
			100354,
			100355
		}
	},
	{
		4,
		"20032215:99",
		"御尘之纹",
		"进入战斗时，获得攻击160%的护盾值",
		"icon_xitong_lingwen_04",
		{
			100451,
			100452,
			100453,
			100454,
			100455
		}
	},
	{
		5,
		"20032217:99",
		"血誓刻印",
		"攻击附带吸血20%，每次吸血不超自身生命值的20%",
		"icon_xitong_lingwen_05",
		{
			100551,
			100552,
			100553,
			100554,
			100555
		}
	},
	{
		6,
		"20032218:99",
		"圣痕裂风",
		"生命百分比越低，伤害越高，最高30%",
		"icon_xitong_lingwen_06",
		{
			100651,
			100652,
			100653,
			100654,
			100655
		}
	},
	{
		7,
		"20032219:99",
		"沉石之纹",
		"己阵存活精灵越多，提升减伤越高，最高24%",
		"icon_xitong_lingwen_07",
		{
			100751,
			100752,
			100753,
			100754,
			100755
		}
	},
	{
		8,
		"20032226:99",
		"固结刻印",
		"反弹20%攻击伤害，不超过自身生命值的40%",
		"icon_xitong_lingwen_08",
		{
			100851,
			100852,
			100853,
			100854,
			100855
		}
	},
	{
		9,
		"20032227:99",
		"千载岩磐",
		"每次受到攻击后，提升免伤4%，最高可叠加6次",
		"icon_xitong_lingwen_09",
		{
			100951,
			100952,
			100953,
			100954,
			100955
		}
	},
	{
		10,
		"20032229:99",
		"落影之纹",
		"出手前，50%概率清除所有减益效果",
		"icon_xitong_lingwen_10",
		{
			101051,
			101052,
			101053,
			101054,
			101055
		}
	},
	{
		11,
		"20032231:99",
		"复引刻印",
		"击杀目标时，恢复自身40点气势（每个大回合限1次）",
		"icon_xitong_lingwen_11",
		{
			101151,
			101152,
			101153,
			101154,
			101155
		}
	},
	{
		12,
		"20032233:99",
		"冥刻暗咒",
		"首次死亡时，降低击杀者全属性30%(2回合)，并有20%概率眩晕击杀者",
		"icon_xitong_lingwen_12",
		{
			101251,
			101252,
			101253,
			101254,
			101255
		}
	}
}
local t_ace_team_holy_stripe_suit = {
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
	dataList[12]
}

t_ace_team_holy_stripe_suit.dataList = dataList

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

return t_ace_team_holy_stripe_suit
