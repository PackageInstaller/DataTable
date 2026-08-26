-- chunkname: @modules/logic/commandstation/view/CommandStationEnterView.lua

module("modules.logic.commandstation.view.CommandStationEnterView", package.seeall)

local CommandStationEnterView = class("CommandStationEnterView", BaseView)

function CommandStationEnterView:onInitView()
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._btnmap = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_map")
	self._btnreward = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_reward")
	self._btntask = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_task")
	self._btnactivity = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_activity")
	self._btnrelationshipboard = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_relationshipboard")
	self._btnplot = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_plot")
	self._txtName = gohelper.findChildText(self.viewGO, "#btn_plot/#txt_Name")
	self._txtNum = gohelper.findChildText(self.viewGO, "#btn_plot/#txt_Name/#txt_Num")
	self._btnwuxiandian = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_wuxiandian")
	self._btnbox = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_box")
	self._imagebox = gohelper.findChildImage(self.viewGO, "#btn_box/#ani/#image_box")
	self._gobottom = gohelper.findChild(self.viewGO, "#go_bottom")
	self._gocontentbg = gohelper.findChild(self.viewGO, "#go_bottom/#go_contentbg")
	self._txtanacn = gohelper.findChildText(self.viewGO, "#go_bottom/#txt_ana_cn")
	self._txtanaen = gohelper.findChildText(self.viewGO, "#go_bottom/#txt_ana_en")
	self._gomap = gohelper.findChild(self.viewGO, "#go_map")
	self._txtmapname = gohelper.findChildText(self.viewGO, "#go_map/line/#txt_mapname")
	self._txtmapnameen = gohelper.findChildText(self.viewGO, "#go_map/#txt_mapnameen")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CommandStationEnterView:addEvents()
	self._btnmap:AddClickListener(self._btnmapOnClick, self)
	self._btnreward:AddClickListener(self._btnrewardOnClick, self)
	self._btntask:AddClickListener(self._btntaskOnClick, self)
	self._btnactivity:AddClickListener(self._btnactivityOnClick, self)
	self._btnrelationshipboard:AddClickListener(self._btnrelationshipboardOnClick, self)
	self._btnplot:AddClickListener(self._btnplotOnClick, self)
	self._btnwuxiandian:AddClickListener(self._btnwuxiandianOnClick, self)
	self._btnbox:AddClickListener(self._btnboxOnClick, self)
end

function CommandStationEnterView:removeEvents()
	self._btnmap:RemoveClickListener()
	self._btnreward:RemoveClickListener()
	self._btntask:RemoveClickListener()
	self._btnactivity:RemoveClickListener()
	self._btnrelationshipboard:RemoveClickListener()
	self._btnplot:RemoveClickListener()
	self._btnwuxiandian:RemoveClickListener()
	self._btnbox:RemoveClickListener()
end

function CommandStationEnterView:_btnrelationshipboardOnClick()
	CommandStationController.instance:openCommandStationRelationShipBoard()
end

function CommandStationEnterView:_btnrewardOnClick()
	CommandStationController.instance:openCommandStationTaskView()
end

function CommandStationEnterView:_btnboxOnClick()
	self._openBox = not self._openBox

	self:_updateBoxAnim()
end

function CommandStationEnterView:_btnplotOnClick()
	JumpController.instance:jumpTo("4#" .. tostring(self._showEpisodeId))
	CommandStationController.StatCommandStationButtonClick(self.viewName, "_btnplotOnClick")
end

function CommandStationEnterView:_btnwuxiandianOnClick()
	local textId = CommandStationConfig.instance:getRandomDialogTextId(CommandStationEnum.DialogueType.Click)

	self:_showDialogue(textId)

	if self._uiSpine then
		self._uiSpine:play("radio_shake")
		TaskDispatcher.cancelTask(self._delayPlayIdleAnim, self)
		TaskDispatcher.runDelay(self._delayPlayIdleAnim, self, 1)
	end

	CommandStationController.StatCommandStationButtonClick(self.viewName, "_btnwuxiandianOnClick")
end

function CommandStationEnterView:_delayPlayIdleAnim()
	self:_playIdleAnim()
end

