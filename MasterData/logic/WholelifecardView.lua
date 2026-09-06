-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/monthcard/view/WholelifecardView.lua

module("logic.extensions.monthcard.view.WholelifecardView", package.seeall)

local WholelifecardView = class("WholelifecardView", ViewComponent)

function WholelifecardView:ctor()
	return
end

function WholelifecardView:buildUI()
	WholelifecardView.super.buildUI(self)

	self._limitConGo = self:getGo("card/limitCon")
	self._limitCellGo = self:getGo("card/limitCon/cell")

	local buyBtn = goutil.findChild(self.mainGO, "card/buyBtn")

	self.buyBtn = GameUtil.asBtn(buyBtn)
	self.activeDesText = goutil.findChildTextComponent(self.mainGO, "card/activeDesText")
	self.btnDesText = goutil.findChildTextComponent(self.mainGO, "card/btnDesText")
	self.dayGetText = goutil.findChildTextComponent(self.mainGO, "card/dayGetText")
	self.btnText = goutil.findChildTextComponent(self.mainGO, "card/buyBtn/text")
	self.activeDesTextChange = goutil.findChild(self.mainGO, "card/activeDesText"):GetComponent(ComponentType.UITextColorChange)
	self._immgetCon = goutil.findChild(self.mainGO, "card/immgetCon")
	self._immgetCell = goutil.findChild(self.mainGO, "card/immgetCon/cell")
	self._daygetCon = goutil.findChild(self.mainGO, "card/daygetCon")
	self._daygetCell = goutil.findChild(self.mainGO, "card/daygetCon/cell")
	self._immgetGroup = ItemGroup.New(self._immgetCon, self._immgetCell, nil, nil, true)
	self._daygetGroup = ItemGroup.New(self._daygetCon, self._daygetCell, nil, nil, true)
	self._limitGroup = ItemGroup.New(self._limitConGo, self._limitCellGo, nil, nil, true)
	self._bgPet = self:getGo("bg/petCon")
	self._immYlq = self:getGo("card/immYlq")
	self._dayYlq = self:getGo("card/dayYlq")
	self._tipsBtn = self:getBtn("card/btnTip")
end

function WholelifecardView:bindEvents()
	WholelifecardView.super.bindEvents(self)
	self.buyBtn:AddClickListener(self.onClickBuy, self)
	self._tipsBtn:AddClickListener(self._onClickTips, self)
end

function WholelifecardView:unbindEvents()
	WholelifecardView.super.unbindEvents(self)
	self.buyBtn:RemoveClickListener()
	self._tipsBtn:RemoveClickListener()
end

function WholelifecardView:onExit()
	WholelifecardView.super.onExit(self)
	UIEffectManager.instance:stopEffect(self.effectHandler)
	GlobalDispatcher:removeListener(MonthCardModel.CarStatesChange, self._updateView, self)
	self._immgetGroup:dispose(function(item)
		local itemCon = goutil.findChild(item.mainGO, "itemCon")

		MaterialMgr.resetAll(itemCon)
	end)
	self._daygetGroup:dispose(function(item)
		local itemCon = goutil.findChild(item.mainGO, "itemCon")

		MaterialMgr.resetAll(itemCon)
	end)
	self._limitGroup:dispose(function(item)
		local itemCon = goutil.findChild(item.mainGO, "itemCon")

		MaterialMgr.resetAll(itemCon)
	end)

	for k, v in pairs(self._effectHandlers) do
		UIEffectManager.instance:stopEffect(v)
	end

	self._effectHandlers = {}
end

function WholelifecardView:onEnter()
	WholelifecardView.super.onEnter(self)
	GlobalDispatcher:addListener(MonthCardModel.CarStatesChange, self._updateView, self)

	self.index = 2
	self._effectHandlers = {}

	self:_updateView()
end

function WholelifecardView:_updateView()
	local cfg = MonthCardConfig.instance:getCfgByIndex(self.index)
	local isActive = MonthCardModel.instance:isCardActive(cfg.cardId)

	self.activeDesText.text = MonthCardModel.instance:getCardActiveDescStr(cfg.cardId)
	self._isgetPrize = MonthCardModel.instance:isgetCardPrize(cfg.cardId)

	local mosDay = string.split(cfg.dailyGain, "#")
	local list = string.split(cfg.onceGain, "#")
	local mosImm = {}

	for i, str in ipairs(list) do
		mosImm[i] = {
			is_privilege = false,
			str = str
		}
	end

	local mosLimit = string.split(cfg.extraGain, "#")

	goutil.setActive(self._immYlq, MonthCardModel.instance:isCardActive(self.index))
	goutil.setActive(self._dayYlq, self._isgetPrize)
	self._immgetGroup:updateWithMoArray(mosImm, self._updateImmgetCell, self)
	self._daygetGroup:updateWithMoArray(mosDay, self._updateDaygetCell, self)
	self._limitGroup:updateWithMoArray(mosLimit, self._updateLimitCell, self)
	self:setTotalGetDesc(cfg)
	self.activeDesTextChange:SetState(isActive and 1 or 0)

	local showBtn = not isActive
	local leftTime = MonthCardModel.instance:getActiveCardLeftTime(cfg.cardId)

	showBtn = showBtn or leftTime <= cfg.repeatBuyDay

	GameUtil.SetActive(self.buyBtn, showBtn)

	if showBtn then
		self.btnText.text = "¥ " .. PayConfig.instance:getPayMoney(cfg.payGoodsId) * PayModel.RMB_UNIT
	end
