-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_upcoming_unlock_show_plan.lua

module("logicconfig.config.t_upcoming_unlock_show_plan", package.seeall)

local title = {
	bgPath = 3,
	id = 2,
	showPrizePlan = 5,
	showDescPlan = 7,
	showPrizes = 4,
	activityId = 1,
	showDescs = 6
}
local dataList = {
	{
		181009,
		1,
		"board_shenyaoshengqi_04",
		"",
		1,
		{
			"圣骑通灵 群攻天灾\n神曜圣骑·苍穹天闪5.30强势进化，挑战&至尊召唤得",
			"神曜圣骑队全员挑战、神器置换、荣耀塔均常驻，收集&养成队伍领限时称号、解锁背包海报！"
		},
		1
	},
	{
		181009,
		2,
		"board_shenyaoshengqi_08",
		"",
		1,
		{
			"圣骑召唤 回血加气\n神曜圣骑·万象迷踪6.6归来，挑战得",
			"“圣骑荣归”活动限时开启，邀好友归来完成任务获得积分抽switch、苹果耳机、京东卡、周边礼盒等好礼！"
		},
		1
	},
	{
		181009,
		3,
		"board_shenyaoshengqi_09",
		"",
		1,
		{
			"群攻降气 复活出手\n神曜圣骑·疾刃阎罗6.20进化，挑战得",
			"“圣骑团远征”副本玩法开启，经营养成最强圣骑团，征战区域BOSS！"
		},
		1
	},
	{
		181009,
		4,
		"board_shenyaoshengqi_07",
		"",
		1,
		{
			"减伤免负 必中目标\n神曜圣骑·审判光轮5.30登场，活跃得",
			"“圣骑竞技”火热开启，参与指定系列竞技玩法角逐竞技之王！排行得动态头像框/动态头像"
		},
		1
	},
	{
		181009,
		5,
		"board_shenyaoshengqi_05",
		"",
		1,
		{
			"圣骑英雄 连携追击\n神曜圣骑·红莲烈心6.6登场，挑战&购买月卡赠送",
			"全新臻品【童真蜜语·卡雅】、性转皮肤【玫色氤氲·无烬神女】、圣品皮肤【恋颂序言·无限未来】即将上线"
		},
		1
	},
	{
		181009,
		6,
		"board_shenyaoshengqi_06",
		"",
		1,
		{
			"高额非伤 灼烧目标\n神曜圣骑·怒麟炎神6.13进化，挑战得",
			"版本翻倍：失落遗迹翻倍/精灵助战上新/萌宠翻倍等\n时间之门高阶挑战上新，神曜王次/龙皇诺亚/神曜时空；普通挑战上新，神曜蜜西西"
		},
		1
	},
	{
		181012,
		1,
		"board_tc_521",
		"",
		1,
		{
			"1、梦队英雄 护盾减伤\n真理之智·哆啦梦梦5.29常驻，活跃得，送3专属红星！",
			"2、新皮肤：页游复刻皮肤，再无世间薄伽丘、妖邪禁域·昆仑；王者梦梦足球主题皮肤\n3、送服饰/装饰：世界杯竞猜上线，参与竞猜赢大奖"
		},
		1
	},
	{
		181012,
		2,
		"board_tc_518",
		"",
		1,
		{
			"1、梦队召唤 格挡加气\n铸贤翠金·炼金梦梦6.5常驻，挑战得，送3专属红星！",
			"2、时间之门：源起王者次元6.5上新/挑战常驻：源起帝释天、冰灵王挑战常驻"
		},
		1
	},
	{
		181012,
		3,
		"board_tc_516",
		"",
		1,
		{
			"1、梦队通灵 连击禁疗\n幽冥夜刃·暗黑梦梦6.5常驻，挑战得，送3专属红星！",
			"2、神唤卡池：限时心愿单必中；神钻卡池更新薄伽丘等精灵\n3、优化：开放120帧率；装备一键突破，装备替换面板调整；小诺助手更新；"
		},
		1
	},
	{
		181012,
		4,
		"board_tc_517",
		"",
		1,
		{
			"1、五梦合体 辅助出手\n祈唤璨梦·王者梦梦5.29登场，挑战&至尊召唤得！",
			"2、送梦队＆红星：参与版本活动得普通梦队、梦队神曜材料、王者梦梦、梦队红星、神器、坐骑自选箱、皮肤自选箱！"
		},
		1
	},
	{
		181012,
		5,
		"board_tc_519",
		"",
		1,
		{
			"1、高额治疗 群体复活\n心咏成歌·爱心梦梦6.19常驻，挑战得，送3专属红星！",
			"2、梦梦通行证：性价比拉满，梦之队神器、红星自选领不停，邀好友拼团返神钻！"
		},
		1
	},
	{
		181012,
		6,
		"board_tc_520",
		"",
		1,
		{
			"1、全阵加气 灼烧重生\n猛火战狂·热血梦梦6.12常驻，挑战得，送3专属红星！",
			"2、回归奖励调整：回归奖励新增红星碎片、红星、精灵自选箱加入六道通灵师神曜材料；\n3、大神帮打源起梦队享增益；王者竞技场新增竞技BUFF"
		},
		1
	}
}
local t_upcoming_unlock_show_plan = {
	[181009] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	},
	[181012] = {
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	}
}

t_upcoming_unlock_show_plan.dataList = dataList

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

return t_upcoming_unlock_show_plan