function CommandStationEnterView:_btnmapOnClick()
	local preloadLoader = CommandStationMapModel.instance:getPreloadSceneLoader()

	if preloadLoader then
		preloadLoader:dispose()
		CommandStationMapModel.instance:setPreloadScene()
	end

	AudioMgr.instance:trigger(AudioEnum3_0.CommandStationMap.play_ui_lushang_zhihuibu_shapan)
	self:_afterBoxClose(function()
		self._viewAnimatorPlayer:Play("close1", self._animDoneForOpenMap, self)
	end)
	CommandStationController.StatCommandStationButtonClick(self.viewName, "_btnmapOnClick")
end

function CommandStationEnterView:_animDoneForOpenMap()
	UIBlockMgrExtend.setNeedCircleMv(false)
	module_views_preloader.CommandStationMapViewPreload(function()
		self:_preloadDone()
	end)
end

function CommandStationEnterView:_preloadDone()
	local sceneConfig = CommandStationMapModel.instance:getCurTimeIdScene()

	if sceneConfig then
		local scenePath = sceneConfig.scene
		local uiPath = "ui/viewres/commandstation/commandstation_mapview.prefab"
		local mapLoader = MultiAbLoader.New()

		CommandStationMapModel.instance:setPreloadScene(mapLoader)
		mapLoader:addPath(scenePath)
		mapLoader:addPath(uiPath)
		mapLoader:startLoad(function()
			local assetItem = mapLoader:getAssetItem(scenePath)

			if assetItem then
				local mainPrefab = assetItem:GetResource(scenePath)
				local sceneGo = gohelper.clone(mainPrefab, self.viewGO)

				gohelper.setActive(sceneGo, false)
				CommandStationMapModel.instance:setPreloadScene(mapLoader, sceneGo)
			end

			local assetItem2 = mapLoader:getAssetItem(uiPath)

			if assetItem2 then
				local mainPrefab2 = assetItem2:GetResource(uiPath)
				local uiLayerGO = ViewMgr.instance:getUILayer("POPUP_TOP")
				local viewGO = gohelper.clone(mainPrefab2, uiLayerGO, ViewName.CommandStationMapView)

				recthelper.setAnchor(viewGO.transform, 10000, 10000)
				CommandStationMapModel.instance:setPreloadView(viewGO)
			end
		end)
	end

	self:_openMap()
end

function CommandStationEnterView:_openMap()
	self._changeVideoViewLayer = true

	local time = 3

	UIBlockHelper.instance:startBlock("CommandStationEnterView_openMap", time)
	VideoController.instance:openFullScreenVideoView(self._toMapVedioPath, nil, time, self._onVideoEndForOpenMap, self, {
		setVideoPlayer = self._setVideoPlayer,
		getVideoPlayer = self._getVideoPlayer,
		waitViewOpen = ViewName.CommandStationMapView
	})
end

function CommandStationEnterView:_getVideoPlayer()
	return self._mapVideoPlayer, self._mapVideoGo
end

function CommandStationEnterView:_setVideoPlayer(videoPlayer, videoGo)
	gohelper.addChild(self._mapVideoNode, videoGo)
end

function CommandStationEnterView:_delayOpenMapView()
	CommandStationController.instance:openCommandStationMapView()
end

function CommandStationEnterView:_onVideoEndForOpenMap()
	self._changeVideoViewLayer = false

	if not ViewMgr.instance:isOpen(ViewName.CommandStationMapView) then
		TaskDispatcher.cancelTask(self._delayOpenMapView, self)
		CommandStationController.instance:openCommandStationMapView()
	end
end

function CommandStationEnterView:_btntaskOnClick()
	self:_afterBoxClose(function()
		self._viewAnimatorPlayer:Play("close1", self._delayPlayVideo, self)
	end)
	UIBlockHelper.instance:startBlock("CommandStationEnterView_taskAnim", 0.2)
	CommandStationController.StatCommandStationButtonClick(self.viewName, "_btntaskOnClick")
end

