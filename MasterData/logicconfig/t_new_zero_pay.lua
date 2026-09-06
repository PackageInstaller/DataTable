-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_new_zero_pay.lua

module("logicconfig.config.t_new_zero_pay", package.seeall)

local title = {
	giftContent = 4,
	followUpGiftContent = 5,
	desc = 9,
	payGoodsId = 3,
	ext = 10,
	getJumpTo = 11,
	raceId = 12,
	maxBuyTimes = 8,
	giftId = 2,
	mailDay = 7,
	mailContent = 6,
	activityId = 1
}
local dataList = {
	{
		34001,
		1,
		"rmb_88",
		"4:90054:1#4:90055:1",
		"4:90054:1#60:1:240",
		"104:2:260",
		7,
		3,
		"<color=#ce7d10>传说梦梦</color>三选一，限定<color=#ce7d10>梦想主题时装</color>，返利<color=#ce7d10>超值购</color>！\n购买后<color=#ce7d10>邮件返钻持续7天</color>，返还期间无法购买，<color=#ce7d10>限时3周</color>，<color=#ce7d10>限购3次</color>\n首次购买后，【译梦师】时装套装将变为<color=#ce7d10>【240体力】</color>",
		"可获双倍钻石，7天共计返还1820钻",
		"func#5051",
		16015
	},
	{
		34002,
		1,
		"rmb_98",
		"4:80325:1#4:90083:1",
		"4:80325:1#4:90083:1",
		"104:2:280",
		7,
		1,
		"<color=#ce7d10>极耀圣龙之魂</color>，限定<color=#ce7d10>夜之召唤师时装</color>，返利<color=#ce7d10>超值购</color>！\n购买后<color=#ce7d10>邮件返钻持续7天</color>，返还期间无法购买，<color=#ce7d10>限时14天</color>，<color=#ce7d10>限购1次</color>\n活动时间：<color=#ce7d10>2021年7月8日05:00</color> 至 <color=#ce7d10>2021年7月22日05:00</color>",
		"可获双倍钻石，7天共计返还1960钻",
		"func#5051",
		16015
	},
	{
		34003,
		1,
		"rmb_98",
		"100:10381:1:1#1:300002:-1:1",
		"100:10381:1:1#1:300002:-1:1",
		"104:2:280",
		7,
		1,
		"<color=#00F0FF>王也直购</color>，送<color=#00F0FF>首个动态闪光时装背景</color>，返利<color=#00F0FF>超值购</color>！\n购买后<color=#00F0FF>邮件返钻持续7天</color>，返还期间无法购买，<color=#00F0FF>限时14天</color>，<color=#00F0FF>限购1次</color>\n活动时间：<color=#00F0FF>2021年7月22日05:00</color> 至 <color=#00F0FF>2021年8月5日05:00</color>",
		"可获双倍钻石，7天共计返还1960钻",
		"func#5051",
		16015
	},
	{
		34004,
		1,
		"rmb_60",
		"100:16004:1:1#13:77:1#14:77:1",
		"100:16004:1:1#13:77:1#14:77:1",
		"204:2:600",
		14,
		1,
		"<color=#00F0FF>超神圣龙直购</color>，购买后立即获得<color=#00F0FF>星宙·超神圣龙</color>，返利<color=#00F0FF>超值购</color>！\n购买后<color=#00F0FF>邮件返还神钻持续14天</color>，返还期间无法购买，活动<color=#00F0FF>限时7天</color>，<color=#00F0FF>限购1次</color>\n活动时间：<color=#00F0FF>2022年1月28日05:00</color> 至 <color=#00F0FF>2022年2月4日05:00</color>",
		"可全额返还，14天共计返还600神钻",
		"func#5051",
		16015
	},
	{
		34005,
		1,
		"rmb_60",
		"100:16006:1:1",
		"100:16006:1:1",
		"204:2:600",
		14,
		1,
		"<color=#00F0FF>璨境女神·星绛直购</color>，购买后立即获得<color=#00F0FF>璨境女神·星绛</color>，返利<color=#00F0FF>超值购</color>！\n购买后<color=#00F0FF>邮件返还神钻持续14天</color>，返还期间无法购买，活动<color=#00F0FF>限时14天</color>，<color=#00F0FF>限购1次</color>\n活动时间：<color=#00F0FF>2022年3月04日05:00</color> 至 <color=#00F0FF>2022年3月18日05:00</color>",
		"可全额返还，14天共计返还600神钻",
		"func#5051",
		16015
	},
	{
		34006,
		1,
		"rmb_60",
		"100:16008:1:1#13:85:1#14:89:1",
		"100:16008:1:1#13:85:1#14:89:1",
		"204:2:600",
		14,
		1,
		"<color=#00F0FF>同心相伴·蜜蕊可直购</color>，购买后立即获得<color=#00F0FF>同心相伴·蜜蕊可</color>，返利<color=#00F0FF>超值购</color>\n购买后<color=#00F0FF>邮件返还神钻持续14天</color>，返还期间无法购买，活动<color=#00F0FF>限时14天</color>，<color=#00F0FF>限购1次</color>\n活动时间：<color=#00F0FF>2022年4月1日05:00</color> 至 <color=#00F0FF>2022年4月29日05:00</color>",
		"可全额返还，10天共计返还400神钻",
		"func#5051",
		16015
	},
	{
		34007,
		1,
		"rmb_40",
		"100:12003:1:1#13:88:1#14:91:1",
		"100:12003:1:1#13:88:1#14:91:1",
		"204:2:400",
		10,
		1,
		"<color=#00F0FF>力量圣魂直购</color>，购买后立即获得<color=#00F0FF>力量圣魂</color>，返利<color=#00F0FF>超值购</color>\n购买后<color=#00F0FF>邮件返还神钻持续10天</color>，返还期间无法购买，活动<color=#00F0FF>限时35天</color>，<color=#00F0FF>限购1次</color>\n活动时间：<color=#00F0FF>2022年4月29日05:00</color> 至 <color=#00F0FF>2022年6月3日05:00</color>",
		"",
		"func#5051",
		16015
	},
	{
		34008,
		1,
		"rmb_40",
		"100:12006:1:1#14:97:1",
		"100:12006:1:1#14:97:1",
		"204:2:400",
		10,
		1,
		"<color=#f4e075>焱心赤羽直购</color>，购买后立即获得<color=#f4e075>焱心赤羽·凤凰 </color>，返利<color=#f4e075>超值购</color>\n购买后<color=#f4e075>邮件返还神钻持续10天</color>，返还期间无法购买，活动<color=#f4e075>限时8天</color>，<color=#f4e075>限购1次</color>\n活动时间：<color=#f4e075>2022年6月2日05:00</color> 至 <color=#f4e075>2022年6月16日05:00</color>",
		"",
		"func#5051",
		16015
	},
	{
		34009,
		1,
		"rmb_60",
		"100:17001:1:1",
		"100:17001:1:1",
		"204:2:600",
		10,
		1,
		"<color=#f4e075>梦魇始魔直购</color>，购买后立即获得<color=#f4e075>梦魇始魔·莱莉丝 </color>，返利<color=#f4e075>超值购</color>\n购买后<color=#f4e075>邮件返还神钻持续10天</color>，返还期间无法购买，活动<color=#f4e075>限时21天</color>，<color=#f4e075>限购1次</color>\n活动时间：<color=#f4e075>2022年7月1日05:00</color> 至 <color=#f4e075>2022年7月22日05:00</color>",
		"",
		"func#5051",
		16015
	},
	{
		34010,
		1,
		"rmb_60",
		"100:16012:1:1",
		"100:16012:1:1",
		"204:2:600",
		10,
		1,
		"<color=#9CE8FE>费因直购</color>，购买后立即获得<color=#9CE8FE>灵界枷锁·费因 </color>，返利<color=#9CE8FE>超值购</color>\n购买后<color=#9CE8FE>邮件返还神钻持续10天</color>，返还期间无法购买，活动<color=#9CE8FE>限时14天</color>，<color=#9CE8FE>限购1次</color>\n活动时间：<color=#9CE8FE>2023年3月3日05:00</color> 至 <color=#9CE8FE>2023年3月17日05:00</color>",
		"",
		"func#5051",
		16015
	},
	{
		34011,
		1,
		"rmb_60",
		"100:16015:1:1",
		"100:16015:1:1",
		"204:2:600",
		10,
		1,
		"<color=#fb9ffe>黛安娜直购</color>，购买后立即获得<color=#fb9ffe>封魔之主·黛安娜 </color>，返利<color=#fb9ffe>超值购</color>\n购买后<color=#fb9ffe>邮件返还神钻持续10天</color>，返还期间无法购买，活动<color=#fb9ffe>限时21天</color>，<color=#fb9ffe>限购1次</color>\n活动时间：<color=#fb9ffe>2023年4月14日05:00</color> 至 <color=#fb9ffe>2023年5月5日05:00</color>",
		"",
		"func#5051",
		16015
	},
	{
		34012,
		1,
		"rmb_60",
		"100:12013:1:1",
		"100:12013:1:1",
		"204:2:600",
		10,
		1,
		"<color=#fb9ffe>幻皇直购</color>，购买后立即获得<color=#fb9ffe>百相之燚·幻皇 </color>，返利<color=#fb9ffe>超值购</color>\n购买后<color=#fb9ffe>邮件返还神钻持续10天</color>，返还期间无法购买，活动<color=#fb9ffe>限时14天</color>，<color=#fb9ffe>限购1次</color>\n活动时间：<color=#fb9ffe>2023年5月19日05:00</color> 至 <color=#fb9ffe>2023年6月2日05:00</color>",
		"",
		"func#5057",
		12013
	},
	{
		34013,
		1,
		"rmb_60",
		"4:91102:1",
		"4:91102:1",
		"204:2:600",
		10,
		1,
		"<color=#fb9ffe>神曜炼金梦梦直购</color>，购买后立即获得<color=#fb9ffe>神曜启蒙·炼金梦梦/炼金梦梦+神曜药剂 </color>，\n购买后<color=#fb9ffe>邮件返还神钻持续10天</color>，返还期间无法购买，活动<color=#fb9ffe>限时21天</color>，<color=#fb9ffe>限购1次</color>",
		"",
		"func#5062",
		13007
	},
	{
		34014,
		1,
		"rmb_60",
		"4:510204:100",
		"4:510204:100",
		"204:2:600",
		3,
		1,
		"<color=#fb9ffe>神曜冰灵王直购</color>，购买后立即获得<color=#fb9ffe>神曜冰灵王进化材料 </color>，\n购买后<color=#fb9ffe>邮件返还神钻持续3天</color>，返还期间无法购买，活动<color=#fb9ffe>限时21天</color>，<color=#fb9ffe>限购1次</color>",
		"",
		"func#917",
		11013
	},
	{
		34015,
		1,
		"rmb_60",
		"4:510214:100",
		"4:510214:100",
		"204:2:600",
		3,
		1,
		"<color=#fb9ffe>神曜天蛮王直购</color>，购买后立即获得<color=#fb9ffe>神曜天蛮王进化材料 </color>，\n购买后<color=#fb9ffe>邮件返还神钻持续3天</color>，返还期间无法购买，活动<color=#fb9ffe>限时21天</color>，<color=#fb9ffe>限购1次</color>",
		"",
		"func#5072",
		13010
	},
	{
		34016,
		1,
		"rmb_60",
		"100:17012:1:1",
		"100:17012:1:1",
		"204:2:600",
		3,
		1,
		"<color=#fb9ffe>无名之雾·撒达零元购</color>，购买后立即获得<color=#fb9ffe>无名之雾·撒达 </color>，\n购买后<color=#fb9ffe>邮件返还神钻持续3天</color>，返还期间无法购买，活动<color=#fb9ffe>限时28天</color>，<color=#fb9ffe>限购1次</color>",
		"",
		"func#725",
		17012
	},
	{
		34017,
		1,
		"rmb_60",
		"4:210:100",
		"4:210:100",
		"204:2:600",
		3,
		1,
		"<color=#fb9ffe>神曜烈阳·光明王零元购</color>，购买后立即获得<color=#fb9ffe>光明王神曜材料*100</color>，\n购买后<color=#fb9ffe>邮件返还神钻持续3天</color>，返还期间无法购买，活动<color=#fb9ffe>限时28天</color>，<color=#fb9ffe>限购1次</color>",
		"",
		"func#978",
		14019
	},
	{
		34018,
		1,
		"rmb_60",
		"4:215:100",
		"4:215:100",
		"204:2:600",
		3,
		1,
		"<color=#fb9ffe>神曜永夜·月影王零元购</color>，购买后立即获得<color=#fb9ffe>月影王神曜材料*100</color>，\n购买后<color=#fb9ffe>邮件返还神钻持续3天</color>，返还期间无法购买，活动<color=#fb9ffe>限时28天</color>，<color=#fb9ffe>限购1次</color>",
		"",
		"func#5085",
		15017
	},
	{
		34019,
		1,
		"rmb_60",
		"100:15022:1:1",
		"100:15022:1:1",
		"204:2:600",
		3,
		1,
		"<color=#fb9ffe>绘笔灵花·缪可零元购</color>，购买后立即获得<color=#fb9ffe>1级绘笔灵花·缪可*1</color>，\n购买后<color=#fb9ffe>邮件返还神钻持续3天</color>，返还期间无法购买，活动<color=#fb9ffe>限时28天</color>，<color=#fb9ffe>限购1次</color>",
		"",
		"func#5088",
		15022
	},
	{
		34020,
		1,
		"rmb_60",
		"100:16018:1:1",
		"100:16018:1:1",
		"204:2:600",
		3,
		1,
		"<color=FFF56BFF>断魂行者·正义零元购</color>，购买后立即获得<color=FFF56BFF>1级断魂行者·正义*1</color>，\n购买后<color=FFF56BFF>邮件返还神钻持续3天</color>，返还期间无法购买，活动<color=FFF56BFF>限时21天</color>，<color=FFF56BFF>限购1次</color>",
		"",
		"func#5094",
		16018
	},
	{
		34021,
		1,
		"rmb_60",
		"4:510260:100",
		"4:510260:100",
		"204:2:600",
		3,
		1,
		"<color=FFF56BFF>神曜学神·帝一鸣零元购</color>，购买后立即获得<color=FFF56BFF>帝一鸣神曜材料*100</color>，\n购买后<color=FFF56BFF>邮件返还神钻持续3天</color>，返还期间无法购买，活动<color=FFF56BFF>限时21天</color>，<color=FFF56BFF>限购1次</color>",
		"",
		"func#5097",
		16021
	},
	{
		34022,
		1,
		"rmb_60",
		"4:510290:100",
		"4:510290:100",
		"204:2:600",
		3,
		1,
		"<color=FFF56BFF>神曜隐刺·维多利亚零元购</color>，购买后立即获得<color=FFF56BFF>维多利亚神曜材料*100</color>，\n购买后<color=FFF56BFF>邮件返还神钻持续3天</color>，返还期间无法购买，活动<color=FFF56BFF>限时21天</color>，<color=FFF56BFF>限购1次</color>",
		"",
		"func#5108",
		11022
	},
	{
		34023,
		1,
		"rmb_60",
		"4:510301:100",
		"4:510301:100",
		"204:2:600",
		3,
		1,
		"<color=FFF56BFF>神曜梦蝶·潘多拉零元购</color>，购买后立即获得<color=FFF56BFF>潘多拉神曜材料*100</color>，\n购买后<color=FFF56BFF>邮件返还神钻持续3天</color>，返还期间无法购买，活动<color=FFF56BFF>限时21天</color>，<color=FFF56BFF>限购1次</color>",
		"",
		"func#5114",
		13016
	},
	{
		34024,
		1,
		"rmb_60",
		"100:13019:1:1",
		"100:13019:1:1",
		"204:2:600",
		3,
		1,
		"<color=#a0e2c2>奇迹麓森·阿瑞斯零元购</color>，购买后立即获得<color=#a0e2c2>1级奇迹麓森·阿瑞斯*1</color>，\n购买后<color=#a0e2c2>邮件返还神钻持续3天</color>，返还期间无法购买，活动<color=#a0e2c2>限时21天</color>，<color=#a0e2c2>限购1次</color>",
		"",
		"func#5117",
		13019
	},
	{
		34025,
		1,
		"rmb_60",
		"4:246:100",
		"4:246:100",
		"204:2:600",
		3,
		1,
		"<color=#a0e2c2>神曜暗祭·达克诺斯零元购</color>，购买后立即获得<color=#a0e2c2>达克诺斯神曜材料*100</color>，\n购买后<color=#a0e2c2>邮件返还神钻持续3天</color>，返还期间无法购买，活动<color=#a0e2c2>限时28天</color>，<color=#a0e2c2>限购1次</color>",
		"",
		"func#5130",
		17021
	},
	{
		34026,
		1,
		"rmb_60",
		"4:510365:100",
		"4:510365:100",
		"204:2:600",
		3,
		1,
		"<color=#a0e2c2>神曜花语·伊丽莎白零元购</color>，购买后立即获得<color=#a0e2c2>伊丽莎白神曜材料*100</color>，\n购买后<color=#a0e2c2>邮件返还神钻持续3天</color>，返还期间无法购买，活动<color=#a0e2c2>限时21天</color>，<color=#a0e2c2>限购1次</color>",
		"",
		"func#5141",
		15028
	},
	{
		34027,
		1,
		"rmb_60",
		"4:259:100",
		"4:259:100",
		"204:2:600",
		3,
		1,
		"<color=#a0e2c2>神曜命星·梵天零元购</color>，购买后立即获得<color=#a0e2c2>梵天神曜材料*100</color>，\n购买后<color=#a0e2c2>邮件返还神钻持续3天</color>，返还期间无法购买，活动<color=#a0e2c2>限时21天</color>，<color=#a0e2c2>限购1次</color>",
		"",
		"func#5146",
		16029
	},
	{
		34028,
		1,
		"rmb_60",
		"4:260:100",
		"4:260:100",
		"204:2:600",
		3,
		1,
		"<color=#a0e2c2>神曜冥息·楼那零元购</color>，购买后立即获得<color=#a0e2c2>楼那神曜材料*100</color>，\n购买后<color=#a0e2c2>邮件返还神钻持续3天</color>，返还期间无法购买，活动<color=#a0e2c2>限时21天</color>，<color=#a0e2c2>限购1次</color>",
		"",
		"func#5150",
		13020
	},
	{
		34029,
		1,
		"rmb_60",
		"100:15031:1:1",
		"100:15031:1:1",
		"204:2:600",
		3,
		1,
		"<color=#a0e2c2>墨夜幽莲·末炎零元购</color>，购买后立即获得<color=#a0e2c2>1级墨夜幽莲·末炎*1</color>，\n购买后<color=#a0e2c2>邮件返还神钻持续3天</color>，返还期间无法购买，活动<color=#a0e2c2>限时21天</color>，<color=#a0e2c2>限购1次</color>",
		"",
		"func#5161",
		15031
	},
	{
		34030,
		1,
		"rmb_60",
		"4:274:100",
		"4:274:100",
		"204:2:600",
		3,
		1,
		"<color=#a0e2c2>神曜星王·星洛零元购</color>，购买后立即获得<color=#a0e2c2>神曜星王·星洛神曜材料*100</color>，\n购买后<color=#a0e2c2>邮件返还神钻持续3天</color>，返还期间无法购买，活动<color=#a0e2c2>限时21天</color>，<color=#a0e2c2>限购1次</color>",
		"",
		"func#5172",
		15034
	},
	{
		34031,
		1,
		"rmb_60",
		"4:291:100",
		"4:291:100",
		"204:2:600",
		3,
		1,
		"<color=#a0e2c2>神曜缚灵·费因零元购</color>，购买后立即获得<color=#a0e2c2>神曜缚灵·费因神曜材料*100</color>，\n购买后<color=#a0e2c2>邮件返还神钻持续3天</color>，返还期间无法购买，活动<color=#a0e2c2>限时21天</color>，<color=#a0e2c2>限购1次</color>",
		"",
		"func#5183",
		16037
	},
	{
		34032,
		1,
		"rmb_60",
		"4:387:100",
		"4:387:100",
		"204:2:600",
		3,
		1,
		"<color=#a0e2c2>神曜灭歌·路西法全额返钻活动</color>，购买后立即获得<color=#a0e2c2>神曜灭歌·路西法神曜材料*100</color>，购买后<color=#a0e2c2>邮件返还神钻持续3天</color>，返还期间无法购买，活动<color=#a0e2c2>限时21天</color>，<color=#a0e2c2>限购1次</color>",
		"",
		"func#5188",
		12035
	},
	{
		34033,
		1,
		"rmb_60",
		"100:15040:1:1",
		"100:15040:1:1",
		"204:2:600",
		3,
		1,
		"<color=#a0e2c2>原罪魔主·多洛莉丝全额返钻活动</color>，购买后立即获得<color=#a0e2c2>1级原罪魔主·多洛莉丝*1</color>，购买后<color=#a0e2c2>邮件返还神钻持续3天</color>，返还期间无法购买，活动<color=#a0e2c2>限时21天</color>，<color=#a0e2c2>限购1次</color>",
		"",
		"func#5207",
		15040
	},
	{
		34034,
		1,
		"rmb_60",
		"100:14043:1:1",
		"100:14043:1:1",
		"204:2:600",
		3,
		1,
		"<color=#a0e2c2>铠甲勇士·帝皇侠全额返钻活动</color>，购买后立即获得<color=#a0e2c2>1级铠甲勇士·帝皇侠*1</color>，购买后<color=#a0e2c2>邮件返还神钻持续3天</color>，返还期间无法购买，活动期间内<color=#a0e2c2>限购1次</color>",
		"",
		"",
		14043
	}
}
local t_new_zero_pay = {
	[34001] = {
		dataList[1]
	},
	[34002] = {
		dataList[2]
	},
	[34003] = {
		dataList[3]
	},
	[34004] = {
		dataList[4]
	},
	[34005] = {
		dataList[5]
	},
	[34006] = {
		dataList[6]
	},
	[34007] = {
		dataList[7]
	},
	[34008] = {
		dataList[8]
	},
	[34009] = {
		dataList[9]
	},
	[34010] = {
		dataList[10]
	},
	[34011] = {
		dataList[11]
	},
	[34012] = {
		dataList[12]
	},
	[34013] = {
		dataList[13]
	},
	[34014] = {
		dataList[14]
	},
	[34015] = {
		dataList[15]
	},
	[34016] = {
		dataList[16]
	},
	[34017] = {
		dataList[17]
	},
	[34018] = {
		dataList[18]
	},
	[34019] = {
		dataList[19]
	},
	[34020] = {
		dataList[20]
	},
	[34021] = {
		dataList[21]
	},
	[34022] = {
		dataList[22]
	},
	[34023] = {
		dataList[23]
	},
	[34024] = {
		dataList[24]
	},
	[34025] = {
		dataList[25]
	},
	[34026] = {
		dataList[26]
	},
	[34027] = {
		dataList[27]
	},
	[34028] = {
		dataList[28]
	},
	[34029] = {
		dataList[29]
	},
	[34030] = {
		dataList[30]
	},
	[34031] = {
		dataList[31]
	},
	[34032] = {
		dataList[32]
	},
	[34033] = {
		dataList[33]
	},
	[34034] = {
		dataList[34]
	}
}

t_new_zero_pay.dataList = dataList

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

return t_new_zero_pay
