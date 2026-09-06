-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/monthcard/view/MonthcardView.lua

module("logic.extensions.monthcard.view.MonthcardView", package.seeall)

local MonthcardView = class("MonthcardView", ViewComponent)

function MonthcardView:ctor()
	return
end

function MonthcardView:buildUI()
	MonthcardView.super.buildUI(self)

	self._limitConGo = self:getGo("card/limitCon")

	local buyBtn = goutil.findChild(self.mainGO, "card/buyBtn")

	self.buyBtn = GameUtil.asBtn(buyBtn)
	self.activeDesText = goutil.findChildTextComponent(self.mainGO, "card/activeDesText")
	self.dayGetText = goutil.findChildTextComponent(self.mainGO, "card/dayGetText")
	self.btnText = goutil.findChildTextComponent(self.mainGO, "card/buyBtn/text")
	self.activeDesTextChange = goutil.findChild(self.mainGO, "card/activeDesText"):GetComponent(ComponentType.UITextColorChange)
	self._immgetCon = goutil.findChild(self.mainGO, "card/immgetCon")
	self._immgetCell = goutil.findChild(self.mainGO, "card/immgetCon/cell")
	self._daygetCon = goutil.findChild(self.mainGO, "card/daygetCon")
	self._daygetCell = goutil.findChild(self.mainGO, "card/daygetCon/cell")
	self._immgetGroup = ItemGroup.New(self._immgetCon, self._immgetCell, nil, nil, true)
	self._daygetGroup = ItemGroup.New(self._daygetCon, self._daygetCell, nil, nil, true)
	self._immYlq = self:getGo("card/immYlq")
	self._dayYlq = self:getGo("card/dayYlq")
	self._tipsBtn = self:getBtn("card/btnTip")
	self._backInfoGo = self:getGo("backInfoGo")

	if self._backInfoGo then
		self._backTxt = goutil.findChildTextComponent(self._backInfoGo, "backTxt")

		GameUtil.SetActive(self._backInfoGo, false)
	end

	self._petInfo = self:getGo("petInfo")

	if self._petInfo then
		self._btnSkill = self:getGo("petInfo/btnSkill")
		self._btnInfo = self:getGo("petInfo/btnInfo")
		self._rare = self:getGo("petInfo/rare")
		self._txtPetName = self:getTxt("petInfo/txtName")
	end
end

function MonthcardView:bindEvents()
	MonthcardView.super.bindEvents(self)
	self.buyBtn:AddClickListener(self.onClickBuy, self)
	self._tipsBtn:AddClickListener(self._onClickTips, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickSkill, self)
	GameUtil.addClickHandler(self._btnInfo, self._onClickInfo, self)
end

function MonthcardView:unbindEvents()
	MonthcardView.super.unbindEvents(self)
	self.buyBtn:RemoveClickListener()
	self._tipsBtn:RemoveClickListener()
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnInfo)
end

function MonthcardView:onExit()
	MonthcardView.super.onExit(self)
	MaterialMgr.resetAll(self._limitConGo)
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

	for k, v in pairs(self._effectHandlers) do
		UIEffectManager.instance:stopEffect(v)
	end

	self._effectHandlers = {}

	removetimer(self._updateView, self)
	MaterialMgr.resetAll(self._rare)
end

function MonthcardView:onEnter()
	MonthcardView.super.onEnter(self)
	GlobalDispatcher:addListener(MonthCardModel.CarStatesChange, self._updateView, self)

	self.index = self:_getCardId()
	self._effectHandlers = {}

	self:_updateView()
	self:_checkCardDisabledTime()
end

function MonthcardView:_getCardId()
	return MonthCardModel.MonthCardId
end