function CommandStationEnterView:_delayPlayVideo()
	module_views_preloader._startLoad({
		"ui/viewres/commandstation/commandstation_paperview.prefab"
	}, function()
		self._changeVideoViewLayer = true

		AudioMgr.instance:trigger(AudioEnum3_0.CommandStationPaper.play_ui_lushang_zhihuibu_handian)
		VideoController.instance:openFullScreenVideoView(self._toPaperVedioPath, nil, 5, self._realOpenPaperView, self, {
			noshowBlackBg = true,
			setVideoPlayer = self._setVideoPlayer2,
			getVideoPlayer = self._getVideoPlayer2,
			waitViewOpen = ViewName.CommandStationPaperView
		})
	end)
end

function CommandStationEnterView:_getVideoPlayer2()
	return self._paperVideoPlayer, self._paperVideoGo
end

function CommandStationEnterView:_setVideoPlayer2(videoPlayer, videoGo)
	gohelper.addChild(self._paperVideoNode, videoGo)
	videoPlayer:pause()
	videoPlayer:seek(0)
end

function CommandStationEnterView:_realOpenPaperView()
	self._changeVideoViewLayer = false

	self.viewContainer:setVisibleInternal(false)

	if ViewMgr.instance:isOpenFinish(ViewName.CommandStationPaperView) then
		local container = ViewMgr.instance:getContainer(ViewName.CommandStationPaperView)

		container:setVisibleInternal(true)
		container:playOpenTransition()
	else
		CommandStationController.instance:openCommandStationPaperView()
	end
end

function CommandStationEnterView:_btnactivityOnClick()
	if not self._constActParamConfig then
		return
	end

	local controller = self._constActParamConfig.value2
	local controllerIns = _G[controller]

	controllerIns = controllerIns or _G.VersionActivityMainFixedEnterController

	controllerIns.instance:openVersionActivityEnterView()
	CommandStationController.StatCommandStationButtonClick(self.viewName, "_btnactivityOnClick")
end

function CommandStationEnterView.isUnlockRelationShipBoard()
	return CommandStationController.relationShipUnlockByDungeon() or CommandStationController.relationShipUnlockByChapter12() or CommandStationController.showNewChapterPage()
end

function CommandStationEnterView:_updateRelationShipBoardBtnStatus()
	gohelper.setActive(self._btnrelationshipboard, CommandStationEnterView.isUnlockRelationShipBoard())
end

function CommandStationEnterView:_editableInitView()
	gohelper.setActive(self._btnmap, false)

	self._viewOpenTime = Time.realtimeSinceStartup
	self._goActivityRedDot = gohelper.findChild(self.viewGO, "#btn_activity/go_reddot")
	self._goRelationShipBoardRedDot = gohelper.findChild(self.viewGO, "#btn_relationshipboard/go_reddot")

	gohelper.setActive(self._goActivityRedDot, false)
	gohelper.setActive(self._goRelationShipBoardRedDot, false)

	self._goActivityBg = gohelper.findChild(self.viewGO, "simage_dec")
	self._constChapterListConfig = CommandStationConfig.instance:getConstConfig(CommandStationEnum.ConstId.ChapterList)

	if self._constChapterListConfig then
		self._chapterList = string.splitToNumber(self._constChapterListConfig.value2, "#")
	end

	self._constActParamConfig = CommandStationConfig.instance:getConstConfig(CommandStationEnum.ConstId.ActParam)
	self._constActParamConfig2 = CommandStationConfig.instance:getConstConfig(CommandStationEnum.ConstId.ActParam2)
	self._mapAnimator = self._gomap:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(self._gomap, false)

	self._bottomAnimator = self._gobottom:GetComponent(typeof(UnityEngine.Animator))
	self._viewAnimatorPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)

	local go = gohelper.findChild(ViewMgr.instance:getUIRoot(), "POPUP_SECOND")

	gohelper.addChild(go, self.viewGO)

	self._openBox = true

	local boxAnimGo = gohelper.findChild(self.viewGO, "#btn_box/#ani")

	self._boxAnimator = boxAnimGo:GetComponent(typeof(UnityEngine.Animator))
	self._actImage = gohelper.findChildSingleImage(self.viewGO, "#btn_activity")
	self._gotaskred = gohelper.findChild(self.viewGO, "#btn_task/go_reddot")

	self:_updateRelationShipBoardBtnStatus()
end

