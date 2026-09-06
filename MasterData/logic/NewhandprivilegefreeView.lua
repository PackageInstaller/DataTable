-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newhandwelfare/view/NewhandprivilegefreeView.lua

module("logic.extensions.newhandwelfare.view.NewhandprivilegefreeView", package.seeall)

local NewhandprivilegefreeView = class("NewhandprivilegefreeView", ViewComponent)

function NewhandprivilegefreeView:ctor()
	NewhandprivilegefreeView.super.ctor(self)
end

function NewhandprivilegefreeView:unbindEvents()
	NewhandprivilegefreeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnBuy)
	GameUtil.rmClickHandler(self._btnGainPrize)
	GameUtil.rmClickHandler(self._btnShowAll)

	for i, item in ipairs(self._privilegeItems or {}) do
		if item and item.itemGo then
			Framework.ButtonAdapter.Get(item.itemGo):RemoveClickListener()
		end
	end
end

function NewhandprivilegefreeView:bindEvents()
	NewhandprivilegefreeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnBuy, self._onClickBuy, self)
	GameUtil.addClickHandler(self._btnGainPrize, self._onClickGainPrize, self)
	GameUtil.addClickHandler(self._btnShowAll, self._onClickShowAll, self)
end

function NewhandprivilegefreeView:buildUI()
	NewhandprivilegefreeView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("card/btnTip")
	self._btnBuy = self:getBtn("card/buyBtn")
	self._btnGainPrize = self:getBtn("card/btnGainPrize/btn")
	self._btnShowAll = self:getBtn("card/btnShowAll")
	self._txtPrice = self:getTxt("card/buyBtn/text")
	self._timeShow = self:getGo("card/remainTime")
	self._txtDay = self:getTxt("card/remainTime/txt")
	self._item = {}

	for i = 1, 3 do
		self._item[i] = self:getGo("card/btnGainPrize/item" .. i)
	end

	self._markGain = self:getGo("card/btnGainPrize/markGain")
	self._redPoint = self:getGo("card/btnGainPrize/redpoint")

	local root = self:getGo("privilege")

	self._privilegeItems = {}

	for i = 1, 9 do
		local cell = goutil.findChild(root, "btncell" .. i)

		self._privilegeItems[i] = {}
		self._privilegeItems[i].itemGo = cell
		self._privilegeItems[i].goIcon = goutil.findChild(cell, "icon")
		self._privilegeItems[i].goLock = goutil.findChild(cell, "lock")
		self._privilegeItems[i].txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
		self._privilegeItems[i].txtName = goutil.findChildTextComponent(cell, "txtName")
	end
end

function NewhandprivilegefreeView:onExit()
	NewhandprivilegefreeView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdateGoldenDiamondCardInfo, self._refreshUI, self)
	GlobalDispatcher:removeListener(PayShopController.NotifyPayShopItemBuySucRes, self._refreshUI, self)

	for _, go in pairs(self._item or {}) do
		MaterialMgr.resetAll(go)
	end

	if self._playEff then
		UIEffectManager.instance:stopEffect(self._playEff)

		self._playEff = nil
	end

	for _, effGo in pairs(self._playEffs or {}) do
		UIEffectManager.instance:stopEffect(effGo)
	end

	self._playEffs = nil
end

function NewhandprivilegefreeView:onEnter()
	NewhandprivilegefreeView.super.onEnter(self)

	if NewhandwelfareModel.instance:checkPriviligeWholeLifeDot() then
		NewhandwelfareModel.instance:recordPriviligeWholeLifeDot()
		GlobalDispatcher:dispatch(NewhandwelfareenterView.CheckRedDot)
	end

	self._params = self:getFirstParam()

	GlobalDispatcher:addListener(GlobalNotify.UpdateGoldenDiamondCardInfo, self._refreshUI, self)
	RedPointController.instance:regRedPoint(self._redPoint, RedPointModel.ID_GOLDENDIAMONDCARD)
	GlobalDispatcher:addListener(PayShopController.NotifyPayShopItemBuySucRes, self._refreshUI, self)

	self._shopItemId = 96003
	self._payCfgById = PayShopConfig.instance:getPayShopGoodsCfgById(self._shopItemId)

	self:_refreshUI()

	self.effResPath = "fx_ui_mibaoshangcheng/fx_ui_mibaoshangchang_jinzuantequan.prefab"
	self._playEff = UIEffectManager.instance:playEffect(self, self.effResPath, nil, 0, 0, true, false, nil, function(target, eff)
		eff:setParent(self.mainGO.transform)
		eff:setLocalPos(0, 0, 0)
		eff:setScale(1)

		eff.hideEffWhileNotOnTop = true
	end)
end

