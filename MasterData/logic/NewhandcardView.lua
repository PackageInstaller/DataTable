-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newhandcard/view/NewhandcardView.lua

module("logic.extensions.newhandcard.view.NewhandcardView", package.seeall)

local NewhandcardView = class("NewhandcardView", ViewComponent)

function NewhandcardView:ctor()
	NewhandcardView.super.ctor(self)
end

function NewhandcardView:buildUI()
	NewhandcardView.super.buildUI(self)

	self._tipBtn = self:getBtn("tipBtn")
	self._recordBtn = self:getBtn("recordBtn")
	self._costTextCon = self:getGo("costTextCon")
	self._hasBuyText = self:getGo("hasBuyText")
	self._clostBtn = self:getBtn("btnClose")
	self._txtBubble = goutil.findChildTextComponent(self.mainGO, "txtBubble")
	self._disCountGo = self:getGo("costTextCon/disCountCon")
	self._norText = goutil.findChildTextComponent(self.mainGO, "costTextCon/norText")
	self._disCountText = goutil.findChildTextComponent(self._disCountGo, "text")
	self._buyBtn = GameUtil.asBtn(self._costTextCon)
end

function NewhandcardView:bindEvents()
	NewhandcardView.super.bindEvents(self)
	self._tipBtn:AddClickListener(self._onClickTip, self)
	self._recordBtn:AddClickListener(self._onClickRecord, self)
	self._buyBtn:AddClickListener(self._onClickBuy, self)
	self._clostBtn:AddClickListener(self.close, self)
end

function NewhandcardView:unbindEvents()
	NewhandcardView.super.unbindEvents(self)
	self._tipBtn:RemoveClickListener()
	self._recordBtn:RemoveClickListener()
	self._buyBtn:RemoveClickListener()
	self._clostBtn:RemoveClickListener()
end

function NewhandcardView:destroyUI()
	NewhandcardView.super.destroyUI(self)
end

function NewhandcardView:onEnter()
	NewhandcardView.super.onEnter(self)
	GlobalDispatcher:addListener(NewHandCardAgent.NewHandCardInfoRes, self._updateView, self)
	GlobalDispatcher:addListener(NewHandCardAgent.NotifyNewHandCardBuySucRes, self._updateView, self)
	NewHandCardAgent.instance:sendPM_NewHandCardInfoReq()
	self:_updateView()
end

function NewhandcardView:onEnterFinished()
	NewhandcardView.super.onEnterFinished(self)
end

function NewhandcardView:onExit()
	NewhandcardView.super.onExit(self)
	GlobalDispatcher:removeListener(NewHandCardAgent.NewHandCardInfoRes, self._updateView, self)
	GlobalDispatcher:removeListener(NewHandCardAgent.NotifyNewHandCardBuySucRes, self._updateView, self)
end

function NewhandcardView:onExitFinished()
	NewhandcardView.super.onExitFinished(self)
end

function NewhandcardView:_onClickTip()
	TipsFacade.instance:openRulesView("newhandcard")
end

function NewhandcardView:_onClickRecord()
	UIStateManager.instance:push(ViewName.NewhandcardrecordView)
end

function NewhandcardView:_onClickBuy()
	if self._cardCfg then
		PayController.instance:pay(self._cardCfg.payGoodsId, GameEnum.PaySubGoodsType.NEW_HAND_CARD, self._cardCfg.id)
	end
end

function NewhandcardView:_updateView()
	local isBuy = NewHandCardModel.instance:isBuyCard()
	local cfg = NewHandCardConfig.instance:getCfgById(1)

	self._cardCfg = cfg

	local preMoney = cfg.oldPrice
	local currMoney = 0
	local payCfg = PayConfig.instance:getPayGoodsCfg(cfg.payGoodsId)

	if payCfg then
		currMoney = payCfg.payMoney
	end

	local showDiscount = currMoney < preMoney

	goutil.setActive(self._costTextCon, not isBuy)
	goutil.setActive(self._hasBuyText, isBuy)
	goutil.setActive(self._disCountGo, showDiscount)

	if showDiscount then
		self._norText.fontSize = 20
		self._norText.alignment = UnityEngine.TextAnchor.MiddleLeft
		self._norText.text = "¥ " .. math.round(preMoney * PayModel.RMB_UNIT)
		self._disCountText.text = " ¥ " .. currMoney * PayModel.RMB_UNIT
	else
		self._norText.text = "¥ " .. currMoney * PayModel.RMB_UNIT
		self._norText.fontSize = 24
		self._norText.alignment = UnityEngine.TextAnchor.MiddleCenter
	end

	self._txtBubble.text = cfg.desc
end

return NewhandcardView