function CommandStationEnterView:_addCacheVideo(name, path)
	local go = UnityEngine.GameObject.New(name)

	gohelper.addChild(self.viewGO, go)
	transformhelper.setLocalPosXY(go.transform, 10000, 0)

	local videoPlayer, videoGo = VideoPlayerMgr.instance:createGoAndVideoPlayer(go)

	videoPlayer:loadMedia(path)

	return go, videoPlayer, videoGo
end

function CommandStationEnterView:_updateBoxAnim()
	self._boxAnimator:Play(self._openBox and "open" or "close")
end

function CommandStationEnterView:_afterBoxClose(callback)
	self._viewIsClose = true

	GameGCMgr.instance:dispatchEvent(GameGCEvent.SetBanGc, "commandstation_playvideo", true)

	if not self._openBox then
		callback()

		return
	end

	self._boxCloseDoneCallback = callback
	self._openBox = false

	self:_updateBoxAnim()

	local time = 0.33

	TaskDispatcher.cancelTask(self._boxCloseDone, self)
	TaskDispatcher.runDelay(self._boxCloseDone, self, time)
	UIBlockHelper.instance:startBlock("CommandStationEnterView_afterBoxClose", time)
end

function CommandStationEnterView:_boxCloseDone()
	self._boxCloseDoneCallback()
end

function CommandStationEnterView:_canShowMapBtn()
	local list = self._chapterList

	for i = #list, 1, -1 do
		local chapterId = list[i]
		local chapterList = DungeonConfig.instance:getPreviewChapterList(chapterId)

		for _, config in ipairs(chapterList) do
			local episodeList = DungeonConfig.instance:getChapterEpisodeCOList(config.id)

			if episodeList and episodeList[1] and DungeonModel.instance:hasPassLevelAndStory(episodeList[1].id) then
				return true
			end
		end
	end
end

function CommandStationEnterView:_getLastEpisodeConfig()
	local list = self._chapterList

	for i = #list, 1, -1 do
		local chapterId = list[i]
		local episodeConfig = self:_getChapterLastEpisodeConfig(chapterId)

		if episodeConfig then
			return episodeConfig
		end
	end

	local chapterId = list[1]
	local episodeList = DungeonConfig.instance:getChapterEpisodeCOList(chapterId)

	return episodeList[1]
end

function CommandStationEnterView:_getChapterLastEpisodeConfig(chapterId)
	local episodeList = DungeonConfig.instance:getChapterEpisodeCOList(chapterId)

	for i = #episodeList, 1, -1 do
		local config = episodeList[i]

		if DungeonModel.instance:hasPassLevelAndStory(config.id) then
			return config
		end

		local isFinishElement = DungeonModel.instance:isFinishElementList(config)

		if isFinishElement and (config.preEpisode == 0 or DungeonModel.instance:hasPassLevelAndStory(config.preEpisode) or DungeonModel.instance:hasPassLevelAndStory(config.preEpisode2)) then
			return config
		end
	end
end

function CommandStationEnterView:_initSpine()
	self._uiSpine = GuiSpine.Create(self._btnwuxiandian.gameObject, true)

	local spineName = "command_radio"
	local resPath = ResUrl.getRolesCgStory(spineName, "v3a0_command_radio")

	self._uiSpine:setResPath(resPath, self._onSpineLoaded, self)
end

function CommandStationEnterView:_onSpineLoaded()
	self:_playIdleAnim()
end

function CommandStationEnterView:_playIdleAnim()
	if self._uiSpine then
		self._uiSpine:play("radio_cycle", true)
	end
end

