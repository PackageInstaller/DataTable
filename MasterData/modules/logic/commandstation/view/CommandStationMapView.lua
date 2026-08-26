-- chunkname: @modules/logic/commandstation/view/CommandStationMapView.lua

module("modules.logic.commandstation.view.CommandStationMapView", package.seeall)

local CommandStationMapView = class("CommandStationMapView", BaseView)

function CommandStationMapView:onInitView()
	self._gobg = gohelper.findChild(self.viewGO, "#go_bg")
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#go_bg/#simage_FullBG")
	self._goevents = gohelper.findChild(self.viewGO, "#go_bg/#go_events")
	self._goVersion = gohelper.findChild(self.viewGO, "#go_Version")
	self._btnEvent = gohelper.findChildButtonWithAudio(self.viewGO, "Event/#btn_Event")
	self._txtEvent = gohelper.findChildText(self.viewGO, "Event/#txt_Event")
	self._goarrow = gohelper.findChild(self.viewGO, "#go_arrow")
	self._btnleft = gohelper.findChildButtonWithAudio(self.viewGO, "#go_arrow/#btn_left")
	self._btnright = gohelper.findChildButtonWithAudio(self.viewGO, "#go_arrow/#btn_right")
	self._goTimeAxis = gohelper.findChild(self.viewGO, "#go_TimeAxis")
	self._scrolltimeline = gohelper.findChildScrollRect(self.viewGO, "#go_TimeAxis/go/timeline/#scroll_timeline")
	self._goViewport = gohelper.findChild(self.viewGO, "#go_TimeAxis/go/timeline/#scroll_timeline/#go_Viewport")
	self._gotimeGroup = gohelper.findChild(self.viewGO, "#go_TimeAxis/go/timeline/#scroll_timeline/#go_Viewport/#go_timeGroup")
	self._gotimeItem = gohelper.findChild(self.viewGO, "#go_TimeAxis/go/timeline/#scroll_timeline/#go_Viewport/#go_timeGroup/#go_timeItem")
	self._goScale = gohelper.findChild(self.viewGO, "#go_TimeAxis/go/timeline/#scroll_timeline/#go_Viewport/#go_timeGroup/#go_Scale")
	self._btnLocation = gohelper.findChildButtonWithAudio(self.viewGO, "#go_TimeAxis/go/timeline/#scroll_timeline/#go_Viewport/#go_timeGroup/#go_Scale/#btn_Location")
	self._gomask = gohelper.findChild(self.viewGO, "#go_TimeAxis/go/timeline/#go_mask")
	self._goleftViewport = gohelper.findChild(self.viewGO, "#go_TimeAxis/go/timeline/Sort/ScrollView/#go_leftViewport")
	self._goleftContent = gohelper.findChild(self.viewGO, "#go_TimeAxis/go/timeline/Sort/ScrollView/#go_leftViewport/#go_leftContent")
	self._goversionItem = gohelper.findChild(self.viewGO, "#go_TimeAxis/go/timeline/Sort/ScrollView/#go_leftViewport/#go_leftContent/#go_versionItem")
	self._gospine = gohelper.findChild(self.viewGO, "#go_TimeAxis/go/timeline/Sort/#go_spine")
	self._goani = gohelper.findChild(self.viewGO, "#go_TimeAxis/go/timeline/Sort/#go_spine/#go_ani")
	self._btnSort = gohelper.findChildButtonWithAudio(self.viewGO, "#go_TimeAxis/go/timeline/Sort/#btn_Sort")
	self._goSelected = gohelper.findChild(self.viewGO, "#go_TimeAxis/go/timeline/Sort/#btn_Sort/#go_Selected")
	self._goSelectedBG = gohelper.findChild(self.viewGO, "#go_TimeAxis/go/timeline/Sort/#btn_Sort/#go_Selected/#go_SelectedBG")
	self._goversionname = gohelper.findChild(self.viewGO, "#go_TimeAxis/go/timeline/Sort/#go_versionname")
	self._btnblockversion = gohelper.findChildButtonWithAudio(self.viewGO, "#go_TimeAxis/go/timeline/Sort/#go_versionname/#btn_blockversion")
	self._gonameViewport = gohelper.findChild(self.viewGO, "#go_TimeAxis/go/timeline/Sort/#go_versionname/#go_nameViewport")
	self._gonameContent = gohelper.findChild(self.viewGO, "#go_TimeAxis/go/timeline/Sort/#go_versionname/#go_nameViewport/#go_nameContent")
	self._gonameItem = gohelper.findChild(self.viewGO, "#go_TimeAxis/go/timeline/Sort/#go_versionname/#go_nameViewport/#go_nameContent/#go_nameItem")
	self._goarrowcontainer = gohelper.findChild(self.viewGO, "#go_arrowcontainer")
	self._btnLeftArrow = gohelper.findChildButtonWithAudio(self.viewGO, "#go_arrowcontainer/#btn_LeftArrow")
	self._btnRightArrow = gohelper.findChildButtonWithAudio(self.viewGO, "#go_arrowcontainer/#btn_RightArrow")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")
	self._goscene = gohelper.findChild(self.viewGO, "#go_scene")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CommandStationMapView:addEvents()
	self._btnEvent:AddClickListener(self._btnEventOnClick, self)
	self._btnleft:AddClickListener(self._btnleftOnClick, self)
	self._btnright:AddClickListener(self._btnrightOnClick, self)
	self._btnLocation:AddClickListener(self._btnLocationOnClick, self)
	self._btnSort:AddClickListener(self._btnSortOnClick, self)
	self._btnblockversion:AddClickListener(self._btnblockversionOnClick, self)
	self._btnLeftArrow:AddClickListener(self._btnLeftArrowOnClick, self)
	self._btnRightArrow:AddClickListener(self._btnRightArrowOnClick, self)
