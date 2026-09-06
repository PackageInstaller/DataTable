-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/idiomchain/view/IdiomChainHomeView.lua

module("logic.extensions.idiomchain.view.IdiomChainHomeView", package.seeall)

local IdiomChainHomeView = class("IdiomChainHomeView", ViewComponent)

function IdiomChainHomeView:buildUI()
	IdiomChainHomeView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtOpenTime = self:getTxt("openTime/txt")
	self._effFenwei = self:getGo("effFenwei")
	self._btnStart = self:getGo("btnStart/btn")
	self._redPointBtnStart = self:getGo("btnStart/btn/redPoint")
	self._txtDescStart = self:getTxt("btnStart/desc/txt")
	self._strTxtDescStart = self._txtDescStart.text
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

function IdiomChainHomeView:bindEvents()
	IdiomChainHomeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnStart, self._onClickBtnStart, self)
end

function IdiomChainHomeView:unbindEvents()
	IdiomChainHomeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnStart)
end

function IdiomChainHomeView:onEnter()
	IdiomChainHomeView.super.onEnter(self)

	self._activityId = IdiomChainController.instance:getActivityId()

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._actData = IdiomChainConfig.instance:getActData(self._activityId)
	self._subMo = IdiomChainController.instance:getSubMo(self._activityId)

	self.addGEvent(self, GlobalNotify.HandlePM_IdiomChainInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_IdiomChainGainPrizeRes, self._onUpdate, self)
	self:_onSetUI()
	self:_onUpdate()
	IdiomChainController.instance:sendPM_IdiomChainInfoReq(self._activityId)
end

function IdiomChainHomeView:onExit()
	IdiomChainHomeView.super.onExit(self)
	self:_onClearPrizeCol()
end

function IdiomChainHomeView:_onSetUI()
	local activityType = ActivityDefineController.instance:getActTypeByActId(self._activityId)

	self._txtOpenTime.text = GameUtil.getActTimeDesc(activityType, self._activityId)

	local effPath = "20251219/chengyujielong/fx_ui_chengyu_fenwei.prefab"

	self:playViewEffectUniGo(effPath, self._effFenwei, nil, true, nil, nil)
end

function IdiomChainHomeView:_onUpdate()
	local maxTimes = self._subMo:getMaxDailyTimes()
	local leftTimes = self._subMo:getLeftDailyTimes()

	self._txtDescStart.text = string.format(self._strTxtDescStart, leftTimes, maxTimes)

	GameUtil.SetActive(self._redPointBtnStart, leftTimes > 0)
	self:_onUpdatePrizeCol()
end

function IdiomChainHomeView:_onUpdatePrizeCol()
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

function IdiomChainHomeView:_onClearPrizeCol()
	self._prizeScrollerList:dispose()
	MaterialMgr.clearIcon(self._prizeCol_total_icon)
end

function IdiomChainHomeView:_getProgressDataList()
	return IdiomChainConfig.instance:getPrizeDatas(self._activityId) or {}
end

function IdiomChainHomeView:_getSliderComp()
	return self._sliderComp
end

function IdiomChainHomeView:_getScrollRect()
	return self._prizeScrollerview:GetComponent(ComponentType.ScrollRect)
end

function IdiomChainHomeView:_getCurProgress()
	return self._subMo:getScore()
end

function IdiomChainHomeView:_getProgressByData(data)
	return data.needScore
end

function IdiomChainHomeView:_getPrizeIdByData(data)
	return data.prizeId
end

function IdiomChainHomeView:_getPrizeStrByData(data)
	return data.prize
end

function IdiomChainHomeView:_isHasGainPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return self._subMo:isHasGainPrize(prizeId)
end

function IdiomChainHomeView:_isEnoughGetPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return self._subMo:isEnoughGetPrize(prizeId)
end

function IdiomChainHomeView:_isCanGetPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return self._subMo:isCanGetPrize(prizeId)
end

function IdiomChainHomeView:_updatePrizeCell(view, cell, data, tag)
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

function IdiomChainHomeView:_clearPrizeCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local btnGet = goutil.findChild(mainGo, "btnGet")
	local effectRoot = goutil.findChild(mainGo, "effectRoot")

	MaterialMgr.resetAll(item)
	GameUtil.rmClickHandler(btnGet)
	self:stopViewEffectUniGo(effectRoot)
end

function IdiomChainHomeView:_onClickPrizeGet(data)
	if self:_isHasGainPrize(data) then
		FloatWordMgr.instance:show("已领取")

		return
	end

	if not self:_isEnoughGetPrize(data) then
		FloatWordMgr.instance:show("未满足")

		return
	end

	local prizeId = self:_getPrizeIdByData(data)

	IdiomChainController.instance:sendPM_IdiomChainGainPrizeReq(self._activityId, prizeId)
end

function IdiomChainHomeView:_onClickBtnStart()
	UIStateManager.instance:push(ViewName.IdiomChainStageView, self._activityId)
end

function IdiomChainHomeView:_onClickBtnTip()
	local key = self._actData.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

return IdiomChainHomeView