function MonthcardView:_updateView()
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

	goutil.setActive(self._immYlq, MonthCardModel.instance:isCardActive(self.index))
	goutil.setActive(self._dayYlq, self._isgetPrize)
	self._immgetGroup:updateWithMoArray(mosImm, self._updateImmgetCell, self)
	self._daygetGroup:updateWithMoArray(mosDay, self._updateDaygetCell, self)
	MaterialMgr.setCellByCfg(cfg.extraGain, self._limitConGo)
	self:setTotalGetDesc(cfg)
	self.activeDesTextChange:SetState(isActive and 1 or 0)

	local showBtn = not isActive
	local leftTime = MonthCardModel.instance:getActiveCardLeftTime(cfg.cardId)

	showBtn = showBtn or leftTime <= cfg.repeatBuyDay

	GameUtil.SetActive(self.buyBtn, showBtn)

	if showBtn then
		self.btnText.text = "¥ " .. PayConfig.instance:getPayMoney(cfg.payGoodsId) * PayModel.RMB_UNIT
	end

	goutil.setActive(self.buyBtn.gameObject, showBtn and self:_isCanBuyCard())

	if checknumber(cfg.faceId) > 0 and self._petInfo ~= nil then
		self:_refreshPetInfo()
	end
end

function MonthcardView:onClickBuy()
	local cfg = MonthCardConfig.instance:getCfgByIndex(self.index)
	local canBuy = false

	if cfg then
		local isActive = MonthCardModel.instance:isCardActive(cfg.cardId)
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
				local content = string.format("您的月卡当前剩余有效期%s天，请确认是否需要购买", leftTime)

				TipsFacade.instance:openPopupWindow("提示", content, okFunc)
			else
				okFunc()
			end
		else
			FloatWordMgr.instance:show("暂时不能购买哦")
		end
	end
end

function MonthcardView:_onClickGet()
	if self._isgetPrize then
		FloatWordMgr.instance:show("今日奖励已领取，请明天再来")

		return
	end

	MonthCardAgent.instance:sendPM_MonthCardGainDailyPrizeReq(self.index)
end

function MonthcardView:_updateImmgetCell(item, data)
	local fakeCell = goutil.findChild(item.mainGO, "fakecell")
	local itemCon = goutil.findChild(item.mainGO, "itemCon")
	local effect = goutil.findChild(item.mainGO, "effect")

	goutil.setActive(effect, false)
	goutil.setActive(fakeCell, false)
	goutil.setActive(itemCon, true)
	MaterialMgr.setCellByCfg(data.str, itemCon)
end

function MonthcardView:_updateDaygetCell(item, str)
	local itemCon = goutil.findChild(item.mainGO, "itemCon")
	local effect = goutil.findChild(item.mainGO, "effect")
	local proxy = MaterialMgr.setCellByCfg(str, itemCon)
	local isActive = MonthCardModel.instance:isCardActive(self.index)

	if isActive then
		::label_15_0::

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

function MonthcardView:setTotalGetDesc(cfg)
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

function MonthcardView:_onClickTips()
	TipsFacade.instance:openRulesView("monthcard1")
end

function MonthcardView:_checkCardDisabledTime()
	local disableTime = RoleModel.instance:getMonthcardDisabledTime(self:_getCardId())

	self._leftTime = disableTime - ServerTime.now()

	if self._leftTime > 0 then
		settimer(self._leftTime, self._updateView, self, false)
	else
		removetimer(self._updateView, self)
	end
end

function MonthcardView:_isCanBuyCard()
	local cfg = MonthCardConfig.instance:getCfgById(self:_getCardId())

	if cfg and not string.nilorempty(cfg.offlineTime) then
		local endTime = GameUtil.string2time(cfg.offlineTime)

		return endTime > ServerTime.now()
	end

	return true
end

function MonthcardView:_refreshPetInfo()
	local cfg = MonthCardConfig.instance:getCfgById(self:_getCardId())

	MaterialMgr.resetAll(self._rare)

	local petCo = PetSkinConfig.instance:getPetSkinCfg(cfg.faceId)

	MaterialMgr.setCell(MatType.PetSkin_Rare, cfg.faceId, self._rare)

	self._txtPetName.text = petCo.skinName
end

function MonthcardView:_onClickInfo()
	local cfg = MonthCardConfig.instance:getCfgById(self:_getCardId())

	if checknumber(cfg.faceId) > 0 then
		PetbookController.instance:openSkinViewNoSetAttr(cfg.faceId)
	end
end

function MonthcardView:_onClickSkill()
	local cfg = MonthCardConfig.instance:getCfgById(self:_getCardId())
	local skinCfg = PetSkinConfig.instance:getPetSkinCfg(cfg.faceId)

	if skinCfg then
		local raceId = skinCfg.raceId

		PetbookController.instance:previewBattle(raceId, cfg.faceId)
	end
end

return MonthcardView