end

function CommandStationMapView:removeEvents()
	self._btnEvent:RemoveClickListener()
	self._btnleft:RemoveClickListener()
	self._btnright:RemoveClickListener()
	self._btnLocation:RemoveClickListener()
	self._btnSort:RemoveClickListener()
	self._btnblockversion:RemoveClickListener()
	self._btnLeftArrow:RemoveClickListener()
	self._btnRightArrow:RemoveClickListener()
end

function CommandStationMapView:_btnleftOnClick()
	local prevId, nextId = self:_getNavBtnInfo()

	self:_selectedTimePoint(prevId)
end

function CommandStationMapView:_btnrightOnClick()
	local prevId, nextId = self:_getNavBtnInfo()

	self:_selectedTimePoint(nextId)
end

function CommandStationMapView:_updateNavBtnStatus()
	local prevId, nextId = self:_getNavBtnInfo()

	gohelper.setActive(self._btnleft, prevId ~= nil)
	gohelper.setActive(self._btnright, nextId ~= nil)
end

function CommandStationMapView:_getNavBtnInfo()
	local prevId, nextId

	for i, v in ipairs(self._timeline) do
		local index = tabletool.indexOf(v.timeId, self._timeId)

		if index then
			local prevConfig = self._timeline[i - 1]
			local nextConfig = self._timeline[i + 1]

			prevId = v.timeId[index - 1] or prevConfig and prevConfig.timeId[#prevConfig.timeId]
			nextId = v.timeId[index + 1] or nextConfig and nextConfig.timeId[1]

			break
		end
	end

	return prevId, nextId
end

function CommandStationMapView:_btnLeftArrowOnClick()
	local mapEventView = self.viewContainer:getMapEventView()

	mapEventView:FocuseLeftEvent()
end

function CommandStationMapView:_btnRightArrowOnClick()
	local mapEventView = self.viewContainer:getMapEventView()

	mapEventView:FocuseRightEvent()
end

function CommandStationMapView:_btnblockversionOnClick()
	self._sortAnimator:Play("unselect", self._hideVersionDone, self)
	CommandStationController.instance:dispatchEvent(CommandStationEvent.HideVersionSelectView)
	self:_openTimelineAnim()
	self:_selectedTimePoint(self._timeId, CommandStationEnum.TimelineOpenTime)

	if self._uiSpine then
		self._uiSpine:play("gear_pop")
	end
end

function CommandStationMapView:_hideVersionDone()
	gohelper.setActive(self._goSelected, false)
	gohelper.setActive(self._goversionname, false)
end

function CommandStationMapView:_btnSortOnClick()
	CommandStationController.StatCommandStationButtonClick(self.viewName, string.format("btnSortOnClick_"))

	if CommandStationMapModel.instance:isTimelineCharacterMode() then
		return
	end

	if self._uiSpine then
		self._uiSpine:play("axle_press")
	end

	gohelper.setActive(self._goSelected, true)
	gohelper.setActive(self._goversionname, true)
	self._sortAnimator:Play("select", self._showVersionDone, self)
	self:_tweenMove(nil, CommandStationEnum.BuoyMoveTime, 0, self._moveToInit)
end

function CommandStationMapView:_showVersionDone()
	return
end

function CommandStationMapView:_moveToInit()
	self:_closeTimelineAnim()
end

function CommandStationMapView:_btnEventOnClick()
	AudioMgr.instance:trigger(AudioEnum3_0.CommandStationMap.play_ui_lushang_zhihuibu_switch)

	local category = CommandStationMapModel.instance:getEventCategory()

	if category == CommandStationEnum.EventCategory.Normal then
		CommandStationMapModel.instance:setEventCategory(CommandStationEnum.EventCategory.Character)
	else
		CommandStationMapModel.instance:setEventCategory(CommandStationEnum.EventCategory.Normal)
	end

	CommandStationController.StatCommandStationButtonClick(self.viewName, "btnEventOnClick_" .. CommandStationMapModel.instance:getEventCategory(), category)
	self:_updateEventCategory()
	CommandStationController.instance:dispatchEvent(CommandStationEvent.ChangeEventCategory)
	self._eventAnimator:Play("light", 0, 0)
end

function CommandStationMapView:_btnLocationOnClick()
	local timeId = CommandStationMapModel.instance:getTimeId()

	CommandStationController.instance:openCommandStationDetailView({
		timeId = timeId
	})

	if CommandStationMapModel.instance:isTimelineCharacterMode() then
		local characterId = CommandStationMapModel.instance:getCharacterId()

		CommandStationController.StatCommandStationButtonClick(self.viewName, string.format("btnLocationOnClick_%s_%s", characterId, timeId))
	else
		local versionId = CommandStationMapModel.instance:getVersionId()

		CommandStationController.StatCommandStationButtonClick(self.viewName, string.format("btnLocationOnClick_%s_%s", versionId, timeId))
	end
end

function CommandStationMapView:_editableInitView()
	self._initArrowY = recthelper.getAnchorY(self._goarrow.transform)

	gohelper.setActive(self._goarrow, false)
	gohelper.setActive(self._btnEvent.transform.parent, false)

	self._viewOpenTime = Time.realtimeSinceStartup
	self._goversion = gohelper.findChild(self.viewGO, "Version")
	self._goevent = gohelper.findChild(self.viewGO, "Event")
	self._gosort = gohelper.findChild(self.viewGO, "#go_TimeAxis/go/timeline/Sort")
	self._sortAnimator = SLFramework.AnimatorPlayer.Get(self._gosort)
	self._versionAnimator = SLFramework.AnimatorPlayer.Get(self._goversion)

	gohelper.setActive(self._goSelected, false)
	gohelper.setActive(self._goversionname, false)
	gohelper.setActive(self._btnLeftArrow, false)
	gohelper.setActive(self._btnRightArrow, false)

	self._animator = self.viewGO:GetComponent("Animator")
	self._eventAnimator = self._goevent:GetComponent("Animator")

	CommandStationMapModel.instance:setEventCategory(CommandStationEnum.EventCategory.Normal)
	self:_updateEventCategory()
	self:_initShowRT()
end

function CommandStationMapView:_initShowRT()
	self._rtGo = gohelper.findChild(self.viewGO, "rt")

	gohelper.setActive(self._rtGo, true)
end

function CommandStationMapView:_initSceneRoot()
	local sceneConfig = CommandStationMapModel.instance:getCurTimeIdScene()

	if not sceneConfig then
		return
	end

	self._sceneConfig = sceneConfig

	local url = sceneConfig.scene_ui
	local loader = PrefabInstantiate.Create(self._goscene)

	loader:startLoad(url, self._loadSceneUIFinished, self)
end

function CommandStationMapView:_loadSceneUIFinished(loader)
	self._sceneInstanceGo = loader:getInstGO()
	self._sceneRoot = gohelper.findChild(self._sceneInstanceGo, "root")

	local fov = CommandStationMapSceneView.getFov(CommandStationEnum.CameraFov)
	local go1 = gohelper.findChild(self._sceneRoot, "ground_01")
	local go1Renderer = go1:GetComponent(typeof(UnityEngine.MeshRenderer))

	go1Renderer.sharedMaterial:SetFloat("_Fov", fov)

	local go2 = gohelper.findChild(self._sceneRoot, "ground_02")
	local go2Renderer = go2:GetComponent(typeof(UnityEngine.MeshRenderer))

	go2Renderer.sharedMaterial:SetFloat("_Fov", fov)
	TaskDispatcher.cancelTask(self._updateScene, self)
	TaskDispatcher.runRepeat(self._updateScene, self, 0)
end

function CommandStationMapView:_updateScene()
	local sceneGo = self.viewContainer:getSceneGo()

	if not sceneGo then
		return
	end

	local sceneGround = gohelper.findChild(sceneGo, self._sceneConfig.scene_node)

	if not sceneGround then
		return
	end

	local mainCameraTrans = CameraMgr.instance:getMainCameraTrs()

	self._sceneRoot.transform.localPosition = mainCameraTrans:InverseTransformPoint(sceneGround.transform.position)

	transformhelper.setLocalRotation(self._sceneRoot.transform, CommandStationEnum.CameraRotaionMax - CommandStationEnum.CameraRotation, 0, 0)
end

function CommandStationMapView:_hideSceneRoot()
	TaskDispatcher.cancelTask(self._updateScene, self)
	gohelper.setActive(self._sceneInstanceGo, false)
end

function CommandStationMapView:_updateEventCategory()
	local category = CommandStationMapModel.instance:getEventCategory()

	self._txtEvent.text = category == CommandStationEnum.EventCategory.Normal and luaLang("commandstation_map_event") or luaLang("commandstation_map_character")
end

function CommandStationMapView:_onSpineLoaded()
	if self._uiSpine then
		self._uiSpine:play("gear_pop")

		local go = self._uiSpine._spineGo

		recthelper.setAnchor(go.transform, 2, -220)
		transformhelper.setLocalScale(go.transform, 0.51, 0.51, 1)

		local spineSkeletonAnim = self._uiSpine:getSkeletonGraphic()

		spineSkeletonAnim.timeScale = 6
	end
end

function CommandStationMapView:onOpen()
	self._uiSpine = GuiSpine.Create(self._goani, true)

	local spineName = "command_post"
	local resPath = ResUrl.getRolesCgStory(spineName, "v3a0_command_post")

	self._uiSpine:setResPath(resPath, self._onSpineLoaded, self)
	self:_initTimeline()
	gohelper.setActive(self._gotimeGroup, false)
	self:_setDungeonMapViewVisible(false)

	self._drag = SLFramework.UGUI.UIDragListener.Get(self._scrolltimeline.gameObject)

	self._drag:AddDragBeginListener(self._onDragBeginHandler, self)
	self._drag:AddDragEndListener(self._onDragEndHandler, self)
	TaskDispatcher.runRepeat(self._delayCheckLocationOverLap, self, 0)
	self:_onScreenResize()
	self.addEventCb(self, CommandStationController.instance, CommandStationEvent.ChangeVersionId, self._onChangeVersionId, self)
	self.addEventCb(self, CommandStationController.instance, CommandStationEvent.MoveTimeline, self._onMoveTimeline, self)
	self.addEventCb(self, CommandStationController.instance, CommandStationEvent.TimelineAnimDone, self._onTimelineAnimDone, self)
	self.addEventCb(self, CommandStationController.instance, CommandStationEvent.MoveScene, self._onMoveScene, self)
	self.addEventCb(self, CommandStationController.instance, CommandStationEvent.EventReadChange, self._onEventReadChange, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._OnCloseViewFinish, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseFullView, self._OnCloseFullView, self, LuaEventSystem.Low)
	self.addEventCb(self, PostProcessingMgr.instance, PostProcessingEvent.onRefreshPopUpBlurNotBlur, self._OnRefreshPopUpBlurNotBlur, self, LuaEventSystem.Low)
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenResize, self)
	self.addEventCb(self, CommandStationController.instance, CommandStationEvent.AfterEventFinish, self._onAfterEventFinish, self)
