-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fruitninja/view/FruitNinjaMainView.lua

module("logic.extensions.fruitninja.view.FruitNinjaMainView", package.seeall)

local FruitNinjaMainView = class("FruitNinjaMainView", ViewComponent)

function FruitNinjaMainView:buildUI()
	FruitNinjaMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtOpenTime = self:getTxt("openTime/txt")
	self._btnRank = self:getGo("btnCol/btnRank")
	self._btnBuff = self:getGo("btnCol/btnBuff")
	self._btnNorGo = self:getGo("btnNor")
	self._btnNor = self:getGo("btnNor/btn")
	self._redBtnNor = self:getGo("btnNor/btn/redPoint")
	self._txtDescBtnNor = self:getTxt("btnNor/desc/txt")
	self._strTxtDescBtnNor = self._txtDescBtnNor.text
	self._bubbleBtnNor = self:getGo("btnNor/bubble")
	self._bubbleItemBtnNor = self:getGo("btnNor/bubble/item")
	self._btnExtGo = self:getGo("btnExt")
	self._btnExt = self:getGo("btnExt/btn")
	self._redBtnExt = self:getGo("btnExt/btn/redPoint")
	self._txtDescBtnExt = self:getTxt("btnExt/desc/txt")
	self._strTxtDescBtnExt = self._txtDescBtnExt.text
	self._prizeCol = goutil.findChild(self.mainGO, "prizeCol")
	self._prizeScrollerview = goutil.findChild(self.mainGO, "prizeCol/scrView")
	self._prizeScrollercell = goutil.findChild(self.mainGO, "prizeCol/scrCell")
	self._progressBar = goutil.findChild(self.mainGO, "prizeCol/scrView/Viewport/Content/progressBar")
	self._sliderComp = self:getSlider("prizeCol/scrView/Viewport/Content/progressBar")
	self._prizeCol_total = goutil.findChild(self.mainGO, "prizeCol/total")
	self._prizeCol_total_txtNum = goutil.findChildTextComponent(self.mainGO, "prizeCol/total/txtNum")
	self._prizeCol_total_icon = goutil.findChild(self.mainGO, "prizeCol/total/icon")
	self._prizeScrollerList = ScrollerList.create(self._prizeScrollerview, self._prizeScrollercell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))
end

function FruitNinjaMainView:bindEvents()
	FruitNinjaMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnNor, self._onClickBtnNor, self)
	GameUtil.addClickHandler(self._btnExt, self._onClickBtnExt, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickBtnRank, self)
	GameUtil.addClickHandler(self._btnBuff, self._onClickBtnBuff, self)
end

function FruitNinjaMainView:unbindEvents()
	FruitNinjaMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnNor)
	GameUtil.rmClickHandler(self._btnExt)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnBuff)
end

function FruitNinjaMainView:onEnter()
	FruitNinjaMainView.super.onEnter(self)

	self._activityId = FruitNinjaController.instance:getActivityId()
	self._activityType = FruitNinjaController.instance:getActivityType()

	local isInTime = FruitNinjaController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._actData = FruitNinjaConfig.instance:getActData(self._activityId)
	self._fruitNinjaMo = FruitNinjaController.instance:getFruitNinjaMo(self._activityId)

	self.addGEvent(self, GlobalNotify.HandlePM_FruitNinjaGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_FruitNinjaGainPrizeRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_FruitNinjaEndGameRes, self._handlePM_FruitNinjaEndGameRes, self)
	self:_onSetUI()
	self:_onUpdate()
	FruitNinjaController.instance:sendPM_FruitNinjaGetInfoReq(self._activityId)
end

function FruitNinjaMainView:onExit()
	FruitNinjaMainView.super.onExit(self)
	self:_onClearPrizeCol()
end

function FruitNinjaMainView:_handlePM_FruitNinjaEndGameRes()
	FruitNinjaController.instance:sendPM_FruitNinjaGetInfoReq(self._activityId)
end

