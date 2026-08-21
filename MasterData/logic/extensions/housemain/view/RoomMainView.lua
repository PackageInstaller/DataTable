-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/housemain/view/RoomMainView.lua

module("logic.extensions.housemain.view.RoomMainView", package.seeall)

local M = class("RoomMainView", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._btnReturn = self:getBtn("2&title_view_-878360263")
	self._goMapContentRoot = self:getGo("room_main_view_-1570063698")
	self._goMapDistribution = self:getGo("room_map_distribution_view_1494262084")
	self._mapDistributionView = Astral.LuaComponentContainer.Add(self._goMapDistribution, RoomMapDistributionView)

	self._mapDistributionView:setViewPresentor(self._viewPresentor)
	self._mapDistributionView:buildUI()

	self._goJoyStickRoot = self:getGo("joystickpanel_-2119778038")
	self._goExploreModeMap = self:getGo("room_main_view_-1135452842")
	self._goTitleView = self:getGo("title_view_-478490097")
	self._goTopCurrencyRoot = self:getGo("1&top_currency_1050779625")
	self._btnViewMode = self:getBtn("room_main_view_-1132315704")

	goutil.setActive(self._btnViewMode.gameObject, false)

	self._goToggleRoot = self:getGo("room_main_view_-890903218")
	self._toggleTabControl = ToggleTabControl.New()

	self._toggleTabControl:setViewPager(self)
	self._toggleTabControl:addToggleTab(self:getUIComponent("room_main_view_-1143118735", UIComponentType.SpaceXToggle))
	self._toggleTabControl:addToggleTab(self:getUIComponent("room_main_view_-1398956247", UIComponentType.SpaceXToggle))

	self._goLeftBtnRoot = self:getGo("room_main_view_1883362732")
	self._btnConstructTask = self:getBtn("room_main_view_1698882293")
	self._goBuildTaskNoteRoot = self:getGo("room_main_view_2000952330")
	self._txtBuildTaskName = self:getText("room_main_view_-1426710046")
	self._goBuildTaskMarkCanReward = self:getGo("room_main_view_-43256573")
	self._goBuildTaskRedPoint = goutil.findChild(self._btnConstructTask.gameObject, "red_point").gameObject
	self._btnFacilityManage = self:getBtn("room_main_view_1935977630")
	self._btnPersonnelManage = self:getBtn("room_main_view_14089366")
	self._toggleHideUI = self:getUIComponent("room_main_view_1778170021", UIComponentType.SpaceXToggle)
	self._btnStorge = self:getBtn("room_main_view_-1050662728")
	self._btnVisit = self:getBtn("room_main_view_-1934717511")
	self._btnExplore = self:getBtn("room_main_view_330447158")
	self._txtEnterState = self:getText("room_main_view_2023392359")
	self._goRightTopRoot = self:getGo("room_main_view_-440939390")
	self._rectTrMap = self:getRectTransform("room_main_view_-1821274721")
	self._rectTrMapPos = self:getRectTransform("room_main_view_-852575506")
	self._btnAtmosphere = self:getBtn("room_main_view_-1365741431")
	self._txtAtmosphere = self:getText("room_main_view_-63765476")
	self._goTimeTypMarkDay = self:getGo("room_main_view_-1880130085")
	self._goTimeTypmarkNight = self:getGo("room_main_view_-848209010")
	self._txtTime = self:getText("room_main_view_-1917730517")
	self._txtTimeMin = self:getText("room_main_view_336025126")
	self._btnGain = self:getBtn("room_main_view_-131505616")
	self._txtGainNum = self:getText("room_main_view_-469993380")
	self._btnBackLog = self:getBtn("room_main_view_-730651650")
	self._txtBackLogNum = self:getText("room_main_view_-1825528331")
	self._goRightBottomRoot = self:getGo("room_main_view_-1628746377")
	self._btnGoUpstairs = self:getBtn("room_main_view_-539352650")
	self._btnGoDownstairs = self:getBtn("room_main_view_-678250422")
	self._txtStoreyName = self:getText("room_main_view_-988937706")
	self._btnAtmosphereEventBlocker = self:getBtn("room_main_view_-234717453")
	self._goAtmosphereTipsRoot = self:getGo("room_main_view_-2126749110")
	self._txtAtmosphereLvInTips = self:getText("room_main_view_-289683129")
	self._txtAtmosphereInTips = self:getText("room_main_view_-432046708")
	self._txtMood = self:getText("room_main_view_-1456525525")
	self._btnAtmoHint = self:getBtn("room_main_view_-2043459303")
	self._rectTrAtmoDetailRoot = self:getRectTransform("room_main_view_-1910397747")
	self._goAtmoDetailItem = self:getGo("room_main_view_-207415044")
	self._goMousePointRoot = self:getGo("room_main_view_-289559273")
	self._rectMousePoint1 = self:getRectTransform("room_main_view_-762878865")
	self._rectMousePoint2 = self:getRectTransform("room_main_view_-2009863977")

	local rectTransMainGo = self.mainGO:GetComponent(UIComponentType.RectTransform)
	local rectTransPointParent = self._rectTrMapPos.parent:GetComponent(UIComponentType.RectTransform)

	self._screenWidth = goutil.getWidth(rectTransMainGo)
	self._screenHeight = goutil.getHeight(rectTransMainGo)
	self._mapPosOrgScaleWidth = goutil.getWidth(self._rectTrMapPos)
	self._mapPosOrgScaleHeight = goutil.getHeight(self._rectTrMapPos)
	self._mapPosMaxWidth = goutil.getWidth(rectTransPointParent)
	self._mapPosMaxHeight = goutil.getHeight(rectTransPointParent) - 10
	self._mapPosMaxPosX = (self._mapPosMaxWidth - self._screenWidth * 0.1) * 0.5
	self._mapPosMaxPosY = (self._mapPosMaxHeight - self._screenHeight * 0.1) * 0.5
	self._txtRoomPassStatus = self:getText("room_main_view_1235641099")
end

function M:destroyUI()
	self._btnReturn = nil
	self._goMapContentRoot = nil
	self._goMapDistribution = nil
	self._btnViewMode = nil
	self._goTitleView = nil
	self._goTopCurrencyRoot = nil
	self._goToggleRoot = nil

	self._toggleTabControl:destroy()

	self._toggleTabControl = nil
	self._goLeftBtnRoot = nil
	self._btnConstructTask = nil
	self._goBuildTaskNoteRoot = nil
	self._txtBuildTaskName = nil
	self._goBuildTaskMarkCanReward = nil
	self._btnFacilityManage = nil
	self._btnPersonnelManage = nil
	self._toggleHideUI = nil
	self._btnStorge = nil
	self._btnVisit = nil
	self._btnExplore = nil
	self._goRightTopRoot = nil
	self._rectTrMap = nil
	self._rectTrMapPos = nil
	self._btnAtmosphere = nil
	self._txtAtmosphere = nil
	self._goTimeTypMarkDay = nil
	self._goTimeTypmarkNight = nil
	self._txtTime = nil
	self._txtTimeMin = nil
	self._btnGain = nil
	self._txtGainNum = nil
	self._btnBackLog = nil
	self._txtBackLogNum = nil
	self._goRightBottomRoot = nil
	self._btnGoUpstairs = nil
	self._btnGoDownstairs = nil
	self._txtStoreyName = nil
	self._btnAtmosphereEventBlocker = nil
	self._goAtmosphereTipsRoot = nil
	self._txtAtmosphereLvInTips = nil
	self._txtAtmosphereInTips = nil
	self._txtMood = nil
	self._btnAtmoHint = nil
	self._rectTrAtmoDetailRoot = nil
	self._goAtmoDetailItem = nil

	for key, value in pairs(self._cellItem or {}) do
		value:destroyUI()
	end

	self._cellItem = nil
	self._goMousePointRoot = nil
	self._rectMousePoint1 = nil
	self._rectMousePoint2 = nil
	self._txtRoomPassStatus = nil

	self._mapDistributionView:unbindEvents()
	self._mapDistributionView:onExit()
end

function M:bindEvents()
	self._mapDistributionView:bindEvents()
	self._btnReturn:AddClickListener(self._onClickReturn, self)
	self._btnConstructTask:AddClickListener(self._onClickConstructTask, self)
	self._btnFacilityManage:AddClickListener(self._onClickFacilityManage, self)
	self._btnPersonnelManage:AddClickListener(self._onClickPersonnelManage, self)
	self._toggleHideUI:AddListener(self._onToggleHideUI, self)
	self._btnStorge:AddClickListener(self._onClickStorge, self)
	self._btnVisit:AddClickListener(self._onClickVisit, self)
	self._btnExplore:AddClickListener(self._onClickExplore, self)
	self._btnViewMode:AddClickListener(self._onClickViewMode, self)
	self._btnAtmosphere:AddClickListener(self._onClickAtmosphere, self)
	self._btnGain:AddClickListener(self._onClickGain, self)
	self._btnBackLog:AddClickListener(self._onClickBackLog, self)
	self._btnGoUpstairs:AddClickListener(self._onClickGoUpstairs, self)
	self._btnGoDownstairs:AddClickListener(self._onClickGoDownstairs, self)
	self._btnAtmoHint:AddClickListener(self._onClickAtmoHint, self)
	self._btnAtmosphereEventBlocker:AddClickListener(self._onClickAtmosphere, self)
end

function M:unbindEvents()
	self._btnReturn:RemoveClickListener()
	self._btnConstructTask:RemoveClickListener()
	self._btnFacilityManage:RemoveClickListener()
	self._btnPersonnelManage:RemoveClickListener()
	self._toggleHideUI:RemoveListener()
	self._btnStorge:RemoveClickListener()
	self._btnVisit:RemoveClickListener()
	self._btnExplore:RemoveClickListener()
	self._btnViewMode:RemoveClickListener()
	self._btnAtmosphere:RemoveClickListener()
	self._btnGain:RemoveClickListener()
	self._btnBackLog:RemoveClickListener()
	self._btnGoUpstairs:RemoveClickListener()
	self._btnGoDownstairs:RemoveClickListener()
	self._btnAtmoHint:RemoveClickListener()
	self._btnAtmosphereEventBlocker:RemoveClickListener()

	for key, value in pairs(self._cellItem or {}) do
		value:unbindEvents()
	end
end

function M:setEventListener(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.HOUSE_HOLDROOM_INFO_CHANGE, self.handleHouseHoldRoomInfoChange, self)
		GlobalDispatcher:addEventListener(EventType.HOUSE_BACKLOG_NUM_CHANGE, self.handleHouseBackLogNumChange, self)
		GlobalDispatcher:addEventListener(EventType.HOUSE_HARVEST_REPORT_NUM_CHANGE, self.handleHouseHarvestReportNumChange, self)
		HouseDispatcher:addEventListener(HouseEventType.ON_SCENE_CAMERA_REFRESH, self._onSceneCameraRefresh, self)
		GlobalDispatcher:addEventListener(EventType.ON_SCENE_PICKER_MULTI_DRAG, self._onMultiDrag, self)
		HouseDispatcher:addEventListener(HouseEventType.ON_SCENE_CHANGE_RING_TYPE, self.handleOnChangeRingType, self)
		HouseDispatcher:addEventListener(HouseEventType.ON_FOCUS_ROOM_EXIST, self.handleOnFocusRoomExist, self)
		HouseDispatcher:addEventListener(HouseEventType.ON_ATMOSPHERE_CHANGE, self.handleOnAtmosphereChange, self)
		HouseDispatcher:addEventListener(HouseEventType.LIVE_ZONE_ACTIVE, self._handleLiveZoneActive, self)
		HouseDispatcher:addEventListener(HouseEventType.LIVE_ZONE_INFO_REFRESH, self._handleLiveZoneInfoRefresh, self)
		HouseDispatcher:addEventListener(HouseEventType.READY_FOCUS_ROOM, self._handleReadyFocusRoom, self)
		HouseDispatcher:addEventListener(HouseEventType.ON_MAIN_ROOM_MAP_POS_CHANGE, self._handleOnMainRoomMapPosChange, self)
		HouseDispatcher:addEventListener(HouseEventType.HOUSE_TASK_INFO_CHANGE, self.handleHouseTaskInfoChange, self)

		if Astral.OSDef.isEditor then
			local inst = KeycodeListener.instance

			inst:addEventListener(UnityEngine.KeyCode.LeftControl, self._onKeycodeChange, self, 0)
		end
	else
		Scheduler.removeListener(self._updateTime, self)
		removetimer(self._fixTime, self)
		GlobalDispatcher:removeEventListener(EventType.HOUSE_HOLDROOM_INFO_CHANGE, self.handleHouseHoldRoomInfoChange, self)
		GlobalDispatcher:removeEventListener(EventType.HOUSE_BACKLOG_NUM_CHANGE, self.handleHouseBackLogNumChange, self)
		GlobalDispatcher:removeEventListener(EventType.HOUSE_HARVEST_REPORT_NUM_CHANGE, self.handleHouseHarvestReportNumChange, self)
		HouseDispatcher:removeEventListener(HouseEventType.ON_SCENE_CAMERA_REFRESH, self._onSceneCameraRefresh, self)
		GlobalDispatcher:removeEventListener(EventType.ON_SCENE_PICKER_MULTI_DRAG, self._onMultiDrag, self)
		HouseDispatcher:removeEventListener(HouseEventType.ON_SCENE_CHANGE_RING_TYPE, self.handleOnChangeRingType, self)
		HouseDispatcher:removeEventListener(HouseEventType.ON_FOCUS_ROOM_EXIST, self.handleOnFocusRoomExist, self)
		HouseDispatcher:removeEventListener(HouseEventType.ON_ATMOSPHERE_CHANGE, self.handleOnAtmosphereChange, self)
		HouseDispatcher:removeEventListener(HouseEventType.LIVE_ZONE_ACTIVE, self._handleLiveZoneActive, self)
		HouseDispatcher:removeEventListener(HouseEventType.LIVE_ZONE_INFO_REFRESH, self._handleLiveZoneInfoRefresh, self)
		HouseDispatcher:removeEventListener(HouseEventType.READY_FOCUS_ROOM, self._handleReadyFocusRoom, self)
		HouseDispatcher:removeEventListener(HouseEventType.ON_MAIN_ROOM_MAP_POS_CHANGE, self._handleOnMainRoomMapPosChange, self)
		HouseDispatcher:removeEventListener(HouseEventType.HOUSE_TASK_INFO_CHANGE, self.handleHouseTaskInfoChange, self)

		if Astral.OSDef.isEditor then
			local inst = KeycodeListener.instance

			inst:removeEventListener(UnityEngine.KeyCode.LeftControl, self._onKeycodeChange, self)
		end
	end
end

function M:onEnter(openReasonType)
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Room)

	self._cellItem = {}

	HouseAgent.instance:sendHouseListTaskRequest()
	HouseAgent.instance:sendGetHeroFeatureRequest()
	TradingAgent.instance:sendGetTradePostInfoRequest()
	TradingAgent.instance:sendGetGoodsPriceRequest()
	HouseMainRoomModel.instance:setHarvestNum(HouseMainEnum.HarvestTyp.HoldReport, ContainmentModel.instance:getHasReportRoomCount())
	SupervisorAgent.instance:sendGetManagerInfoRequest()
	ManufactureAgent.instance:sendGetManufactureInfoRequest()
	HouseMainRoomModel.instance:setBackLogNum(HouseMainEnum.BackLogTyp.tradeGoodsFull, RoomBackpackModel.instance:getIsTradeMaterialFull() and 1 or 0)
	self:checkTime()
	self:_updateCurStoreyShow()
	self:updateAtmosphereData()
	self:updateBackLogEntryShow()
	self:updateHarvestReportEntryShow()
	self:_refreshMap()

	self._uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

	self:setEventListener(true)

	local focusRoomId = HouseMainRoomModel.instance:getFocusRoomId()
	local lastState = HouseMainStateModel.instance:getState() or HouseMainEnum.State.Normal

	if focusRoomId == nil then
		self._toggleHideUI.IsOn = true

		self:_onFousRoomHideUI(true)
		self:showUpLastScene()
		self:showUpLastTab()

		if lastState == HouseMainEnum.State.ExploreMode then
			self:_enterExploreMode()
		end
	else
		HouseModel.instance:setLastHouseModeTabIndex(1)
		self:showUpLastScene()
		self:showUpLastTab()
		self:_onFousRoomHideUI(false)
		HouseMainStateModel.instance:changeState(HouseMainEnum.State.FocusRoom)
		HouseDispatcher:dispatchEvent(HouseEventType.ON_SCENE_CHANGE_RING_TYPE, self._ringType)
		HouseFocusController.instance:doFocusRoom(focusRoomId, true, true, true)
	end

	goutil.setActive(self._goJoyStickRoot, false)
	goutil.setActive(self._goExploreModeMap, false)

	local inExplore = HouseMainStateModel.instance:isInState(HouseMainEnum.State.ExploreMode)
	local stateStr = inExplore and lang("tip_house_build") or lang("tip_house_explore")

	self._txtEnterState.text = stateStr