end

function CommandStationMapView:_onAfterEventFinish()
	if not self._lockTimeIdList or #self._lockTimeIdList == 0 then
		return
	end

	for i, timeId in ipairs(self._lockTimeIdList) do
		if CommandStationMapModel.instance:checkTimeIdUnlock(timeId) then
			self:_initTimeline()
			self:_updateNavBtnStatus()

			return
		end
	end
end

function CommandStationMapView:_onScreenResize()
	local width = recthelper.getWidth(self._goarrowcontainer.transform)
	local height = recthelper.getHeight(self._goarrowcontainer.transform)
	local arrowWidth = recthelper.getWidth(self._btnRightArrow.transform)

	self._minX = -width / 2 + arrowWidth / 2 + 100
	self._maxX = width / 2 - arrowWidth / 2
	self._minY = -height / 2 + 440
	self._maxY = height / 2 + 440
end

function CommandStationMapView:_onMoveScene(isTween)
	TaskDispatcher.cancelTask(self._checkShowArrow, self)

	if isTween then
		TaskDispatcher.runRepeat(self._checkShowArrow, self, 0, 20)

		return
	end

	self:_checkShowArrow()
end

function CommandStationMapView:_checkShowArrow()
	if self._hideAllArrow then
		gohelper.setActive(self._btnLeftArrow, false)
		gohelper.setActive(self._btnRightArrow, false)

		return
	end

	local mapEventView = self.viewContainer:getMapEventView()
	local leftEvent, rightEvent = mapEventView:checkEventsDir()

	gohelper.setActive(self._btnLeftArrow, leftEvent ~= nil)
	gohelper.setActive(self._btnRightArrow, rightEvent ~= nil)

	if leftEvent then
		self:_faceToEvent(self._btnLeftArrow, leftEvent)
	end

	if rightEvent then
		self:_faceToEvent(self._btnRightArrow, rightEvent)
	end
