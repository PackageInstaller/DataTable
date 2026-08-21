-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airtightroom/view/AirtightRoomTimeView.lua

module("logic.extensions.airtightroom.view.AirtightRoomTimeView", package.seeall)

local M = class("AirtightRoomTimeView", ViewComponent)
local kLightCode = 12

function M:buildUI()
	M.super.buildUI(self)

	self._canvasGroup = goutil.addComponentOnce(self.mainGO.gameObject, ComponentType.CanvasGroup)

	local rootGO = self:getGo("2&secret_time_table_panel_57200496")

	self._txtRealTime = goutil.findChildTextComponent(rootGO, "objGo/txtLocalTime")
	self._txtAirtightEndTime = goutil.findChildTextComponent(rootGO, "objGo/txt2/txtSecretTime")
	self._txtAirtightEndTimeTitle = goutil.findChildTextComponent(rootGO, "objGo/txt2")
	self._btnTime = UIComponentType.ButtonAdapter(goutil.findChild(rootGO, "objGo/btnSecret"))
	self._btnOpen = UIComponentType.ButtonAdapter(goutil.findChild(rootGO, "objGo/btnForcedOpen"))

	local rootDate = goutil.findChild(rootGO, "objGo/txtDayList")
	local rootDayAM = goutil.findChild(rootGO, "objGo/dayItemGroup/amList")
	local rootDayPM = goutil.findChild(rootGO, "objGo/dayItemGroup/pmList")

	for i = 1, 7 do
		local txtDate = goutil.findChildTextComponent(rootDate, string.format("txtDay%s", i))
		local am = goutil.findChild(rootDayAM, string.format("day%s", i))
		local pm = goutil.findChild(rootDayPM, string.format("day%s", i))

		self:_buildDayMark(i, txtDate, am, pm)
	end
end

function M:_buildDayMark(wDay, txtDate, amRoot, pmRoot)
	if not self._compsWeekDay then
		self._compsWeekDay = {}
	end

	goutil.findChildTextComponent(amRoot, "normalCurrentTime/txtTime").text = "00:00-11:59"
	goutil.findChildTextComponent(amRoot, "secretTime/txtTime").text = "00:00-11:59"
	goutil.findChildTextComponent(pmRoot, "normalCurrentTime/txtTime").text = "12:00-23:59"
	goutil.findChildTextComponent(pmRoot, "secretTime/txtTime").text = "12:00-23:59"

	local comps = {}

	comps.txtDate = txtDate
	comps.goNowAM = goutil.findChild(amRoot, "normalCurrentTime")
	comps.goAirtightMarkAM = goutil.findChild(amRoot, "secretTime")
	comps.goAirtightActiveAM = goutil.findChild(amRoot, "secretTime/isTime")
	comps.goAirtightNormalIconAM = goutil.findChild(amRoot, "secretTime/imgNormal")
	comps.goAirtightPropIconAM = goutil.findChild(amRoot, "secretTime/imgProp")
	comps.goNowPM = goutil.findChild(pmRoot, "normalCurrentTime")
	comps.goAirtightMarkPM = goutil.findChild(pmRoot, "secretTime")
	comps.goAirtightActivePM = goutil.findChild(pmRoot, "secretTime/isTime")
	comps.goAirtightNormalIconPM = goutil.findChild(pmRoot, "secretTime/imgNormal")
	comps.goAirtightPropIconPM = goutil.findChild(pmRoot, "secretTime/imgProp")
	self._compsWeekDay[wDay] = comps
end

function M:destroyUI()
	M.super.destroyUI(self)
end

function M:bindEvents()
	self._btnOpen:AddClickListener(self._onClickOpen, self)
	self._btnTime:AddClickListener(self._onClickTime, self)
end

function M:unbindEvents()
	self._btnOpen:RemoveClickListener()
	self._btnTime:RemoveClickListener()
end

function M:_setEvents(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.FW_CLOCK_TICKMINUTE, self._onMinTimer, self)
		GlobalDispatcher:addEventListener(EventType.ON_AIRTIGHT_EXIT_TIME_CHANGE, self._handleAirtightExitTimeChange, self)
		GlobalDispatcher:addEventListener(EventType.MAIN_SCENE_TO_AIRTIGHT_ANI_FINISHED, self._onToAirtightAniFinished, self)
		GlobalDispatcher:addEventListener(EventType.ON_ARITIGHT_EDITOR_OFFSET, self._handleAirtightEditorOffset, self)
	else
		GlobalDispatcher:removeEventListener(EventType.FW_CLOCK_TICKMINUTE, self._onMinTimer, self)
		GlobalDispatcher:removeEventListener(EventType.ON_AIRTIGHT_EXIT_TIME_CHANGE, self._handleAirtightExitTimeChange, self)
		GlobalDispatcher:removeEventListener(EventType.MAIN_SCENE_TO_AIRTIGHT_ANI_FINISHED, self._onToAirtightAniFinished, self)
		GlobalDispatcher:removeEventListener(EventType.ON_ARITIGHT_EDITOR_OFFSET, self._handleAirtightEditorOffset, self)
	end
