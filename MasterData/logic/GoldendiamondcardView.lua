-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goldendiamondcard/view/GoldendiamondcardView.lua

module("logic.extensions.goldendiamondcard.view.GoldendiamondcardView", package.seeall)

local GoldendiamondcardView = class("GoldendiamondcardView", ViewComponent)

function GoldendiamondcardView:buildUI()
	GoldendiamondcardView.super.buildUI(self)

	self.btnBuy = self:getBtn("card/buyBtn")
	self.txtPrice = self:getTxt("card/buyBtn/text")
	self.btnGainPrize = self:getBtn("card/btnGainPrize/btn")
	self.btnShowAll = self:getBtn("card/btnShowAll")
	self.btnTip = self:getBtn("card/btnTip")
	self.timeShow = self:getGo("card/time")
	self.txtDay = goutil.findChildTextComponent(self.timeShow, "txtDay")
	self._item = {}

	for i = 1, 3 do
		self._item[i] = self:getGo("card/btnGainPrize/item" .. i)
	end

	self.markGain = self:getGo("card/btnGainPrize/markGain")
	self.redPoint = self:getGo("card/btnGainPrize/redpoint")
	self._newhandbubbleGo = self:getGo("card/newhandbubble")
	self.btnGift = self:getBtn("card/btnGift")
	self._txtGiftTip = self:getTxt("card/btnGift/txtTip")
end

function GoldendiamondcardView:bindEvents()
	GoldendiamondcardView.super.bindEvents(self)
	self.btnBuy:AddClickListener(self.onClickBtnBuy, self)
	self.btnShowAll:AddClickListener(self.onClickBtnShowAll, self)
	self.btnGainPrize:AddClickListener(self.onClickBtnGainPrize, self)
	self.btnTip:AddClickListener(self.onClickBtnTip, self)
	self.btnGift:AddClickListener(self.onClickBtnGift, self)
end

function GoldendiamondcardView:unbindEvents()
	GoldendiamondcardView.super.unbindEvents(self)
	self.btnBuy:RemoveClickListener()
	self.btnShowAll:RemoveClickListener()
	self.btnGainPrize:RemoveClickListener()
	self.btnTip:RemoveClickListener()
	self.btnGift:RemoveClickListener()
end

function GoldendiamondcardView:onEnter()
	GoldendiamondcardView.super.onEnter(self)

	self.model = GoldenDiamondCardModel.instance

	self:refreshView()
	GlobalDispatcher:addListener(GlobalNotify.UpdateGoldenDiamondCardInfo, self.refreshView, self)
	RedPointController.instance:regRedPoint(self.redPoint, RedPointModel.ID_GOLDENDIAMONDCARD)

	self.effResPath = "fx_ui_mibaoshangcheng/fx_ui_mibaoshangchang_jinzuantequan.prefab"
	self._playEff = UIEffectManager.instance:playEffect(self, self.effResPath, nil, 0, 0, true, false, nil, function(target, eff)
		eff:setParent(self.mainGO.transform)
		eff:setLocalPos(0, 0, 0)
		eff:setScale(1)

		eff.hideEffWhileNotOnTop = true
	end)
end

function GoldendiamondcardView:onExit()
	GoldendiamondcardView.super.onExit(self)

	for i = 1, 3 do
		local cellPoint = self._item[i]

		MaterialMgr.resetAll(cellPoint)
	end

	GlobalDispatcher:removeListener(GlobalNotify.UpdateGoldenDiamondCardInfo, self.refreshView, self)
	RedPointController.instance:unregRedPoint(self.redPoint)

	if self._playEff then
		UIEffectManager.instance:stopEffect(self._playEff)

		self._playEff = nil
	end

	if self._playEffs then
		for i = 1, 3 do
			UIEffectManager.instance:stopEffect(self._playEffs[i])
		end
	end

	self._playEffs = nil

	GoldenDiamondCardModel.instance:setTryBuyGiftId()
end