end

function CommandStationMapView:_onEventReadChange(eventId)
	self:_updateTimeIdRedPoint(self._timeId)

	local unlockEventId = CommandStationConfig.instance:getActivatedEventId(eventId)

	if unlockEventId then
		::label_30_0::

		local timeId = CommandStationConfig.instance:getTimeIdByEventId(unlockEventId)

		if timeId and timeId ~= self._timeId then
			self:_updateTimeIdRedPoint(timeId)
		end
	end
end

function CommandStationMapView:_updateTimeIdRedPoint(timeId)
	local redPoint = self._timeIdRedPointMap[timeId]

	if redPoint then
		local canRead = CommandStationModel.instance:getTimeIdCanRead(timeId)

		gohelper.setActive(redPoint, canRead)
	end
end

function CommandStationMapView:_faceToEvent(arrow, event)
	local eventPosX, eventPosY = recthelper.getAnchor(event.viewGO.transform)
	local arrowPosX, arrowPosY = recthelper.getAnchor(arrow.transform)
	local x = arrowPosX - eventPosX
	local y = arrowPosY - eventPosY
	local angle = Mathf.Atan2(y, x) * Mathf.Rad2Deg

	transformhelper.setLocalRotation(arrow.transform, 0, 0, angle)

	local posX = eventPosX
	local posY = eventPosY

	posX = Mathf.Clamp(posX, self._minX, self._maxX)
	posY = Mathf.Clamp(posY, self._minY, self._maxY)

	recthelper.setAnchor(arrow.transform, posX, posY)
