-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activitypopup/view/HdpetskinlimitView.lua

module("logic.extensions.activitypopup.view.HdpetskinlimitView", package.seeall)

local HdpetskinlimitView = class("HdpetskinlimitView", ViewComponent)
local longyanCfgId = 1
local xixiCfgId = 2

function HdpetskinlimitView:ctor()
	HdpetskinlimitView.super.ctor(self)
end

function HdpetskinlimitView:buildUI()
	HdpetskinlimitView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self.btnTryLY = self:getGo("longyan/btnTry")
	self.btnPayLY = self:getGo("longyan/btnPay")
	self.txtLyPay = self:getTxt("longyan/btnPay/Text")
	self.lingquGoL = self:getGo("longyan/btnPay/lingquGo")
	self.priceLY = self:getGo("longyan/btnPay/price")
	self.txtLyPay = self:getTxt("longyan/btnPay/Text")
	self.txtLYPayGo = self:getGo("longyan/btnPay/Text")
	self.txtLyPayOld = self:getTxt("longyan/btnPay/price/txtOld")
	self.txtLyPayNow = self:getTxt("longyan/btnPay/price/Now")
	self.btnObtainLy = self:getGo("longyan/btnObtain")
	self.imageLy = self:getGo("longyan/Image")
	self.txtPriceLy = self:getGo("longyan/txtPrice")
	self.txtPrice2Ly = self:getGo("longyan/txtPrice2")
	self.btnObtainXX = self:getGo("xixi/btnObtain")
	self.btnTryXX = self:getGo("xixi/btnTry")
	self.btnPayXX = self:getGo("xixi/btnPay")
	self.lingquGoX = self:getGo("xixi/btnPay/lingquGo")
	self.txtXXPayGo = self:getGo("xixi/btnPay/Text")
	self.priceXX = self:getGo("xixi/btnPay/price")
	self.txtXXPay = self:getTxt("xixi/btnPay/Text")
	self.txtXXPayOld = self:getTxt("xixi/btnPay/price/txtOld")
	self.txtXXPayNow = self:getTxt("xixi/btnPay/price/Now")
	self.imageXX = self:getGo("xixi/Image")
	self.txtPriceXX = self:getGo("xixi/txtPrice")
	self.txtPrice2XX = self:getGo("xixi/txtPrice2")
	self.btnHelp = self:getGo("btnHelp")
end

function HdpetskinlimitView:bindEvents()
	HdpetskinlimitView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
	GameUtil.addClickHandler(self.btnTryLY, self.onTryLongyan, self)
	GameUtil.addClickHandler(self.btnTryXX, self.onTryXixi, self)
	GameUtil.addClickHandler(self.btnObtainLy, GameUtil.handler(self.onObtain, self, longyanCfgId))
	GameUtil.addClickHandler(self.btnObtainXX, GameUtil.handler(self.onObtain, self, xixiCfgId))
	GameUtil.addClickHandler(self.btnPayLY, self.onPayLongyan, self)
	GameUtil.addClickHandler(self.btnPayXX, self.onPayXixi, self)
	GameUtil.addClickHandler(self.btnHelp, self.onClickHelp, self)
end

function HdpetskinlimitView:unbindEvents()
	HdpetskinlimitView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
	GameUtil.rmClickHandler(self.btnTryLY)
	GameUtil.rmClickHandler(self.btnTryXX)
	GameUtil.rmClickHandler(self.btnObtainLy)
	GameUtil.rmClickHandler(self.btnObtainXX)
	GameUtil.rmClickHandler(self.btnPayLY)
	GameUtil.rmClickHandler(self.btnPayXX)
	GameUtil.rmClickHandler(self.btnHelp)
end

function HdpetskinlimitView:destroyUI()
	HdpetskinlimitView.super.destroyUI(self)
end

