-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fiveyearrecap/view/FiveYearRecapHomeView.lua

module("logic.extensions.fiveyearrecap.view.FiveYearRecapHomeView", package.seeall)

local FiveYearRecapHomeView = class("FiveYearRecapHomeView", ViewComponent)

function FiveYearRecapHomeView:ctor()
	FiveYearRecapHomeView.super.ctor(self)
end

function FiveYearRecapHomeView:buildUI()
	FiveYearRecapHomeView.super.buildUI(self)

	self._btnShare = self:getGo("btnShare")
	self._btnOpen = self:getGo("btnOpen")
	self._redBtnOpen = self:getGo("btnOpen/red")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")

	local prizeScrView = self:getGo("prizeCol/scrView")
	local prizeScrCell = self:getGo("prizeCol/scrCell")

	self._prizeScrollerList = ScrollerList.create(prizeScrView, prizeScrCell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))
end

function FiveYearRecapHomeView:bindEvents()
	FiveYearRecapHomeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnShare, self._onClickShare, self)
	GameUtil.addClickHandler(self._btnOpen, self._onClickOpen, self)
end

function FiveYearRecapHomeView:unbindEvents()
	FiveYearRecapHomeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnShare)
	GameUtil.rmClickHandler(self._btnOpen)
end

function FiveYearRecapHomeView:onEnter()
	FiveYearRecapHomeView.super.onEnter(self)

	self._activityId = FiveYearRecapController.instance:getActivityId()
	self._subMo = FiveYearRecapController.instance:getSubMo(self._activityId)
	self._actData = FiveYearRecapConfig.instance:getActivityData(self._activityId)

	self.addGEvent(self, GlobalNotify.HandlePM_FiveYearRecapGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_FiveYearRecapShareRes, self._onUpdate, self)

	self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)

	RedPointController.instance:regRedPoint(self._redBtnOpen, RedPointModel.ID_FIVEYEARRECAP_PLAYER_FIRST_OPEN)
	self:_onUpdate()
end

function FiveYearRecapHomeView:onExit()
	FiveYearRecapHomeView.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._redBtnOpen)
	self._prizeScrollerList:dispose()
end

function FiveYearRecapHomeView:_onUpdate()
	self:_onUpdatePrizeCol()
end

function FiveYearRecapHomeView:_onUpdatePrizeCol()
	if self._actData then
		if not self._actData.sharePrize then
			local prize = ""
			local prizeList = string.split(prize, "#") or {}

			self._prizeScrollerList:reloadData(prizeList)
		end
	end
end

function FiveYearRecapHomeView:_updatePrizeCell(view, cell, prizeStr, tag)
	local isHasShared = self._subMo:isHasShared()
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local tagHasGain = goutil.findChild(mainGo, "tagHasGain")

	MaterialMgr.setCellByCfg(prizeStr, item)
	GameUtil.SetActive(tagHasGain, isHasShared)
end

function FiveYearRecapHomeView:_clearPrizeCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.resetAll(item)
end

function FiveYearRecapHomeView:_onClickShare()
	local isHasReported = FiveYearRecapController.instance:isHasReported(self._activityId)

	if not isHasReported then
		FloatWordMgr.instance:show("还未回顾完成，先去查看报告吧！")

		return
	end

	UIStateManager.instance:push(ViewName.FiveYearRecapReportSummaryView, self._activityId, true)
end

function FiveYearRecapHomeView:_onClickOpen()
	FiveYearRecapController.instance:setPlayerFirstOpenRedPoint(self._activityId)
	UIStateManager.instance:push(ViewName.FiveYearRecapReportView, self._activityId)
end

return FiveYearRecapHomeView