function CommandStationEnterView:onOpen()
	self._idleConfig = CommandStationConfig.instance:getDialogByType(CommandStationEnum.DialogueType.Idle)

	self:_startIdleDialogue()
	self:_showEpisodeInfo()
	self:_initSpine()
	self:_checkRed()
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._onRefreshActivity, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, self._onUpdateDungeonInfo, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._OnCloseViewFinish, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._OnOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseFullView, self._OnCloseFullView, self, LuaEventSystem.Low)
	self.addEventCb(self, RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, self._checkRed, self)
	self.addEventCb(self, VideoController.instance, VideoEvent.OnVideoStarted, self._onVideoStarted, self)
	self.addEventCb(self, VideoController.instance, VideoEvent.OnVideoFirstFrameReady, self._onVideoFirstFrameReady, self)
	self.addEventCb(self, CommandStationController.instance, CommandStationEvent.OnPaperUpdate, self._onPaperUpdate, self)

	if self.viewParam and self.viewParam.fromDungeonSectionItem then
		self:_resetLayer()
	else
		TaskDispatcher.cancelTask(self._openPostProcess, self)
		TaskDispatcher.runRepeat(self._openPostProcess, self, 0)
	end

	if ViewMgr.instance:isOpen(ViewName.CommandStationEnterAnimView) then
		TaskDispatcher.runDelay(self._delayUpdatePaper, self, 0)
		TaskDispatcher.runDelay(self._delayUpdateActBtn, self, 0.5)
	else
		self:_updatePaper()
		self:_updateActBtn()
	end
end

function CommandStationEnterView:_delayUpdatePaper()
	self:_updatePaper()
end

function CommandStationEnterView:_delayUpdateActBtn()
	self:_updateActBtn()
end

function CommandStationEnterView:_onPaperUpdate()
	self:_updatePaper()
end

function CommandStationEnterView:_updatePaper()
	if not CommandStationModel.instance.paper then
		local paper = 0

		paper = Mathf.Clamp(paper, 0, 9)

		local name = paper == 0 and "commandstation_box_empty" or "commandstation_box_0" .. tostring(paper)

		UISpriteSetMgr.instance:setCommandStationSprite(self._imagebox, name)
	end
end

function CommandStationEnterView:_hideMainScene()
	local curScene = GameSceneMgr.instance:getCurScene()
	local curSceneRootGO = curScene:getSceneContainerGO()

	gohelper.setActive(curSceneRootGO, false)
end

function CommandStationEnterView:_onVideoStarted(videoPath)
	if videoPath == self._toMapVedioPath then
		TaskDispatcher.cancelTask(self._delayHideSelf, self)
		TaskDispatcher.runDelay(self._delayHideSelf, self, 0)
	end

	if videoPath == self._toPaperVedioPath then
		self.viewContainer:setVisibleInternal(false)
	end
end

function CommandStationEnterView:_onVideoFirstFrameReady(videoPath)
	return
end

function CommandStationEnterView:_delayHideSelf()
	self.viewContainer:setVisibleInternal(false)
	TaskDispatcher.cancelTask(self._delayOpenMapView, self)
	TaskDispatcher.runDelay(self._delayOpenMapView, self, 0.85)
end

function CommandStationEnterView:_openPostProcess()
	PostProcessingMgr.instance:setUIActive(true)
end

function CommandStationEnterView:_resetLayer()
	local go = ViewMgr.instance:getUILayer(UILayerName.PopUpTop)

	gohelper.addChild(go, self.viewGO)
end

function CommandStationEnterView:_checkRed()
	gohelper.setActive(self._gotaskred, RedDotModel.instance:isDotShow(RedDotEnum.DotNode.CommandStationPaper))
	gohelper.setActive(self._goActivityRedDot, RedDotModel.instance:isDotShow(RedDotEnum.DotNode.VersionActivityEnterRedDot))
	gohelper.setActive(self._goRelationShipBoardRedDot, RedDotModel.instance:isDotShow(RedDotEnum.DotNode.CommandStationRelationShipBoard))
end

function CommandStationEnterView:_OnOpenView(viewName)
	if viewName == ViewName.CommandStationMapView or viewName == ViewName.CommandStationPaperView then
		UIBlockMgrExtend.setNeedCircleMv(true)
		self.viewContainer:setVisibleInternal(false)
		GameGCMgr.instance:dispatchEvent(GameGCEvent.SetBanGc, "commandstation_playvideo", false)
	end

	if self._changeVideoViewLayer and viewName == ViewName.FullScreenVideoView then
		self._changeVideoViewLayer = false

		local container = ViewMgr.instance:getContainer(ViewName.FullScreenVideoView)

		if container and not gohelper.isNil(container.viewGO) then
			local hudLayer = ViewMgr.instance:getUILayer("HUD")

			gohelper.addChild(hudLayer, container.viewGO)
		end
	end