end

function M:onExit(closeReasonType)
	self._activeIndex = nil
	self._uiCamera = nil

	self:setEventListener(false)

	for key, value in pairs(self._cellItem or {}) do
		value:onExit()
	end

	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_Room)
end

function M:checkTime()
	local info = ServerTime.nowDateServerLook()
	local offsetSec = 60 - info.sec

	if offsetSec > 0 then
		settimer(offsetSec, self._fixTime, self, false)
	else
		Scheduler.addListener(60, self._updateTime, self, true)
	end

	self:_updateTimeShow(info.hour, info.min, info.sec)
end

function M:_fixTime()
	self:_updateTime()
	removetimer(self._fixTime, self)
	Scheduler.addListener(60, self._updateTime, self, true)
end

function M:_updateTime()
	local info = ServerTime.nowDateServerLook()

	self:_updateTimeShow(info.hour, info.min, info.sec)
end

function M:_updateTimeShow(hour, min, sec)
	self._txtTime.text = StringUtil.getLess10With0(hour)
	self._txtTimeMin.text = StringUtil.getLess10With0(min)

	local isDay = hour >= 5 and hour < 20

	goutil.setActive(self._goTimeTypMarkDay, isDay)
	goutil.setActive(self._goTimeTypmarkNight, not isDay)
