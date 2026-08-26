-- chunkname: @modules/logic/versionactivity1_3/chess/view/Activity1_3ChessMapView.lua

module("modules.logic.versionactivity1_3.chess.view.Activity1_3ChessMapView", package.seeall)

local Activity1_3ChessMapView = class("Activity1_3ChessMapView", BaseView)

function Activity1_3ChessMapView:onInitView()
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "LeftTop/#simage_Title")
	self._btnRewardBtn = gohelper.findChildButtonWithAudio(self.viewGO, "RightTop/#btn_RewardBtn")
	self._goStage1 = gohelper.findChild(self.viewGO, "Map/Path1/#go_Stage1")
	self._goStage2 = gohelper.findChild(self.viewGO, "Map/Path1/#go_Stage2")
	self._goStage3 = gohelper.findChild(self.viewGO, "Map/Path1/#go_Stage3")
	self._goStage4 = gohelper.findChild(self.viewGO, "Map/Path1/#go_Stage4")
	self._goNextBtn = gohelper.findChild(self.viewGO, "Map/Path1/#go_NextBtn")
	self._goNextBtnRoot = gohelper.findChild(self.viewGO, "Map/Path1/#go_NextBtn/Root")
	self._txtStageName = gohelper.findChildText(self.viewGO, "Map/Path1/#go_NextBtn/Root/Info/#txt_StageName")
	self._goImageLock = gohelper.findChild(self.viewGO, "Map/Path1/#go_NextBtn/Root/Info/#txt_StageName/#image_Lock")
	self._goLockBg = gohelper.findChild(self.viewGO, "Map/Path1/#go_NextBtn/Root/#image_StageNormalBG")
	self._txtStageNum = gohelper.findChildText(self.viewGO, "Map/Path1/#go_NextBtn/Root/Info/#txt_StageName/#txt_StageNum")
	self._btnGoNextClick = gohelper.findChildButtonWithAudio(self.viewGO, "Map/Path1/#go_NextBtn/Root/#btn_Click")
	self._goPath2Stage1 = gohelper.findChild(self.viewGO, "Map/Path2/#go_Stage1")
	self._goPath2Stage2 = gohelper.findChild(self.viewGO, "Map/Path2/#go_Stage2")
	self._goPath2Stage3 = gohelper.findChild(self.viewGO, "Map/Path2/#go_Stage3")
	self._goPath2Stage4 = gohelper.findChild(self.viewGO, "Map/Path2/#go_Stage4")
	self._goPreviousBtn = gohelper.findChild(self.viewGO, "Map/Path2/#go_PreviousBtn")
	self._btnPath2Click = gohelper.findChildButtonWithAudio(self.viewGO, "Map/Path2/#go_PreviousBtn/Root/#btn_Click")
	self._goPath1 = gohelper.findChild(self.viewGO, "Map/Path1")
	self._goPath2 = gohelper.findChild(self.viewGO, "Map/Path2")
	self._goreceive = gohelper.findChild(self.viewGO, "RightTop/ani/gifts_receive")
	self._simageMask = gohelper.findChildSingleImage(self.viewGO, "image_Mask")
	self._simageMainPath1 = gohelper.findChildSingleImage(self.viewGO, "Map/Path1/image_MainPath1")
	self._simageMainPath2 = gohelper.findChildSingleImage(self.viewGO, "Map/Path2/image_MainPath2")
	self._goexcessive = gohelper.findChild(self.viewGO, "#go_excessive")

	gohelper.setActive(self._goexcessive, true)

	self._goRedDotRoot = gohelper.findChild(self.viewGO, "RightTop/#go_reddotreward")

	local animatorType = typeof(UnityEngine.Animator)

	self._viewAnimator = self.viewGO:GetComponent(animatorType)
	self._rewardAnimator = gohelper.findChildComponent(self.viewGO, "RightTop/ani", animatorType)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity1_3ChessMapView:addEvents()
	self._btnRewardBtn:AddClickListener(self._btnRewardBtnOnClick, self)
	self._btnGoNextClick:AddClickListener(self._btnClickOnClick, self)
	self._btnPath2Click:AddClickListener(self._btnPath2ClickOnClick, self)
	self.addEventCb(self, Activity1_3ChessController.instance, Activity1_3ChessEvent.ClickEpisode, self._onGotoTaskEpisode, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self._refreshRewardAnim, self)
end

