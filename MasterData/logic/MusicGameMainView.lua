-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/musicgame/view/MusicGameMainView.lua

module("logic.extensions.musicgame.view.MusicGameMainView", package.seeall)

local MusicGameMainView = class("MusicGameMainView", ViewComponent)

function MusicGameMainView:ctor()
	MusicGameMainView.super.ctor(self)
end

function MusicGameMainView:buildUI()
	MusicGameMainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
	self._btnStart = goutil.findChild(self.mainGO, "prizeCol/btnStart/btn")
	self._redBtnStart = goutil.findChild(self.mainGO, "prizeCol/btnStart/btn/redPoint")
	self._txtDescBtnStart = goutil.findChildTextComponent(self.mainGO, "prizeCol/btnStart/desc/txt")
	self._prizeCol = goutil.findChild(self.mainGO, "prizeCol")
	self._prizeScrollerview = goutil.findChild(self.mainGO, "prizeCol/scrView")
	self._prizeScrollercell = goutil.findChild(self.mainGO, "prizeCol/scrCell")
	self._progressBar = goutil.findChild(self.mainGO, "prizeCol/scrView/Viewport/Content/progressBar")
	self._sliderComp = self:getSlider("prizeCol/scrView/Viewport/Content/progressBar")
	self._prizeCol_total = goutil.findChild(self.mainGO, "prizeCol/total")
	self._prizeCol_total_txtNum = goutil.findChildTextComponent(self.mainGO, "prizeCol/total/txtNum")
	self._prizeCol_total_icon = goutil.findChild(self.mainGO, "prizeCol/total/icon")
	self._prizeScrollerList = ScrollerList.create(self._prizeScrollerview, self._prizeScrollercell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))
	self._tipsRoot = self:getGo("tipsRoot")
end

function MusicGameMainView:bindEvents()
	MusicGameMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnStart, self._onClickBtnStart, self)
end

function MusicGameMainView:unbindEvents()
	MusicGameMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnStart)
end

function MusicGameMainView:onEnter()
	MusicGameMainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = MusicGameController.instance:getActivityId()
	end

	self._activityType = MusicGameController.instance:getActivityType()

	local isInTime = MusicGameController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._actData = MusicGameConfig.instance:getActData(self._activityId)
	self._musicGameMo = MusicGameController.instance:getMusicGameMo(self._activityId)

	if self._txtOpenTime then
		self._txtOpenTime.text = GameUtil.getActTimeDesc(self._activityType, self._activityId)
	end

	self.addGEvent(self, GlobalNotify.HandlePM_MusicGameInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_MusicGameGainPrizeRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_MusicGameEndRes, self._handlePM_MusicGameEndRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_MusicGameSweepRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.AnnuityPrivilegeTipsViewClose, self._handleAnnuityPrivilegeTipsViewClose, self)
	MusicGameController.instance:sendPM_MusicGameInfoReq(self._activityId)
	AnnuityPrivilegeController.instance:addAnnuityPrivilegeSweepTipsView(self._tipsRoot, self._viewPresentor, self._activityId)

	local key = string.format("MusicGameRUle_%s", self._activityId)

	GameUtil.doCallbackWhenFirst(key, function()
		self:_onClickBtnTip()
	end, nil)
end

function MusicGameMainView:onExit()
	MusicGameMainView.super.onExit(self)
	self:_onClearPrizeCol()
end

function MusicGameMainView:_handlePM_MusicGameEndRes()
	MusicGameController.instance:sendPM_MusicGameInfoReq(self._activityId)
end

function MusicGameMainView:_handleAnnuityPrivilegeTipsViewClose()
	AnnuityPrivilegeController.instance:addAnnuityPrivilegeSweepTipsView(self._tipsRoot, self._viewPresentor, self._activityId)
end

function MusicGameMainView:_onUpdate()
	self:_onUpdatePrizeCol()

	local left = self._musicGameMo:getLeftTimes()

	self._txtDescBtnStart.text = string.format("今日剩余：%s次", left)

	GameUtil.SetActive(self._redBtnStart, left > 0)
end