end

function M:handleHouseHoldRoomInfoChange()
	if self._mapDistributionView then
		self._mapDistributionView:handleHouseHoldRoomInfoChange()
	end
end

function M:handleHouseBackLogNumChange()
	self:updateBackLogEntryShow()

	if self._mapDistributionView then
		self._mapDistributionView:handleHouseBackLogNumChange()
	end
end

function M:handleHouseHarvestReportNumChange()
	self:updateHarvestReportEntryShow()

	if self._mapDistributionView then
		self._mapDistributionView:handleHouseHarvestReportNumChange()
	end
end

function M:_handleLiveZoneActive(e, zoneId)
	printWarn("房间激活 ", zoneId)

	if self._mapDistributionView then
		self._mapDistributionView:handleLiveZoneActive(zoneId)
	end

	self:_refreshMap()
end

function M:_handleLiveZoneInfoRefresh(e, zoneId)
	self:_refreshMap()
end

function M:_handleReadyFocusRoom(e, canFocus)
	if canFocus then
		goutil.setActive(self._goMapContentRoot, false)
		self:_onFousRoomHideUI(false)
	end
end

function M:_handleOnMainRoomMapPosChange(e, posInfo)
	if self:isInConstructMode() then
		local curMaxPosX = self._mapPosMaxPosX * posInfo.scale
		local curMaxPosY = self._mapPosMaxPosY * posInfo.scale
		local posX = posInfo.posX / posInfo.maxPosX * posInfo.scale * self._mapPosMaxPosX * -1
		local posY = posInfo.posY / posInfo.maxPosY * posInfo.scale * self._mapPosMaxPosY * -1

		RectTransformUtils.SetAnchoredPosition(self._rectTrMapPos, posX, posY)

		local width, height = self._screenWidth * 0.1, self._screenHeight * 0.1

		width = width + (self._mapPosMaxWidth - width) * (1 - posInfo.scale)
		height = height + (self._mapPosMaxHeight - height) * (1 - posInfo.scale)

		self:_updateMapPosScale(width, height)
	end