end

function CommandStationMapView:_setArrowVisible(visible)
	self._hideAllArrow = not visible

	self:_checkShowArrow()
end

function CommandStationMapView:_OnRefreshPopUpBlurNotBlur()
	local container = ViewMgr.instance:getContainer(ViewName.FullScreenVideoView)

	if container and not gohelper.isNil(container.viewGO) then
		gohelper.setAsLastSibling(self.viewGO)

		return
	end

	self.removeEventCb(self, PostProcessingMgr.instance, PostProcessingEvent.onRefreshPopUpBlurNotBlur, self._OnRefreshPopUpBlurNotBlur, self)
end

function CommandStationMapView:_OnCloseViewFinish(viewName)
	if viewName == self.viewName then
		self:_setDungeonMapViewVisible(true)
	end
end

function CommandStationMapView:_OnCloseFullView(viewName)
	if viewName == self.viewName then
		self:_setDungeonMapViewVisible(false)
	end
end

function CommandStationMapView:_setDungeonMapViewVisible(value)
	local dungeonContainer = ViewMgr.instance:getContainer(ViewName.DungeonMapView)

	if dungeonContainer then
		dungeonContainer:setVisibleInternal(value)
	end
end

function CommandStationMapView:_delayCheckLocationOverLap()
	if self._locationDragMove then
		gohelper.setActive(self._goarrow, false)

		return
	end

	gohelper.setActive(self._goarrow, true)

	if self._locationClickMove then
		return
	end

	recthelper.setAnchorY(self._goarrow.transform, self._initArrowY + (self:_checkLocationOverLap() and 100 or 0))
end

function CommandStationMapView:_checkLocationOverLap()
	local x, y = recthelper.rectToRelativeAnchorPos2(self._btnLocation.transform.position, self._goarrow.transform)
	local leftX = recthelper.getAnchorX(self._btnleft.transform)
	local rightX = recthelper.getAnchorX(self._btnright.transform)
	local distance = 80

	return distance > math.abs(x - leftX) or distance > math.abs(x - rightX)
end

function CommandStationMapView:_onDragBeginHandler()
	if self._uiSpine then
		self._uiSpine:play("gear_loop", true)
	end

	self._locationDragMove = true
end

function CommandStationMapView:_onDragEndHandler()
	if self._uiSpine then
		self._uiSpine:play("gear_stop")
	end

	self._locationDragMove = false
end

function CommandStationMapView:_onTimelineAnimDone(isOpenAnim)
	if isOpenAnim then
		self:_setItemGapWidth(1, 0)
	end
end

function CommandStationMapView:onOpenFinish()
	self._isOpenFinished = true

	self:_selectedTimePoint(CommandStationMapModel.instance:getTimeId(), CommandStationEnum.TimelineOpenTime)
	self:_openTimelineAnim()
	self:_hideSceneRoot()
	TaskDispatcher.cancelTask(self._hideRT, self)
	TaskDispatcher.runDelay(self._hideRT, self, 0.5)
