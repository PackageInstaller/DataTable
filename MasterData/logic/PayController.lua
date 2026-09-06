-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pay/controller/PayController.lua

module("logic.extensions.pay.controller.PayController", package.seeall)

local PayController = class("PayController", BaseController)

PayController.NotifyPayResultRes = "PayController.NotifyPayResultRes"

function PayController:ctor()
	self.model = PayModel.instance
end

function PayController:onInit()
	GlobalDispatcher:addListener(PayAgent.NotifyPayResultRes, self.handleNotifyPayResultRes, self)
end

function PayController:onReset()
	return
end

function PayController:handleNotifyPayResultRes(status, msg)
	if status == 0 then
		RoleModel.instance:addMyConsumeMoney(msg.money)

		local subGoodsType = msg.subGoodsType

		if subGoodsType == GameEnum.PaySubGoodsType.PAY_SHOP then
			-- block empty
		elseif subGoodsType == GameEnum.PaySubGoodsType.MONTH_CARD then
			-- block empty
		end

		GlobalDispatcher:dispatch(PayController.NotifyPayResultRes, msg)
	end
end

function PayController:pay(goodsId, subGoodsType, subGoodsId, extParams)
	local platformPermit = not Framework.OSDef.isEditor and (Framework.OSDef.RunOS == Framework.OSDef.Android or Framework.OSDef.RunOS == Framework.OSDef.IOS)

	if platformPermit and AntiAddictionController.instance:getMyAntiType() == 1 then
		local str = "需要先绑定账号，才可以继续进行支付功能"

		TipsFacade.instance:openPopupWindow("需要绑定账号", str, function()
			AntiAddictionController.instance:gotoGuestUpgradeAccount()
		end, function()
			return
		end, "绑定账号", "返回")

		return
	end

	local function okFunc()
		self:sendGenOrderNoReq(goodsId, subGoodsType, subGoodsId, extParams)
	end

	if subGoodsType == GameEnum.PaySubGoodsType.MONTH_CARD and subGoodsId ~= 2 or subGoodsType == GameEnum.PaySubGoodsType.GOLDENDIAMONDCARD or subGoodsType == GameEnum.PaySubGoodsType.PASS_PORT then
		if AntiAddictionController.instance.onlineLimit == 1 and AntiAddictionController.instance.onlineLimitMinute > 0 and AntiAddictionController.instance.onlineLimitTime ~= nil then
			local text = "根据《关于进一步严格管理切实防止未成年人沉迷网络游戏的通知》，18岁以下未成年人只可以在周五、周六、周日和法定节假日的20时至21时体验游戏，请谨慎购买此类商品，可能会导致你部分收益受损，是否依然购买？"

			TipsFacade.instance:openPopupWindow("提示", text, okFunc)
		else
			okFunc()
		end
	else
		okFunc()
	end
end

local lastSubGoodsId = false

function PayController:sendGenOrderNoReq(goodsId, subGoodsType, subGoodsId, extParams)
	if lastSubGoodsId and (not self.genOrderNoReqTime or ServerTime.nowMs() - self.genOrderNoReqTime < 100) then
		FloatWordMgr.instance:show("支付处理中")

		return
	end

	self.genOrderNoReqTime = ServerTime.nowMs()
	lastSubGoodsId = subGoodsId
	extParams = extParams or ""

	local function handler(msg)
		PayModel.instance:handlerGenOrderNoRes(msg, subGoodsType, lastSubGoodsId)
		removetimer(self.statTimeOut, self)

		lastSubGoodsId = false
	end

	local function errHandler()
		removetimer(self.statTimeOut, self)

		lastSubGoodsId = false
	end

	local callBackStr = tostring(goodsId .. "#" .. subGoodsType .. "#" .. extParams)

	PayAgent.instance:sendGenOrderNoReq(goodsId, subGoodsType, subGoodsId, extParams, callBackStr, handler, nil, errHandler)
	removetimer(self.statTimeOut, self)
	settimer(2, self.statTimeOut, self)
end

function PayController:statTimeOut()
	removetimer(self.statTimeOut, self)

	lastSubGoodsId = false
end

function PayController:getPaySymbol()
	if BootstrapPjaqGameConfigMgr.isReview then
		return "HK$"
	end

	if LanguageMgr.instance._curLang == LanguageType.ZH then
		return "¥"
	elseif LanguageMgr.instance._curLang == LanguageType.TW then
		return "$"
	end

	return "?"
end

PayController.instance = PayController.New()

return PayController