function FruitNinjaMainView:_onSetUI()
	if self._txtOpenTime then
		self._txtOpenTime.text = GameUtil.getActTimeDesc(self._activityType, self._activityId)
	end
end

function FruitNinjaMainView:_onUpdate()
	local leftTimes = self._fruitNinjaMo:getLeftNormalGameTimes()
	local maxTimes = self._fruitNinjaMo:getMaxNormalGameTimes()

	self._txtDescBtnNor.text = string.format(self._strTxtDescBtnNor, leftTimes, maxTimes)

	local maxScore = self._fruitNinjaMo:getHistoryMaxScore(FruitNinjaEnum.GameMode_Ext)

	self._txtDescBtnExt.text = string.format(self._strTxtDescBtnExt, maxScore)

	self:_onUpdatePrizeCol()
end

function FruitNinjaMainView:_onUpdatePrizeCol()
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

function FruitNinjaMainView:_onClearPrizeCol()
	self._prizeScrollerList:dispose()
	MaterialMgr.clearIcon(self._prizeCol_total_icon)
end

function FruitNinjaMainView:_getProgressDataList()
	return FruitNinjaConfig.instance:getProgressPrizeCfg(self._activityId) or {}
end

function FruitNinjaMainView:_getSliderComp()
	return self._sliderComp
end

function FruitNinjaMainView:_getScrollRect()
	return self._prizeScrollerview:GetComponent(ComponentType.ScrollRect)
end

function FruitNinjaMainView:_getCurProgress()
	return self._fruitNinjaMo:getNormalModeScore()
end

function FruitNinjaMainView:_getProgressByData(data)
	return data.needScore
end

function FruitNinjaMainView:_getPrizeIdByData(data)
	return data.prizeId
end

function FruitNinjaMainView:_getPrizeStrByData(data)
	return data.prize
end

function FruitNinjaMainView:_isHasGainPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return self._fruitNinjaMo:isHasGainPrizeNormal(prizeId)
end

function FruitNinjaMainView:_isEnoughGetPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return self._fruitNinjaMo:isEnoughGetPrize(prizeId)
end

function FruitNinjaMainView:_isCanGetPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return self._fruitNinjaMo:isCanGetPrizeNormal(prizeId)
end

function FruitNinjaMainView:_updatePrizeCell(view, cell, data, tag)
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

function FruitNinjaMainView:_clearPrizeCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local btnGet = goutil.findChild(mainGo, "btnGet")
	local effectRoot = goutil.findChild(mainGo, "effectRoot")

	MaterialMgr.resetAll(item)
	GameUtil.rmClickHandler(btnGet)
	self:stopViewEffectUniGo(effectRoot)
end

function FruitNinjaMainView:_onClickPrizeGet(data)
	if self:_isHasGainPrize(data) then
		FloatWordMgr.instance:show("已领取")

		return
	end

	if not self:_isEnoughGetPrize(data) then
		FloatWordMgr.instance:show("未满足")

		return
	end

	local prizeId = self:_getPrizeIdByData(data)

	FruitNinjaController.instance:sendPM_FruitNinjaGainPrizeReq(self._activityId, prizeId)
end

function FruitNinjaMainView:_onClickBtnNor()
	FruitNinjaController.instance:startFruitNinjaGame(self._activityId, FruitNinjaEnum.GameMode_Nor)
end

function FruitNinjaMainView:_onClickBtnExt()
	FruitNinjaController.instance:startFruitNinjaGame(self._activityId, FruitNinjaEnum.GameMode_Ext)
end

function FruitNinjaMainView:_onClickBtnRank()
	UIStateManager.instance:push(ViewName.FruitNinjaGameRankView, self._activityId)
end

function FruitNinjaMainView:_onClickBtnBuff()
	UIStateManager.instance:push(ViewName.FruitNinjaBuffView, self._activityId)
end

function FruitNinjaMainView:_onClickBtnTip()
	local key = self._actData.ruleKey

	TipsFacade.instance:openRulesView(key)
end

return FruitNinjaMainView