end

function M:handleHouseTaskInfoChange(e)
	self:updateBuildTaskNote()
end

function M:handleOnChangeRingType(e, ringType)
	self._ringType = ringType

	self:_updateCurStoreyShow()
end

function M:_onSceneCameraRefresh(e, ringType, camContrastAngle)
	if not self:isInConstructMode() then
		TransformUtils.SetEulerAngles(self._rectTrMap, 0, 0, -camContrastAngle)
		self:_updateRoomStatus(ringType, camContrastAngle)
	end
end

function M:showUpLastTab()
	local defaultTabIndex = HouseModel.instance:getLastHouseModeTabIndex()

	self._toggleTabControl:selectTab(defaultTabIndex)
end

function M:showUpLastScene()
	local lastCamAngle = HouseModel.instance:getLastHouseCamContrastAngle()
	local lastRoomId = HouseModel.instance:getOnceEnterRoomId()

	if lastRoomId then
		local roomCO = HouseConfig.instance:getConfigByKey(ConfigName.HouseZone, lastRoomId)

		lastCamAngle = roomCO.angle
		self._ringType = NavMeshUtil.getRingTypeByZoneId(lastRoomId)
	else
		lastRoomId = HouseModel.instance:getDefaultRoomId()
		self._ringType = HouseModel.instance:getLastRingType()
	end

	if not lastCamAngle then
		local roomCO = HouseConfig.instance:getConfigByKey(ConfigName.HouseZone, lastRoomId)

		lastCamAngle = roomCO.angle
	end

	TransformUtils.SetEulerAngles(self._rectTrMap, 0, 0, tonumber(lastCamAngle) * -1)
	self:_updateCurStoreyShow()
end

function M:handleOnFocusRoomExist(e)
	self:_onFousRoomHideUI(true)
	self:_updateShowPage()
end

function M:_onMultiDrag(e, centerX, centerY, scale, distance, isFirstMultiDrag)
	if Astral.OSDef.isEditor and self:isInConstructMode() then
		self._mapDistributionView:onMultiDragListener(centerX, centerY, scale, distance, isFirstMultiDrag)
	end
end

function M:setPage(tabIndex)
	if self._activeIndex and tabIndex == self._activeIndex then
		return
	end

	self._activeIndex = tabIndex

	HouseModel.instance:setLastHouseModeTabIndex(tabIndex)
	self:_updateShowPage()
end