end

function CommandStationMapView:_hideRT()
	gohelper.setActive(self._rtGo, false)
	CommandStationController.instance:dispatchEvent(CommandStationEvent.RTGoHide)
end

function CommandStationMapView:onUpdateParam()
	self._timeId = CommandStationMapModel.instance:getTimeId()

	self:_changeTimeline()
end

function CommandStationMapView:_onMoveTimeline(param)
	local node = param and param.node

	if gohelper.isNil(node) then
		gohelper.addChild(self.viewGO, self._goTimeAxis)
		gohelper.setSiblingAfter(self._golefttop, self._goTimeAxis)
		gohelper.addChild(self.viewGO, self._goarrow)
		gohelper.setSiblingBefore(self._goarrowcontainer, self._goarrow)

		self._animator.enabled = true

		self._animator:Play("timelinein")
		gohelper.setActive(self._btnSort, true)
	else
		gohelper.addChild(node, self._goTimeAxis)
		gohelper.addChild(node, self._goarrow)
		gohelper.setAsLastSibling(param.leftopNode)

		self._animator.enabled = true

		self._animator:Play("timelinein")
		gohelper.setActive(self._btnSort, false)
		AudioMgr.instance:trigger(AudioEnum3_0.CommandStationMap.play_ui_lushang_zhihuibu_timeline3)
	end

	self:_changeTimeline()
	self:_selectedTimePoint(CommandStationMapModel.instance:getTimeId())
end

function CommandStationMapView:_changeTimelinePosView(viewName)
	return viewName == ViewName.CommandStationTimelineEventView
end

function CommandStationMapView:_onChildViewOpen(animName)
	self._animator.enabled = true

	self._animator:Play(animName)
	self:_setArrowVisible(false)
	self.viewContainer:showHelp(false)
end

function CommandStationMapView:_onOpenView(viewName)
	if self:_changeTimelinePosView(viewName) then
		self:_onChildViewOpen("eventin")

		return
	end

	if viewName == ViewName.CommandStationDialogueEventView then
		self:_onChildViewOpen("uiout")

		return
	end

	if viewName == ViewName.CommandStationDispatchEventMainView then
		self:_onChildViewOpen("dispatchin")

		return
	end

	if viewName == ViewName.CommandStationCharacterEventView then
		self:_onChildViewOpen("timelineout")

		return
	end
end

function CommandStationMapView:_onChildViewClose(animName)
	self._animator.enabled = true

	self._animator:Play(animName)
	CommandStationController.instance:dispatchEvent(CommandStationEvent.CancelSelectedEvent)
	self:_setArrowVisible(true)
	self.viewContainer:showHelp(true)
end

function CommandStationMapView:_onCloseView(viewName)
	if self:_changeTimelinePosView(viewName) then
		self:_onChildViewClose("eventout")
		AudioMgr.instance:trigger(AudioEnum3_0.CommandStationMap.play_ui_lushang_zhihuibu_timeline3)

		return
	end

	if viewName == ViewName.CommandStationDialogueEventView then
		self:_onChildViewClose("uiin")
		AudioMgr.instance:trigger(AudioEnum3_0.CommandStationMap.play_ui_lushang_zhihuibu_timeline3)

		return
	end

	if viewName == ViewName.CommandStationDispatchEventMainView then
		self:_onChildViewClose("dispatchout")
		AudioMgr.instance:trigger(AudioEnum3_0.CommandStationMap.play_ui_lushang_zhihuibu_timeline3)

		return
	end

	if viewName == ViewName.CommandStationCharacterEventView then
		self:_onChildViewClose("timelinein")
		AudioMgr.instance:trigger(AudioEnum3_0.CommandStationMap.play_ui_lushang_zhihuibu_timeline3)

		return
	end
end

function CommandStationMapView:_openTimelineAnim(delay)
	local posX = self:_getTimePointPos(self._timeId, true)
	local viewportWidth = recthelper.getWidth(self._goViewport.transform)
	local offsetX = self._timeGroupWidth - posX
	local contentPosX = math.min(0, viewportWidth - self._timeGroupWidth + offsetX)

	self:_setItemGapWidth(1, CommandStationEnum.TimeItemWidth * 2)
	self.viewContainer:getTimelineAnimView():openTimelineAnim(self._itemPosMap, contentPosX, self._timeGroupWidth, delay)
end

function CommandStationMapView:_closeTimelineAnim()
	self.viewContainer:getTimelineAnimView():closeTimelineAnim(self._itemPosMap, self._timeGroupWidth)
end

function CommandStationMapView:_onChangeVersionId(versionId)
	self._timeId = CommandStationMapModel.instance:getTimeId()

	self:_changeTimeline()
	self._sortAnimator:Play("unselect", self._hideVersionDone, self)

	if self._uiSpine then
		self._uiSpine:play("gear_pop")
	end