function HdpetskinlimitView:onEnter()
	HdpetskinlimitView.super.onEnter(self)

	local cfg1 = ActivityPopupConfig.instance:getLyXxCfg(longyanCfgId)

	self.txtLyPay.text = "￥ " .. PayConfig.instance:getPayMoneyYuan(cfg1.normalPrice)
	self.txtLyPayOld.text = "￥ " .. PayConfig.instance:getPayMoneyYuan(cfg1.normalPrice)
	self.txtLyPayNow.text = " " .. PayConfig.instance:getPayMoneyYuan(cfg1.discountPrice)

	GameUtil.SetActive(self.lingquGoL, PetskinController.instance:checkHasForeverSkinBySkinId(cfg1.skinId))

	local itemStr = cfg1.discountCost

	if string.nilorempty(itemStr) then
		GameUtil.SetActive(self.priceLY, false)
		GameUtil.SetActive(self.txtLYPayGo, true)
		GameUtil.SetActive(self.btnObtainLy, false)
		GameUtil.SetActive(self.imageLy, false)
		GameUtil.SetActive(self.txtPriceLy, false)
		GameUtil.SetActive(self.txtPrice2Ly, false)
	else
		GameUtil.SetActive(self.imageLy, true)
		GameUtil.SetActive(self.txtPriceLy, true)
		GameUtil.SetActive(self.txtPrice2Ly, true)

		if MaterialMgr.getMatEnough(itemStr) then
			GameUtil.SetActive(self.priceLY, true)
			GameUtil.SetActive(self.txtLYPayGo, false)
			GameUtil.SetActive(self.btnObtainLy, false)
		else
			GameUtil.SetActive(self.priceLY, false)
			GameUtil.SetActive(self.txtLYPayGo, true)
			GameUtil.SetActive(self.btnObtainLy, true)
		end
	end

	local cfg2 = ActivityPopupConfig.instance:getLyXxCfg(xixiCfgId)

	self.txtXXPay.text = "￥ " .. PayConfig.instance:getPayMoneyYuan(cfg2.normalPrice)
	self.txtXXPayOld.text = "￥ " .. PayConfig.instance:getPayMoneyYuan(cfg2.normalPrice)
	self.txtXXPayNow.text = " " .. PayConfig.instance:getPayMoneyYuan(cfg2.discountPrice)

	GameUtil.SetActive(self.lingquGoX, PetskinController.instance:checkHasForeverSkinBySkinId(cfg2.skinId))

	local itemStr = cfg2.discountCost

	if string.nilorempty(itemStr) then
		GameUtil.SetActive(self.priceXX, false)
		GameUtil.SetActive(self.txtXXPayGo, true)
		GameUtil.SetActive(self.btnObtainXX, false)
		GameUtil.SetActive(self.imageXX, false)
		GameUtil.SetActive(self.txtPriceXX, false)
		GameUtil.SetActive(self.txtPrice2XX, false)
	else
		GameUtil.SetActive(self.imageXX, true)
		GameUtil.SetActive(self.txtPriceXX, true)
		GameUtil.SetActive(self.txtPrice2XX, true)

		if MaterialMgr.getMatEnough(itemStr) then
			GameUtil.SetActive(self.priceXX, true)
			GameUtil.SetActive(self.txtXXPayGo, false)
			GameUtil.SetActive(self.btnObtainXX, false)
		else
			GameUtil.SetActive(self.priceXX, false)
			GameUtil.SetActive(self.txtXXPayGo, true)
			GameUtil.SetActive(self.btnObtainXX, true)
		end
	end
end

function HdpetskinlimitView:onEnterFinished()
	HdpetskinlimitView.super.onEnterFinished(self)
end

function HdpetskinlimitView:onExit()
	HdpetskinlimitView.super.onExit(self)
end

function HdpetskinlimitView:onExitFinished()
	HdpetskinlimitView.super.onExitFinished(self)
end

function HdpetskinlimitView:onObtain(id)
	SurveyController.instance:reportBehavior(SurveyBehaviorID.CLICK_XIXI_GIFT)

	local cfg = ActivityPopupConfig.instance:getLyXxCfg(id)
	local itemStr = cfg.discountCost

	MaterialMgr.openGetSourceByStr(itemStr)
end