function M:_updateShowPage()
	if self._activeIndex == 1 then
		goutil.setActive(self._goMapContentRoot, false)
		goutil.setActive(self._goRightBottomRoot, true)
		self:setAtmosphereShow(false)
		self:_updateMapPosScale(self._mapPosOrgScaleWidth, self._mapPosOrgScaleHeight)
		self:_updateCurStoreyShow()
		self._mapDistributionView:leavePage()
	elseif self._activeIndex == 2 then
		goutil.setActive(self._goMapContentRoot, true)
		goutil.setActive(self._goRightBottomRoot, false)
		self:setAtmosphereShow(false)
		self._mapDistributionView:onEnter()
	end

	self:_updateMapPosShow()
end

function M:_updateMapPosShow()
	local angle = HouseModel.instance:getLastHouseCamContrastAngle()

	if self._activeIndex == 1 then
		if not angle then
			local lastRoomId = HouseModel.instance:getOnceEnterRoomId() or HouseModel.instance:getDefaultRoomId()
			local roomCO = HouseConfig.instance:getConfigByKey(ConfigName.HouseZone, lastRoomId)

			angle = roomCO.angle
		end
	elseif self._activeIndex == 2 then
		angle = 0
	end

	TransformUtils.SetEulerAngles(self._rectTrMap, 0, 0, -angle)
end

function M:_updateMapPosScale(width, height)
	goutil.setWidth(self._rectTrMapPos, width)
	goutil.setHeight(self._rectTrMapPos, height)
end

function M:isInConstructMode()
	local state = HouseMainStateModel.instance:getState()

	return state == HouseMainEnum.State.Normal and self._activeIndex == 2
end

function M:_updateCurStoreyShow()
	self._txtStoreyName.text = lang(HouseMainEnum.StoreyName[self._ringType])

	local y = HouseMainEnum.StoreyPointPos[self._ringType] or HouseMainEnum.StoreyPointPos[1]

	RectTransformUtils.SetAnchoredPosition(self._rectTrMapPos, 0, y)
end

function M:_onClickReturn()
	local state = HouseMainStateModel.instance:getState()

	if state == HouseMainEnum.State.ViewMode then
		self:_exitViewMode()
	else
		HouseMainFacade.instance:backScene()
	end
end

function M:_onClickConstructTask()
	ViewMgr.instance:open(ViewName.RoomBuildTaskView)
end

function M:_onClickFacilityManage()
	ViewMgr.instance:open(ViewName.HouseRoomManage)
end

function M:_onClickPersonnelManage()
	ViewMgr.instance:open(ViewName.NewHouseWorkerMainView)
end

function M:_onToggleHideUI(tab, isOn)
	local showUI = isOn

	goutil.setActive(self._btnConstructTask.gameObject, showUI)
	goutil.setActive(self._btnFacilityManage.gameObject, showUI)
	goutil.setActive(self._btnPersonnelManage.gameObject, showUI)
	goutil.setActive(self._btnStorge.gameObject, showUI)
	goutil.setActive(self._btnExplore.gameObject, showUI)
	goutil.setActive(self._goRightTopRoot, showUI)
	goutil.setActive(self._goRightBottomRoot, showUI)
	goutil.setActive(self._btnViewMode.gameObject, false)
	goutil.setActive(self._goToggleRoot, showUI)
	self:setAtmosphereShow(false)
end

function M:_onFousRoomHideUI(showUI)
	self:_onToggleHideUI(nil, showUI)
	goutil.setActive(self._goTopCurrencyRoot, showUI)
	goutil.setActive(self._goLeftBtnRoot, showUI)
	goutil.setActive(self._goTitleView, showUI)
	self:setAtmosphereShow(false)
end

function M:_onViewModeHideUI(showUI)
	self:_onToggleHideUI(nil, showUI)
	goutil.setActive(self._goTopCurrencyRoot, showUI)
	goutil.setActive(self._goLeftBtnRoot, showUI)
	goutil.setActive(self._goTitleView, true)
	goutil.setActive(self._toggleHideUI.gameObject, showUI)
	self:setAtmosphereShow(false)

	if self._activeIndex == 2 then
		goutil.setActive(self._goMapContentRoot, showUI)
	end
end

function M:_onClickStorge()
	printWarn("小屋主界面，点击仓库")
	ViewMgr.instance:open(ViewName.RoomBackpackView)
end

function M:_onClickVisit()
	printWarn("小屋主界面，点击寻访")
	DungeonMainLineChapterModel.instance:tryEnterChapterScene()
end

function M:_onClickExplore()
	printWarn("小屋主界面，点击探索")

	local inExplore = HouseMainStateModel.instance:isInState(HouseMainEnum.State.ExploreMode)
	local stateStr = inExplore and lang("tip_house_build") or lang("tip_house_explore")
	local dialog = Dialog.showMessage(lang("tip_title"), langF("tip_house_change_state", stateStr))

	dialog:setConfirmListener(function()
		LoadingFacade.instance:showLoading()
		DoTweenUtil.DelayedCall(0.5, function()
			if inExplore then
				self:_exitExploreMode()
			else
				self:_enterExploreMode()
			end
		end)
		DoTweenUtil.DelayedCall(1, function()
			LoadingFacade.instance:hideLoading()
		end)
	end, self)
end

function M:_onClickViewMode()
	printWarn("小屋主界面，点击观赏模式")

	local dialog = Dialog.showMessage(lang("tip_title"), lang("tip_view_all_warship_scene"))

	dialog:setConfirmListener(function()
		self:_enterViewMode()
	end, self)
end

function M:_onClickAtmosphere()
	self:setAtmosphereShow(not self._goAtmosphereTipsRoot.activeSelf)
end

function M:_onClickGain()
	local pointNum = self:getHarvestReportNum()

	if pointNum > 0 then
		ContainmentZoneAgent.instance:sendReceiveHouseRewardsRequest()
	end
