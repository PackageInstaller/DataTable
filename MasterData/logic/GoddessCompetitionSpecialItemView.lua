-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscompetition/view/GoddessCompetitionSpecialItemView.lua

module("logic.extensions.goddesscompetition.view.GoddessCompetitionSpecialItemView", package.seeall)

local GoddessCompetitionSpecialItemView = class("GoddessCompetitionSpecialItemView", ViewComponent)

function GoddessCompetitionSpecialItemView:ctor()
	GoddessCompetitionSpecialItemView.super.ctor(self)
end

function GoddessCompetitionSpecialItemView:unbindEvents()
	GoddessCompetitionSpecialItemView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnGoto)
end

function GoddessCompetitionSpecialItemView:bindEvents()
	GoddessCompetitionSpecialItemView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnGoto, self._onClickGoto, self)
end

function GoddessCompetitionSpecialItemView:buildUI()
	GoddessCompetitionSpecialItemView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")

	local scrView = self:getGo("itemCol/scrView")
	local scrCell = self:getGo("itemCol/scrCell")

	self._itemScrollerList = ScrollerList.create(scrView, scrCell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))
	self._txtBtnUse = self:getTxt("itemCol/scrCell/btnUse/txt")
	self._strBtnUse = self._txtBtnUse.text
	self._prizeCol = self:getGo("prizeCol")
	self._prizeScrView = self:getGo("prizeCol/scrView")
	self._prizeScrCell = self:getGo("prizeCol/scrCell")
	self._progressBar = self:getGo("prizeCol/scrView/Viewport/Content/progressBar")
	self._sliderComp = self:getSlider("prizeCol/scrView/Viewport/Content/progressBar")
	self._prizeCol_total = self:getGo("prizeCol/total")
	self._prizeCol_total_txtNum = self:getTxt("prizeCol/total/txtNum")
	self._prizeScrollerList = ScrollerList.create(self._prizeScrView, self._prizeScrCell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))
	self._btnGoto = self:getGo("prizeCol/btnGoto")
end

function GoddessCompetitionSpecialItemView:onEnter()
	GoddessCompetitionSpecialItemView.super.onEnter(self)

	self._activityId = GoddessCompetitionModel.instance:getCurActId()

	self:_onUpdate()
	self.addGEvent(self, GlobalNotify.GoddessCompetitionUseDoubleCardRes, self._onUseDoubleCard, self)
	self.addGEvent(self, GlobalNotify.GoddessCompetitionDoubleCardNotify, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.GoddessCompetitionGainProgressPrizeRes, self._onUpdate, self)
end

function GoddessCompetitionSpecialItemView:onExit()
	GoddessCompetitionSpecialItemView.super.onExit(self)
	self._itemScrollerList:dispose()
	self._prizeScrollerList:dispose()
end

function GoddessCompetitionSpecialItemView:_onUseDoubleCard()
	FloatWordMgr.instance:show("使用成功")
	self:_updateItemList()
end

function GoddessCompetitionSpecialItemView:_onUpdate()
	self:_updateItemList()
	self:_onUpdatePrizeCol()
end

function GoddessCompetitionSpecialItemView:_updateItemList()
	local cfgs = GoddessCompetitionConfig.instance:getDoubleCardCfgs(self._activityId) or {}

	self._itemScrollerList:reloadData(cfgs)
end

