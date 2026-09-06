-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_cute_pet_introduce.lua

module("logicconfig.config.t_cute_pet_introduce", package.seeall)

local title = {
	parentId = 4,
	raceId = 5,
	title = 6,
	imagePath = 8,
	desc = 7,
	tabName = 2,
	id = 1,
	redId = 9,
	tabType = 3
}
local dataList = {
	{
		1,
		"限时福利",
		1,
		0,
		0,
		"",
		"",
		"",
		-348
	},
	{
		2,
		"萌宠介绍",
		1,
		0,
		0,
		"",
		"",
		"",
		-349
	},
	{
		3,
		"爆爆龙",
		2,
		2,
		1,
		"爆爆龙",
		"类型：<color=#a27a5a>爆裂宠 乘胜追击</color>\r\n\r\n精灵推荐：<color=#a27a5a>多单位阵容克星</color>\r\n\r\n满级庇护技能：<color=#a27a5a>每有一个血量低于50%或阵亡的敌方单位，提高自身7%的伤害</color>",
		"ui/bigbg/chongwuyuanintro/board_cwmjbsx_bbl.png",
		0
	},
	{
		4,
		"海龙兽",
		2,
		2,
		2,
		"海龙兽",
		"类型：<color=#a27a5a>制衡宠 回复增益</color>\r\n\r\n精灵推荐：<color=#a27a5a>吸血自愈精灵、友军治疗</color>\r\n\r\n满级庇护技能：<color=#a27a5a>每次恢复血量后，永久提升5%命中率和2%暴击率，最高叠加5次</color>",
		"ui/bigbg/chongwuyuanintro/board_cwmjbsx_hls.png",
		0
	},
	{
		5,
		"三叶兽",
		2,
		2,
		3,
		"三叶兽",
		"类型：<color=#a27a5a>乖乖宠 治疗护盾</color>\r\n\r\n精灵推荐：<color=#a27a5a>治疗、护盾阵容</color>\r\n\r\n满级庇护技能：<color=#a27a5a>使用治疗技能时，为受疗单位附加治疗量30%的护盾，有护盾的友方单位提高10%免伤</color>",
		"ui/bigbg/chongwuyuanintro/board_cwmjbsx_sys.png",
		0
	},
	{
		6,
		"波波鸟",
		2,
		2,
		4,
		"波波鸟",
		"类型：<color=#a27a5a>爆裂宠 失手增益</color>\r\n\r\n精灵推荐：<color=#a27a5a>格挡、闪避克星</color>\r\n\r\n满级庇护技能：<color=#a27a5a>攻击被格挡或闪避时，自身获得30点气势，并提高下次出手15%伤害</color>",
		"ui/bigbg/chongwuyuanintro/board_cwmjbsx_bbn.png",
		0
	},
	{
		7,
		"小伏妖",
		2,
		2,
		5,
		"小伏妖",
		"类型：<color=#a27a5a>爆裂宠 收割增伤</color>\r\n\r\n精灵推荐：<color=#a27a5a>高爆发高输出精灵</color>\r\n\r\n满级庇护技能：<color=#a27a5a>击杀目标时，提高自身8%伤害和4%攻击力，最多叠加5层</color>",
		"ui/bigbg/chongwuyuanintro/board_cwmjbsx_fy.png",
		0
	},
	{
		8,
		"小妖王",
		2,
		2,
		6,
		"小妖王",
		"类型：<color=#a27a5a>制衡宠 蓄力增伤</color>\r\n\r\n精灵推荐：<color=#a27a5a>后排输出精灵，配合队友保护</color>\r\n\r\n满级庇护技能：<color=#a27a5a>每回合结束时，如果本回合未受到伤害，则提高下次出手20%伤害，并提高20气势</color>",
		"ui/bigbg/chongwuyuanintro/board_cwmjbsx_cy.png",
		0
	},
	{
		9,
		"滑板小诺",
		2,
		2,
		7,
		"滑板小诺",
		"类型：<color=#a27a5a>乖乖宠 登场高闪</color>\r\n\r\n精灵推荐：<color=#a27a5a>闪避增益精灵，提高前期生存</color>\r\n\r\n满级庇护技能：<color=#a27a5a>进入战斗时提高35%闪避率，每次受击减少5%闪避率，最多减少2次</color>",
		"ui/bigbg/chongwuyuanintro/board_cwmjbsx_hbxn.png",
		0
	},
	{
		10,
		"战士小诺",
		2,
		2,
		8,
		"战士小诺",
		"类型：<color=#a27a5a>制衡宠 中期加气</color>\r\n\r\n精灵推荐：<color=#a27a5a>中慢速阵容</color>\r\n\r\n满级庇护技能：<color=#a27a5a>第1回合后，每回合开始时获得30点气势</color>",
		"ui/bigbg/chongwuyuanintro/board_cwmjbsx_zsxn.png",
		0
	},
	{
		11,
		"学生小诺",
		2,
		2,
		9,
		"学生小诺",
		"类型：<color=#a27a5a>制衡宠 降低气势</color>\r\n\r\n精灵推荐：<color=#a27a5a>群体攻击、多段攻击精灵</color>\r\n\r\n满级庇护技能：<color=#a27a5a>攻击降低目标20点气势，40%概率额外降低30点气势</color>",
		"ui/bigbg/chongwuyuanintro/board_cwmjbsx_xsxn.png",
		0
	},
	{
		12,
		"西装小炎",
		2,
		2,
		10,
		"西装小炎",
		"类型：<color=#a27a5a>铁甲宠 保护核心</color>\r\n\r\n精灵推荐：<color=#a27a5a>高格挡精灵，克制敌阵开场爆发</color>\r\n\r\n满级庇护技能：<color=#a27a5a>进入战斗时，使生命最高的友军格挡率暂时提高35%并附带自身格挡率（持续2个大回合，不可叠加，上限80%）</color>",
		"ui/bigbg/chongwuyuanintro/board_cwmjbsx_xzxx.png",
		0
	},
	{
		13,
		"运动小炎",
		2,
		2,
		11,
		"运动小炎",
		"类型：<color=#a27a5a>铁甲宠 残血回复</color>\r\n\r\n精灵推荐：<color=#a27a5a>前排精灵</color>\r\n\r\n满级庇护技能：<color=#a27a5a>前两次生命低于50%后，回复最大生命35%血量和获得35%最大生命值护盾，并减免20%伤害（不可叠加，持续2个大回合）</color>",
		"ui/bigbg/chongwuyuanintro/board_cwmjbsx_ydxx.png",
		0
	},
	{
		14,
		"勇者小炎",
		2,
		2,
		12,
		"勇者小炎",
		"类型：<color=#a27a5a>爆裂宠 残血斩杀</color>\r\n\r\n精灵推荐：<color=#a27a5a>坦克、boss克星</color>\r\n\r\n满级庇护技能：<color=#a27a5a>目标血量低于50%时，提高20%暴击率和10%暴击伤害</color>",
		"ui/bigbg/chongwuyuanintro/board_cwmjbsx_yzxx.png",
		0
	},
	{
		15,
		"暗黑梦梦",
		2,
		2,
		13,
		"暗黑梦梦",
		"类型：<color=#a27a5a>爆裂宠 乘胜追击</color>\r\n\r\n精灵推荐：<color=#a27a5a>核心输出</color>\r\n\r\n满级庇护技能：<color=#a27a5a>攻击前，令自身提高X*5%暴击率和X*5暴击伤害（X为己阵精灵存活数量）</color>",
		"ui/bigbg/chongwuyuanintro/board_cwmjbsx_ahmm.png",
		0
	},
	{
		16,
		"哆啦梦梦",
		2,
		2,
		14,
		"哆啦梦梦",
		"类型：<color=#a27a5a>铁甲宠 受击回血</color>\r\n\r\n精灵推荐：<color=#a27a5a>前排职业泛用宠物</color>\r\n\r\n满级庇护技能：<color=#a27a5a>进入战斗时令自身及己阵攻击力最高的一只精灵获得20%免伤（不可叠加，持续2个大回合），每次受击后，自身血量低于60%，则恢复自身12%血量</color>",
		"ui/bigbg/chongwuyuanintro/board_cwmjbsx_dlmm.png",
		0
	},
	{
		17,
		"王者梦梦",
		2,
		2,
		15,
		"王者梦梦",
		"类型：<color=#a27a5a>制衡宠 护盾攻防</color>\r\n\r\n精灵推荐：<color=#a27a5a>平衡职业泛用宠物</color>\r\n\r\n满级庇护技能：<color=#a27a5a>进入战斗时获得自身最大生命值*40%的护盾，每次受到伤害时，永久提升5%攻击和8%防御，最高叠加5次</color>",
		"ui/bigbg/chongwuyuanintro/board_cwmjbsx_wzmm.png",
		0
	},
	{
		18,
		"爱心梦梦",
		2,
		2,
		16,
		"爱心梦梦",
		"类型：<color=#a27a5a>乖乖宠 暴击治疗</color>\r\n\r\n精灵推荐：<color=#a27a5a>治疗职业泛用宠物</color>\r\n\r\n满级庇护技能：<color=#a27a5a>暴击率提升20%，自身每有1%暴击率则转换成0.4%治疗效果，使用治疗技能暴击时，为受疗单位附加治疗量20%的护盾并提高20%攻击（不叠加，持续1个大回合）</color>",
		"ui/bigbg/chongwuyuanintro/board_cwmjbsx_axmm.png",
		0
	},
	{
		19,
		"炼金梦梦",
		2,
		2,
		17,
		"炼金梦梦",
		"类型：<color=#a27a5a>制衡宠 格挡回血</color>\r\n\r\n精灵推荐：<color=#a27a5a>平衡职业泛用宠物</color>\r\n\r\n满级庇护技能：<color=#a27a5a>格挡率提升15%，每次格挡时，恢复自身10%血量并降低伤害来源15点气势</color>",
		"ui/bigbg/chongwuyuanintro/board_cwmjbsx_ljmm.png",
		0
	},
	{
		20,
		"热血梦梦",
		2,
		2,
		18,
		"热血梦梦",
		"类型：<color=#a27a5a>爆裂宠 气势增伤</color>\r\n\r\n精灵推荐：<color=#a27a5a>后排输出精灵</color>\r\n\r\n满级庇护技能：<color=#a27a5a>攻击前，自身每有12点气势则提高1%伤害</color>",
		"ui/bigbg/chongwuyuanintro/board_cwmjbsx_rxmm.png",
		0
	}
}
local t_cute_pet_introduce = {
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
	dataList[14],
	dataList[15],
	dataList[16],
	dataList[17],
	dataList[18],
	dataList[19],
	dataList[20]
}

t_cute_pet_introduce.dataList = dataList

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

return t_cute_pet_introduce
