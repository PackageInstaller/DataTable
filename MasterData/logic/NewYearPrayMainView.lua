-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newyearpray/view/NewYearPrayMainView.lua

module("logic.extensions.newyearpray.view.NewYearPrayMainView", package.seeall)

local NewYearPrayMainView = class("NewYearPrayMainView", ViewComponent)

function NewYearPrayMainView:ctor()
	NewYearPrayMainView.super.ctor(self)
end

function NewYearPrayMainView:buildUI()
	NewYearPrayMainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
	self._btnEnter = goutil.findChild(self.mainGO, "btnEnter")
	self._btnEnter_btn = goutil.findChild(self.mainGO, "btnEnter/btn")
	self._btnEnter_desc_txt = goutil.findChildTextComponent(self.mainGO, "btnEnter/desc/txt")
	self._prizeCol = goutil.findChild(self.mainGO, "prizeCol")
	self._prizeScrollerview = goutil.findChild(self.mainGO, "prizeCol/prizeScrollerview")
	self._prizeScrollercell = goutil.findChild(self.mainGO, "prizeCol/prizeScrollercell")
	self._progressBar = goutil.findChild(self.mainGO, "prizeCol/prizeScrollerview/Viewport/Content/progressBar")
	self._sliderComp = self:getSlider("prizeCol/prizeScrollerview/Viewport/Content/progressBar")
	self._prizeCol_total = goutil.findChild(self.mainGO, "prizeCol/total")
	self._prizeCol_total_txtNum = goutil.findChildTextComponent(self.mainGO, "prizeCol/total/txtNum")
	self._prizeCol_total_icon = goutil.findChild(self.mainGO, "prizeCol/total/icon")
	self._prizeScrollerList = ScrollerList.create(self._prizeScrollerview, self._prizeScrollercell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))
end

function NewYearPrayMainView:bindEvents()
	NewYearPrayMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnEnter_btn, self._onClickBtnEnter, self)
end

function NewYearPrayMainView:unbindEvents()
	NewYearPrayMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnEnter_btn)
end

function NewYearPrayMainView:onEnter()
	NewYearPrayMainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(self._activityId)

	if self._activityId <= 0 then
		self._activityId = NewYearPrayController.instance:getActivityId()
	end

	self._activityType = NewYearPrayController.instance:getActivityType()

	local isInTime = NewYearPrayController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self._actData = NewYearPrayConfig.instance:getNypActData(self._activityId)

	self:_onSetUI()
	self.addGEvent(self, GlobalNotify.handlePM_NewYearPrayGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.handlePM_NewYearPrayGainProgressPrizeRes, self._onUpdate, self)
	NewYearPrayController.instance:sendPM_NewYearPrayGetInfoReq(self._activityId)
end

function NewYearPrayMainView:onExit()
	NewYearPrayMainView.super.onExit(self)
	MaterialMgr.clearIcon(self._prizeCol_total_icon)
	self:_onClear()
end

function NewYearPrayMainView:_onSetUI()
	if self._txtOpenTime then
		self._txtOpenTime.text = GameUtil.getActTimeDesc(self._activityType, self._activityId)
	end

	local matStr = self._actData.progressItem

	if not string.nilorempty(matStr) then
		local matType, matId, matNum = MaterialMgr.getMatParams(matStr)

		MaterialMgr.setIcon(self._prizeCol_total_icon, matType, matId, nil, nil)
		GameUtil.SetActive(self._prizeCol_total_icon, true)
	else
		MaterialMgr.clearIcon(self._prizeCol_total_icon)
		GameUtil.SetActive(self._prizeCol_total_icon, false)
	end
end

function NewYearPrayMainView:_onUpdate()
	local curTimes = NewYearPrayController.instance:getLeftActCount(self._activityId)
	local maxTimes = self._actData.dailyActCount

	self._btnEnter_desc_txt.text = string.format("今日可祈愿：%s / %s", curTimes, maxTimes)

	self:_onUpdatePrizeCol()
end

function NewYearPrayMainView:_onClear()
	self:_onClearPrizeCol()
end