end

function M:_onClickBackLog()
	local pointNum = self:getBackLogNum()

	if pointNum > 0 then
		ViewMgr.instance:open(ViewName.RoomBacklogView)
	end

	HouseModel.instance:setClickedBackLog(true)
end

function M:_onClickGoUpstairs()
	local nextStoreyTyp = self._ringType - 1

	nextStoreyTyp = nextStoreyTyp < 1 and 1 or nextStoreyTyp

	if nextStoreyTyp == self._ringType then
		return
	end

	self._ringType = nextStoreyTyp

	HouseModel.instance:setLastRingType(self._ringType)
	HouseDispatcher:dispatchEvent(HouseEventType.ON_SCENE_CHANGE_RING_TYPE, self._ringType)
	self:_updateCurStoreyShow()
end

function M:_onClickGoDownstairs()
	local nextStoreyTyp = self._ringType + 1
	local maxStorey = #HouseMainEnum.StoreyName

	nextStoreyTyp = maxStorey < nextStoreyTyp and maxStorey or nextStoreyTyp

	if nextStoreyTyp == self._ringType then
		return
	end

	self._ringType = nextStoreyTyp

	HouseModel.instance:setLastRingType(self._ringType)
	HouseDispatcher:dispatchEvent(HouseEventType.ON_SCENE_CHANGE_RING_TYPE, self._ringType)
	self:_updateCurStoreyShow()
end

function M:_onClickAtmoHint()
	ViewMgr.instance:open(ViewName.RoomMainAtmosValueTipView)
end

function M:_enterViewMode()
	HouseMainStateModel.instance:changeState(HouseMainEnum.State.ViewMode)
	self:_onViewModeHideUI(false)

	local houseCameraUnit = VirtualCameraMgr.instance:getActiveCamera()
	local cameraGo = houseCameraUnit:getMainGO()
	local houseCameraPos = houseCameraUnit:getPosition()
	local orgEulerX, orgEulerY, orgEulerZ = Astral.TransformUtil.GetLocalRotation(cameraGo.transform, 0, 0, 0)

	self._orgCameraInfo = {
		pos = houseCameraPos,
		fov = houseCameraUnit:getFieldOfView(),
		eulerX = orgEulerX,
		eulerY = orgEulerY,
		eulerZ = orgEulerZ
	}

	Astral.TransformUtil.SetLocalRotation(cameraGo.transform, 0, 0, 0)
	houseCameraUnit:setFieldOfView(153)
	houseCameraUnit:setPosition(0, 0, houseCameraPos.z)
end

function M:_exitViewMode()
	HouseMainStateModel.instance:changeState(HouseMainEnum.State.Normal)
	self:_onViewModeHideUI(true)

	local houseCameraUnit = VirtualCameraMgr.instance:getActiveCamera()
	local cameraGo = houseCameraUnit:getMainGO()

	Astral.TransformUtil.SetLocalRotation(cameraGo.transform, self._orgCameraInfo.eulerX, self._orgCameraInfo.eulerY, self._orgCameraInfo.eulerZ)
	houseCameraUnit:setFieldOfView(self._orgCameraInfo.fov)
	houseCameraUnit:setPosition(self._orgCameraInfo.pos.x, self._orgCameraInfo.pos.y, self._orgCameraInfo.pos.z)

	self._orgCameraInfo = nil
end

function M:_enterExploreMode()
	HouseMainStateModel.instance:changeState(HouseMainEnum.State.ExploreMode)
	self:_onViewModeHideUI(false)
	goutil.setActive(self._btnExplore.gameObject, true)

	local houseCameraUnit = VirtualCameraMgr.instance:getActiveCamera()
	local cameraGo = houseCameraUnit:getMainGO()
	local houseCameraPos = houseCameraUnit:getPosition()
	local orgEulerX, orgEulerY, orgEulerZ = Astral.TransformUtil.GetLocalRotation(cameraGo.transform, 0, 0, 0)

	self._orgCameraInfo = {
		pos = houseCameraPos,
		fov = houseCameraUnit:getFieldOfView(),
		eulerX = orgEulerX,
		eulerY = orgEulerY,
		eulerZ = orgEulerZ,
		ringType = self._ringType
	}

	goutil.setActive(self._goExploreModeMap, true)
	HouseDispatcher:dispatchEvent(HouseEventType.HOUSE_EXPLORE_MODE_ENTER, true)

	self._txtEnterState.text = lang("tip_house_build")
end

function M:_exitExploreMode()
	HouseDispatcher:dispatchEvent(HouseEventType.HOUSE_EXPLORE_MODE_ENTER, false)
	HouseMainStateModel.instance:changeState(HouseMainEnum.State.Normal)
	self:_onViewModeHideUI(true)

	local houseCameraUnit = VirtualCameraMgr.instance:getActiveCamera()
	local cameraGo = houseCameraUnit:getMainGO()

	Astral.TransformUtil.SetLocalRotation(cameraGo.transform, self._orgCameraInfo.eulerX, self._orgCameraInfo.eulerY, self._orgCameraInfo.eulerZ)
	houseCameraUnit:setFieldOfView(self._orgCameraInfo.fov)
	houseCameraUnit:setPosition(self._orgCameraInfo.pos.x, self._orgCameraInfo.pos.y, self._orgCameraInfo.pos.z)
	goutil.setActive(self._goExploreModeMap, false)
	HouseDispatcher:dispatchEvent(HouseEventType.ON_SCENE_CHANGE_RING_TYPE, self._orgCameraInfo.ringType)
	HouseDispatcher:dispatchEvent(HouseEventType.ON_SCENE_CAMERA_REFRESH, self._orgCameraInfo.ringType, self._orgCameraInfo.eulerZ)

	self._orgCameraInfo = nil
	self._txtEnterState.text = lang("tip_house_explore")