function Activity1_3ChessMapView:removeEvents()
	self._btnRewardBtn:RemoveClickListener()
	self._btnGoNextClick:RemoveClickListener()
	self._btnPath2Click:RemoveClickListener()
end

function Activity1_3ChessMapView:_btnRewardBtnOnClick()
	ViewMgr.instance:openView(ViewName.Activity1_3ChessTaskView)
end

function Activity1_3ChessMapView:_btnClickOnClick()
	local isChapter2Open = Activity1_3ChessController.instance:checkEpisodeIsOpenByChapterId(Activity1_3ChessEnum.Chapter.Two)

	if isChapter2Open then
		AudioMgr.instance:trigger(AudioEnum.RoleChessGame1_3Common.NextStage)
		self:_beginSwitchStage(Activity1_3ChessEnum.Chapter.Two)
	else
		GameFacade.showToast(ToastEnum.Va3Act120ChapterNotOpenTime)
	end
end

function Activity1_3ChessMapView:_btnPath2ClickOnClick()
	AudioMgr.instance:trigger(AudioEnum.RoleChessGame1_3Common.NextStage)
	self:_beginSwitchStage(Activity1_3ChessEnum.Chapter.One)
end

function Activity1_3ChessMapView:_editableInitView()
	self._path1NodeRoots = {
		self._goStage1,
		self._goStage2,
		self._goStage3,
		self._goStage4
	}
	self._path2NodeRoots = {
		self._goPath2Stage1,
		self._goPath2Stage2,
		self._goPath2Stage3,
		self._goPath2Stage4
	}
	self._stageRoots = {
		self._goPath1,
		self._goPath2
	}

	MainCameraMgr.instance:addView(self.viewName, self.initCamera, nil, self)
	self._simageMask:LoadImage(ResUrl.getJiaLaBoNaIcon("v1a3_role1_igfullmask"))
	self._simageMainPath1:LoadImage(ResUrl.get1_3ChessMapIcon("v1a3_role2_og_mapmainpath_1"))
	self._simageMainPath2:LoadImage(ResUrl.get1_3ChessMapIcon("v1a3_role2_og_mapmainpath_2"))
	RedDotController.instance:addRedDot(self._goRedDotRoot, RedDotEnum.DotNode.Activity1_3RedDotAct122Reward)
end

function Activity1_3ChessMapView:initCamera()
	local camera = CameraMgr.instance:getMainCamera()

	camera.orthographic = true

	local scale = GameUtil.getAdapterScale(true)

	camera.orthographicSize = 8.75 * scale
end

function Activity1_3ChessMapView:onUpdateParam()
	self:_refreshNextChapterView()
end

function Activity1_3ChessMapView:onOpen()
	self:_initMapNodeItems()
	self:_refreshNodeItemViews()

	local curEpisodeId = Activity122Model.instance:getCurEpisodeId()
	local actId = VersionActivity1_3Enum.ActivityId.Act304
	local episodeCfg = Va3ChessConfig.instance:getEpisodeCo(actId, curEpisodeId)

	if episodeCfg then
		if not episodeCfg.chapterId then
			local stage = 1

			self:_switchToStage(stage)
			self.viewContainer:showEnterSceneView(stage)
			self:_refreshNextChapterView()
			self:_refreshRewardAnim()
			self:playViewAnimation(UIAnimationName.Open)
		end
	end
end

function Activity1_3ChessMapView:onClose()
	TaskDispatcher.cancelTask(self._acturalSwitchStage, self)
	TaskDispatcher.cancelTask(self._playNodeAppearEnd, self)
	TaskDispatcher.cancelTask(self._playNextBtnUnlockAni, self)
	TaskDispatcher.cancelTask(self._playNodeAppearAnimation, self)
end

function Activity1_3ChessMapView:onDestroyView()
	if self._nodeItemDict then
		for _, nodeItem in pairs(self._nodeItemDict) do
			nodeItem:onDestroyView()
		end
	end

	self._nodeItemDict = nil

	self._simageMask:UnLoadImage()
	self._simageMainPath2:UnLoadImage()
	self._simageMainPath1:UnLoadImage()
end

function Activity1_3ChessMapView:_initMapNodeItems()
	if self._nodeItemDict then
		return
	end

	self._nodeItemDict = {}

	local actId = VersionActivity1_3Enum.ActivityId.Act304

	self._episodeCfgList = Activity122Config.instance:getEpisodeList(actId)

	for i, episodeCfg in ipairs(self._episodeCfgList) do
		self:_createMapNodeItem(episodeCfg)
	end