function HdpetskinlimitView:onPayLongyan()
	local cfg1 = ActivityPopupConfig.instance:getLyXxCfg(longyanCfgId)
	local skinName = PetSkinConfig.instance:getPetSkinName(cfg1.skinId)
	local itemStr = cfg1.discountCost

	if not PetskinController.instance:checkHasForeverSkinBySkinId(cfg1.skinId) then
		local subGoodsType = GameEnum.PaySubGoodsType.LONG_YAN_XI_XI_SKIN
		local subGoodsId = longyanCfgId

		if string.nilorempty(itemStr) then
			PayController.instance:pay(cfg1.normalPrice, subGoodsType, subGoodsId)
		elseif MaterialMgr.getMatEnough(itemStr) then
			PayController.instance:pay(cfg1.discountPrice, subGoodsType, subGoodsId)
		else
			local content = MaterialMgr.getContentMatStr(itemStr, 110, -15, MaterialMgr.ICON_TYPE_MATID)
			local str = langPara("您当前仍未获得【%s】对应折扣券。\n您可以点击前往去获得折扣券。\n%s", skinName, content)

			TipsFacade.instance:openPopupWindow(lang("tip"), str, function()
				MaterialMgr.openGetSourceByStr(itemStr)
			end, function()
				PayController.instance:pay(cfg1.normalPrice, subGoodsType, subGoodsId)
			end, lang("前往获得"), lang("直接购买"), UnityEngine.TextAnchor.MiddleCenter)
		end
	else
		TipsFacade.instance:openCommonTips(langPara("已经拥有%s,不需要购买", skinName))
	end
end

function HdpetskinlimitView:onPayXixi()
	local cfg2 = ActivityPopupConfig.instance:getLyXxCfg(xixiCfgId)
	local itemStr = cfg2.discountCost
	local skinName = PetSkinConfig.instance:getPetSkinName(cfg2.skinId)

	if not PetskinController.instance:checkHasForeverSkinBySkinId(cfg2.skinId) then
		local subGoodsType = GameEnum.PaySubGoodsType.LONG_YAN_XI_XI_SKIN
		local subGoodsId = xixiCfgId

		if string.nilorempty(itemStr) then
			PayController.instance:pay(cfg2.normalPrice, subGoodsType, subGoodsId)
		elseif MaterialMgr.getMatEnough(itemStr) then
			PayController.instance:pay(cfg2.discountPrice, subGoodsType, subGoodsId)
		else
			local content = MaterialMgr.getContentMatStr(itemStr, 110, -15, MaterialMgr.ICON_TYPE_MATID)
			local str = langPara("您当前仍未获得【%s】对应折扣券。\n您可以点击前往去获得折扣券。\n%s", skinName, content)

			TipsFacade.instance:openPopupWindow(lang("tip"), str, function()
				MaterialMgr.openGetSourceByStr(itemStr)
			end, function()
				PayController.instance:pay(cfg2.normalPrice, subGoodsType, subGoodsId)
			end, lang("前往获得"), lang("直接购买"), UnityEngine.TextAnchor.MiddleCenter)
		end
	else
		TipsFacade.instance:openCommonTips(langPara("已经拥有%s,不需要购买", skinName))
	end
end

function HdpetskinlimitView:onClickHelp()
	local cfgKey = "hd_longyanxixi_skin"

	UIStateManager.instance:open(ViewName.RulesView, cfgKey)
end

function HdpetskinlimitView:onTryLongyan()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.CLICK_TRY_LONGYAN)
	self:goTryBattle(longyanCfgId)
end

function HdpetskinlimitView:onTryXixi()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.CLICK_TRY_XIXI)
	self:goTryBattle(xixiCfgId)
end

function HdpetskinlimitView:goTryBattle(id)
	local cfg = ActivityPopupConfig.instance:getLyXxCfg(id)
	local skinId = cfg.skinId

	if skinId then
		local cfg = PetSkinConfig.instance:getPetSkinCfg(skinId)

		if cfg then
			local raceId = cfg.raceId

			PetbookController.instance:previewBattle(raceId, skinId)
		end
	end
end

return HdpetskinlimitView