function GoddessCompetitionSpecialItemView:_updateItemCell(view, cell, data, tag)
	local cost = data.cost
	local ownCount = MaterialMgr.getMatCount(cost)
	local curDoubleCard = GoddessCompetitionModel.instance:getDoubleCardInfo()
	local effectCardId = checknumber(curDoubleCard and curDoubleCard.effectDoubleCardId)
	local leftValue = checknumber(curDoubleCard and curDoubleCard.doubleCardLeftValue)
	local isGlobalActive = effectCardId > 0 and leftValue > 0
	local isEnoughCount = ownCount > 0
	local isActive = effectCardId == data.cardId
	local mainGo = cell.gameObject
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local countGo = goutil.findChild(mainGo, "count")
	local txtCount = goutil.findChildTextComponent(mainGo, "count/txt")
	local item = goutil.findChild(mainGo, "item")
	local btnUse = goutil.findChild(mainGo, "btnUse")
	local txtBtnUse = goutil.findChildTextComponent(mainGo, "btnUse/txt")
	local banTips = goutil.findChild(mainGo, "banTips")
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")

	txtName.text = MaterialMgr.getMaterialsNameByCfg(cost)
	txtCount.text = string.format("剩余生效票数:<color=#32FFE9FF>%s</color>/%s", leftValue, data.cardValue)

	GameUtil.SetActive(countGo, isActive)

	local matType, cfgId = MaterialMgr.getMatParams(cost)

	MaterialMgr.setIcon(item, matType, cfgId)

	local cardValue = checknumber(data.cardValue)
	local ratio = checknumber(data.ratio)

	txtDesc.text = string.format("使用后，后续投票/发红包增加的人气值中，前%s点按%s倍生效，超出部分按1倍生效", cardValue, ratio)

	GameUtil.SetActive(banTips, not isActive and isGlobalActive)

	txtBtnUse.text = isActive and "生效中" or self._strBtnUse

	GameUtil.SetGray(btnUse, not isEnoughCount or isGlobalActive)
	GameUtil.addClickHandler(btnUse, GameUtil.handler(self._onClickUse, self, data))
end

function GoddessCompetitionSpecialItemView:_clearItemCell(cell)
	local mainGo = cell.gameObject
	local btnUse = goutil.findChild(mainGo, "btnUse")
	local item = goutil.findChild(mainGo, "item")

	GameUtil.SetGray(btnUse, false)
	GameUtil.rmClickHandler(btnUse)
	MaterialMgr.resetAll(item)
end

function GoddessCompetitionSpecialItemView:_onClickUse(data)
	local curDoubleCard = GoddessCompetitionModel.instance:getDoubleCardInfo()
	local effectCardId = checknumber(curDoubleCard and curDoubleCard.effectDoubleCardId)
	local leftValue = checknumber(curDoubleCard and curDoubleCard.doubleCardLeftValue)
	local isGlobalActive = effectCardId > 0 and leftValue > 0

	if isGlobalActive then
		FloatWordMgr.instance:show("无法使用，当前已存在全局生效的翻倍卡")

		return
	end

	local isInCompetitionTime = GoddessCompetitionController.instance:isInCompetitionTime(self._activityId)

	if not isInCompetitionTime then
		FloatWordMgr.instance:show("活动已结束")

		return
	end

	local cost = data.cost
	local matNum = MaterialMgr.getMatCount(cost)

	if matNum <= 0 then
		FloatWordMgr.instance:show("数量不足，无法使用")

		return
	end

	local itemName = MaterialMgr.getMaterialsNameByCfg(cost)
	local cardValue = checknumber(data.cardValue)
	local ratio = checknumber(data.ratio)
	local text = string.format("是否立即使用【%s】？\n使用后，后续投票/发红包增加的人气值中，前%s点按%s倍生效，超出部分按1倍生效", itemName, cardValue, ratio)

	TipsFacade.instance:openPopupWindow("提示", text, function()
		GoddessCompetitionController.instance:useDoubleCard(self._activityId, data.cardId)
	end)
end

function GoddessCompetitionSpecialItemView:_onUpdatePrizeCol()
	local dataList = self:_getProgressDataList()
	local curProgress = self:_getCurProgress()
	local sliderComp = self:_getSliderComp()
	local scoreList = {}

	for _, data in ipairs(dataList) do
		table.insert(scoreList, self:_getProgressByData(data))
	end

	local index = -1

	for idx, data in ipairs(dataList) do
		if not self:_isHasGainPrize(data) then
			index = idx

			break
		end
	end

	self._prizeScrollerList:reloadData(dataList)
	self._prizeScrollerList:updateUnderSlider(sliderComp, curProgress, scoreList)
	self._prizeScrollerList:MoveCellToCenter(index == -1 and 0 or index)

	self._prizeCol_total_txtNum.text = curProgress
end