end

function Activity1_3ChessMapView:_createMapNodeItem(episodeCfg)
	local id = episodeCfg.id
	local nodeItem = self._nodeItemDict[id]

	if not nodeItem then
		local prefabPath = Activity1_3ChessMapNodeItem.prefabPath

		if id <= #self._path1NodeRoots then
			if not self._path1NodeRoots[id] then
				local root = self._path2NodeRoots[id - #self._path1NodeRoots]
				local cloneGo = self:getResInst(prefabPath, root)
				local nodeItem = MonoHelper.addNoUpdateLuaComOnceToGo(cloneGo, Activity1_3ChessMapNodeItem, self)

				nodeItem:setCfg(episodeCfg)
				nodeItem:setClickCallback(self._clickNodeCallback, self)

				self._nodeItemDict[id] = nodeItem
			end
		end
	end
end

function Activity1_3ChessMapView:_refreshNodeItemViews()
	if not self._nodeItemDict then
		return
	end

	for id, nodeItem in pairs(self._nodeItemDict) do
		nodeItem:refreshUI()
	end
end

function Activity1_3ChessMapView:_refreshNextChapterView()
	gohelper.setActive(self._goNextBtn, true)

	local playerCacheData = Activity122Model.instance:getPlayerCacheData()
	local isChapter2Open = Activity1_3ChessController.instance:checkEpisodeIsOpenByChapterId(Activity1_3ChessEnum.Chapter.Two)
	local needShowUnlockAni = isChapter2Open and playerCacheData.isNextChapterLock

	if needShowUnlockAni then
		playerCacheData.isNextChapterLock = false

		Activity122Model.instance:saveCacheData()
		TaskDispatcher.runDelay(self._playNextBtnUnlockAni, self, 0.4)
	end

	gohelper.setActive(self._goImageLock, not isChapter2Open)
	ZProj.UGUIHelper.SetGrayFactor(self._goLockBg, isChapter2Open and 0 or 1)
end

function Activity1_3ChessMapView:_clickNodeCallback(id)
	local curEpisodeId = Activity122Model.instance:getCurEpisodeId()

	if curEpisodeId == id then
		self._targetNodeId = id

		self:_playNodeAppearEnd()
	else
		local actId = VersionActivity1_3Enum.ActivityId.Act304
		local episodeCfg = Va3ChessConfig.instance:getEpisodeCo(actId, curEpisodeId)
		local targetEpisodeCfg = Va3ChessConfig.instance:getEpisodeCo(actId, curEpisodeId)
		local curEpisodeChapter = episodeCfg.chapterId
		local targetEpisodeChapter = targetEpisodeCfg.chapterId
		local isSameChapter = targetEpisodeChapter == curEpisodeChapter
		local curNode = self._nodeItemDict[curEpisodeId]
		local targetNode = self._nodeItemDict[id]

		if isSameChapter then
			UIBlockMgr.instance:startBlock(Activity1_3ChessEnum.UIBlockKey)
			curNode:playDisAppearAni(id)

			self._targetNodeId = id

			TaskDispatcher.runDelay(self._playNodeAppearAnimation, self, 0.4)
			AudioMgr.instance:trigger(AudioEnum.RoleChessGame1_3Common.PlayerChessMove)
		else
			targetNode:playAppearAni(curEpisodeId)
			AudioMgr.instance:trigger(AudioEnum.RoleChessGame1_3Common.PlayerChessMove)
		end
	end
end

function Activity1_3ChessMapView:_playNodeAppearAnimation(nodeId)
	UIBlockMgr.instance:startBlock(Activity1_3ChessEnum.UIBlockKey)

	local curEpisodeId = Activity122Model.instance:getCurEpisodeId()
	local nodeItem = self._nodeItemDict[self._targetNodeId]

	nodeItem:playAppearAni(curEpisodeId)
	TaskDispatcher.runDelay(self._playNodeAppearEnd, self, 0.8)
end

function Activity1_3ChessMapView:_playNodeAppearEnd()
	UIBlockMgr.instance:startBlock(Activity1_3ChessEnum.UIBlockKey)
	self:playViewAnimation(UIAnimationName.Close)
	Activity1_3ChessController.instance:requestEnterChessGame(self._targetNodeId, 0.3)

	self._targetNodeId = nil
end

function Activity1_3ChessMapView:_beginSwitchStage(Stage)
	UIBlockMgr.instance:startBlock(Activity1_3ChessEnum.UIBlockKey)
	self:playSwitchSceneAni(Stage == Activity1_3ChessEnum.Chapter.Two)

	self._delayToStage = Stage

	TaskDispatcher.cancelTask(self._acturalSwitchStage, self)
	TaskDispatcher.runDelay(self._acturalSwitchStage, self, 0.5)
end

function Activity1_3ChessMapView:_acturalSwitchStage(page)
	UIBlockMgr.instance:endBlock(Activity1_3ChessEnum.UIBlockKey)
	self:_switchToStage(self._delayToStage)
end

function Activity1_3ChessMapView:_switchToStage(stage)
	local isStageOpen = self:_checkChessMapStageOpen(stage)

	if isStageOpen then
		self._curStage = stage

		for i = 1, #self._stageRoots do
			gohelper.setActive(self._stageRoots[i], i == stage)
		end
	end

	if self.viewContainer.switchStage then
		self.viewContainer:switchStage(stage)
	end
end

function Activity1_3ChessMapView:_checkChessMapStageOpen(stage)
	return (Activity1_3ChessController.instance:checkEpisodeIsOpenByChapterId(stage))
end

function Activity1_3ChessMapView:onSetVisible(visible)
	if visible then
		self:_refreshNodeItemViews()

		local curEpisodeId = Activity122Model.instance:getCurEpisodeId()
		local actId = VersionActivity1_3Enum.ActivityId.Act304
		local episodeCfg = Va3ChessConfig.instance:getEpisodeCo(actId, curEpisodeId)

		if episodeCfg then
			if not episodeCfg.chapterId then
				local stage = 1

				self:_switchToStage(stage)
				self:_refreshNextChapterView()
			end
		end
	end
end

function Activity1_3ChessMapView:_onGotoTaskEpisode(EpisodeId)
	local chapterId = self:_getEpisodeChapterId(EpisodeId)

	if chapterId and chapterId ~= self._curStage then
		self:_switchToStage(chapterId)
	end

	self:_clickNodeCallback(EpisodeId)
end

function Activity1_3ChessMapView:_getEpisodeChapterId(episodeId)
	if not self._episodeCfgList or #self._episodeCfgList < 1 then
		return
	end

	if episodeId then
		::label_26_0::

		local episodeCfg = Activity122Config.instance:getEpisodeCo(VersionActivity1_3Enum.ActivityId.Act304, episodeId)

		if episodeCfg and Activity1_3ChessController.isOpenDay(episodeId) then
			return episodeCfg.chapterId
		end

		local selectCfg = self._episodeCfgList[1]

		for _, episodeCfg in ipairs(self._episodeCfgList) do
			if Activity122Model.instance:isEpisodeClear(episodeCfg.id) then
				selectCfg = episodeCfg
			else
				if Activity1_3ChessController.isOpenDay(episodeCfg.id) then
					selectCfg = episodeCfg
				end

				break
			end
		end

		if selectCfg then
			return selectCfg.chapterId
		end
	end
end

function Activity1_3ChessMapView:playViewAnimation(aniName)
	self._viewAnimator:Play(aniName, 0, 0)
end

function Activity1_3ChessMapView:_playNextBtnUnlockAni()
	local animator = gohelper.onceAddComponent(self._goNextBtnRoot, typeof(UnityEngine.Animator))

	animator:Play(UIAnimationName.Unlock)
end

function Activity1_3ChessMapView:playCloseAnimation(callback, obj)
	local animator = gohelper.onceAddComponent(self.viewGO, typeof(UnityEngine.Animator))

	animator:Play(UIAnimationName.Close, callback, obj)
end

function Activity1_3ChessMapView:playSwitchSceneAni(isNext)
	gohelper.setActive(self._goexcessive, true)

	local animatorType = typeof(UnityEngine.Animator)
	local swicthSceneAnimator = gohelper.findChildComponent(self.viewGO, "#go_excessive", animatorType)

	swicthSceneAnimator:Play(isNext and "story" or "hard")
end

function Activity1_3ChessMapView:_refreshRewardAnim()
	local isHas = Activity1_3ChessController.instance:checkHasReward()

	if self._lastIsHasReward ~= isHas then
		self._lastIsHasReward = isHas

		self._rewardAnimator:Play(isHas and "loop" or "idle")
	end
end

return Activity1_3ChessMapView