end

function CommandStationMapView:_changeTimeline()
	self:_initTimeline()
	self:_openTimelineAnim()
	self:_selectedTimePoint(self._timeId, CommandStationEnum.TimelineOpenTime)
end

function CommandStationMapView:_initTimeline()
	self._clickImageParam = self._clickImageParam or self:getUserDataTb_()

	gohelper.addChild(nil, self._goScale)
	self:_initTimelineData()

	self._itemPosX = 0
	self._itemPosMap = self._itemPosMap or {}
	self._timeIdRedPointMap = self._timeIdRedPointMap or self:getUserDataTb_()

	tabletool.clear(self._timeIdRedPointMap)
	self:_clearItemPosMap()
	gohelper.CreateObjList(self, self._onTimeItemShow, self._timeline, self._gotimeGroup, self._gotimeItem)

	self._timeGroupWidth = self._itemPosX

	recthelper.setWidth(self._gotimeGroup.transform, self._timeGroupWidth)
	gohelper.addChild(self._gotimeGroup, self._goScale)

	for i, v in ipairs(self._itemPosMap) do
		gohelper.setAsFirstSibling(v.go)
	end
end

function CommandStationMapView:_clearItemPosMap()
	for k, v in pairs(self._itemPosMap) do
		if v.tweenId then
			ZProj.TweenHelper.KillById(v.tweenId)
		end

		self._itemPosMap[k] = nil
	end
end

function CommandStationMapView:_initTimelineData()
	local versionId = CommandStationMapModel.instance:getVersionId()
	local characterId = CommandStationMapModel.instance:getCharacterId()

	if characterId then
		local list = CommandStationConfig.instance:getTimeGroupByCharacterId(characterId)

		list = CommandStationMapModel.instance:checkTimelineByCharacterId(list, characterId, versionId)
		self._timeline, self._firstTimeId, self._lockTimeIdList = CommandStationMapModel.instance:checkTimeline(list)

		return
	end

	self._timeline, self._firstTimeId, self._lockTimeIdList = CommandStationMapModel.instance:getVersionTimeline(versionId)

	CommandStationController.StatCommandStationButtonClick(self.viewName, string.format("getVersionTimeLine_%s", versionId))
end

