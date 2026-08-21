-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/controlaction/view/ControlActionView.lua

module("logic.extensions.controlaction.view.ControlActionView", package.seeall)

local M = class("ControlActionView", ViewComponent)
local WeekPassImgAlpha = "#FFFFFF4C"
local kLabelKey = WordEnum.NetRAM

function M:ctor(...)
	M.super.ctor(self, ...)

	self._curPageIndex = 1
	self._isShutDown = false
	self._currAirTimeState = 0
end

function M:buildUI()
	self._imgNormalGo = self:getGo("regulatory_action_desk_view_957207292")
	self._imgSecretGo = self:getGo("regulatory_action_desk_view_-1473605346")
	self._btnListGo = self:getGo("regulatory_action_desk_view_1887434134")
	self._lastTimeGo = self:getGo("regulatory_action_desk_view_-392896372")
	self._txtLastTime = self:getUIComponent("regulatory_action_desk_view_453353367", UIComponentType.TextMeshProUGUI)
	self._txtTimeCenter = self:getText("regulatory_action_desk_view_-977672953")
	self._txtTime = self:getText("regulatory_action_desk_view_907851290")
	self._txtTimeFlag = self:getText("regulatory_action_desk_view_-281125814")
	self._btnStart = self:getBtn("regulatory_action_desk_view_988503425")
	self._btnClose = self:getBtn("regulatory_action_desk_view_518980233")
	self._btnMonitor = self:getBtn("regulatory_action_desk_view_968915611")
	self._btnForum = self:getBtn("regulatory_action_desk_view_-514248453")
	self._btnManual = self:getBtn("regulatory_action_desk_view_1872824758")
	self._btnMonitorLF = self:getBtn("regulatory_action_desk_view_1462016613")
	self._btnForumLF = self:getBtn("regulatory_action_desk_view_380553776")
	self._btnManualLF = self:getBtn("regulatory_action_desk_view_1841429137")
	self._monitorLFNormal = goutil.findChild(self._btnMonitorLF, "normal")
	self._monitorLFLock = goutil.findChild(self._btnMonitorLF, "lock")
	self._selectFlags = {
		self:getGo("regulatory_action_desk_view_1086235496"),
		self:getGo("regulatory_action_desk_view_-341010358"),
		self:getGo("regulatory_action_desk_view_1933557606")
	}
	self._bottomBtnGos = {
		self._btnMonitor.gameObject,
		self._btnForum.gameObject,
		self._btnManual.gameObject
	}
	self._bottomSelectFlags = {
		self:getGo("regulatory_action_desk_view_-453964666"),
		self:getGo("regulatory_action_desk_view_885724126"),
		self:getGo("regulatory_action_desk_view_265393308")
	}
	self._weekTimesImgs = {
		self:getImage("regulatory_action_desk_view_news_1096633277"),
		self:getImage("regulatory_action_desk_view_news_-1110608281"),
		self:getImage("regulatory_action_desk_view_news_1396774862"),
		self:getImage("regulatory_action_desk_view_news_-1182457724"),
		self:getImage("regulatory_action_desk_view_news_531404989")
	}
	self._textWeekTimes = self:getUIComponent("regulatory_action_desk_view_news_1614783766", UIComponentType.TextMeshProUGUI)
	self._textWeekLabel = self:getUIComponent("regulatory_action_desk_view_news_-137692777", UIComponentType.TextMeshProUGUI)
	self._btnWeekLabel = self:getBtn("regulatory_action_desk_view_news_581319569")

	goutil.setActive(self._txtTimeCenter.gameObject, false)

	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
end

function M:bindEvents()
	self._guiAnimation:AddListener(self._handleViewAniDoneEvent, self)
	self._btnStart:AddClickListener(self._onClickBtnStart, self)
	self._btnClose:AddClickListener(self._onClickBtnClose, self)
	self._btnMonitor:AddClickListener(self._onClickBtnMonitor, self)
	self._btnForum:AddClickListener(self._onClickBtnForum, self)
	self._btnManual:AddClickListener(self._onClickBtnManual, self)
	self._btnMonitorLF:AddClickListener(self._onClickBtnMonitor, self)
	self._btnForumLF:AddClickListener(self._onClickBtnForum, self)
	self._btnManualLF:AddClickListener(self._onClickBtnManual, self)
	self._btnWeekLabel:AddClickListener(self._onClickBtnWeekLabel, self)
	GlobalDispatcher:addEventListener(EventType.CONTROLACTION_CLOSE, self._handleViewClose, self)
	GlobalDispatcher:addEventListener(EventType.PASS_GUIDE_BY_CLICK, self._setGuideEventState, self)
	GlobalDispatcher:addEventListener(EventType.CONTROLACTION_MONITORDATA_FINISH, self._onMonitorDataUpdate, self)
	GlobalDispatcher:addEventListener(EventType.ON_IMPORTANT_INSTANT_PUSH, self._handleNewWeek, self)