function MusicGameMainView:_onUpdatePrizeCol()
	local dataList = self:_getProgressDataList()
	local curProgress = self:_getCurProgress()
	local sliderComp = self:_getSliderComp()
	local scoreList = {}

	for _, data in ipairs(dataList) do
		table.insert(scoreList, self:_getProgressByData(data))
	end

	local index = 0

	for idx, data in ipairs(dataList) do
		if self:_isHasGainPrize(data) then
			index = idx

			break
		end
	end

	self._prizeScrollerList:reloadData(dataList)
	self._prizeScrollerList:updateUnderSlider(sliderComp, curProgress, scoreList)
	self._prizeScrollerList:MoveCellToCenter(index == -1 and 0 or index)

	self._prizeCol_total_txtNum.text = curProgress

	local matStr = self._actData.itemId

	if not string.nilorempty(matStr) then
		local matType, matId, matNum = MaterialMgr.getMatParams(matStr)

		MaterialMgr.setIcon(self._prizeCol_total_icon, matType, matId, nil, nil)
	else
		MaterialMgr.clearIcon(self._prizeCol_total_icon)
	end
end

function MusicGameMainView:_onClearPrizeCol()
	self._prizeScrollerList:dispose()
	MaterialMgr.clearIcon(self._prizeCol_total_icon)
end

function MusicGameMainView:_getProgressDataList()
	return MusicGameConfig.instance:getPrizeCfg(self._activityId)
end

function MusicGameMainView:_getSliderComp()
	return self._sliderComp
end

function MusicGameMainView:_getScrollRect()
	return self._prizeScrollerview:GetComponent(ComponentType.ScrollRect)
end

function MusicGameMainView:_getCurProgress()
	return self._musicGameMo:getScore()
end

function MusicGameMainView:_getProgressByData(data)
	return data.progress
end

function MusicGameMainView:_getPrizeIdByData(data)
	return data.prizeId
end

function MusicGameMainView:_getPrizeStrByData(data)
	return data.prize
end

function MusicGameMainView:_isHasGainPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return self._musicGameMo:isHasGainPrize(prizeId)
end

function MusicGameMainView:_isEnoughGetPrize(data)
	local need = self:_getProgressByData(data)
	local cur = self:_getCurProgress()

	return need <= cur
end

function MusicGameMainView:_isCanGetPrize(data)
	return not self:_isHasGainPrize(data) and self:_isEnoughGetPrize(data)
end

function MusicGameMainView:_updatePrizeCell(view, cell, data, tag)
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

	GameUtil.addClickHandler(btnGet, GameUtil.handler(self._onClickPrizeGet, self, data))
end

function MusicGameMainView:_clearPrizeCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local btnGet = goutil.findChild(mainGo, "btnGet")

	MaterialMgr.resetAll(item)
	GameUtil.rmClickHandler(btnGet)

	if self._prizeEffPool then
		UIEffectManager.instance:stopEffect(self._prizeEffPool[mainGo])
	end
end

function MusicGameMainView:_onClickPrizeGet(data)
	if self:_isHasGainPrize(data) then
		FloatWordMgr.instance:show("已领取")

		return
	end

	if not self:_isEnoughGetPrize(data) then
		FloatWordMgr.instance:show("未满足")

		return
	end

	local prizeId = self:_getPrizeIdByData(data)

	MusicGameController.instance:sendPM_MusicGameGainPrizeReq(self._activityId, prizeId)
end

function MusicGameMainView:_onClickBtnTip()
	local list = self._actData.imageRules

	if list then
		TipsFacade.instance:openImageRuleView(list, "提示")

		return
	end

	local key = self._actData.ruleKey

	if not string.nilorempty(key) then
		TipsFacade.instance:openRulesView(key)

		return
	end
end

function MusicGameMainView:_onClickBtnStart()
	local left = self._musicGameMo:getLeftTimes()

	if left <= 0 then
		FloatWordMgr.instance:show("次数不足")

		return
	end

	UIStateManager.instance:push(ViewName.MusicGameStageView, self._activityId)
end

return MusicGameMainView