end

function M:onEnter()
	M.super.onEnter(self)

	self._canvasGroup.interactable = true
	self._isAirtightTime = nil

	self:_forceRefreshAll()
	self:_setEvents(true)
	MainScenePerformUtil.viewCamCtrl(self._viewPresentor:getViewName(), 1, true, true)
	MainScenePerformUtil.setBgHeroShow(false, true, true)
	MainScenePerformUtil.setElementShow(MainPerformEnum.ElementIdAirtightClock, true)
	GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_CLOCK_CHANGE_MODE, false)
	LightMgr.instance:turnOn(kLightCode)
end

function M:onExit(reasonTyp)
	self:_setEvents(false)

	self._canvasGroup.interactable = false
	self._cacheHour = nil
	self._playingAirtightShow = nil

	local isNormalClose = reasonTyp ~= WindowType.WindowCloseReasonType.QuickCloseType

	MainScenePerformUtil.viewCamCtrl(self._viewPresentor:getViewName(), self._activeIndex, false, isNormalClose)

	if isNormalClose then
		LightMgr.instance:turnOff(kLightCode)
	end
end

function M:_handleAirtightEditorOffset()
	self:_forceRefreshAll()
end

function M:_handleAirtightExitTimeChange(e, exitTimeStamp)
	local nowTime = AirtightRoomModel.instance:getServerTime()

	if exitTimeStamp and nowTime < exitTimeStamp then
		self._playingAirtightShow = true

		self:_setCanvas(0, false)
		MainScenePerformUtil.tweenMainSceneCam(MainPerformEnum.CamCodeMain, MainPerformEnum.DefaultCamTweenDuration, DG.Tweening.Ease.InOutSine)

		local displayHero, displayHeroSkin = MainScenePerformUtil.getDisplayAdjutantHeroId()
		local forceSet = false
		local prefix = MainPerformEnum.AnimPrefix.Shafa
		local mixDuration
		local isChange = false
		local defaultHide = false
		local blockChangeEff = true

		MainScenePerformUtil.changeHeroReq(MainPerformEnum.ElementPointAdjutant, displayHero, displayHeroSkin, forceSet, prefix, mixDuration, isChange, defaultHide, blockChangeEff)
	end

	self:_forceRefreshAll()
end

function M:_onToAirtightAniFinished()
	if not self._playingAirtightShow then
		return
	end

	self._playingAirtightShow = nil

	MainScenePerformUtil.tweenMainSceneCam(MainPerformEnum.CamCodeClock, MainPerformEnum.DefaultCamTweenDuration, DG.Tweening.Ease.OutQuint)
	MainScenePerformUtil.setBgHeroShow(false, true, true)
	self:_setCanvas(1, true)
end

function M:_setCanvas(alpha, interactable)
	self._canvasGroup.alpha = alpha
	self._canvasGroup.interactable = interactable
end

function M:_onMinTimer()
	self:_updateAirtightTime()
end

function M:_forceRefreshAll()
	self._cacheHour = nil

	self:_updateAirtightTime()
end

function M:_updateAirtightTime()
	local nowTime = AirtightRoomModel.instance:getServerTime()
	local inAirtightTime, inTimeByItem, hour, minute, second, airtightEndTS = AirtightRoomController.instance:getAirtightTimeInfo(nowTime)
	local inSpTime, inSpNormal, inSpAirtight = AirtightRoomUtil.getSpTimeInfo()

	self._txtRealTime.text = os.date("%H:%M", nowTime)

	local hourChange = not self._cacheHour or self._cacheHour ~= hour
	local airtightChange = not self._isAirtightTime or self._isAirtightTime ~= inAirtightTime

	if hourChange or airtightChange then
		self:refreshDetail()

		self._txtAirtightEndTimeTitle.text = inAirtightTime and lang("tip_secret_time_end_countdown") or lang("tip_secret_time_start_countdown")
	end

	if inAirtightTime then
		self._txtAirtightEndTime.text = airtightEndTS and TimeUtil.instance:numberToTime(airtightEndTS - nowTime, "h:m") or "--:--"
	else
		local nextTimeStamp = AirtightRoomController.instance:getNextAirtightBeginTimeStamp()

		self._txtAirtightEndTime.text = TimeUtil.instance:numberToTime(nextTimeStamp - nowTime, "h:m")
	end

	goutil.setActive(self._txtAirtightEndTimeTitle.gameObject, AirtightRoomUtil.isSystemOpen(false))
	goutil.setActive(self._btnTime.gameObject, false)
	goutil.setActive(self._btnOpen.gameObject, not inAirtightTime and not inSpTime)

	self._cacheHour = hour
	self._isAirtightTime = inAirtightTime