end

function M:unbindEvents()
	self._guiAnimation:RemoveListener()
	self._btnStart:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnMonitor:RemoveClickListener()
	self._btnForum:RemoveClickListener()
	self._btnManual:RemoveClickListener()
	self._btnMonitorLF:RemoveClickListener()
	self._btnForumLF:RemoveClickListener()
	self._btnManualLF:RemoveClickListener()
	self._btnWeekLabel:RemoveClickListener()
	GlobalDispatcher:removeEventListener(EventType.CONTROLACTION_CLOSE, self._handleViewClose, self)
	GlobalDispatcher:removeEventListener(EventType.PASS_GUIDE_BY_CLICK, self._setGuideEventState, self)
	GlobalDispatcher:removeEventListener(EventType.CONTROLACTION_MONITORDATA_FINISH, self._onMonitorDataUpdate, self)
	GlobalDispatcher:removeEventListener(EventType.ON_IMPORTANT_INSTANT_PUSH, self._handleNewWeek, self)
end

function M:onEnter()
	ControlActionAgent.instance:sendGetControlActionsRequest()

	self._isShutDown = false

	local isIn = AirtightRoomController.instance:getIsInAirtightTime()

	goutil.setActive(self._imgSecretGo, isIn and not ControlActionUtil.isInGuide())
	goutil.setActive(self._imgNormalGo, not isIn or ControlActionUtil.isInGuide())
	self:_timeCounter()
	settimer(1, self._timeCounter, self, true)
	self:_setBottomDate()
	self:_setWeekTimesInfo()
end

function M:onEnterFinished()
	ViewBlockMgr.instance:blockClick(false, ViewBlockKey.ControlAction)

	local isIn = AirtightRoomController.instance:getIsInAirtightTime()

	if isIn and not ControlActionUtil.isInGuide() or ControlActionUtil.getGuideBattle() then
		self:_onClickBtnMonitor()
	else
		self:_onClickBtnForum()
	end

	ControlActionModel.instance:setDailyLogin()
end

function M:onExit()
	ViewMgr.instance:close(ViewName.ControlActionMonitor)
	ViewMgr.instance:close(ViewName.control_action_manual)
	ViewMgr.instance:close(ViewName.ControlActionForum)
	removetimer(self._timeCounter, self)

	for i = 1, #self._bottomBtnGos do
		goutil.setActive(self._bottomBtnGos[i], false)
	end

	goutil.setActive(self._btnClose.gameObject, false)

	self._currAirTimeState = 0

	goutil.setActive(self._lastTimeGo, false)
end

function M:playCloseAnimation(windowCloseReasonType, isStop)
	if false then
		if self._isShutDown then
			self._guiAnimation:PlayAniByName("close2")
		else
			self._guiAnimation:PlayAniByName("close1")
		end

		if isStop then
			self._guiAnimation:StopTimelineAni()
		end
	else
		self._viewPresentor:_onCloseAnimationDone()
	end
end

function M:_convertAirTimeAnim()
	if ControlActionUtil.isInGuideFirst() then
		self._guiAnimation:PlayAniByName("cutover_blue")

		return
	else
		self._guiAnimation:PlayAniByName("cutover_red")

		return
	end

	if self._currAirTimeState then
		self._guiAnimation:PlayAniByName("cutover_red")
	else
		self._guiAnimation:PlayAniByName("cutover_blue")
	end
end

function M:destroyUI()
	removetimer(self._timeCounter, self)
end

function M:_formatNumber(num)
	if num < 10 then
		return string.format("0%s", num)
	end

	return num
end

function M:_setWeekTimesInfo()
	self._textWeekLabel.text = lang("control_action_week_times_label")

	local passTimes = ControlActionModel.instance:getWeekPassTimes()
	local weekTotalTimes = ControlActionConfig.instance:getConstValue(ControlActionEnum.WeekLimitTime)
	local weekLeftTimes = ControlActionModel.instance:getWeekLeftTimes()

	if weekLeftTimes <= 0 then
		self._textWeekTimes.text = langF("control_action_week_times_zero", 0, weekTotalTimes)
	else
		self._textWeekTimes.text = langF("control_action_week_times", weekLeftTimes, weekTotalTimes)
	end

	for times = 1, #self._weekTimesImgs do
		local img = self._weekTimesImgs[times]

		goutil.setActive(img.gameObject, times <= weekTotalTimes)

		img.color = parsecolor(times <= passTimes and WeekPassImgAlpha or "#FFFFFFFF")
	end
end

function M:_setBottomDate()
	local date = TimeUtil.instance:formatUnixTime2Date(AirtightRoomModel.instance:getServerTime())

	self._txtTime.text = string.format("%s:%s", self:_formatNumber(date.hour), self:_formatNumber(date.minute))

	if date.hour < 12 then
		self._txtTimeFlag.text = "AM"
	else
		self._txtTimeFlag.text = "PM"
	end