end

function M:handleOnAtmosphereChange()
	self:updateAtmosphereData()
end

function M:updateAtmosphereData()
	local atmospheres = LivingFacilitiesZoneModel.instance:getAtmospheres()

	if not self._atmospheres then
		self._atmospheres = {}
	end

	for key, AtmosphereNO in ipairs(atmospheres or {}) do
		local typ = AtmosphereNO.atmosphereType
		local val = AtmosphereNO.value

		self._atmospheres[typ] = val
	end

	self:reflashAtmosphereShow()
end

function M:getAtmosphereData(typ)
	return self._atmospheres[typ] or 0
end

function M:getAtmosphereTotalVal()
	return self:getAtmosphereData(HouseExtension_pb.Atmosphere.NORMAL)
end

function M:reflashAtmosphereShow()
	local totalAtmosphere = self:getAtmosphereTotalVal()
	local cfgAtmos = LivingFacilitiesConfig.instance:getConfigList(ConfigName.HouseAtmosphere)
	local atmosLv = 1
	local moodRecover = 0

	for key, value in ipairs(cfgAtmos or {}) do
		if totalAtmosphere >= value.rankNum then
			atmosLv = value.level
			moodRecover = value.moodRecover
		else
			break
		end
	end

	self._txtAtmosphere.text = totalAtmosphere
	self._txtAtmosphereInTips.text = totalAtmosphere
	self._txtAtmosphereLvInTips.text = string.format("Lv.%d", atmosLv)
	self._txtMood.text = self:_formatMoodVal(moodRecover * 60, 1)

	local root = self._rectTrAtmoDetailRoot
	local spAtmospheresCount = #HouseMainEnum.AtmosphereShowOrder

	while spAtmospheresCount > root.childCount do
		goutil.cloneAndSetParent(self._goAtmoDetailItem, root)
	end

	for i = 0, root.childCount - 1 do
		local show = i < spAtmospheresCount
		local tempGo = root:GetChild(i).gameObject

		if show then
			local typ = i + 2
			local typVal = self:getAtmosphereData(typ)
			local typLevel = HouseMainUtil.getSpAtmosphereLv(typ, typVal)
			local shower = Astral.LuaComponentContainer.Get(tempGo, RoomMainAtmosphereItemCell)

			if shower == nil then
				shower = Astral.LuaComponentContainer.Add(tempGo, RoomMainAtmosphereItemCell)

				shower:buildUI()
				shower:bindEvents()
				shower:onEnter()
				shower:setTyp(typ)
			end

			shower:setValue(typVal)
			shower:setLv(string.format("Lv.%d", typLevel))
		end

		goutil.setActive(tempGo, show)
	end
end

function M:_formatMoodVal(val, numDigits)
	local finalVal = val
	local _, _decimals = math.modf(val)

	if _decimals ~= 0 then
		numDigits = 10^numDigits
		finalVal = MathUtil.roundingBy456(val * numDigits)
		finalVal = finalVal ~= 0 and finalVal / numDigits or finalVal / numDigits
	end

	return finalVal
end

function M:_refreshMap()
	local mapRootGO = self:getGo("7&room_map_distribution_view_-900576721")
	local cfgZoneLst = HouseConfig.instance:getConfigList(ConfigName.HouseZone)

	for _, zoneCo in pairs(cfgZoneLst or {}) do
		local roomId = zoneCo.id
		local zoneType = NavMeshUtil.getZoneTypeByZoneId(roomId)

		if zoneType == HouseEnum.ZoneType.Room then
			local openTyp = HouseMainRoomModel.instance:getRoomOpenTyp(roomId)
			local activeGO = goutil.findChild(mapRootGO, string.format("room_%s/imgDistribution1", roomId))

			goutil.setActive(activeGO, openTyp == HouseMainEnum.RoomOpenTyp.OpenActive)
		end
	end
end

function M:setAtmosphereShow(show)
	goutil.setActive(self._goAtmosphereTipsRoot, show)
	goutil.setActive(self._btnAtmosphereEventBlocker.gameObject, show)
end

function M:getBackLogNum()
	return HouseMainRoomModel.instance:getBackLogNum()
end

function M:updateBackLogEntryShow()
	local pointNum = self:getBackLogNum()
	local show = pointNum > 0

	if show then
		pointNum = pointNum > 99 and 99 or pointNum
		self._txtBackLogNum.text = pointNum
	end

	goutil.setActive(self._btnBackLog.gameObject, show)
end

function M:getHarvestReportNum()
	return HouseMainRoomModel.instance:getCanGainReportNum()
end

function M:updateHarvestReportEntryShow()
	local pointNum = self:getHarvestReportNum()
	local show = pointNum > 0

	if show then
		pointNum = pointNum > 99 and 99 or pointNum
		self._txtGainNum.text = pointNum
	end

	goutil.setActive(self._btnGain.gameObject, show)
end

function M:updateBuildTaskNote()
	local orgTaskLst = HouseTaskModel.instance:getTaskLst()
	local show = #orgTaskLst > 0

	if show then
		table.sort(orgTaskLst, HouseTaskModel.sortAchievement)

		local showMo = orgTaskLst[1]

		show = showMo and not showMo:getIsFinish()

		if show then
			local desc = StringUtil.getShortName(showMo:getDesc(), 20, 20)
			local finishCnt = showMo:getFinishCnt()
			local maxCnt = showMo:getMaxCnt()

			self._txtBuildTaskName.text = string.format("%s(%s/%s)", desc, finishCnt, maxCnt)

			goutil.setActive(self._goBuildTaskMarkCanReward, showMo:canGetReward())
		end
	end

	goutil.setActive(self._goBuildTaskNoteRoot, show)
	goutil.setActive(self._goBuildTaskRedPoint, HouseTaskModel.instance:getTaskOrAchievenmentCanRewardCount() > 0)