end

function M:refreshDetail()
	local nowTime = AirtightRoomModel.instance:getServerTime()
	local isAm = tonumber(os.date("%H", nowTime)) < 12
	local nowWeekDay = AirtightRoomUtil.getNowWeekDay(nowTime)

	for i = 1, 7 do
		local showWeekDay = i - 1 + nowWeekDay
		local offsetWeek = math.floor(showWeekDay / 8)

		showWeekDay = showWeekDay % 7
		showWeekDay = showWeekDay == 0 and 7 or showWeekDay

		local markWeekDay = nowWeekDay == showWeekDay and offsetWeek == 0
		local comps = self._compsWeekDay[i]
		local date = AirtightRoomUtil.getWeekDayDate(nowTime, showWeekDay, offsetWeek)

		comps.txtDate.text = string.format("%d/%d", date.month, date.day)

		local inAirtightTime = self:_isTimeRangeAirtight(showWeekDay, true, offsetWeek)

		goutil.setActive(comps.goNowAM, isAm and markWeekDay and not inAirtightTime)
		goutil.setActive(comps.goAirtightMarkAM, inAirtightTime)
		goutil.setActive(comps.goAirtightActiveAM, isAm and markWeekDay and inAirtightTime)
		goutil.setActive(comps.goAirtightNormalIconAM, true)
		goutil.setActive(comps.goAirtightPropIconAM, false)

		inAirtightTime = self:_isTimeRangeAirtight(showWeekDay, false, offsetWeek)

		goutil.setActive(comps.goNowPM, not isAm and markWeekDay and not inAirtightTime)
		goutil.setActive(comps.goAirtightMarkPM, inAirtightTime)
		goutil.setActive(comps.goAirtightActivePM, not isAm and markWeekDay and inAirtightTime)
		goutil.setActive(comps.goAirtightNormalIconPM, true)
		goutil.setActive(comps.goAirtightPropIconPM, false)
	end
end

function M:_isTimeRangeAirtight(weekDay, isAM, weekOffset)
	weekOffset = weekOffset or 0

	local systemOpen = AirtightRoomUtil.isSystemOpen(false)
	local nowTime = AirtightRoomModel.instance:getServerTime()
	local startTime = AirtightRoomModel.instance:getAirtightStartTimeStamp()
	local stepSecond = 43200
	local stepRealSec = 86400
	local stepAirtightSec = 129600
	local mondayTS = AirtightRoomUtil.getWDayTimeStamp(nowTime, 1)

	mondayTS = mondayTS + weekOffset * 7 * stepRealSec

	local _ts1 = mondayTS + (weekDay - 1) * 86400
	local _ts2 = _ts1 + stepSecond
	local _ts3 = _ts2 + stepSecond
	local ts = isAM and _ts1 or _ts2
	local ts2 = isAM and _ts2 or _ts3
	local inAirtightTime = false
	local useRealTime = ts <= startTime

	if not systemOpen then
		useRealTime = true
	end

	if useRealTime then
		inAirtightTime = false
	else
		local _startTime = startTime
		local _stepSec = stepAirtightSec
		local hour, minute, second = AirtightRoomUtil.getOneDayTimeStruct((ts - _startTime) % _stepSec)

		inAirtightTime = hour >= 24
		hour, minute, second = AirtightRoomUtil.getOneDayTimeStruct((ts2 - _startTime) % _stepSec)

		if inAirtightTime and hour == 0 then
			hour = 36
		end
	end

	return inAirtightTime
end

function M:_onClickOpen()
	if self._isAirtightTime then
		FloatWordMgr.instance:show(lang("tip_airtighttime_already"))

		return
	end

	local itemId = AirtightRoomUtil.getItemId()

	if ItemModel.instance:getItemCountByItemId(itemId) > 0 then
		ToolTipsMgr.showAirtightRoomTimeOpenTips()
	else
		FloatWordMgr.instance:show(lang("tip_goods_not_enough"))
	end
end

function M:_onClickTime()
	printWarn("click time")
end

return M
