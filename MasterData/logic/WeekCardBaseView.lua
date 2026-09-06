-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/monthcard/view/WeekCardBaseView.lua

module("logic.extensions.monthcard.view.WeekCardBaseView", package.seeall)

local WeekCardBaseView = class("WeekCardBaseView", ViewComponent)
local BtnState = {
	ISOFFLINE = 4,
	CANBUY = 1,
	CANGET = 2,
	NEXTDAYGet = 3,
	NONE = 0
}

function WeekCardBaseView:ctor()
	WeekCardBaseView.super.ctor(self)
end

function WeekCardBaseView:buildUI()
	WeekCardBaseView.super.buildUI(self)

	self._txtBtnBuy = goutil.findChildTextComponent(self.mainGO, "btnBuy/text")
	self._txtLeftTime = goutil.findChildTextComponent(self.mainGO, "txtLeftTime")
	self._txtBubble = MaterialMgr.findGraphicText(self.mainGO, "txtBubble")
	self._txtBubble2 = MaterialMgr.findGraphicText(self.mainGO, "txtBubble2")
	self._btnBuy = self:getBtn("btnBuy")
	self._effectGo = self:getGo("effect")
end

function WeekCardBaseView:bindEvents()
	WeekCardBaseView.super.bindEvents(self)
	self._btnBuy:AddClickListener(self._onClickbtnBuy, self)
end

function WeekCardBaseView:unbindEvents()
	WeekCardBaseView.super.unbindEvents(self)
	self._btnBuy:RemoveClickListener()
end

function WeekCardBaseView:destroyUI()
	WeekCardBaseView.super.destroyUI(self)
end

function WeekCardBaseView:onEnter()
	WeekCardBaseView.super.onEnter(self)
	GlobalDispatcher:addListener(MonthCardModel.CarStatesChange, self._updateView, self)
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._checkRefreshTime, self)

	self._cardId = self:_getCardId()

	self:_updateView()
	self:_setEffect()
end

function WeekCardBaseView:onEnterFinished()
	WeekCardBaseView.super.onEnterFinished(self)
end

function WeekCardBaseView:onExit()
	WeekCardBaseView.super.onExit(self)
	GlobalDispatcher:removeListener(MonthCardModel.CarStatesChange, self._updateView, self)
	ClockMgr.instance:removeListener(ClockMgr.TickDailyRefresh, self._checkRefreshTime, self)
	UIEffectManager.instance:stopEffect(self._effectHandler)
end

function WeekCardBaseView:onExitFinished()
	WeekCardBaseView.super.onExitFinished(self)
end

function WeekCardBaseView:_getCardId()
	printError("重写！！！！！")
end

function WeekCardBaseView:_onClickbtnBuy()
	local cfg = MonthCardConfig.instance:getCfgById(self._cardId)
	local canBuy = false

	if cfg then
		local isActive = MonthCardModel.instance:isCardActive(cfg.cardId)

		if self._btnState == BtnState.CANBUY then
			local leftTime = 0

			if isActive then
				leftTime = MonthCardModel.instance:getActiveCardLeftTime(cfg.cardId)
				canBuy = leftTime <= cfg.repeatBuyDay
			else
				canBuy = true
			end

			if canBuy then
				local function okFunc()
					PayController.instance:pay(cfg.payGoodsId, GameEnum.PaySubGoodsType.MONTH_CARD, cfg.cardId)
				end

				if isActive then
					local content = string.format("您的%s当前剩余有效期%s天，请确认是否需要购买", cfg.cardName, leftTime)

					TipsFacade.instance:openPopupWindow("提示", content, okFunc)
				else
					okFunc()
				end
			else
				FloatWordMgr.instance:show("暂时不能购买哦")
			end
		elseif self._btnState == BtnState.CANGET then
			if isActive then
				MonthCardAgent.instance:sendPM_MonthCardGainDailyPrizeReq(self._cardId)
			else
				self:_updateView()
				FloatWordMgr.instance:show(cfg.cardName .. "已过期")
			end
		elseif self._btnState == BtnState.NEXTDAYGet then
			FloatWordMgr.instance:show("明天再来")
		elseif self._btnState == BtnState.ISOFFLINE then
			TipsFacade.instance:openTipWindowNoX(lang("tip"), cfg.cardName .. "已下架")
		end
	end
