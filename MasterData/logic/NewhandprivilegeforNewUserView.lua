-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newhandwelfare/view/NewhandprivilegeforNewUserView.lua

module("logic.extensions.newhandwelfare.view.NewhandprivilegeforNewUserView", package.seeall)

local NewhandprivilegeforNewUserView = class("NewhandprivilegeforNewUserView", ViewComponent)

function NewhandprivilegeforNewUserView:buildUI()
	NewhandprivilegeforNewUserView.super.buildUI(self)

	self.btnBuy = self:getBtn("card/buyBtn")
	self.txtPrice = self:getTxt("card/buyBtn/text")
	self.btnGainPrize = self:getBtn("card/btnGainPrize/btn")
	self.btnShowAll = self:getBtn("card/btnShowAll")
	self.btnTip = self:getBtn("card/btnTip")
	self.timeShow = self:getGo("card/remainTime")
	self.txtDay = goutil.findChildTextComponent(self.timeShow, "txt")
	self._item = {}

	for i = 1, 3 do
		self._item[i] = self:getGo("card/btnGainPrize/item" .. i)
	end

	self.markGain = self:getGo("card/btnGainPrize/markGain")
	self.redPoint = self:getGo("card/btnGainPrize/redpoint")
	self._btnClose = self:getBtn("btnClose")
	self._bubbleGo = self:getGo("card/bubble")
	self._txtDiscountGo = self:getGo("card/buyBtn/txtDiscount")
	self._txtDiscount = self:getTxt("card/buyBtn/txtDiscount")

	self:_getPrivilegeItems()

	self._imgNew = self:getGo("imgNew")
	self._tipCon1 = goutil.findChild(self._imgNew, "con1")
	self._tipCon2 = goutil.findChild(self._imgNew, "con2")
	self._btnGet = self:getGo("card/buyGet")
	self._txtbtnGet = goutil.findChildTextComponent(self._btnGet, "text")
end

function NewhandprivilegeforNewUserView:_getPrivilegeItems()
	self._privilegeItems = {}

	local root = self:getGo("privilege")

	for i = 1, 9 do
		local cell = goutil.findChild(root, "btncell" .. i)
		local goIcon = goutil.findChild(cell, "icon")
		local goLock = goutil.findChild(cell, "lock")
		local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
		local txtName = goutil.findChildTextComponent(cell, "txtName")
		local btn = Framework.ButtonAdapter.Get(cell)

		self._privilegeItems[i] = {
			goIcon = goIcon,
			goLock = goLock,
			txtDesc = txtDesc,
			txtName = txtName,
			btn = btn
		}
	end
end

