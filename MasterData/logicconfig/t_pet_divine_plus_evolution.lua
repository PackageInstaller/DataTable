-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pet_divine_plus_evolution.lua

module("logicconfig.config.t_pet_divine_plus_evolution", package.seeall)

local title = {
	beginTime = 3,
	DescBubble_before = 9,
	DescBubble_after2 = 11,
	jumpTo = 8,
	evolutionType = 12,
	txt = 7,
	newRaceId = 2,
	DescBubble_after = 10,
	petValidator = 6,
	goodsCost = 4,
	raceId = 1,
	des = 5
}
local dataList = {
	{
		10324,
		14013,
		nil,
		"4:510153:100",
		"放入<color=#cd7800>圣域·黄金圣龙</color>继承觉醒&等级；放入<color=#cd7800>光系</color>精灵不继承",
		"Race$10324&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		10027,
		14014,
		nil,
		"4:510158:100",
		"放入<color=#cd7800>破空·圣光飞龙</color>继承觉醒&等级；放入<color=#cd7800>光系</color>精灵不继承",
		"Race$10027&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		10097,
		12009,
		nil,
		"4:510165:100",
		"放入<color=#cd7800>女皇·末炎</color>继承觉醒&等级；放入<color=#cd7800>火系</color>精灵不继承",
		"Race$10097&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		12004,
		12016,
		nil,
		"4:510169:100",
		"放入<color=#cd7800>赤龙银甲·火次元</color>继承觉醒&等级；放入<color=#cd7800>火系</color>精灵不继承",
		"Race$12004&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		10339,
		15016,
		nil,
		"4:510184:100",
		"放入<color=#cd7800>暗黑梦梦</color>继承觉醒&等级；放入<color=#cd7800>暗系</color>精灵不继承",
		"Race$10339&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		10338,
		11009,
		nil,
		"4:510183:100",
		"放入<color=#cd7800>哆啦梦梦</color>继承觉醒&等级；放入<color=#cd7800>水系</color>精灵不继承",
		"Race$10338&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		10341,
		13007,
		nil,
		"4:510192:100",
		"放入<color=#cd7800>炼金梦梦</color>继承觉醒&等级；放入<color=#cd7800>草系</color>精灵不继承",
		"Race$10341&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		10342,
		12017,
		nil,
		"4:510193:100",
		"放入<color=#cd7800>热血梦梦</color>继承觉醒&等级；放入<color=#cd7800>火系</color>精灵不继承",
		"Race$10342&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		10343,
		14015,
		nil,
		"4:510191:100",
		"放入<color=#cd7800>爱心梦梦</color>继承觉醒&等级；放入<color=#cd7800>光系</color>精灵不继承",
		"Race$10343&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		11002,
		11011,
		nil,
		"4:510203:100",
		"放入<color=#cd7800>神罚·秩序圣龙</color>继承觉醒&等级；放入<color=#cd7800>水系</color>精灵不继承",
		"Race$11002&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		10098,
		11013,
		nil,
		"4:510204:100",
		"放入<color=#cd7800>寒魄·冰灵王</color>继承觉醒&等级；放入<color=#cd7800>水系</color>精灵不继承",
		"Race$10098&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		10144,
		13009,
		nil,
		"4:510211:100",
		"放入<color=#cd7800>生命王者·阿瑞斯</color>继承觉醒&等级；放入<color=#cd7800>草系</color>精灵不继承",
		"Race$10144&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		10099,
		13010,
		nil,
		"4:510214:100",
		"放入<color=#cd7800>战神·天蛮王</color>继承觉醒&等级；放入<color=#cd7800>草系</color>精灵不继承",
		"Race$10099&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		10313,
		14016,
		nil,
		"4:510228:100",
		"放入<color=#cd7800>万象·次元圣龙</color>继承觉醒&等级；",
		"Race$10313&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>万象·次元圣龙</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>次元之心</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量万象·次元圣龙专属魂",
		"1.次元之心<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>只获得</color>1级0觉醒神曜万象·次元圣龙",
		1
	},
	{
		10127,
		11018,
		nil,
		"4:510229:100",
		"放入<color=#cd7800>不败传说·星蓝龙</color>继承觉醒&等级；放入<color=#cd7800>水系</color>精灵不继承",
		"Race$10127&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		17003,
		17014,
		nil,
		"4:510233:100",
		"放入<color=#cd7800>天元·王者圣龙</color>继承觉醒&等级；放入<color=#cd7800>创系</color>精灵不继承",
		"Race$17003&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		10145,
		14018,
		nil,
		"4:211:100",
		"放入<color=#cd7800>时间王者·诺亚</color>继承觉醒&等级；放入<color=#cd7800>光系</color>精灵不继承",
		"Race$10145&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		10100,
		14019,
		nil,
		"4:210:100",
		"放入<color=#cd7800>神圣·光明王</color>继承觉醒&等级；放入<color=#cd7800>光系</color>精灵不继承",
		"Race$10100&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		10101,
		15017,
		nil,
		"4:215:100",
		"放入<color=#cd7800>极夜·月影王</color>继承觉醒&等级；放入<color=#cd7800>暗系</color>精灵不继承",
		"Race$10101&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		10146,
		15018,
		nil,
		"4:217:100",
		"放入<color=#cd7800>是非王者·修尔</color>继承觉醒&等级；放入<color=#cd7800>暗系</color>精灵不继承",
		"Race$10146&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		15014,
		15024,
		nil,
		"4:226:100",
		"放入<color=#cd7800>轮回之神·正理 </color>继承觉醒&等级；放入<color=#cd7800>暗系</color>精灵不继承",
		"Race$15014&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		17002,
		17015,
		nil,
		"4:510256:100",
		"放入<color=#cd7800>神爵·龙尊圣主</color>继承觉醒&等级；放入<color=#cd7800>创系</color>精灵不继承",
		"Race$17002&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		16002,
		16021,
		nil,
		"4:510260:100",
		"放入<color=#cd7800>学神·帝一鸣</color>继承觉醒&等级；放入<color=#cd7800>空系</color>精灵不继承",
		"Race$16002&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		16004,
		16022,
		nil,
		"4:510259:100",
		"放入<color=#cd7800>星宙·超神圣龙</color>继承觉醒&等级；放入<color=#cd7800>空系</color>精灵不继承",
		"Race$16004&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		10143,
		12018,
		nil,
		"4:510279:100",
		"放入<color=#cd7800>力量王者·龙炎</color>继承觉醒&等级；放入<color=#cd7800>火系</color>精灵不继承",
		"Race$10143&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		10326,
		12019,
		nil,
		"4:510280:100",
		"放入<color=#cd7800>焚世·赤焰龙皇</color>继承觉醒&等级；放入<color=#cd7800>火系</color>精灵不继承",
		"Race$10326&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		10314,
		12021,
		nil,
		"4:510281:100",
		"放入<color=#cd7800>烈焰·无烬圣龙</color>继承觉醒&等级；放入<color=#cd7800>火系</color>精灵不继承",
		"Race$10314&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		16006,
		11019,
		nil,
		"4:510291:100",
		"放入<color=#cd7800>璨境女神·星绛</color>继承觉醒&等级；放入<color=#cd7800>水系</color>精灵不继承",
		"Race$16006&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		16003,
		11020,
		nil,
		"4:234:100",
		"放入<color=#cd7800>神临王者·秩序</color>继承觉醒&等级；放入<color=#cd7800>水系</color>精灵不继承",
		"Race$16003&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		10142,
		11021,
		nil,
		"4:233:100",
		"放入<color=#cd7800>智慧王者·帝释天</color>继承觉醒&等级；放入<color=#cd7800>水系</color>精灵不继承",
		"Race$10142&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		10308,
		11022,
		nil,
		"4:510290:100",
		"放入<color=#cd7800>隐刺·维多利亚</color>继承觉醒&等级；放入<color=#cd7800>水系</color>精灵不继承",
		"Race$10308&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		13006,
		13014,
		nil,
		"4:510300:100",
		"放入<color=#cd7800>生命女神·盖西瑞</color>继承觉醒&等级；放入<color=#cd7800>草系</color>精灵不继承",
		"Race$13006&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		10167,
		13016,
		nil,
		"4:510301:100",
		"放入<color=#cd7800>梦蝶·潘多拉</color>继承觉醒&等级；放入<color=#cd7800>草系</color>精灵不继承",
		"Race$10167&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		13005,
		13018,
		nil,
		"4:235:100",
		"放入<color=#cd7800>赫魔莉·青骨</color>继承觉醒&等级；放入<color=#cd7800>草系</color>精灵不继承",
		"Race$13005&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		16008,
		16025,
		nil,
		"4:238:100",
		"放入<color=#cd7800>同心相伴·蜜蕊可</color>继承觉醒&等级；放入<color=#cd7800>空系</color>精灵不继承",
		"Race$16008&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		16001,
		16026,
		nil,
		"4:510318:100",
		"放入<color=#cd7800>解神意志·赤</color>继承觉醒&等级；",
		"Race$16001&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>解神意志·赤</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>解神之心</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜解神·赤专属魂",
		"1.解神之心<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>只获得</color>1级0觉醒神曜解神·赤",
		1
	},
	{
		17001,
		17017,
		nil,
		"4:245:100",
		"放入<color=#cd7800>梦魇始魔·莱莉丝</color>继承觉醒&等级；放入<color=#cd7800>创系</color>精灵不继承",
		"Race$17001&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		17008,
		17019,
		nil,
		"4:248:100",
		"放入<color=#cd7800>创世天命·弥娅</color>继承觉醒&等级；放入<color=#cd7800>创系</color>精灵不继承",
		"Race$17008&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		17006,
		17020,
		nil,
		"4:510334:100",
		"放入<color=#cd7800>晞光神魔·修诺</color>继承觉醒&等级；放入<color=#cd7800>创系</color>精灵不继承",
		"Race$17006&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		17004,
		17021,
		nil,
		"4:246:100",
		"放入<color=#cd7800>暗祭·达克诺斯</color>继承觉醒&等级；放入<color=#cd7800>创系</color>精灵不继承",
		"Race$17004&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		14000,
		14026,
		nil,
		"4:510360:100",
		"放入<color=#cd7800>昼夜女神·诺雅</color>继承觉醒&等级；放入<color=#cd7800>光系</color>精灵不继承",
		"Race$14000&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		14011,
		14027,
		nil,
		"4:510361:100",
		"放入<color=#cd7800>神崇王者·次元</color>继承觉醒&等级；放入<color=#cd7800>光系</color>精灵不继承",
		"Race$14011&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		15013,
		15026,
		nil,
		"4:510373:100",
		"放入<color=#cd7800>殛魔之主·安</color>继承觉醒&等级；放入<color=#cd7800>暗系</color>精灵不继承",
		"Race$15013&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		15006,
		15027,
		nil,
		"4:510376:100",
		"放入<color=#cd7800>无限时空·龙尊</color>继承觉醒&等级；放入<color=#cd7800>暗系</color>精灵不继承",
		"Race$15006&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		10322,
		15028,
		nil,
		"4:510365:100",
		"放入<color=#cd7800>花语·伊丽莎白</color>继承觉醒&等级；放入<color=#cd7800>暗系</color>精灵不继承",
		"Race$10322&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		16009,
		16027,
		nil,
		"4:510378:100",
		"放入<color=#cd7800>伙伴意志·极</color>继承觉醒&等级；放入<color=#cd7800>空系</color>精灵不继承",
		"Race$16009&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		16000,
		16029,
		nil,
		"4:259:100",
		"放入<color=#cd7800>命运·梵天</color>继承觉醒&等级；放入<color=#cd7800>空系</color>精灵不继承",
		"Race$16000&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		16011,
		16030,
		nil,
		"4:258:100",
		"放入<color=#cd7800>无序之神·昧</color>继承觉醒&等级；放入<color=#cd7800>空系</color>精灵不继承",
		"Race$16011&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		10309,
		12025,
		nil,
		"4:510402:100",
		"放入<color=#cd7800>暴力少女·茜茜</color>继承觉醒&等级；放入<color=#cd7800>火系</color>精灵不继承",
		"Race$10309&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		13004,
		13020,
		nil,
		"4:260:100",
		"放入<color=#cd7800>绝息者·楼那</color>继承觉醒&等级；放入<color=#cd7800>草系</color>精灵不继承",
		"Race$13004&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		12005,
		12024,
		nil,
		"4:510392:100",
		"放入<color=#cd7800>迷魇之主·维蕾塔</color>继承觉醒&等级；放入<color=#cd7800>火系</color>精灵不继承",
		"Race$12005&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		10129,
		13021,
		nil,
		"4:264:100",
		"放入<color=#cd7800>混元天命·真龙</color>继承觉醒&等级；放入<color=#cd7800>草系</color>精灵不继承",
		"Race$10129&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		13008,
		13022,
		nil,
		"4:265:100",
		"放入<color=#cd7800>不朽枯木·永恒圣龙</color>继承觉醒&等级；放入<color=#cd7800>草系</color>精灵不继承",
		"Race$13008&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		11003,
		11027,
		nil,
		"4:263:100",
		"放入<color=#cd7800>八卦信使·蜜西西</color>继承觉醒&等级；放入<color=#cd7800>水系</color>精灵不继承",
		"Race$11003&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		10327,
		12029,
		nil,
		"4:266:100",
		"放入<color=#cd7800>记忆之神·弥梦离</color>继承觉醒&等级；放入<color=#cd7800>火系</color>精灵不继承",
		"Race$10327&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		16014,
		16031,
		nil,
		"4:510447:100",
		"放入<color=#cd7800>命定之恶·尘</color>继承觉醒&等级；放入<color=#cd7800>空系</color>精灵不继承",
		"Race$16014&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		16005,
		16032,
		nil,
		"4:268:100",
		"放入<color=#cd7800>无限未来·∞</color>继承觉醒&等级；放入<color=#cd7800>空系</color>精灵不继承",
		"Race$16005&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		13013,
		13023,
		nil,
		"4:270:100",
		"放入<color=#cd7800>创界天衍·昆仑</color>继承觉醒&等级；放入<color=#cd7800>草系</color>精灵不继承",
		"Race$13013&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		17010,
		16033,
		nil,
		"4:272:100",
		"放入<color=#cd7800>龙魂王者·极</color>继承觉醒&等级；放入<color=#cd7800>空系</color>精灵不继承",
		"Race$17010&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		14017,
		14032,
		nil,
		"4:510493:100",
		"放入<color=#cd7800>无上战主·无敌</color>继承觉醒&等级；放入<color=#cd7800>光系</color>精灵不继承",
		"Race$14017&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		14020,
		14033,
		nil,
		"4:280:100",
		"放入<color=#cd7800>昼夜王者·诺雅</color>继承觉醒&等级；放入<color=#cd7800>光系</color>精灵不继承",
		"Race$14020&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		10323,
		14034,
		nil,
		"4:275:100",
		"放入<color=#cd7800>夜羽执事·洛世琦</color>继承觉醒&等级；放入<color=#cd7800>光系</color>精灵不继承",
		"Race$10323&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		15007,
		15034,
		nil,
		"4:274:100",
		"放入<color=#cd7800>神王·星洛</color>继承觉醒&等级；放入<color=#cd7800>暗系</color>精灵不继承",
		"Race$15007&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		16016,
		16034,
		nil,
		"4:282:100",
		"放入<color=#cd7800>神判·双生圣龙</color>继承觉醒&等级；放入<color=#cd7800>空系</color>精灵不继承",
		"Race$16016&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		11007,
		11029,
		nil,
		"4:286:100",
		"放入<color=#cd7800>圣骑·天闪</color>继承觉醒&等级；放入<color=#cd7800>水系</color>精灵不继承",
		"Race$11007&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		14008,
		14035,
		nil,
		"4:287:100",
		"放入<color=#cd7800>圣骑·光轮</color>继承觉醒&等级；放入<color=#cd7800>光系</color>精灵不继承",
		"Race$14008&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		12007,
		12031,
		"2025-06-06T05:00:00",
		"4:288:100",
		"放入<color=#cd7800>圣骑·烈心</color>继承觉醒&等级；放入<color=#cd7800>水系</color>精灵不继承",
		"Race$12007&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		13001,
		13024,
		"2025-06-06T05:00:00",
		"4:283:100",
		"放入<color=#cd7800>圣骑·迷踪</color>继承觉醒&等级；放入<color=#cd7800>光系</color>精灵不继承",
		"Race$13001&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		12008,
		12032,
		"2025-06-13T05:00:00",
		"4:289:100",
		"放入<color=#cd7800>圣骑·炎神</color>继承觉醒&等级；放入<color=#cd7800>火系</color>精灵不继承",
		"Race$12008&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		15011,
		15035,
		"2025-06-20T05:00:00",
		"4:285:100",
		"放入<color=#cd7800>圣骑·阎罗</color>继承觉醒&等级；放入<color=#cd7800>暗系</color>精灵不继承",
		"Race$15011&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		16019,
		16035,
		"2025-06-27T05:00:00",
		"4:296:100",
		"放入<color=#cd7800>命运神谕·女帝</color>继承觉醒&等级；放入<color=#cd7800>空系</color>精灵不继承",
		"Race$16019&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		16020,
		16036,
		"2025-06-27T05:00:00",
		"4:293:100",
		"放入<color=#cd7800>造物王者·以撒</color>继承觉醒&等级；放入<color=#cd7800>空系</color>精灵不继承",
		"Race$16020&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		16012,
		16037,
		"2025-07-04T05:00:00",
		"4:291:100",
		"放入<color=#cd7800>灵界枷锁·费因</color>继承觉醒&等级；放入<color=#cd7800>空系</color>精灵不继承",
		"Race$16012&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		12014,
		12033,
		"2025-07-25T05:00:00",
		"4:299:100",
		"放入<color=#cd7800>神堕虚无·伏妖</color>继承觉醒&等级；放入<color=#cd7800>火系</color>精灵不继承",
		"Race$12014&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		12011,
		12035,
		"2025-08-01T05:00:00",
		"4:387:100",
		"放入<color=#cd7800>死亡魔君·路西法</color>继承觉醒&等级；放入<color=#cd7800>火系</color>精灵不继承",
		"Race$12011&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		12012,
		12036,
		"2025-08-01T05:00:00",
		"4:298:100",
		"放入<color=#cd7800>征战诡影·余灰</color>继承觉醒&等级；放入<color=#cd7800>火系</color>精灵不继承",
		"Race$12012&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		11014,
		11030,
		"2025-08-22T05:00:00",
		"4:394:100",
		"放入<color=#cd7800>逆海吞天·兰德斯</color>继承觉醒&等级；放入<color=#cd7800>水系</color>精灵不继承",
		"Race$11014&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		11012,
		11032,
		"2025-08-22T05:00:00",
		"4:395:100",
		"放入<color=#cd7800>神执统帅·特莎姆</color>继承觉醒&等级；放入<color=#cd7800>水系</color>精灵不继承",
		"Race$11012&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		16010,
		16040,
		"2025-08-29T05:00:00",
		"4:391:100",
		"放入<color=#cd7800>离阳龙脉·敖九</color>继承觉醒&等级；",
		"Race$16010&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>离阳龙脉·敖九</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>敖九之心</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜离阳·敖九专属魂",
		"1.敖九之心<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>只获得</color>1级0觉醒离阳龙脉·敖九",
		1
	},
	{
		11017,
		11034,
		"2025-09-12T05:00:00",
		"4:390:100",
		"放入<color=#cd7800>业火若水·天炎</color>继承觉醒&等级；放入<color=#cd7800>水系</color>精灵不继承",
		"Race$11017&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		14023,
		14038,
		"2025-10-01T09:00:00",
		"4:396:100",
		"放入<color=#cd7800>希望之神·夏因</color>继承觉醒&等级；放入<color=#cd7800>光系</color>精灵不继承",
		"Race$14023&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		12020,
		12038,
		"2025-09-26T05:00:00",
		"4:510580:100",
		"放入<color=#cd7800>六道之祸·终绯</color>继承觉醒&等级；放入<color=#cd7800>火系</color>精灵不继承",
		"Race$12020&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		14024,
		14037,
		"2025-09-29T05:00:00",
		"4:510581:100",
		"放入<color=#cd7800>恒古王者·时空龙尊</color>继承觉醒&等级；放入<color=#cd7800>光系</color>精灵不继承",
		"Race$14024&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		10205,
		15036,
		"2025-09-26T05:00:00",
		"4:397:100",
		"放入<color=#cd7800>玄冥天龙</color>继承觉醒&等级；放入<color=#cd7800>暗系</color>精灵不继承",
		"Race$10205&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		10345,
		11035,
		"2025-10-03T05:00:00",
		"4:398:100",
		"放入<color=#cd7800>龙女·耶梦加得</color>继承觉醒&等级；放入<color=#cd7800>水系</color>精灵不继承",
		"Race$10345&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		15022,
		15038,
		"2025-10-24T05:00:00",
		"4:510598:100",
		"放入<color=#cd7800>绘笔灵花·缪可</color>继承觉醒&等级；放入<color=#cd7800>暗系</color>精灵不继承",
		"Race$15022&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		15021,
		15037,
		"2025-10-24T05:00:00",
		"4:510608:100",
		"放入<color=#cd7800>毁灭暴君·法纳斯</color>继承觉醒&等级；放入<color=#cd7800>暗系</color>精灵不继承",
		"Race$15021&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		15020,
		15039,
		"2025-10-31T05:00:00",
		"4:400:100",
		"放入<color=#cd7800>暗星王者·超神</color>继承觉醒&等级；放入<color=#cd7800>暗系</color>精灵不继承",
		"Race$15020&Level$大于等于,1&AwakenLevel$大于等于,0",
		"神格突破",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量神曜专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒神曜精灵",
		1
	},
	{
		10330,
		15043,
		"2025-11-28T05:00:00",
		"4:510635:100",
		"放入<color=#cd7800>灭世魔女·艾希</color>继承觉醒&等级；放入<color=#cd7800>暗系</color>精灵不继承",
		"Race$10330&Level$大于等于,1&AwakenLevel$大于等于,0",
		"源起进化",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量源起专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒源起精灵",
		2
	},
	{
		14026,
		14039,
		"2025-11-21T05:00:00",
		"4:430:100",
		"放入<color=#cd7800>神曜昼夜·诺雅</color>继承觉醒&等级；放入<color=#cd7800>光系</color>精灵不继承",
		"Race$14026&Level$大于等于,1&AwakenLevel$大于等于,0",
		"源起进化",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量源起专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒源起精灵",
		2
	},
	{
		15018,
		15042,
		"2025-11-21T05:00:00",
		"4:510636:100",
		"放入<color=#cd7800>神曜魅冥·修尔</color>继承觉醒&等级；放入<color=#cd7800>暗系</color>精灵不继承",
		"Race$15018&Level$大于等于,1&AwakenLevel$大于等于,0",
		"源起进化",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量源起专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒源起精灵",
		2
	},
	{
		14010,
		14041,
		"2025-11-28T05:00:00",
		"4:510637:100",
		"放入<color=#cd7800>救世圣钥·启</color>继承觉醒&等级；放入<color=#cd7800>光系</color>精灵不继承",
		"Race$14010&Level$大于等于,1&AwakenLevel$大于等于,0",
		"源起进化",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量源起专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒源起精灵",
		2
	},
	{
		14018,
		14040,
		"2025-11-21T05:00:00",
		"4:510638:100",
		"放入<color=#cd7800>神曜时隙·诺亚</color>继承觉醒&等级；放入<color=#cd7800>光系</color>精灵不继承",
		"Race$14018&Level$大于等于,1&AwakenLevel$大于等于,0",
		"源起进化",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量源起专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒源起精灵",
		2
	},
	{
		14027,
		14042,
		"2025-12-05T09:00:00",
		"4:431:100",
		"放入<color=#cd7800>神曜崇尊·次元</color>继承觉醒&等级；放入<color=#cd7800>光系</color>精灵不继承",
		"Race$14027&Level$大于等于,1&AwakenLevel$大于等于,0",
		"源起进化",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量源起专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒源起精灵",
		2
	},
	{
		16027,
		16041,
		"2025-12-19T05:00:00",
		"4:432:100",
		"放入<color=#cd7800>神曜意志·极</color>继承觉醒&等级；放入<color=#cd7800>空系</color>精灵不继承",
		"Race$16027&Level$大于等于,1&AwakenLevel$大于等于,0",
		"源起进化",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量源起专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒源起精灵",
		2
	},
	{
		16029,
		16042,
		"2025-12-19T05:00:00",
		"4:510647:100",
		"放入<color=#cd7800>神曜命星·梵天</color>继承觉醒&等级；放入<color=#cd7800>空系</color>精灵不继承",
		"Race$16029&Level$大于等于,1&AwakenLevel$大于等于,0",
		"源起进化",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量源起专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒源起精灵",
		2
	},
	{
		16021,
		16043,
		"2025-12-26T05:00:00",
		"4:434:100",
		"放入<color=#cd7800>神曜学神·帝一鸣</color>继承觉醒&等级；放入<color=#cd7800>空系</color>精灵不继承",
		"Race$16021&Level$大于等于,1&AwakenLevel$大于等于,0",
		"源起进化",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量源起专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒源起精灵",
		2
	},
	{
		16028,
		16044,
		"2026-01-02T05:00:00",
		"4:510648:100",
		"放入<color=#cd7800>时隙龙脉·诺亚</color>继承觉醒&等级；放入<color=#cd7800>空系</color>精灵不继承",
		"Race$16028&Level$大于等于,1&AwakenLevel$大于等于,0",
		"源起进化",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量源起专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒源起精灵",
		2
	},
	{
		16022,
		16045,
		"2026-01-09T05:00:00",
		"4:510645:100",
		"放入<color=#cd7800>神曜星宙·超神圣龙</color>继承觉醒&等级；放入<color=#cd7800>空系</color>精灵不继承",
		"Race$16022&Level$大于等于,1&AwakenLevel$大于等于,0",
		"源起进化",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量源起专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒源起精灵",
		2
	},
	{
		13014,
		13025,
		"2026-01-16T05:00:00",
		"4:510678:100",
		"放入<color=#cd7800>神曜晨曦·盖西瑞</color>继承觉醒&等级；放入<color=#cd7800>草系</color>精灵不继承",
		"Race$13014&Level$大于等于,1&AwakenLevel$大于等于,0",
		"源起进化",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量源起专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒源起精灵",
		2
	},
	{
		13009,
		13026,
		"2026-01-16T05:00:00",
		"4:510679:100",
		"放入<color=#cd7800>神曜永恒·阿瑞斯</color>继承觉醒&等级；放入<color=#cd7800>草系</color>精灵不继承",
		"Race$13009&Level$大于等于,1&AwakenLevel$大于等于,0",
		"源起进化",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量源起专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒源起精灵",
		2
	},
	{
		13010,
		13027,
		"2026-01-23T05:00:00",
		"4:510680:100",
		"放入<color=#cd7800>神曜八荒·天蛮王</color>继承觉醒&等级；放入<color=#cd7800>草系</color>精灵不继承",
		"Race$13010&Level$大于等于,1&AwakenLevel$大于等于,0",
		"源起进化",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量源起专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒源起精灵",
		2
	},
	{
		13022,
		13028,
		"2026-01-30T05:00:00",
		"4:510681:100",
		"放入<color=#cd7800>神曜不朽·永恒圣龙</color>继承觉醒&等级；放入<color=#cd7800>草系</color>精灵不继承",
		"Race$13022&Level$大于等于,1&AwakenLevel$大于等于,0",
		"源起进化",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量源起专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒源起精灵",
		2
	},
	{
		13015,
		13029,
		"2026-01-30T05:00:00",
		"4:510682:100",
		"放入<color=#cd7800>森境圣灵·卡雅</color>继承觉醒&等级；放入<color=#cd7800>草系</color>精灵不继承",
		"Race$13015&Level$大于等于,1&AwakenLevel$大于等于,0",
		"源起进化",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量源起专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒源起精灵",
		2
	},
	{
		12024,
		12040,
		"2026-02-13T05:00:00",
		"4:510698:100",
		"放入<color=#cd7800>神曜迷魇·维蕾塔</color>继承觉醒&等级；放入<color=#cd7800>火系</color>精灵不继承",
		"Race$12024&Level$大于等于,1&AwakenLevel$大于等于,0",
		"源起进化",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量源起专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒源起精灵",
		2
	},
	{
		12021,
		12041,
		"2026-02-16T09:00:00",
		"4:510703:100",
		"放入<color=#cd7800>神曜烈焰·无烬圣龙</color>继承觉醒&等级；放入<color=#cd7800>火系</color>精灵不继承",
		"Race$12021&Level$大于等于,1&AwakenLevel$大于等于,0",
		"源起进化",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量源起专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒源起精灵",
		2
	},
	{
		12018,
		12042,
		"2026-02-13T05:00:00",
		"4:510702:100",
		"放入<color=#cd7800>神曜狂焰·龙炎</color>继承觉醒&等级；放入<color=#cd7800>火系</color>精灵不继承",
		"Race$12018&Level$大于等于,1&AwakenLevel$大于等于,0",
		"源起进化",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量源起专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒源起精灵",
		2
	},
	{
		12009,
		12043,
		"2026-02-20T05:00:00",
		"4:510701:100",
		"放入<color=#cd7800>神曜莲火·末炎</color>继承觉醒&等级；放入<color=#cd7800>火系</color>精灵不继承",
		"Race$12009&Level$大于等于,1&AwakenLevel$大于等于,0",
		"源起进化",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量源起专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒源起精灵",
		2
	},
	{
		12023,
		12044,
		"2026-02-20T05:00:00",
		"4:510700:100",
		"放入<color=#cd7800>炽莲王者·末炎</color>继承觉醒&等级；放入<color=#cd7800>火系</color>精灵不继承",
		"Race$12023&Level$大于等于,1&AwakenLevel$大于等于,0",
		"源起进化",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量源起专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒源起精灵",
		2
	},
	{
		12016,
		12045,
		"2026-02-27T05:00:00",
		"4:510699:100",
		"放入<color=#cd7800>神曜赤甲·火次元</color>继承觉醒&等级；放入<color=#cd7800>火系</color>精灵不继承",
		"Race$12016&Level$大于等于,1&AwakenLevel$大于等于,0",
		"源起进化",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量源起专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒源起精灵",
		2
	},
	{
		11019,
		11036,
		"2026-03-13T05:00:00",
		"4:510724:100",
		"放入<color=#cd7800>神曜璨境·星绛</color>继承觉醒&等级；放入<color=#cd7800>水系</color>精灵不继承",
		"Race$11019&Level$大于等于,1&AwakenLevel$大于等于,0",
		"源起进化",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量源起专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒源起精灵",
		2
	},
	{
		11011,
		11037,
		"2026-03-13T09:00:00",
		"4:510722:100",
		"放入<color=#cd7800>神曜法则·秩序圣龙</color>继承觉醒&等级；放入<color=#cd7800>水系</color>精灵不继承",
		"Race$11011&Level$大于等于,1&AwakenLevel$大于等于,0",
		"源起进化",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量源起专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒源起精灵",
		2
	},
	{
		11013,
		11038,
		"2026-03-20T05:00:00",
		"4:510725:100",
		"放入<color=#cd7800>神曜寒魄·冰灵王</color>继承觉醒&等级；放入<color=#cd7800>水系</color>精灵不继承",
		"Race$11013&Level$大于等于,1&AwakenLevel$大于等于,0",
		"源起进化",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量源起专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒源起精灵",
		2
	},
	{
		11021,
		11039,
		"2026-03-20T05:00:00",
		"4:510727:100",
		"放入<color=#cd7800>神曜星寰·帝释天</color>继承觉醒&等级；放入<color=#cd7800>水系</color>精灵不继承",
		"Race$11021&Level$大于等于,1&AwakenLevel$大于等于,0",
		"源起进化",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量源起专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒源起精灵",
		2
	},
	{
		11020,
		11040,
		"2026-03-27T05:00:00",
		"4:510726:100",
		"放入<color=#cd7800>神曜王者·秩序</color>继承觉醒&等级；放入<color=#cd7800>水系</color>精灵不继承",
		"Race$11020&Level$大于等于,1&AwakenLevel$大于等于,0",
		"源起进化",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量源起专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒源起精灵",
		2
	},
	{
		17018,
		17025,
		"2026-04-03T05:00:00",
		"4:510760:100",
		"放入<color=#cd7800>万灵始祖·究</color>继承觉醒&等级；放入<color=#cd7800>创系</color>精灵不继承",
		"Race$17018&Level$大于等于,1&AwakenLevel$大于等于,0",
		"源起进化",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量源起专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒源起精灵",
		2
	},
	{
		17016,
		17028,
		"2026-04-10T05:00:00",
		"4:510746:100",
		"放入<color=#cd7800>神国百相·权天使</color>继承觉醒&等级；放入<color=#cd7800>创系</color>精灵不继承",
		"Race$17016&Level$大于等于,1&AwakenLevel$大于等于,0",
		"源起进化",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量源起专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒源起精灵",
		2
	},
	{
		17015,
		17029,
		"2026-04-17T09:00:00",
		"4:510747:100",
		"放入<color=#cd7800>神曜权御·龙尊圣主</color>继承觉醒&等级；放入<color=#cd7800>创系</color>精灵不继承",
		"Race$17015&Level$大于等于,1&AwakenLevel$大于等于,0",
		"源起进化",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量源起专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒源起精灵",
		2
	},
	{
		15026,
		15044,
		"2026-05-01T05:00:00",
		"4:510776:100",
		"放入<color=#cd7800>神曜殛主·安</color>继承觉醒&等级；放入<color=#cd7800>暗系</color>精灵不继承",
		"Race$15026&Level$大于等于,1&AwakenLevel$大于等于,0",
		"源起进化",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量源起专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒源起精灵",
		2
	},
	{
		15027,
		15045,
		"2026-04-30T09:00:00",
		"4:510779:100",
		"放入<color=#cd7800>神曜时空·龙尊</color>继承觉醒&等级；放入<color=#cd7800>暗系</color>精灵不继承",
		"Race$15027&Level$大于等于,1&AwakenLevel$大于等于,0",
		"源起进化",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量源起专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒源起精灵",
		2
	},
	{
		10183,
		15046,
		"2026-04-30T05:00:00",
		"4:510777:100",
		"放入<color=#cd7800>炼狱·暗天使</color>继承觉醒&等级；放入<color=#cd7800>暗系</color>精灵不继承",
		"Race$10183&Level$大于等于,1&AwakenLevel$大于等于,0",
		"源起进化",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量源起专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒源起精灵",
		2
	},
	{
		15017,
		15047,
		"2026-05-08T05:00:00",
		"4:510780:100",
		"放入<color=#cd7800>神曜永夜·月影王</color>继承觉醒&等级；放入<color=#cd7800>暗系</color>精灵不继承",
		"Race$15017&Level$大于等于,1&AwakenLevel$大于等于,0",
		"源起进化",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量源起专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒源起精灵",
		2
	},
	{
		15028,
		15048,
		"2026-05-08T05:00:00",
		"4:510781:100",
		"放入<color=#cd7800>神曜花语·伊丽莎白</color>继承觉醒&等级；放入<color=#cd7800>暗系</color>精灵不继承",
		"Race$15028&Level$大于等于,1&AwakenLevel$大于等于,0",
		"源起进化",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量源起专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒源起精灵",
		2
	},
	{
		15024,
		15049,
		"2026-05-15T05:00:00",
		"4:510778:100",
		"放入<color=#cd7800>神曜轮回·正理</color>继承觉醒&等级；放入<color=#cd7800>暗系</color>精灵不继承",
		"Race$15024&Level$大于等于,1&AwakenLevel$大于等于,0",
		"源起进化",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量源起专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒源起精灵",
		2
	},
	{
		15016,
		15050,
		"2026-06-05T05:00:00",
		"4:510798:100",
		"放入<color=#cd7800>神曜佑魂·暗黑梦梦</color>继承觉醒&等级；放入<color=#cd7800>暗系</color>精灵不继承",
		"Race$15016&Level$大于等于,1&AwakenLevel$大于等于,0",
		"源起进化",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量源起专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒源起精灵",
		2
	},
	{
		11010,
		11041,
		"2026-05-29T05:00:00",
		"4:510803:100",
		"放入<color=#cd7800>祈唤璨星·王者梦梦</color>继承觉醒&等级；放入<color=#cd7800>水系</color>精灵不继承",
		"Race$11010&Level$大于等于,1&AwakenLevel$大于等于,0",
		"源起进化",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量源起专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒源起精灵",
		2
	},
	{
		11009,
		11042,
		"2026-05-29T05:00:00",
		"4:510802:100",
		"放入<color=#cd7800>神曜极睿·哆啦梦梦</color>继承觉醒&等级；放入<color=#cd7800>水系</color>精灵不继承",
		"Race$11009&Level$大于等于,1&AwakenLevel$大于等于,0",
		"源起进化",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量源起专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒源起精灵",
		2
	},
	{
		13007,
		13031,
		"2026-06-05T05:00:00",
		"4:510801:100",
		"放入<color=#cd7800>神曜启蒙·炼金梦梦</color>继承觉醒&等级；放入<color=#cd7800>草系</color>精灵不继承",
		"Race$13007&Level$大于等于,1&AwakenLevel$大于等于,0",
		"源起进化",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量源起专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒源起精灵",
		2
	},
	{
		12017,
		12046,
		"2026-06-12T05:00:00",
		"4:510799:100",
		"放入<color=#cd7800>神曜炽火·热血梦梦</color>继承觉醒&等级；放入<color=#cd7800>火系</color>精灵不继承",
		"Race$12017&Level$大于等于,1&AwakenLevel$大于等于,0",
		"源起进化",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量源起专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒源起精灵",
		2
	},
	{
		14015,
		14044,
		"2026-06-19T05:00:00",
		"4:510800:100",
		"放入<color=#cd7800>神曜天使·爱心梦梦</color>继承觉醒&等级；放入<color=#cd7800>光系</color>精灵不继承",
		"Race$14015&Level$大于等于,1&AwakenLevel$大于等于,0",
		"源起进化",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量源起专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒源起精灵",
		2
	},
	{
		14016,
		14045,
		"2026-06-26T09:00:00",
		"4:510826:100",
		"放入<color=#cd7800>神曜万象·次元龙尊</color>继承觉醒&等级；",
		"Race$14016&Level$大于等于,1&AwakenLevel$大于等于,0",
		"源起进化",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量源起专属魂",
		"1.次元之心<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>只获得</color>1级0觉醒神曜万象·次元龙尊",
		2
	},
	{
		14013,
		14046,
		"2026-06-26T05:00:00",
		"4:510827:100",
		"放入<color=#cd7800>神曜寰宇·黄金圣龙</color>继承觉醒&等级；放入<color=#cd7800>光系</color>精灵不继承",
		"Race$14013&Level$大于等于,1&AwakenLevel$大于等于,0",
		"源起进化",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量源起专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒源起精灵",
		2
	},
	{
		14019,
		14047,
		"2026-07-03T05:00:00",
		"4:510828:100",
		"放入<color=#cd7800>神曜烈阳·光明王</color>继承觉醒&等级；放入<color=#cd7800>光系</color>精灵不继承",
		"Race$14019&Level$大于等于,1&AwakenLevel$大于等于,0",
		"源起进化",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量源起专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒源起精灵",
		2
	},
	{
		14014,
		14049,
		"2026-07-10T05:00:00",
		"4:510829:100",
		"放入<color=#cd7800>神曜苍穹·圣光飞龙</color>继承觉醒&等级；放入<color=#cd7800>光系</color>精灵不继承",
		"Race$14014&Level$大于等于,1&AwakenLevel$大于等于,0",
		"源起进化",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量源起专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒源起精灵",
		2
	},
	{
		16031,
		16046,
		"2026-07-24T05:00:00",
		"4:510844:100",
		"放入<color=#cd7800>神曜落情·尘</color>继承觉醒&等级；放入<color=#cd7800>空系</color>精灵不继承",
		"Race$16031&Level$大于等于,1&AwakenLevel$大于等于,0",
		"源起进化",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量源起专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒源起精灵",
		2
	},
	{
		12029,
		12047,
		"2026-07-31T05:00:00",
		"4:510848:100",
		"放入<color=#cd7800>神曜辉忆·弥梦离</color>继承觉醒&等级；放入<color=#cd7800>火系</color>精灵不继承",
		"Race$12029&Level$大于等于,1&AwakenLevel$大于等于,0",
		"源起进化",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量源起专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒源起精灵",
		2
	},
	{
		15031,
		15051,
		"2026-07-24T05:00:00",
		"4:510847:100",
		"放入<color=#cd7800>墨夜幽莲·末炎</color>继承觉醒&等级；放入<color=#cd7800>暗系</color>精灵不继承",
		"Race$15031&Level$大于等于,1&AwakenLevel$大于等于,0",
		"源起进化",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量源起专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒源起精灵",
		2
	},
	{
		16032,
		16047,
		"2026-07-31T05:00:00",
		"4:510846:100",
		"放入<color=#cd7800>神曜光维·无限未来</color>继承觉醒&等级；放入<color=#cd7800>空系</color>精灵不继承",
		"Race$16032&Level$大于等于,1&AwakenLevel$大于等于,0",
		"源起进化",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量源起专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒源起精灵",
		2
	},
	{
		16034,
		16048,
		"2026-08-07T09:00:00",
		"4:510845:100",
		"放入<color=#cd7800>神曜圣裁·双生圣龙</color>继承觉醒&等级；放入<color=#cd7800>空系</color>精灵不继承",
		"Race$16034&Level$大于等于,1&AwakenLevel$大于等于,0",
		"源起进化",
		"ui#lottery",
		"1.放入<color=#EB4642>指定精灵</color>，继承精灵等级和觉醒\r\n2.放入<color=#EB4642>同属性传说精灵</color>，不继承等级和觉醒",
		"1.放入指定精灵<color=#EB4642>继承</color>精灵等级\r\n2.<color=#EB4642>返还</color>放入精灵觉醒等级同等数量源起专属魂",
		"1.放入同属性传说精灵，传说精灵<color=#EB4642>被消耗</color>\r\n2.<color=#EB4642>直接</color>获得1级0觉醒源起精灵",
		2
	}
}
local t_pet_divine_plus_evolution = {
	[10324] = {
		[14013] = dataList[1]
	},
	[10027] = {
		[14014] = dataList[2]
	},
	[10097] = {
		[12009] = dataList[3]
	},
	[12004] = {
		[12016] = dataList[4]
	},
	[10339] = {
		[15016] = dataList[5]
	},
	[10338] = {
		[11009] = dataList[6]
	},
	[10341] = {
		[13007] = dataList[7]
	},
	[10342] = {
		[12017] = dataList[8]
	},
	[10343] = {
		[14015] = dataList[9]
	},
	[11002] = {
		[11011] = dataList[10]
	},
	[10098] = {
		[11013] = dataList[11]
	},
	[10144] = {
		[13009] = dataList[12]
	},
	[10099] = {
		[13010] = dataList[13]
	},
	[10313] = {
		[14016] = dataList[14]
	},
	[10127] = {
		[11018] = dataList[15]
	},
	[17003] = {
		[17014] = dataList[16]
	},
	[10145] = {
		[14018] = dataList[17]
	},
	[10100] = {
		[14019] = dataList[18]
	},
	[10101] = {
		[15017] = dataList[19]
	},
	[10146] = {
		[15018] = dataList[20]
	},
	[15014] = {
		[15024] = dataList[21]
	},
	[17002] = {
		[17015] = dataList[22]
	},
	[16002] = {
		[16021] = dataList[23]
	},
	[16004] = {
		[16022] = dataList[24]
	},
	[10143] = {
		[12018] = dataList[25]
	},
	[10326] = {
		[12019] = dataList[26]
	},
	[10314] = {
		[12021] = dataList[27]
	},
	[16006] = {
		[11019] = dataList[28]
	},
	[16003] = {
		[11020] = dataList[29]
	},
	[10142] = {
		[11021] = dataList[30]
	},
	[10308] = {
		[11022] = dataList[31]
	},
	[13006] = {
		[13014] = dataList[32]
	},
	[10167] = {
		[13016] = dataList[33]
	},
	[13005] = {
		[13018] = dataList[34]
	},
	[16008] = {
		[16025] = dataList[35]
	},
	[16001] = {
		[16026] = dataList[36]
	},
	[17001] = {
		[17017] = dataList[37]
	},
	[17008] = {
		[17019] = dataList[38]
	},
	[17006] = {
		[17020] = dataList[39]
	},
	[17004] = {
		[17021] = dataList[40]
	},
	[14000] = {
		[14026] = dataList[41]
	},
	[14011] = {
		[14027] = dataList[42]
	},
	[15013] = {
		[15026] = dataList[43]
	},
	[15006] = {
		[15027] = dataList[44]
	},
	[10322] = {
		[15028] = dataList[45]
	},
	[16009] = {
		[16027] = dataList[46]
	},
	[16000] = {
		[16029] = dataList[47]
	},
	[16011] = {
		[16030] = dataList[48]
	},
	[10309] = {
		[12025] = dataList[49]
	},
	[13004] = {
		[13020] = dataList[50]
	},
	[12005] = {
		[12024] = dataList[51]
	},
	[10129] = {
		[13021] = dataList[52]
	},
	[13008] = {
		[13022] = dataList[53]
	},
	[11003] = {
		[11027] = dataList[54]
	},
	[10327] = {
		[12029] = dataList[55]
	},
	[16014] = {
		[16031] = dataList[56]
	},
	[16005] = {
		[16032] = dataList[57]
	},
	[13013] = {
		[13023] = dataList[58]
	},
	[17010] = {
		[16033] = dataList[59]
	},
	[14017] = {
		[14032] = dataList[60]
	},
	[14020] = {
		[14033] = dataList[61]
	},
	[10323] = {
		[14034] = dataList[62]
	},
	[15007] = {
		[15034] = dataList[63]
	},
	[16016] = {
		[16034] = dataList[64]
	},
	[11007] = {
		[11029] = dataList[65]
	},
	[14008] = {
		[14035] = dataList[66]
	},
	[12007] = {
		[12031] = dataList[67]
	},
	[13001] = {
		[13024] = dataList[68]
	},
	[12008] = {
		[12032] = dataList[69]
	},
	[15011] = {
		[15035] = dataList[70]
	},
	[16019] = {
		[16035] = dataList[71]
	},
	[16020] = {
		[16036] = dataList[72]
	},
	[16012] = {
		[16037] = dataList[73]
	},
	[12014] = {
		[12033] = dataList[74]
	},
	[12011] = {
		[12035] = dataList[75]
	},
	[12012] = {
		[12036] = dataList[76]
	},
	[11014] = {
		[11030] = dataList[77]
	},
	[11012] = {
		[11032] = dataList[78]
	},
	[16010] = {
		[16040] = dataList[79]
	},
	[11017] = {
		[11034] = dataList[80]
	},
	[14023] = {
		[14038] = dataList[81]
	},
	[12020] = {
		[12038] = dataList[82]
	},
	[14024] = {
		[14037] = dataList[83]
	},
	[10205] = {
		[15036] = dataList[84]
	},
	[10345] = {
		[11035] = dataList[85]
	},
	[15022] = {
		[15038] = dataList[86]
	},
	[15021] = {
		[15037] = dataList[87]
	},
	[15020] = {
		[15039] = dataList[88]
	},
	[10330] = {
		[15043] = dataList[89]
	},
	[14026] = {
		[14039] = dataList[90]
	},
	[15018] = {
		[15042] = dataList[91]
	},
	[14010] = {
		[14041] = dataList[92]
	},
	[14018] = {
		[14040] = dataList[93]
	},
	[14027] = {
		[14042] = dataList[94]
	},
	[16027] = {
		[16041] = dataList[95]
	},
	[16029] = {
		[16042] = dataList[96]
	},
	[16021] = {
		[16043] = dataList[97]
	},
	[16028] = {
		[16044] = dataList[98]
	},
	[16022] = {
		[16045] = dataList[99]
	},
	[13014] = {
		[13025] = dataList[100]
	},
	[13009] = {
		[13026] = dataList[101]
	},
	[13010] = {
		[13027] = dataList[102]
	},
	[13022] = {
		[13028] = dataList[103]
	},
	[13015] = {
		[13029] = dataList[104]
	},
	[12024] = {
		[12040] = dataList[105]
	},
	[12021] = {
		[12041] = dataList[106]
	},
	[12018] = {
		[12042] = dataList[107]
	},
	[12009] = {
		[12043] = dataList[108]
	},
	[12023] = {
		[12044] = dataList[109]
	},
	[12016] = {
		[12045] = dataList[110]
	},
	[11019] = {
		[11036] = dataList[111]
	},
	[11011] = {
		[11037] = dataList[112]
	},
	[11013] = {
		[11038] = dataList[113]
	},
	[11021] = {
		[11039] = dataList[114]
	},
	[11020] = {
		[11040] = dataList[115]
	},
	[17018] = {
		[17025] = dataList[116]
	},
	[17016] = {
		[17028] = dataList[117]
	},
	[17015] = {
		[17029] = dataList[118]
	},
	[15026] = {
		[15044] = dataList[119]
	},
	[15027] = {
		[15045] = dataList[120]
	},
	[10183] = {
		[15046] = dataList[121]
	},
	[15017] = {
		[15047] = dataList[122]
	},
	[15028] = {
		[15048] = dataList[123]
	},
	[15024] = {
		[15049] = dataList[124]
	},
	[15016] = {
		[15050] = dataList[125]
	},
	[11010] = {
		[11041] = dataList[126]
	},
	[11009] = {
		[11042] = dataList[127]
	},
	[13007] = {
		[13031] = dataList[128]
	},
	[12017] = {
		[12046] = dataList[129]
	},
	[14015] = {
		[14044] = dataList[130]
	},
	[14016] = {
		[14045] = dataList[131]
	},
	[14013] = {
		[14046] = dataList[132]
	},
	[14019] = {
		[14047] = dataList[133]
	},
	[14014] = {
		[14049] = dataList[134]
	},
	[16031] = {
		[16046] = dataList[135]
	},
	[12029] = {
		[12047] = dataList[136]
	},
	[15031] = {
		[15051] = dataList[137]
	},
	[16032] = {
		[16047] = dataList[138]
	},
	[16034] = {
		[16048] = dataList[139]
	}
}

t_pet_divine_plus_evolution.dataList = dataList

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

return t_pet_divine_plus_evolution
