-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dumplingfeast/view/DumplingFeastMainView.lua

module("logic.extensions.dumplingfeast.view.DumplingFeastMainView", package.seeall)

local DumplingFeastMainView = class("DumplingFeastMainView", ViewComponent)

function DumplingFeastMainView:buildUI()
	DumplingFeastMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtTitle = self:getTxt("leftTop/txtTitle")
	self._txtOpenTime = self:getTxt("openTime/txt")
	self._btnFeed = self:getGo("btnFeed")
	self._redBtnFeed = self:getGo("btnFeed/redPoint")
	self._btnShop = self:getGo("btnShop")
	self._btnBoss = self:getGo("btnBoss")
	self._redBtnBoss = self:getGo("btnBoss/redPoint")
	self._btnMake = self:getGo("btnMake")
	self._prizeCol = self:getGo("prizeCol")
	self._prizeScrollerview = self:getGo("prizeCol/scrView")
	self._prizeScrollercell = self:getGo("prizeCol/scrCell")
	self._progressBar = self:getGo("prizeCol/scrView/Viewport/Content/progressBar")
	self._sliderComp = self:getSlider("prizeCol/scrView/Viewport/Content/progressBar")
	self._prizeCol_total = self:getGo("prizeCol/total")
	self._prizeCol_total_txtNum = self:getTxt("prizeCol/total/txtNum")
	self._prizeCol_total_icon = self:getGo("prizeCol/total/icon")
	self._prizeScrollerList = ScrollerList.create(self._prizeScrollerview, self._prizeScrollercell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))
end

function DumplingFeastMainView:bindEvents()
	DumplingFeastMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickBtnShop, self)
	GameUtil.addClickHandler(self._btnFeed, self._onClickBtnFeed, self)
	GameUtil.addClickHandler(self._btnBoss, self._onClickBtnBoss, self)
	GameUtil.addClickHandler(self._btnMake, self._onClickBtnMake, self)
end

function DumplingFeastMainView:unbindEvents()
	DumplingFeastMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnFeed)
	GameUtil.rmClickHandler(self._btnBoss)
	GameUtil.rmClickHandler(self._btnMake)
end

function DumplingFeastMainView:onEnter()
	DumplingFeastMainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = DumplingFeastController.instance:getActivityId()
	end

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._subMo = DumplingFeastController.instance:getSubMo(self._activityId)
	self._actData = DumplingFeastConfig.instance:getActivityData(self._activityId)

	RedPointController.instance:regRedPoint(self._redBtnFeed, RedPointModel.ID_DUMMPLINGFEAST_INTIMACY_PRIZE)
	RedPointController.instance:regRedPoint(self._redBtnBoss, RedPointModel.ID_DUMMPLINGFEAST_BOSS_DAMAGE_PRIZE)
	self:_onUpdate()
	self.addGEvent(self, GlobalNotify.HandlePM_DumplingFeastInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_DumplingFeastGainIntimacyProgressRes, self._onUpdate, self)
	DumplingFeastController.instance:sendPM_DumplingFeastInfoReq(self._activityId)
end

function DumplingFeastMainView:onExit()
	DumplingFeastMainView.super.onExit(self)
	self:_onClearPrizeCol()
	RedPointController.instance:unregRedPoint(self._redBtnFeed)
	RedPointController.instance:unregRedPoint(self._redBtnBoss)
end

function DumplingFeastMainView:_onUpdate()
	self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)

	self:_onUpdatePrizeCol()
end

function DumplingFeastMainView:_onUpdatePrizeCol()
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

function DumplingFeastMainView:_onClearPrizeCol()
	self._prizeScrollerList:dispose()
	MaterialMgr.clearIcon(self._prizeCol_total_icon)
end

function DumplingFeastMainView:_getProgressDataList()
	return DumplingFeastConfig.instance:getIntimacyProgressDatas(self._activityId) or {}
end

function DumplingFeastMainView:_getSliderComp()
	return self._sliderComp
end

function DumplingFeastMainView:_getScrollRect()
	return self._prizeScrollerview:GetComponent(ComponentType.ScrollRect)
end

function DumplingFeastMainView:_getCurProgress()
	return self._subMo:getTotalIntimacy()
end

function DumplingFeastMainView:_getProgressByData(data)
	return data.intimacy
end

function DumplingFeastMainView:_getPrizeIdByData(data)
	return data.progressId
end

function DumplingFeastMainView:_getPrizeStrByData(data)
	return data.prize
end

function DumplingFeastMainView:_isHasGainPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return self._subMo:isHasGainPrizeInIntimacy(prizeId)
end

function DumplingFeastMainView:_isEnoughGetPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return self._subMo:isEnoughGetPrizeInIntimacy(prizeId)
end

function DumplingFeastMainView:_isCanGetPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return self._subMo:isCanGetPrizeInIntimacy(prizeId)
end

function DumplingFeastMainView:_updatePrizeCell(view, cell, data, tag)
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

function DumplingFeastMainView:_clearPrizeCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local btnGet = goutil.findChild(mainGo, "btnGet")
	local effectRoot = goutil.findChild(mainGo, "effectRoot")

	MaterialMgr.resetAll(item)
	GameUtil.rmClickHandler(btnGet)
	self:stopViewEffectUniGo(effectRoot)
end

function DumplingFeastMainView:_onClickPrizeGet(data)
	if self:_isHasGainPrize(data) then
		FloatWordMgr.instance:show("已领取")

		return
	end

	if not self:_isEnoughGetPrize(data) then
		FloatWordMgr.instance:show("未满足")

		return
	end

	local prizeId = self:_getPrizeIdByData(data)

	DumplingFeastController.instance:sendPM_DumplingFeastGainIntimacyProgressReq(self._activityId)
end

function DumplingFeastMainView:_onClickBtnTip()
	local data = DumplingFeastConfig.instance:getActivityData(self._activityId)
	local key = data and data.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function DumplingFeastMainView:_onClickBtnShop()
	local key = string.format("func#191#562#%s", self._activityId)

	GotoMgr.gotoByString(key)
end

function DumplingFeastMainView:_onClickBtnFeed()
	UIStateManager.instance:push(ViewName.DumplingFeastFeedView, self._activityId)
end

function DumplingFeastMainView:_onClickBtnBoss()
	UIStateManager.instance:push(ViewName.DumplingFeastBossView, self._activityId)
end

function DumplingFeastMainView:_onClickBtnMake()
	UIStateManager.instance:push(ViewName.DumplingFeastKitchenView, self._activityId)
end

return DumplingFeastMainView