end

function M:_onKeycodeChange(keycode, isOn)
	if keycode then
		if isOn then
			self._mousePos = {}
			self._lastDis = 0
			self._multiDragCount = 0

			removetimer(self._timerForKeyContinutePress, self)
			self:_timerForKeyContinutePress()
			goutil.setActive(self._goMousePointRoot, true)
			settimer(0.05, self._timerForKeyContinutePress, self, true)
		else
			removetimer(self._timerForKeyContinutePress, self)

			self._mousePos = {}
			self._lastDis = 0
			self._multiDragCount = 0

			goutil.setActive(self._goMousePointRoot, false)
		end
	end
end

function M:_timerForKeyContinutePress()
	local defaultDistance = 200
	local mousePos = MainPlayerInputFacade.instance:getScreenPosition()

	if not self._mousePos[1] then
		self._mousePos[1] = mousePos

		local targetX, targetY = RectTransformUtils.ScreenPointToLocalPointInRectangle(self._goMousePointRoot.transform, self._mousePos[1].x, self._mousePos[1].y, self._uiCamera, 0, 0)

		self._midPosX = targetX
		self._midPosY = targetY

		Astral.TransformUtil.SetAnchoredPos(self._rectMousePoint1, targetX, targetY + defaultDistance * 0.5)
		Astral.TransformUtil.SetAnchoredPos(self._rectMousePoint2, targetX, targetY - defaultDistance * 0.5)
	else
		if not self._mousePos[2] then
			if math.abs(mousePos.y - self._mousePos[1].y) <= 2 then
				return
			end

			self._scaleBig = mousePos.y > self._mousePos[1].y
		else
			if self._scaleBig and mousePos.y < self._mousePos[1].y then
				return
			end

			if not self._scaleBig and mousePos.y > self._mousePos[1].y then
				return
			end
		end

		self._mousePos[2] = mousePos
	end

	if self._mousePos and #self._mousePos >= 2 then
		local pos1X = math.floor(self._mousePos[1].x * 100) / 100
		local pos1Y = math.floor(self._mousePos[1].y * 100) / 100
		local pos2X = math.floor(self._mousePos[2].x * 100) / 100
		local pos2Y = math.floor(self._mousePos[2].y * 100) / 100
		local centerX = pos1X
		local centerY = pos1Y
		local delX = pos1X - pos2X
		local delY = pos1Y - pos2Y
		local distance = math.sqrt(delX * delX + delY * delY)

		distance = distance <= 100 and 100 or distance

		local scale = 1

		if self._lastDis > 0 then
			scale = self._scaleBig and distance / self._lastDis or self._lastDis / distance
		end

		if distance == self._lastDis then
			return
		end

		local isFirstMultiDrag = self._multiDragCount == 0

		self._multiDragCount = self._multiDragCount + 1
		self._lastDis = distance

		if pos1Y < pos2Y then
			local tY = self._midPosY + defaultDistance * 0.5 + distance * 0.5

			Astral.TransformUtil.SetAnchoredPos(self._rectMousePoint1, self._midPosX, tY)

			tY = self._midPosY - defaultDistance * 0.5 - distance * 0.5

			Astral.TransformUtil.SetAnchoredPos(self._rectMousePoint2, self._midPosX, self._midPosY - distance * 0.5)
		else
			local tY = self._midPosY + defaultDistance * 0.5 - distance * 0.5

			tY = tY < self._midPosY and self._midPosY or tY

			Astral.TransformUtil.SetAnchoredPos(self._rectMousePoint1, self._midPosX, tY)

			tY = self._midPosY - defaultDistance * 0.5 + distance * 0.5
			tY = tY > self._midPosY and self._midPosY or tY

			Astral.TransformUtil.SetAnchoredPos(self._rectMousePoint2, self._midPosX, tY)
		end

		GlobalDispatcher:dispatchEvent(EventType.ON_SCENE_PICKER_MULTI_DRAG, centerX, centerY, scale, distance, isFirstMultiDrag)
	end
end

function M:_updateRoomStatus(ringType, camContrastAngle)
	local needUpdate = false

	camContrastAngle = MathUtil.normalizeAngle(camContrastAngle)

	if self._lastCamAngleForUpdateRoomStatus then
		if math.abs(self._lastCamAngleForUpdateRoomStatus - camContrastAngle) >= 10 then
			needUpdate = true
		end
	else
		needUpdate = true
	end

	if not self._lastRingTypForUpdateRoomStatus then
		self._lastRingTypForUpdateRoomStatus = 0
	end

	if self._lastRingTypForUpdateRoomStatus ~= ringType then
		self._lastRingTypForUpdateRoomStatus = ringType
		needUpdate = true
	end

	if needUpdate then
		local cfgRoomId = -1

		self._lastCamAngleForUpdateRoomStatus = camContrastAngle

		local angleLst = HouseMainRoomModel.instance:getRoomAngleLst(ringType)

		for roomId, cfgAngle in pairs(angleLst or {}) do
			if camContrastAngle >= cfgAngle - 12 and camContrastAngle <= cfgAngle + 7 then
				cfgRoomId = roomId

				break
			end
		end

		if not self._lastRoomIdForUpdateRoomStatus then
			self._lastRoomIdForUpdateRoomStatus = 0
		end

		if cfgRoomId > 0 and self._lastRoomIdForUpdateRoomStatus ~= cfgRoomId then
			self._lastRoomIdForUpdateRoomStatus = cfgRoomId

			local state = HouseMainRoomModel.instance:getRoomOpenTyp(cfgRoomId)

			state = HouseMainEnum.RoomOpenTypStr[state] or ""
			self._txtRoomPassStatus.text = string.format("[%d] %s", cfgRoomId, state)
		end
	end
end

return M