end

function CommandStationEnterView:_OnCloseViewFinish(viewName)
	if not ViewHelper.instance:checkViewOnTheTop(self.viewName) then
		return
	end

	if viewName == ViewName.CommandStationPaperView then
		AudioMgr.instance:trigger(AudioEnum3_0.CommandStationPaper.play_ui_lushang_zhihuibu_fanhui)
	end

	if viewName == ViewName.CommandStationMapView or viewName == ViewName.CommandStationRelationShipBoard or viewName == ViewName.DungeonMapView or viewName == ViewName.CommandStationPaperView or self._viewIsClose then
		self.viewContainer:setVisibleInternal(true)
		self._viewAnimatorPlayer:Play("open2", self._animDone, self)

		self._viewIsClose = false
		self._openBox = true

		self:_updateBoxAnim()
	end
end

function CommandStationEnterView:onUpdateParam()
	self.viewContainer:setVisibleInternal(true)
	self._viewAnimatorPlayer:Play("open2", self._animDone, self)
end

function CommandStationEnterView:_OnCloseFullView(viewName)
	if viewName == ViewName.CommandStationMapView or viewName == ViewName.DungeonMapView then
		self.viewContainer:setVisibleInternal(false)
	end
end

function CommandStationEnterView:_animDone()
	return
end

function CommandStationEnterView:_onUpdateDungeonInfo()
	self:_showEpisodeInfo()
	self:_updateRelationShipBoardBtnStatus()
	self:_checkRed()
end

function CommandStationEnterView:_onRefreshActivity()
	self:_updateActBtn()
end

function CommandStationEnterView:_updateActBtn()
	local showActivity, iconPath = self:_isShowActivity()

	gohelper.setActive(self._btnactivity, showActivity)
	gohelper.setActive(self._goActivityBg, showActivity)

	if showActivity then
		self._actImage:LoadImage(iconPath)
	end
end

function CommandStationEnterView:_isShowActivity()
	if CommandStationEnum.ForceHideCommandStation then
		return false, nil
	end

	if self._constActParamConfig2 then
		local actId = self._constActParamConfig2.value
		local status = actId > 0 and ActivityHelper.getActivityStatus(actId)
		local showActivity = status == ActivityEnum.ActivityStatus.Normal

		if showActivity then
			return showActivity, self._constActParamConfig2.value3
		end
	end

	if self._constActParamConfig then
		local actId = self._constActParamConfig.value
		local status = ActivityHelper.getActivityStatus(actId)
		local showActivity = status == ActivityEnum.ActivityStatus.Normal

		if showActivity then
			return showActivity, self._constActParamConfig.value3
		end
	end
end

function CommandStationEnterView:onOpenFinish()
	self:_resetLayer()
	PostProcessingMgr.instance:setUIActive(false)
	TaskDispatcher.cancelTask(self._openPostProcess, self)
	self:_showEnterDialogue()
	self:_showMap()
	self:_preloadVideos()
end

function CommandStationEnterView:_preloadVideos()
	self._toMapVedioPath = "commandstation_tomap"
	self._toPaperVedioPath = "commandstation_tocode"
	self._paperVideoNode, self._paperVideoPlayer, self._paperVideoGo = self:_addCacheVideo("paperVideo", self._toPaperVedioPath)
	self._mapVideoNode, self._mapVideoPlayer, self._mapVideoGo = self:_addCacheVideo("mapVideo", self._toMapVedioPath)
end

function CommandStationEnterView:_showEpisodeInfo()
	if not self._chapterList then
		logError("CommandStationEnterView:_showEpisodeInfo chapterList is nil")

		return
	end

	local episodeConfig = self:_getLastEpisodeConfig()
	local episodeIndex = DungeonConfig.instance:getEpisodeLevelIndex(episodeConfig)
	local chapterCO = DungeonConfig.instance:getChapterCO(episodeConfig.chapterId)

	gohelper.setActive(self._btnmap, self:_canShowMapBtn())

	if LuaUtil.containChinese(episodeConfig.name) then
		local num = LuaUtil.getCharNum(episodeConfig.name)
		local maxNum = 8

		self._txtName.text = maxNum < num and LuaUtil.subString(episodeConfig.name, 1, maxNum) .. "..." or episodeConfig.name
	else
		self._txtName.text = episodeConfig.name
	end

	self._txtNum.text = string.format("%s-%s", chapterCO.chapterIndex, episodeIndex)
	self._showEpisodeId = episodeConfig.id