function NewhandprivilegeforNewUserView:bindEvents()
	NewhandprivilegeforNewUserView.super.bindEvents(self)
	self.btnBuy:AddClickListener(self.onClickBtnBuy, self)
	self.btnShowAll:AddClickListener(self.onClickBtnShowAll, self)
	self.btnGainPrize:AddClickListener(self.onClickBtnGainPrize, self)
	self.btnTip:AddClickListener(self.onClickBtnTip, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	GameUtil.addClickHandler(self._btnGet, self._onClickbtnGet, self)
end

function NewhandprivilegeforNewUserView:unbindEvents()
	NewhandprivilegeforNewUserView.super.unbindEvents(self)
	self.btnBuy:RemoveClickListener()
	self.btnShowAll:RemoveClickListener()
	self.btnGainPrize:RemoveClickListener()
	self.btnTip:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	GameUtil.rmClickHandler(self._btnGet)
end

function NewhandprivilegeforNewUserView:onEnter()
	NewhandprivilegeforNewUserView.super.onEnter(self)

	self._actId = nil

	if NewhandwelfareModel.instance:checkPriviligeWholeLifeDot() then
		NewhandwelfareModel.instance:recordPriviligeWholeLifeDot()
		GlobalDispatcher:dispatch(NewhandwelfareenterView.CheckRedDot)
	end

	self._actId = self:getFirstParam()

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

function NewhandprivilegeforNewUserView:onExit()
	NewhandprivilegeforNewUserView.super.onExit(self)

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
end

function NewhandprivilegeforNewUserView:refreshView()
	self.goodsId = GoldenDiamondCardConfig.instance:getCommonValue("GOODS_ID")
	self._discountGoodsId = self.goodsId

	goutil.setActive(self._txtDiscountGo, false)

	local isOnTrial = NewhandwelfareModel.instance:isOnTrialGoldenDiamond()

	if isOnTrial then
		self.txtPrice.text = "体验中"

		Framework.TransformUtil.SetAnchoredPos(self.txtPrice.transform, 0, 1)
	elseif GoldenDiamondCardModel.instance.ableToRenew then
		Framework.TransformUtil.SetAnchoredPos(self.txtPrice.transform, -21, 1)
		goutil.setActive(self._txtDiscountGo, true)

		local newId = GoldenDiamondCardConfig.instance:getCommonValue("NEW_HAND_GOODS_ID")

		self._discountGoodsId = newId
		self.txtPrice.text = lang("￥") .. PayConfig.instance:getPayMoneyYuan(self.goodsId)
		self._txtDiscount.text = lang("￥") .. PayConfig.instance:getPayMoneyYuan(newId)
	else
		Framework.TransformUtil.SetAnchoredPos(self.txtPrice.transform, 0, 1)

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

	goutil.setActive(self.btnBuy.gameObject, isOnTrial or GoldenDiamondCardModel.instance.ableToRenew)
	goutil.setActive(self._bubbleGo, isOnTrial or GoldenDiamondCardModel.instance.ableToRenew)
	goutil.setActive(self.markGain, GoldenDiamondCardModel.instance.prizeNum == 0 and GoldenDiamondCardModel.instance.isUser)

	if GoldenDiamondCardModel.instance.prizeNum > 0 and GoldenDiamondCardModel.instance.isUser then
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

	goutil.setActive(self.timeShow, GoldenDiamondCardModel.instance.isUser)

	local leftTime = math.ceil((GoldenDiamondCardModel.instance.endTime / 1000 - ServerTime.now()) / 86400)

	self.txtDay.text = langPara("剩余有效期:%s天", leftTime)

	self:_setPrivilegeItems()

	if self._actId and self._actId > 0 then
		goutil.setActive(self._btnGet, true)
		goutil.setActive(self._bubbleGo, false)
		goutil.setActive(self.btnBuy.gameObject, false)
		goutil.setActive(self._tipCon1, false)
		goutil.setActive(self._tipCon2, true)

		local curGainFreeGolgenCard = FirstAnnualWelfareModel.instance:getGainFreeGoldenCard()

		self._txtbtnGet.text = curGainFreeGolgenCard and lang("体验中") or lang("领取")
	else
		goutil.setActive(self._tipCon2, false)
		goutil.setActive(self._tipCon1, true)
		goutil.setActive(self._btnGet, false)
		goutil.setActive(self._bubbleGo, isOnTrial or GoldenDiamondCardModel.instance.ableToRenew)
		goutil.setActive(self.btnBuy.gameObject, true)
	end
end

function NewhandprivilegeforNewUserView:onClickBtnBuy()
	if NewhandwelfareModel.instance:isOnTrialGoldenDiamond() then
		return
	end

	if not GoldenDiamondCardModel.instance.ableToRenew then
		return
	end

	if GoldenDiamondCardModel.instance.ableToRenew then
		PayController.instance:pay(self._discountGoodsId, GameEnum.PaySubGoodsType.GOLDENDIAMONDCARD, 1)
	else
		goutil.setActive(self.btnBuy.gameObject, false)
	end
end

function NewhandprivilegeforNewUserView:onClickBtnShowAll()
	UIStateManager.instance:push(ViewName.GoldendiamondallView)
end

function NewhandprivilegeforNewUserView:onClickBtnGainPrize()
	if GoldenDiamondCardModel.instance.isUser and GoldenDiamondCardModel.instance.prizeNum == 1 then
		GoldenDiamondCardAgent.instance:sendPM_GoldenDiamondCardGainDailyPrizeReq()

		return
	end

	if GoldenDiamondCardModel.instance.prizeNum == 0 and GoldenDiamondCardModel.instance.isUser then
		FloatWordMgr.instance:show("今日礼包已领取")

		return
	end

	self:onClickBtnShowAll()
end

function NewhandprivilegeforNewUserView:onClickBtnTip()
	ViewMgr.instance:open(ViewName.RulesView, "goldendiamondcard")
end

function NewhandprivilegeforNewUserView:_onClickbtnClose()
	self:close()
end

function NewhandprivilegeforNewUserView:_setPrivilegeItems()
	for i, item in ipairs(self._privilegeItems) do
		local cfg = NewhandwelfareConfig.instance:getGoldenDiamondCfg(i)
		local isUnlock = cfg.funcId <= 0 or FuncOpenModel.instance:getFuncIsOpen(cfg.funcId)

		goutil.setActive(item.goLock, false)
		item.btn:AddClickListener(function()
			if not isUnlock then
				FloatWordMgr.instance:show(FuncOpenModel.instance:getFuncLockDescription(cfg.funcId))

				return
			end

			if not string.nilorempty(cfg.jumpTo) then
				GotoMgr.gotoByString(cfg.jumpTo)
				self:close()
			end
		end)
	end
end

function NewhandprivilegeforNewUserView:_onClickbtnGet()
	if self._actId and self._actId > 0 then
		local curGainFreeGolgenCard = FirstAnnualWelfareModel.instance:getGainFreeGoldenCard()

		if curGainFreeGolgenCard then
			FloatWordMgr.instance:show("特权已领取，体验中")
		else
			FirstAnnualWelfareController.instance:onSendFirstAnnualWelfareGainFreeGoldenCardReq(self._actId)
		end
	end
end

return NewhandprivilegeforNewUserView
