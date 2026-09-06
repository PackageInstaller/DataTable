-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_mail_ml_word.lua

module("logicconfig.config.t_mail_ml_word", package.seeall)

local title = {
	word = 2,
	key = 1
}
local dataList = {
	{
		"campaignTheme",
		"活动礼包"
	},
	{
		"payShop",
		"商城"
	},
	{
		"wishingWell",
		"许愿池礼包"
	},
	{
		"regress",
		"回归活动"
	},
	{
		"payMiYa",
		"限时挑战-弥娅觉醒礼包"
	},
	{
		"payTempt",
		"限时礼包"
	},
	{
		"payDiscountAccruing",
		"累购折扣"
	},
	{
		"payTimeMachine",
		"等级时光机"
	},
	{
		"payTruss",
		"服装"
	},
	{
		"paySkin",
		"皮肤"
	},
	{
		"monthCard",
		"月卡"
	},
	{
		"payVip",
		"VIP礼包"
	},
	{
		"zeroPay",
		"零元购活动"
	},
	{
		"periodPassport",
		"悬赏令"
	},
	{
		"permanentPassport",
		"投资"
	},
	{
		"newHandCard",
		"新手卡"
	},
	{
		"fmBossSystem",
		"系统"
	},
	{
		"mirrorTrial",
		"镜像试炼"
	},
	{
		"selfSelect",
		"自选礼包"
	},
	{
		"payRaceStrength",
		"龙女特惠活动"
	},
	{
		"noahChallenge",
		"神启挑战"
	},
	{
		"monopolySale",
		"专卖活动"
	},
	{
		"integrationChallenge",
		"合体挑战"
	},
	{
		"preheatSale",
		"预热售卖"
	},
	{
		"summarySignIn",
		"汇总签到"
	},
	{
		"annuity",
		"年费礼包"
	},
	{
		"payStrengthPermanent",
		"常驻精灵直升"
	},
	{
		"payStrengthActivity",
		"常驻精灵直升折扣活动"
	},
	{
		"newHandWelfare",
		"新手福利"
	},
	{
		"goldenDiamondCardTimedBuy",
		"金钻卡限时礼包"
	},
	{
		"monthCardPack",
		"月卡打包售卖"
	},
	{
		"godLongYanChallenge",
		"神启龙炎挑战"
	},
	{
		"dressSell",
		"次元龙服饰售卖"
	},
	{
		"saintKnightCard",
		"圣骑卡"
	},
	{
		"seasonModeWarOrder",
		"赛季模式-战令"
	},
	{
		"packDiscount",
		"特惠礼包"
	},
	{
		"webOfficial",
		"手游支付平台"
	},
	{
		"companionMall",
		"周边商城"
	},
	{
		"companionMallSingleBuyFail",
		"周边商城商品重复购买"
	},
	{
		"companionMallSelectPackBuyFail",
		"周边商城自选组合包含重复购买商品"
	},
	{
		"wanderPass",
		"5周年逍遥令"
	}
}
local t_mail_ml_word = {
	campaignTheme = dataList[1],
	payShop = dataList[2],
	wishingWell = dataList[3],
	regress = dataList[4],
	payMiYa = dataList[5],
	payTempt = dataList[6],
	payDiscountAccruing = dataList[7],
	payTimeMachine = dataList[8],
	payTruss = dataList[9],
	paySkin = dataList[10],
	monthCard = dataList[11],
	payVip = dataList[12],
	zeroPay = dataList[13],
	periodPassport = dataList[14],
	permanentPassport = dataList[15],
	newHandCard = dataList[16],
	fmBossSystem = dataList[17],
	mirrorTrial = dataList[18],
	selfSelect = dataList[19],
	payRaceStrength = dataList[20],
	noahChallenge = dataList[21],
	monopolySale = dataList[22],
	integrationChallenge = dataList[23],
	preheatSale = dataList[24],
	summarySignIn = dataList[25],
	annuity = dataList[26],
	payStrengthPermanent = dataList[27],
	payStrengthActivity = dataList[28],
	newHandWelfare = dataList[29],
	goldenDiamondCardTimedBuy = dataList[30],
	monthCardPack = dataList[31],
	godLongYanChallenge = dataList[32],
	dressSell = dataList[33],
	saintKnightCard = dataList[34],
	seasonModeWarOrder = dataList[35],
	packDiscount = dataList[36],
	webOfficial = dataList[37],
	companionMall = dataList[38],
	companionMallSingleBuyFail = dataList[39],
	companionMallSelectPackBuyFail = dataList[40],
	wanderPass = dataList[41]
}

t_mail_ml_word.dataList = dataList

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

return t_mail_ml_word