function GoddessCompetitionSpecialItemView:_getProgressDataList()
	return GoddessCompetitionConfig.instance:getProgressPrizeCfgs(self._activityId) or {}
end

function GoddessCompetitionSpecialItemView:_getSliderComp()
	return self._sliderComp
end

function GoddessCompetitionSpecialItemView:_getScrollRect()
	return self._prizeScrView:GetComponent(ComponentType.ScrollRect)
end

function GoddessCompetitionSpecialItemView:_getCurProgress()
	return GoddessCompetitionModel.instance:getTotalPopularity()
end

function GoddessCompetitionSpecialItemView:_getProgressByData(data)
	return checknumber(data.progress)
end

function GoddessCompetitionSpecialItemView:_getPrizeIdByData(data)
	return data.prizeId
end

function GoddessCompetitionSpecialItemView:_getPrizeStrByData(data)
	return data.prize
end

function GoddessCompetitionSpecialItemView:_isHasGainPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return GoddessCompetitionModel.instance:isPrizeGained(prizeId)
end

function GoddessCompetitionSpecialItemView:_isEnoughGetPrize(data)
	local curProgress = self:_getCurProgress()
	local needProgress = self:_getProgressByData(data)

	return needProgress <= curProgress
end

function GoddessCompetitionSpecialItemView:_isCanGetPrize(data)
	return self:_isEnoughGetPrize(data) and not self:_isHasGainPrize(data)
end

function GoddessCompetitionSpecialItemView:_updatePrizeCell(view, cell, data, tag)
	local prizeId = self:_getPrizeIdByData(data)
	local isHasGain = self:_isHasGainPrize(data)
	local isCanGet = self:_isCanGetPrize(data)
	local progress = self:_getProgressByData(data)
	local prizeStr = self:_getPrizeStrByData(data)
	local scrollRect = self:_getScrollRect()
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local received = goutil.findChild(mainGo, "received")
	local btnGet = goutil.findChild(mainGo, "btnGet")
	local txtScore = goutil.findChildTextComponent(mainGo, "txtScore")
	local effectRoot = goutil.findChild(mainGo, "effectRoot")

	if not string.nilorempty(prizeStr) then
		MaterialMgr.setCellByCfg(prizeStr, item)
	else
		MaterialMgr.resetAll(item)
	end

	if txtScore then
		txtScore.text = progress
	end

	GameUtil.SetActive(received, isHasGain)
	GameUtil.SetActive(btnGet, isCanGet)

	if isCanGet then
		local function loadedHandler(handlerTarget, eff)
			eff:setScrollRectClipping(scrollRect)
		end

		self:playViewEffectUniGo("fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", effectRoot, nil, true, nil, loadedHandler)
	else
		self:stopViewEffectUniGo(effectRoot)
	end

	GameUtil.addClickHandler(btnGet, GameUtil.handler(self._onClickPrizeGet, self, data))
end

function GoddessCompetitionSpecialItemView:_clearPrizeCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local btnGet = goutil.findChild(mainGo, "btnGet")
	local effectRoot = goutil.findChild(mainGo, "effectRoot")

	MaterialMgr.resetAll(item)
	GameUtil.rmClickHandler(btnGet)
	self:stopViewEffectUniGo(effectRoot)
end

function GoddessCompetitionSpecialItemView:_onClickPrizeGet(data)
	if self:_isHasGainPrize(data) then
		FloatWordMgr.instance:show("已领取")

		return
	end

	if not self:_isEnoughGetPrize(data) then
		FloatWordMgr.instance:show("未满足")

		return
	end

	local prizeId = self:_getPrizeIdByData(data)

	GoddessCompetitionController.instance:gainProgressPrize(self._activityId, {
		prizeId
	})
end

function GoddessCompetitionSpecialItemView:_onClickGoto()
	local frameId = self._activityId
	local headTabId = 1
	local secTabId = GoddessCompetitionController.instance:getCurStepIdByTime(self._activityId)

	GlobalDispatcher:dispatch(TabFrameWorkController.NotifyOpentabframeworkview, {
		frameId,
		headTabId,
		secTabId
	})
end

return GoddessCompetitionSpecialItemView