function GoldendiamondcardView:refreshView()
	self.model = GoldenDiamondCardModel.instance
	self.goodsId = GoldenDiamondCardConfig.instance:getCommonValue("GOODS_ID")
	self._discountGoodsId = self.goodsId

	local isNewhandPlayer = ServerTime.now() < NewhandwelfareModel.instance:getNewHandPlayerEndTime() and self.model.ableToRenew
	local isOnTrial = NewhandwelfareModel.instance:isOnTrialGoldenDiamond()

	if isOnTrial then
		self.txtPrice.text = "体验中"
	elseif isNewhandPlayer then
		self._discountGoodsId = GoldenDiamondCardConfig.instance:getCommonValue("NEW_HAND_GOODS_ID")
		self.txtPrice.text = lang("￥") .. PayConfig.instance:getPayMoneyYuan(self._discountGoodsId)
	else
		self.txtPrice.text = lang("￥") .. PayConfig.instance:getPayMoneyYuan(self.goodsId)
	end

	local prizes = GoldenDiamondCardConfig.instance:getCommonValue("DAILY_PRIZE")
	local prizeStrs = MaterialMgr.changeItemStrArr(prizes)

	for i = 1, 3 do
		local matStr = prizeStrs[i]
		local cellPoint = self._item[i]

		MaterialMgr.resetAll(cellPoint)

		if GameUtil.isEmptyString(matStr) then
			goutil.setActive(cellPoint, false)
		else
			goutil.setActive(cellPoint, true)
			MaterialMgr.setCellByCfg(matStr, cellPoint)
		end
	end

	goutil.setActive(self.btnBuy.gameObject, self.model.ableToRenew or isNewhandPlayer or isOnTrial)
	goutil.setActive(self._newhandbubbleGo, isNewhandPlayer or isOnTrial)
	goutil.setActive(self.markGain, self.model.prizeNum == 0 and self.model.isUser)

	if self.model.prizeNum > 0 and self.model.isUser then
		if self._playEffs then
			for i = 1, 3 do
				UIEffectManager.instance:stopEffect(self._playEffs[i])
			end
		end

		self._playEffs = {}

		local effPath = "fx_ui_tequan/fx_ui_tequan_kuang.prefab"

		for i = 1, 3 do
			self._playEffs[i] = UIEffectManager.instance:playEffect(self, effPath, self._item[i], 0, 0, true, false, nil, function(target, eff)
				eff.effGo.transform:SetParent(self._item[i].transform)
				GameUtil.setLocalPos(eff.effGo.transform, 0, 0, 0)
				GameUtil.setLocalScale(eff.effGo.transform, 1.5, 1.5, 1)

				eff.hideEffWhileNotOnTop = true
			end)
		end
	else
		if self._playEffs then
			for i = 1, 3 do
				UIEffectManager.instance:stopEffect(self._playEffs[i])
			end
		end

		self._playEffs = nil
	end

	goutil.setActive(self.timeShow, self.model.isUser)

	local leftTime = math.ceil((self.model.endTime / 1000 - ServerTime.now()) / 86400)

	self.txtDay.text = langPara("剩余有效期:%s天", leftTime)

	self:_updateGiftPart()
end

function GoldendiamondcardView:_updateGiftPart()
	self.giftCfg = GoldenDiamondCardConfig.instance:getCurGiftCfgByServerTime()

	if self.giftCfg and not GoldenDiamondCardModel.instance:getGiftBuyState(self.giftCfg.timedId) then
		goutil.setActive(self.btnGift.gameObject, true)

		local endDate = GameUtil.time2date(GameUtil.string2time(self.giftCfg.endTime))

		self._txtGiftTip.text = string.format("限时折扣将于%s月%s日05:00结束", endDate.month, endDate.day)
	else
		goutil.setActive(self.btnGift.gameObject, false)
	end
end

function GoldendiamondcardView:onClickBtnGift()
	if not self.giftCfg then
		self:_updateGiftPart()

		return
	end

	local giftId = self.giftCfg.timedId
	local giftGoodsId = self.giftCfg.goodsId

	if not GoldenDiamondCardModel.instance:getGiftBuyState(giftId) then
		TipsFacade.instance:openPopupWindow(lang("提示"), self.giftCfg.tips, function()
			GoldenDiamondCardModel.instance:setTryBuyGiftId(giftId)
			PayController.instance:pay(giftGoodsId, GameEnum.PaySubGoodsType.GOLDEN_DIAMOND_CARD_GIFT, giftId)
		end, function()
			GoldenDiamondCardModel.instance:setTryBuyGiftId()
		end, langPara("￥%s", PayConfig.instance:getPayMoneyYuan(giftGoodsId)), lang("取消"))
	end
end

function GoldendiamondcardView:onClickBtnBuy()
	if NewhandwelfareModel.instance:isOnTrialGoldenDiamond() then
		return
	end

	if self.model.ableToRenew then
		PayController.instance:pay(self._discountGoodsId, GameEnum.PaySubGoodsType.GOLDENDIAMONDCARD, 1)
	else
		goutil.setActive(self.btnBuy.gameObject, false)
	end
end

function GoldendiamondcardView:onClickBtnShowAll()
	UIStateManager.instance:push(ViewName.GoldendiamondallView)
end

function GoldendiamondcardView:onClickBtnGainPrize()
	if self.model.isUser and self.model.prizeNum == 1 then
		GoldenDiamondCardAgent.instance:sendPM_GoldenDiamondCardGainDailyPrizeReq()

		return
	end

	self:onClickBtnShowAll()
end

function GoldendiamondcardView:onClickBtnTip()
	ViewMgr.instance:open(ViewName.RulesView, "goldendiamondcard")
end

return GoldendiamondcardView