end

function M:_timeCounter()
	local isIn, inTimeByItem, hour, minute, second, airtightEndTS = AirtightRoomController.instance:getAirtightTimeInfo()

	if ControlActionUtil.isInGuideFirst() then
		self._txtTimeCenter.text = string.format("%s:%s:%s", 23, 59, 59)
	elseif ControlActionUtil.isInGuideSecond() then
		self._txtTimeCenter.text = string.format("%s:%s:%s", 24, "00", "00")

		removetimer(self._timeCounter, self)
		self:_convertAirTimeAnim()
	else
		self._txtTimeCenter.text = string.format("%s:%s:%s", self:_formatNumber(hour), self:_formatNumber(minute), self:_formatNumber(second))

		local inSpTime, inSpNormal, inSpAirtight = AirtightRoomUtil.getSpTimeInfo()

		goutil.setActive(self._lastTimeGo, not isIn and not inSpTime)

		local nowTime = AirtightRoomModel.instance:getServerTime()
		local nextTimeStamp = AirtightRoomController.instance:getNextAirtightBeginTimeStamp()
		local timeStr = TimeUtil.instance:numberToTime(nextTimeStamp - nowTime, "h")
		local langStr = lang("tip_controlaction_monitor_time1")

		if timeStr == "00" then
			timeStr = TimeUtil.instance:numberToTime(nextTimeStamp - nowTime, "m")
			langStr = lang("tip_controlaction_monitor_time3")
		end

		self._txtLastTime.text = string.format(langStr, timeStr)

		goutil.setActive(self._monitorLFNormal, isIn)
		goutil.setActive(self._monitorLFLock, not isIn)
	end

	if second == 0 then
		self:_setBottomDate()
	end

	if not self._txtTimeCenter.gameObject.activeSelf then
		goutil.setActive(self._txtTimeCenter.gameObject, true)
	end

	if self._currAirTimeState == 0 then
		self._currAirTimeState = isIn
	end

	if self._currAirTimeState ~= isIn then
		self._currAirTimeState = isIn

		self:_convertAirTimeAnim()
	end
end

function M:_handleViewClose(e, viewIndex)
	goutil.setActive(self._bottomBtnGos[viewIndex], false)
end

function M:_onPageChanged()
	goutil.setActive(self._bottomBtnGos[self._curPageIndex], true)

	for i = 1, #self._selectFlags do
		goutil.setActive(self._selectFlags[i], i == self._curPageIndex)
	end

	for i = 1, #self._bottomSelectFlags do
		goutil.setActive(self._bottomSelectFlags[i], i == self._curPageIndex)
	end
end

function M:_onClickBtnStart()
	if self._btnClose.gameObject.activeSelf then
		goutil.setActive(self._btnClose.gameObject, false)
	else
		goutil.setActive(self._btnClose.gameObject, true)
	end
end

function M:_onClickBtnClose()
	self._isShutDown = true

	ControlActionModel.instance:setClickShutDown()
	ViewMgr.instance:close(ViewName.ControlActionMonitor)
	ViewMgr.instance:close(ViewName.ControlActionManual)
	ViewMgr.instance:close(ViewName.ControlActionForum)
	self:back()
end

function M:_onClickReturn()
	self:playCloseAnimation()
end

function M:_onClickBtnMonitor()
	self._curPageIndex = 1

	self:_onPageChanged()
	ViewMgr.instance:close(ViewName.ControlActionForum)
	ViewMgr.instance:close(ViewName.ControlActionManual)
	ViewMgr.instance:open(ViewName.ControlActionMonitor)
end

function M:_onClickBtnForum()
	self._curPageIndex = 2

	self:_onPageChanged()
	ViewMgr.instance:close(ViewName.ControlActionMonitor)
	ViewMgr.instance:close(ViewName.ControlActionManual)
	ViewMgr.instance:open(ViewName.ControlActionForum)
end

function M:_onClickBtnManual()
	self._curPageIndex = 3

	self:_onPageChanged()
	ViewMgr.instance:close(ViewName.ControlActionForum)
	ViewMgr.instance:close(ViewName.ControlActionMonitor)
	ViewMgr.instance:open(ViewName.ControlActionManual)
end

function M:_onClickBtnWeekLabel()
	ViewMgr.instance:open(ViewName.ControlActionLabelView, kLabelKey)
end

function M:_setGuideEventState(evt, pauseEvent)
	self:_onClickBtnClose()
end

function M:_onMonitorDataUpdate()
	removetimer(self._timeCounter, self)
	self:_timeCounter()
	settimer(1, self._timeCounter, self, true)
	self:_setWeekTimesInfo()
end

function M:_handleNewWeek(_, key)
	if key == UserExtension_pb.ImportantInstantKey.MONDAY_ZERO then
		ControlActionAgent.instance:sendGetControlActionsRequest()
	end
end

return M