function NewYearPrayMainView:_onUpdatePrizeCol()
	local dataList = self:_getProgressDataList()
	local curProgress = self:_getCurProgress()
	local sliderComp = self:_getSliderComp()
	local scoreList = {}

	for _, data in ipairs(dataList) do
		table.insert(scoreList, self:_getProgressByData(data))
	end

	local index = 0

	for idx, data in ipairs(dataList) do
		local prizeId = self:_getPrizeIdByData(data)

		if self:_isHasGainPrize(prizeId) then
			index = idx

			break
		end
	end

	self._prizeScrollerList:reloadData(dataList)
	self._prizeScrollerList:updateUnderSlider(sliderComp, curProgress, scoreList)
	self._prizeScrollerList:MoveCellToCenter(index == -1 and 0 or index)

	self._prizeCol_total_txtNum.text = curProgress
end

function NewYearPrayMainView:_onClearPrizeCol()
	self._prizeScrollerList:dispose()
end

function NewYearPrayMainView:_getProgressDataList()
	return NewYearPrayConfig.instance:getNypProgressCfg(self._activityId)
end

function NewYearPrayMainView:_getSliderComp()
	return self._sliderComp
end

function NewYearPrayMainView:_getScrollRect()
	return self._prizeScrollerview:GetComponent(ComponentType.ScrollRect)
end

function NewYearPrayMainView:_getCurProgress()
	return NewYearPrayController.instance:getProgress(self._activityId)
end

function NewYearPrayMainView:_getProgressByData(data)
	return data.progress
end

function NewYearPrayMainView:_getPrizeIdByData(data)
	return data.dataBitId
end

function NewYearPrayMainView:_getPrizeStrByData(data)
	return data.prize
end

function NewYearPrayMainView:_isHasGainPrize(prizeId)
	return NewYearPrayController.instance:isHasGainPrizeOfProgress(self._activityId, prizeId)
end

function NewYearPrayMainView:_isCanGetPrize(prizeId)
	return NewYearPrayController.instance:isCanGetPrizeOfProgress(self._activityId, prizeId)
end

function NewYearPrayMainView:_updatePrizeCell(view, cell, data, tag)
	local prizeId = self:_getPrizeIdByData(data)
	local isHasGain = self:_isHasGainPrize(prizeId)
	local isCanGet = self:_isCanGetPrize(prizeId)
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

	self._prizeEffPool = self._prizeEffPool or {}

	UIEffectManager.instance:stopEffect(self._prizeEffPool[mainGo])

	if isCanGet == true then
		local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

		local function func(_, eff)
			eff:setScrollRectClipping(scrollRect)
			eff:setParent(effectRoot.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)
		end

		self._prizeEffPool[mainGo] = UIEffectManager.instance:playEffect(self, effPath, effectRoot, 0, 0, true, false, nil, func, nil)
	end

	GameUtil.addClickHandler(btnGet, GameUtil.handler(self._onClickPrizeGet, self, prizeId))
end

function NewYearPrayMainView:_clearPrizeCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local btnGet = goutil.findChild(mainGo, "btnGet")

	MaterialMgr.resetAll(item)
	GameUtil.rmClickHandler(btnGet)

	if self._prizeEffPool then
		UIEffectManager.instance:stopEffect(self._prizeEffPool[mainGo])
	end
end

function NewYearPrayMainView:_onClickPrizeGet(prizeId)
	local result, tips = NewYearPrayController.instance:getTryGetPrizeOfProgressResultAndTips(self._activityId, prizeId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	NewYearPrayController.instance:sendPM_NewYearPrayGainProgressPrizeReq(self._activityId, prizeId)
end

function NewYearPrayMainView:_onClickBtnTip()
	local key = NewYearPrayConfig.instance:getNypCommonValue(self._activityId, "ruleKeyMain")

	TipsFacade.instance:openRulesView(key)
end

function NewYearPrayMainView:_onClickBtnEnter()
	local result, tips = NewYearPrayController.instance:getTrEnterPrayResultAndTips(self._activityId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	UIStateManager.instance:push(ViewName.NewYearPraySceneView, self._activityId)
end

return NewYearPrayMainView