end

function WeekCardBaseView:_updateView()
	local cfg = MonthCardConfig.instance:getCfgById(self._cardId)

	self:_setBtnState(cfg)
	self:_setCardActiveDesc(cfg.cardId)
	self:_setReward(cfg)
end

function WeekCardBaseView:_setCardActiveDesc(cardId)
	self._txtLeftTime.text = MonthCardModel.instance:getCardActiveDescStr(cardId)
end

function WeekCardBaseView:_setBtnState(cfg)
	local isActive = MonthCardModel.instance:isCardActive(cfg.cardId)
	local leftTime = MonthCardModel.instance:getActiveCardLeftTime(cfg.cardId)

	self._btnState = BtnState.NONE

	if isActive then
		local isget = MonthCardModel.instance:isgetCardPrize(cfg.cardId)

		if isget then
			if leftTime <= 0 and not string.nilorempty(cfg.offlineTime) then
				local offlineTime = GameUtil.string2time(cfg.offlineTime)

				if offlineTime <= ServerTime.now() then
					self._btnState = BtnState.ISOFFLINE
				end
			else
				self._btnState = leftTime <= cfg.repeatBuyDay and BtnState.CANBUY or BtnState.NEXTDAYGet
			end
		else
			self._btnState = BtnState.CANGET
		end
	elseif not string.nilorempty(cfg.offlineTime) then
		local offlineTime = GameUtil.string2time(cfg.offlineTime)

		self._btnState = offlineTime <= ServerTime.now() and BtnState.ISOFFLINE or BtnState.CANBUY
	else
		self._btnState = BtnState.CANBUY
	end

	if self._btnState == BtnState.CANBUY then
		self._txtBtnBuy.text = "¥ " .. PayConfig.instance:getPayMoneyYuan(cfg.payGoodsId)
	elseif self._btnState == BtnState.CANGET then
		self._txtBtnBuy.text = "领取"
	elseif self._btnState == BtnState.NEXTDAYGet then
		self._txtBtnBuy.text = "明天再来"
	elseif self._btnState == BtnState.ISOFFLINE then
		self._txtBtnBuy.text = "已下架"
	end
end

function WeekCardBaseView:_setReward(cfg)
	local onceGains = string.split(cfg.onceGain, "#")
	local dailyGains = string.split(cfg.dailyGain, "#")
	local onceGainStr = "购买后立即获得"

	for i, v in ipairs(onceGains) do
		local temp = string.split(v, ":")
		local matType = checknumber(temp[1])
		local matId = checknumber(temp[2])
		local num = checknumber(temp[#temp])
		local name = MaterialMgr.getMaterialsName(matType, matId)

		onceGainStr = onceGainStr .. string.format("%s%s*%s ", MaterialMgr.getContentMatCfg(matType, matId, 40, -10, MaterialMgr.ICON_TYPE_ICON), name, num)

		break
	end

	local dailyGainStr = string.format("<color=%s>%s天</color>内每日登录领取", self:_getCanActiveDayColor(), cfg.day)

	for i, v in ipairs(dailyGains) do
		local temp = string.split(v, ":")
		local matType = checknumber(temp[1])
		local matId = checknumber(temp[2])
		local num = checknumber(temp[#temp])
		local name = MaterialMgr.getMaterialsName(matType, matId)

		dailyGainStr = dailyGainStr .. string.format("%s%s*%s ", MaterialMgr.getContentMatCfg(matType, matId, 40, -10, MaterialMgr.ICON_TYPE_ICON), name, num)
	end

	if self._txtBubble.text ~= onceGainStr then
		self._txtBubble.text = onceGainStr
	end

	if self._txtBubble2.text ~= dailyGainStr then
		self._txtBubble2.text = dailyGainStr
	end
end

function WeekCardBaseView:_getCanActiveDayColor()
	return "#00FF21"
end

function WeekCardBaseView:_checkRefreshTime()
	self:_updateView()
end

function WeekCardBaseView:_setEffect()
	local effName = self:_getEffectName()

	self._effectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

	self._effectHandler:setParent(self._effectGo.transform)
	self._effectHandler:setScale(1)
	self._effectHandler:setLocalPos(0, 0, 0)
end

function WeekCardBaseView:_getEffectName()
	return ""
end

return WeekCardBaseView