end

function CommandStationEnterView:_startIdleDialogue()
	TaskDispatcher.cancelTask(self._playIdleDialogue, self)
	TaskDispatcher.runDelay(self._playIdleDialogue, self, self._idleConfig.time)
end

function CommandStationEnterView:_playIdleDialogue()
	local textId = CommandStationConfig.instance:getRandomDialogTextId(CommandStationEnum.DialogueType.Idle)

	self:_showDialogue(textId)
end

function CommandStationEnterView:_showEnterDialogue()
	local textId = CommandStationConfig.instance:getRandomDialogTextId(CommandStationEnum.DialogueType.Enter)

	self:_showDialogue(textId)
end

function CommandStationEnterView:_showDialogue(textId)
	if not textId then
		logError("_showDialogue textId is nil")

		return
	end

	local config = lua_copost_npc_text.configDict[textId]

	if not config then
		logError(string.format("CommandStationEnterView _showDialogue textId:%s config is nil", textId))

		return
	end

	TaskDispatcher.cancelTask(self._playIdleDialogue, self)
	TaskDispatcher.cancelTask(self._hideDialogue, self)
	TaskDispatcher.runDelay(self._hideDialogue, self, 5)
	self._bottomAnimator:Play("in", 0, 0)
	gohelper.setActive(self._gobottom, true)

	self._txtanacn.text = config.text
	self._txtanaen.text = config.engtext
end

function CommandStationEnterView:_hideDialogue()
	self._bottomAnimator:Play("out", 0, 0)
	self:_startIdleDialogue()
end

function CommandStationEnterView:_showMap()
	local key = string.format("%s_%s", CommandStationEnum.PrefsKey.NewMapTip, CommandStationConfig.instance:getCurVersionId())

	if CommandStationController.hasOnceActionKey(key) then
		return
	end

	CommandStationController.setOnceActionKey(key)

	local constConfig = CommandStationConfig.instance:getConstConfig(CommandStationEnum.ConstId.VersionName)

	if constConfig then
		self._txtmapname.text = constConfig.value4
	end

	gohelper.setActive(self._gomap, true)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Story_Map_In)
	self._mapAnimator:Play("go_mapname_in")
	TaskDispatcher.cancelTask(self._mapOut, self)
	TaskDispatcher.runDelay(self._mapOut, self, 3)
end

function CommandStationEnterView:_mapOut()
	self._mapAnimator:Play("go_mapname_out")
end

function CommandStationEnterView:onClose()
	TaskDispatcher.cancelTask(self._hideDialogue, self)
	TaskDispatcher.cancelTask(self._playIdleDialogue, self)
	TaskDispatcher.cancelTask(self._mapOut, self)
	TaskDispatcher.cancelTask(self._openPostProcess, self)
	TaskDispatcher.cancelTask(self._delayPlayIdleAnim, self)
	TaskDispatcher.cancelTask(self._delayOpenMapView, self)
	TaskDispatcher.cancelTask(self._delayHideSelf, self)
	TaskDispatcher.cancelTask(self._boxCloseDone, self)
	TaskDispatcher.cancelTask(self._delayUpdatePaper, self)
	TaskDispatcher.cancelTask(self._delayUpdateActBtn, self)
	CommandStationController.StatCommandStationViewClose(self.viewName, Time.realtimeSinceStartup - self._viewOpenTime)
	UIBlockMgrExtend.setNeedCircleMv(true)
	GameGCMgr.instance:dispatchEvent(GameGCEvent.SetBanGc, "commandstation_playvideo", false)
	CommandStationMapModel.instance:setPreloadView()
end

function CommandStationEnterView:onDestroyView()
	local preloadLoader = CommandStationMapModel.instance:getPreloadSceneLoader()

	if preloadLoader then
		preloadLoader:dispose()
		CommandStationMapModel.instance:setPreloadScene()
	end
end

return CommandStationEnterView