end

function WholelifecardView:onClickBuy()
	local cfg = MonthCardConfig.instance:getCfgByIndex(self.index)
	local canBuy = false

	if cfg then
		local isActive = MonthCardModel.instance:isCardActive(cfg.cardId)

		if isActive then
			local leftTime = MonthCardModel.instance:getActiveCardLeftTime(cfg.cardId)

			canBuy = leftTime <= cfg.repeatBuyDay
		else
			canBuy = true
		end

		if canBuy then
			PayController.instance:pay(cfg.payGoodsId, GameEnum.PaySubGoodsType.MONTH_CARD, cfg.cardId)
		else
			FloatWordMgr.instance:show("暂时不能购买哦")
		end
	end
end

function WholelifecardView:_onClickGet()
	if self._isgetPrize then
		FloatWordMgr.instance:show("今日奖励已领取，请明天再来")

		return
	end

	MonthCardAgent.instance:sendPM_MonthCardGainDailyPrizeReq(self.index)
end

function WholelifecardView:_updateImmgetCell(item, data)
	local itemCon = goutil.findChild(item.mainGO, "itemCon")
	local effect = goutil.findChild(item.mainGO, "effect")

	goutil.setActive(effect, false)
	goutil.setActive(itemCon, true)
	MaterialMgr.setCellByCfg(data.str, itemCon)
end

function WholelifecardView:_updateDaygetCell(item, str)
	local itemCon = goutil.findChild(item.mainGO, "itemCon")
	local effect = goutil.findChild(item.mainGO, "effect")
	local proxy = MaterialMgr.setCellByCfg(str, itemCon)
	local isActive = MonthCardModel.instance:isCardActive(self.index)

	if isActive then
		::label_14_0::

		local notget = not MonthCardModel.instance:isgetCardPrize(self.index)
		local showEffect = isActive and notget

		goutil.setActive(effect, showEffect)

		if showEffect then
			local handler = self._effectHandlers[effect]

			handler = handler or UIEffectManager.instance:playEffect(self, "fx_ui_tequan/fx_ui_tequan_kuang.prefab", nil, nil, nil, true)

			handler:setParent(effect.transform)
			handler:setScale(1.4)
			handler:setLocalPos(0, 0, 0)

			self._effectHandlers[effect] = handler
		end

		proxy.binder:setAutoTips(not showEffect)

		if showEffect then
			proxy.binder:setCallBack(function()
				self:_onClickGet()
			end)
		else
			proxy.binder:setCallBack(nil)
		end
	end
end

function WholelifecardView:_updateLimitCell(item, str)
	local itemCon = goutil.findChild(item.mainGO, "itemCon")

	MaterialMgr.setCellByCfg(str, itemCon)
end

function WholelifecardView:setTotalGetDesc(cfg)
	if self.index == 2 then
		local list = GameUtil.parseItemStr(cfg.dailyGain)
		local count = 0

		for i, v in ipairs(list) do
			if v.itemType == MatType.Diamond then
				count = v.count

				break
			end
		end
	else
		local kvList = {}
		local list1 = GameUtil.parseItemStr(cfg.onceGain)
		local list2 = GameUtil.parseItemStr(cfg.dailyGain)

		for i, v in ipairs(list1) do
			local key = v.itemType .. "@" .. v.itemId
			local data = kvList[key]

			if data then
				data.count = v.count + data.count
			else
				kvList[key] = v
			end
		end

		for i, v in ipairs(list2) do
			local key = v.itemType .. "@" .. v.itemId
			local data = kvList[key]

			if data then
				data.count = v.count * cfg.day + data.count
			else
				v.count = v.count * cfg.day
				kvList[key] = v
			end
		end

		local sortList = {}

		for k, v in pairs(kvList) do
			table.insert(sortList, v)
		end

		table.sort(sortList, function(a, b)
			return a.itemType < b.itemType
		end)

		local str = ""

		for i, v in ipairs(sortList) do
			local name = MaterialModel.instance:getMaterialsName(v.itemType, v.itemId)

			str = str .. string.format("%s*%s%s", name, v.count, i == #sortList and "" or "+")
		end
	end
end

function WholelifecardView:_onClickTips()
	TipsFacade.instance:openRulesView("monthcard2")
end

return WholelifecardView