function CommandStationMapView:_onTimeItemShow(obj, data, index)
	local image = gohelper.findChild(obj, "image")
	local gap = gohelper.findChild(obj, "gap")
	local showGap = true

	gohelper.setActive(gap, showGap)

	local dateTxt = gohelper.findChildText(obj, "image/txt_Date")

	if dateTxt then
		dateTxt.text = CommandStationConfig.instance:getTimePointName(data.id)
	end

	local width = CommandStationEnum.TimeItemWidth * (#data.timeId + 1)

	recthelper.setWidth(image.transform, width)

	self._itemPosMap[index] = {
		posX = self._itemPosX,
		go = obj,
		gap = gap
	}

	recthelper.setAnchorX(obj.transform, self._itemPosX)

	if showGap then
		if index == 1 then
			if not (CommandStationEnum.TimeItemWidth * 20) then
				local gapWidth = math.min(self._itemPosX, CommandStationEnum.TimeItemWidth * 8)

				recthelper.setWidth(gap.transform, gapWidth)
			end
		end
	end

	self._itemPosX = self._itemPosX + width + CommandStationEnum.TimeItemSpace

	self:_addImageClick(image, data, index)

	local point = gohelper.findChild(obj, "image/point")
	local pointImage = gohelper.findChild(obj, "image/point/image")

	gohelper.CreateObjList(self, self._onTimePointItemShow, data.timeId, point, pointImage)
end

function CommandStationMapView:_onTimePointItemShow(obj, data, index)
	recthelper.setAnchorX(obj.transform, 120 + (index - 1) * CommandStationEnum.TimeItemWidth)

	local redpoint = gohelper.findChild(obj, "redpoint")
	local canRead = CommandStationModel.instance:getTimeIdCanRead(data)

	gohelper.setActive(redpoint, canRead)

	self._timeIdRedPointMap[data] = redpoint
end

function CommandStationMapView:_setItemGapWidth(index, width)
	return
end

function CommandStationMapView:_addImageClick(image, data, index)
	local item = self._clickImageParam[image]

	if not item then
		local clickListener = SLFramework.UGUI.UIClickListener.Get(image)

		item = {
			clickListener = clickListener
		}
		self._clickImageParam[image] = item

		clickListener:AddClickListener(self._onClickImage, self, image)
	end

	item.data = data
	item.index = index
end

function CommandStationMapView:_onClickImage(image, pos, delta)
	local param = self._clickImageParam[image]
	local anchorPos = recthelper.screenPosToAnchorPos(pos, image.transform)
	local posX = anchorPos.x
	local index

	for i = 1, #param.data.timeId do
		local width = CommandStationEnum.TimeItemWidth * i

		if posX >= width - CommandStationEnum.ClickOffset and posX <= width + CommandStationEnum.ClickOffset then
			index = i

			break
		end
	end

	if not index then
		return
	end

	local timeId = param.data.timeId[index]

	self:_selectedTimePoint(timeId)

	if CommandStationMapModel.instance:isTimelineCharacterMode() then
		local characterId = CommandStationMapModel.instance:getCharacterId()

		CommandStationController.StatCommandStationButtonClick(self.viewName, string.format("selectedTimePoint_%s_%s", characterId, timeId))
	else
		local versionId = CommandStationMapModel.instance:getVersionId()

		CommandStationController.StatCommandStationButtonClick(self.viewName, string.format("selectedTimePoint_%s_%s", versionId, timeId))
	end
end

function CommandStationMapView:_selectedTimePoint(timeId, time)
	if not timeId then
		logError("timeId is nil")

		return
	end

	self._timeId = timeId

	self:_updateNavBtnStatus()

	self._locationClickMove = true

	AudioMgr.instance:trigger(AudioEnum3_0.CommandStationMap.play_ui_lushang_zhihuibu_zhizhen1)

	local posX = self:_getTimePointPos(timeId)

	self:_tweenMove(timeId, time or CommandStationEnum.BuoyMoveTime, posX, self._moveDone)

	local viewportWidth = recthelper.getWidth(self._goViewport.transform)
	local scrollPosX = recthelper.getAnchorX(self._gotimeGroup.transform)
	local minX = math.abs(scrollPosX)
	local max = minX + viewportWidth

	if posX < minX then
		recthelper.setAnchorX(self._gotimeGroup.transform, scrollPosX + minX - posX + CommandStationEnum.TimeItemWidth)
	elseif max < posX then
		recthelper.setAnchorX(self._gotimeGroup.transform, scrollPosX + max - posX - CommandStationEnum.TimeItemWidth)
	end
end

function CommandStationMapView:_moveDone(timeId)
	self._locationClickMove = false

	CommandStationController.instance:dispatchEvent(CommandStationEvent.SelectTimePoint, timeId)
	AudioMgr.instance:trigger(AudioEnum3_0.CommandStationMap.stop_ui_lushang_zhihuibu_zhizhen2)
end

function CommandStationMapView:_tweenMove(param, time, posX, callback)
	UIBlockHelper.instance:startBlock("CommandStationMapView:_tweenMove", time)
	self:_killTween()

	self._moveTweenId = CommandStationController.CustomOutBack(self._goScale.transform, time, posX, CommandStationEnum.TimeItemWidth / 2, callback, self, param)
end

function CommandStationMapView:_killTween()
	if self._moveTweenId then
		ZProj.TweenHelper.KillById(self._moveTweenId)

		self._moveTweenId = nil
	end
end

function CommandStationMapView:_getTimePointPos(timeId, allGroupWidth)
	local posX = 0

	for i, v in ipairs(self._timeline) do
		local index = tabletool.indexOf(v.timeId, timeId)
		local width = CommandStationEnum.TimeItemWidth * (#v.timeId + 1) + CommandStationEnum.TimeItemSpace

		if not index then
			posX = posX + width
		else
			if allGroupWidth then
				posX = posX + width

				break
			end

			posX = posX + CommandStationEnum.TimeItemWidth * index

			break
		end
	end

	return posX
end

function CommandStationMapView:onClose()
	TaskDispatcher.cancelTask(self._updateScene, self)
	TaskDispatcher.cancelTask(self._checkShowArrow, self)
	TaskDispatcher.cancelTask(self._hideRT, self)
	TaskDispatcher.cancelTask(self._delayCheckLocationOverLap, self)

	if self._clickImageParam then
		for i, v in pairs(self._clickImageParam) do
			v.clickListener:RemoveClickListener()
		end
	end

	if self._drag then
		self._drag:RemoveDragBeginListener()
		self._drag:RemoveDragEndListener()
	end

	self:_killTween()
	self:_clearItemPosMap()
	CommandStationController.StatCommandStationViewClose(self.viewName, Time.realtimeSinceStartup - self._viewOpenTime)
	AudioMgr.instance:trigger(AudioEnum3_0.CommandStationMap.play_ui_lushang_zhihuibu_fanhui)
end

function CommandStationMapView:onDestroyView()
	return
end

return CommandStationMapView