function NewhandprivilegefreeView:_refreshUI()
	self:_updataGoldCard()
	self:_dayGainPrize()
	self:_setPrivilegeItems()
	self:_updataShowBuyInfo()
end

function NewhandprivilegefreeView:_dayGainPrize()
	local prizes = GoldenDiamondCardConfig.instance:getCommonValue("DAILY_PRIZE")
	local prizeStrs = MaterialMgr.changeItemStrArr(prizes)

	for i = 1, 3 do
		MaterialMgr.resetAll(self._item[i])

		if GameUtil.isEmptyString(prizeStrs[i]) then
			GameUtil.SetActive(self._item[i], false)
		else
			GameUtil.SetActive(self._item[i], true)
			MaterialMgr.setCellByCfg(prizeStrs[i], self._item[i])
		end
	end

	local isGinPrize = GoldenDiamondCardModel.instance.prizeNum == 0 and GoldenDiamondCardModel.instance.isUser

	GameUtil.SetActive(self._markGain, isGinPrize)

	for _, effGo in pairs(self._playEffs or {}) do
		if effGo then
			UIEffectManager.instance:stopEffect(effGo)
		end
	end

	self._playEffs = {}

	if isGinPrize then
		local effectPath = "fx_ui_tequan/fx_ui_tequan_kuang.prefab"

		for i = 1, 3 do
			self._playEffs[i] = UIEffectManager.instance:playEffect(self, effectPath, self._item[i], 0, 0, true, false, nil, function(target, eff)
				eff.effGo.transform:SetParent(self._item[i].transform)
				GameUtil.setLocalPos(eff.effGo.transform, 0, 0, 0)
				GameUtil.setLocalScale(eff.effGo.transform, 1.5, 1.5, 1)

				eff.hideEffWhileNotOnTop = true
			end)
		end
	end
end

function NewhandprivilegefreeView:_setPrivilegeItems()
	for i, item in ipairs(self._privilegeItems) do
		GameUtil.rmClickHandler(item.itemGo)

		local cfg = NewhandwelfareConfig.instance:getGoldenDiamondCfg(i)
		local isUnlock = cfg.funcId <= 0 or FuncOpenModel.instance:getFuncIsOpen(cfg.funcId)

		GameUtil.SetActive(item.goLock, false)
		GameUtil.addClickHandler(item.itemGo, function()
			if not isUnlock then
				FloatWordMgr.instance:show(FuncOpenModel.instance:getFuncLockDescription(cfg.funcId))

				return
			end

			if not string.nilorempty(cfg.jumpTo) then
				GotoMgr.gotoByString(cfg.jumpTo)
				self:close()
			end
		end, self)
	end
end

function NewhandprivilegefreeView:_updataShowBuyInfo()
	self._txtPrice.text = not PayShopModel.instance:getPayShopGoodsCanBuyById(self._shopItemId) and "已领取" or "可领取"

	if checknumber(self._supCount) <= 0 then
		GameUtil.SetActive(self._timeShow, false)
	else
		GameUtil.SetActive(self._timeShow, true)

		self._txtDay.text = langPara("剩余有效期:%s天", self._supCount)
	end
end

function NewhandprivilegefreeView:_updataGoldCard()
	local model = GoldenDiamondCardModel.instance
	local leftTime = math.ceil((model.endTime / 1000 - ServerTime.now()) / 86400)

	self._supCount = leftTime or 0

	self:_updataShowBuyInfo()
end

function NewhandprivilegefreeView:_onClickBuy()
	if not PayShopModel.instance:getPayShopGoodsCanBuyById(self._shopItemId) then
		FloatWordMgr.instance:show("已成功领取，快去背包使用7天特权卡吧~")

		return
	end

	PayShopController.instance:buyShopItem(self._shopItemId, 1, discountPlans, 0)
end

function NewhandprivilegefreeView:_onClickGainPrize()
	if GoldenDiamondCardModel.instance.isUser and GoldenDiamondCardModel.instance.prizeNum == 1 then
		GoldenDiamondCardAgent.instance:sendPM_GoldenDiamondCardGainDailyPrizeReq()

		return
	end

	if GoldenDiamondCardModel.instance.prizeNum == 0 and GoldenDiamondCardModel.instance.isUser then
		FloatWordMgr.instance:show("今日礼包已领取")

		return
	end

	UIStateManager.instance:push(ViewName.GoldendiamondallView)
end

function NewhandprivilegefreeView:_onClickShowAll()
	UIStateManager.instance:push(ViewName.GoldendiamondallView)
end

function NewhandprivilegefreeView:_onClickTip()
	ViewMgr.instance:open(ViewName.RulesView, "goldendiamondcard")
end

return NewhandprivilegefreeView
