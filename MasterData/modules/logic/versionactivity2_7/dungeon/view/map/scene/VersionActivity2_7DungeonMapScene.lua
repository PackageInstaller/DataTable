-- chunkname: @modules/logic/versionactivity2_7/dungeon/view/map/scene/VersionActivity2_7DungeonMapScene.lua

module("modules.logic.versionactivity2_7.dungeon.view.map.scene.VersionActivity2_7DungeonMapScene", package.seeall)

local VersionActivity2_7DungeonMapScene = class("VersionActivity2_7DungeonMapScene", VersionActivityFixedDungeonMapScene)
local cutSceneTime = 1
local delayCutSceneTime = 0.16

function VersionActivity2_7DungeonMapScene:onInitView()
	VersionActivity2_7DungeonMapScene.super.onInitView(self)

	local gameScreenState = GameGlobalMgr.instance:getScreenState()

	self._screenWidth, self._screenHeight = gameScreenState:getScreenSize()
	self._mainCameraGO = CameraMgr.instance:getMainCameraGO()
	self._mainRoot = CameraMgr.instance:getCameraTraceGO()
	self._mainCamera = CameraMgr.instance:getMainCamera()
	self._mainCameraAnim = gohelper.onceAddComponent(CameraMgr.instance:getCameraRootGO(), typeof(UnityEngine.Animator))
	self._mainCustomCameraData = self._mainCameraGO:GetComponent(PostProcessingMgr.PPCustomCamDataType)
	self._unitCameraGO = CameraMgr.instance:getUnitCameraGO()
	self._unitCamera = CameraMgr.instance:getUnitCamera()
	self._ppVolumeGo = gohelper.findChild(self._unitCameraGO, "PPVolume")
	self._unitPPVolume = self._ppVolumeGo:GetComponent(PostProcessingMgr.PPVolumeWrapType)

	local _, rotateY = transformhelper.getLocalRotation(self._mainRoot.transform)

	self._ppvalue = {
		bloomActive = false,
		BloomThreshold = 0.7,
		LocalBloomActive = false,
		localBloomActive = false,
		BloomActive = false,
		bloomThreshold = 0.7
	}

	local unitPPValue = {}

	for key, _ in pairs(self._ppvalue) do
		unitPPValue[key] = PostProcessingMgr.instance:getUnitPPValue(key)
	end

	local ignoreUIBlur = PostProcessingMgr.instance:getIgnoreUIBlur()

	self._cameraParam = {
		runtimeAnimatorController = self._mainCameraAnim.runtimeAnimatorController,
		volumeTrigger = self._mainCustomCameraData.volumeTrigger,
		usePostProcess = self._mainCustomCameraData.usePostProcess,
		unitCameraGOActive = self._unitCameraGO.gameObject.activeSelf,
		unitCameraEnable = self._unitCamera.enabled,
		unitPPValue = unitPPValue,
		orthographic = self._mainCamera.orthographic,
		Fov = self._mainCamera.fieldOfView,
		RotateY = rotateY,
		IgnoreUIBlur = ignoreUIBlur
	}
	self._isNeedCircleMv = UIBlockMgrExtend.needCircleMv
end

function VersionActivity2_7DungeonMapScene:addEvents()
	VersionActivity2_7DungeonMapScene.super.addEvents(self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenFullViewFinish, self._onOpenFullViewFinish, self, LuaEventSystem.Low)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	self.addEventCb(self, VersionActivityFixedDungeonController.instance, VersionActivityFixedDungeonEvent.SwitchBGM, self._switchBGM, self)
	self.addEventCb(self, VersionActivityFixedDungeonController.instance, VersionActivityFixedDungeonEvent.OpenFinishMapLevelView, self._openFinishMapLevelView, self)
end

function VersionActivity2_7DungeonMapScene:removeEvents()
	VersionActivity2_7DungeonMapScene.super.removeEvents(self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenFullViewFinish, self._onOpenFullViewFinish, self, LuaEventSystem.Low)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	self.removeEventCb(self, VersionActivityFixedDungeonController.instance, VersionActivityFixedDungeonEvent.SwitchBGM, self._switchBGM, self)
	self.removeEventCb(self, VersionActivityFixedDungeonController.instance, VersionActivityFixedDungeonEvent.OpenFinishMapLevelView, self._openFinishMapLevelView, self)
end

function VersionActivity2_7DungeonMapScene:onOpen()
	self:_onLoadRes()
	VersionActivity2_7DungeonMapScene.super.onOpen(self)
end

function VersionActivity2_7DungeonMapScene:_checkCameraParam()
	local isSpace = self:_isSpaceScene()

	if isSpace then
		self:_setCameraParam()
	else
		self:_resetCameraParam()
	end
end

function VersionActivity2_7DungeonMapScene:_onOpenFullViewFinish(viewName)
	if viewName == self.viewName then
		self:_checkCameraParam()
	end
end

local RevertUIBlurView = {
	ViewName.VersionActivity2_7StoreView,
	ViewName.VersionActivity2_7TaskView,
	ViewName.DungeonRewardView,
	ViewName.StoryFrontView,
	ViewName.ReactivityStoreView,
	ViewName.DungeonRecheckElementsView
}

function VersionActivity2_7DungeonMapScene:_onOpenView(viewName)
	if LuaUtil.tableContains(RevertUIBlurView, viewName) or viewName == ViewName.DungeonFragmentInfoView then
		self:_resetCameraParam()
	end

	if viewName == ViewName.StoryFrontView then
		self:_playSceneBgm(false)
	end
end

function VersionActivity2_7DungeonMapScene:_openFinishMapLevelView(viewGO)
	self:_setLoadParent(viewGO)
end

function VersionActivity2_7DungeonMapScene:_onCloseView(viewName, viewParam)
	if LuaUtil.tableContains(RevertUIBlurView, viewName) then
		self:_checkCameraParam()
	end

	if viewName == ViewName.DungeonFragmentInfoView and viewParam and viewParam.isRecheck then
		self:_resetCameraParam()
	end

	if viewName == ViewName.VersionActivity2_7DungeonMapLevelView then
		self:_setLoadParent(self.viewGO)
	end
end

function VersionActivity2_7DungeonMapScene:_onCloseViewFinish(viewName)
	if viewName == ViewName.StoryFrontView then
		self:_switchBGM()
		self:refreshMap()
	end
end

function VersionActivity2_7DungeonMapScene:_switchBGM()
	local isSpace = self:_isSpaceScene()

	self:_playSceneBgm(isSpace)
end

function VersionActivity2_7DungeonMapScene:_setLoadParent(parentGo)
	if self._loadObj then
		self._loadObj.transform:SetParent(parentGo.transform, true)
	end
end

function VersionActivity2_7DungeonMapScene:_cancelTask()
	TaskDispatcher.cancelTask(self._cutSpaceScene, self)
	TaskDispatcher.cancelTask(self._spaceSceneAnimFinish, self)
	TaskDispatcher.cancelTask(self._enterOrReturnSpace, self)
	TaskDispatcher.cancelTask(self._setMapPos, self)
end

function VersionActivity2_7DungeonMapScene:onClose()
	VersionActivity2_7DungeonMapScene.super.onClose(self)
	self:_cancelTask()
	self:_resetCameraParam()
	self:_playSceneBgm(false)

	if self._rotateTweenId then
		ZProj.TweenHelper.KillById(self._rotateTweenId)
	end

	self:tweenFinishRotateCallback()

	if self._mainCameraAnim then
		self._mainCameraAnim.runtimeAnimatorController = self._cameraParam.runtimeAnimatorController
	end

	self._curEpisodeIndex = nil

	VersionActivity2_7DungeonController.instance:resetLoading()

	local gameScreenState = GameGlobalMgr.instance:getScreenState()
	local width, height = gameScreenState:getScreenSize()

	if width ~= self._screenWidth or height ~= self._screenHeight then
		GameGlobalMgr.instance:dispatchEvent(GameStateEvent.OnScreenResize, width, height)
	end
end

function VersionActivity2_7DungeonMapScene:refreshMap(needTween, mapCfg)
	self._mapCfg = mapCfg or VersionActivityFixedDungeonConfig.instance:getEpisodeMapConfig(self.activityDungeonMo.episodeId)
	self.needTween = needTween

	self:_checkGoSpaceOrReturn()
end

function VersionActivity2_7DungeonMapScene:_initScene()
	local sizeGo = gohelper.findChild(self._sceneGo, "root/size")

	if sizeGo then
		VersionActivity2_7DungeonMapScene.super._initScene(self)
	else
		self._mapMinX = nil
		self._mapMaxX = nil
		self._mapMinY = nil
		self._mapMaxY = nil
	end
end

function VersionActivity2_7DungeonMapScene:_reallyCutScene()
	if self._mapCfg.id == self._lastLoadMapId then
		if not self.loadedDone then
			return
		end

		self:_initElements()
		self:_setMapPos()
	else
		if self._lastLoadMapId then
			local mapcfg = lua_chapter_map.configDict[self._lastLoadMapId]

			if mapcfg.res == self._mapCfg.res then
				self._lastLoadMapId = self._mapCfg.id

				self:_initScene()
				self:_setMapPos()
				self:_addMapLight()
				self:_initElements()
				self:_addMapAudio()

				return
			end
		end

		self._lastLoadMapId = self._mapCfg.id

		self:loadMap()
	end

	VersionActivityFixedDungeonModel.instance:setMapNeedTweenState(true)
end

VersionActivity2_7DungeonMapScene.UI_CLICK_BLOCK_KEY = "VersionActivity2_7DungeonMapScene_Click"

function VersionActivity2_7DungeonMapScene:_startBlock()
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(VersionActivity2_7DungeonMapScene.UI_CLICK_BLOCK_KEY)
end

function VersionActivity2_7DungeonMapScene:_endBlock()
	UIBlockMgrExtend.setNeedCircleMv(self._isNeedCircleMv)
	UIBlockMgr.instance:endBlock(VersionActivity2_7DungeonMapScene.UI_CLICK_BLOCK_KEY)
end

function VersionActivity2_7DungeonMapScene:_checkGoSpaceOrReturn()
	local curEpisodeIndex = DungeonConfig.instance:getEpisodeLevelIndexByEpisodeId(self.activityDungeonMo.episodeId)
	local lastEpisodeIndex = self._curEpisodeIndex

	self:_cancelTask()

	if lastEpisodeIndex and not self:_isSpaceScene(lastEpisodeIndex) and self:_isSpaceScene(curEpisodeIndex) then
		self._sceneAnimType = VersionActivity2_7DungeonEnum.SceneAnimType.GotoSpace

		self:_startBlock()
		self:_tweenPreSpaceScenePos()
	elseif lastEpisodeIndex and self:_isSpaceScene(lastEpisodeIndex) and not self:_isSpaceScene(curEpisodeIndex) then
		self._sceneAnimType = VersionActivity2_7DungeonEnum.SceneAnimType.ReturnEarth

		self:_startBlock()
		self:_enterOrReturnSpace()
	else
		self._sceneAnimType = VersionActivity2_7DungeonEnum.SceneAnimType.Normal

		self:_reallyCutScene()
	end

	self._curEpisodeIndex = curEpisodeIndex
end

function VersionActivity2_7DungeonMapScene:_getEpisodeCoByIndex(index)
	if not self._episodeList then
		local dungeonEnum = VersionActivityFixedHelper.getVersionActivityDungeonEnum(2, 7)

		self._episodeList = DungeonConfig.instance:getChapterEpisodeCOList(dungeonEnum.DungeonChapterId.Story)
	end

	if self._episodeList[index] then
		local id = self._episodeList[index].id

		return lua_chapter_map.configDict[id]
	end
end

function VersionActivity2_7DungeonMapScene:_getPreSpaceScenePos()
	local preIndex = self:_getFirstSpaceSceneEpisodeIndex() - 1
	local mapcfg = self:_getEpisodeCoByIndex(preIndex)

	return mapcfg.initPos
end

function VersionActivity2_7DungeonMapScene:_getFirstSpaceSceneEpisodeIndex()
	return VersionActivity2_7DungeonEnum.SpaceSceneEpisodeIndexs[1] or 18
end

function VersionActivity2_7DungeonMapScene:_tweenPreSpaceScenePos()
	local pos = self:_getPreSpaceScenePos()
	local posParam = string.splitToNumber(pos, "#")

	self._tempVector:Set(posParam[1], posParam[2], 0)

	if self._tempVector == self._oldScenePos then
		self:tweenFinishCallback()

		return
	end

	self:tweenSetScenePos(self._tempVector, self._oldScenePos)
end

function VersionActivity2_7DungeonMapScene:focusElementByCo(elementCo)
	local pos = string.splitToNumber(elementCo.pos, "#")

	if not -pos[2] then
		local x, y = -pos[1] or 0, 0

		self._tempVector:Set(x, y, 0)
		self:tweenSetScenePos(self._tempVector)
	end
end

function VersionActivity2_7DungeonMapScene:tweenFinishCallback()
	VersionActivity2_7DungeonMapScene.super.tweenFinishCallback(self)

	if self._sceneAnimType == VersionActivity2_7DungeonEnum.SceneAnimType.GotoSpace then
		TaskDispatcher.cancelTask(self._enterOrReturnSpace, self)
		TaskDispatcher.runDelay(self._enterOrReturnSpace, self, delayCutSceneTime)

		self.needTween = false
	end
end

function VersionActivity2_7DungeonMapScene:_loadSceneFinish()
	self.loadedDone = true

	self:disposeOldMap()

	local assetUrl = self._sceneUrl
	local assetItem = self._mapLoader:getAssetItem(assetUrl)
	local mainPrefab = assetItem:GetResource(assetUrl)

	self._sceneGo = gohelper.clone(mainPrefab, self._sceneRoot, self._mapCfg.id)
	self._sceneTrans = self._sceneGo.transform

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnLoadSceneFinish, {
		mapConfig = self._mapCfg,
		mapSceneGo = self._sceneGo
	})
	TaskDispatcher.cancelTask(self._setMapPos, self)
	self:_initScene()

	if self._sceneAnimType == VersionActivity2_7DungeonEnum.SceneAnimType.ReturnEarth then
		self:_tweenPreSpaceScenePos()
		self:_resetCameraParam()
	else
		if self._sceneAnimType == VersionActivity2_7DungeonEnum.SceneAnimType.GotoSpace then
			self._sceneAnimType = VersionActivity2_7DungeonEnum.SceneAnimType.Normal
		end

		self:_setMapPos()
	end

	self:_addMapLight()
	self:_initElements()
	self:_addMapAudio()
	VersionActivity2_7DungeonController.instance:loadingFinish(self.activityDungeonMo.episodeId, self._sceneGo)
end

function VersionActivity2_7DungeonMapScene:_enterOrReturnSpace()
	gohelper.setActive(self._loadObj, true)

	local isSpace = self._sceneAnimType == VersionActivity2_7DungeonEnum.SceneAnimType.GotoSpace

	self:_playEnterOrReturnSpaceAnim(isSpace, 0)

	if isSpace then
		if not VersionActivity2_7DungeonEnum.GotoSpaceAnimName then
			local animName = VersionActivity2_7DungeonEnum.returnAnimName

			self:_playSceneAnimBgm(isSpace)

			local animTime = 2.2

			if self._animClipTime and self._animClipTime[animName] then
				animTime = self._animClipTime[animName]
			end

			TaskDispatcher.cancelTask(self._cutSpaceScene, self)
			TaskDispatcher.runDelay(self._cutSpaceScene, self, cutSceneTime)
			TaskDispatcher.cancelTask(self._spaceSceneAnimFinish, self)
			TaskDispatcher.runDelay(self._spaceSceneAnimFinish, self, animTime)
		end
	end
end

function VersionActivity2_7DungeonMapScene:_playEnterOrReturnSpaceAnim(isSpace, progress)
	if isSpace then
		if not VersionActivity2_7DungeonEnum.GotoSpaceAnimName then
			local animName = VersionActivity2_7DungeonEnum.returnAnimName

			if self._mainCameraAnim then
				self._mainCameraAnim.enabled = true

				self._mainCameraAnim:Play(animName, 0, progress or 0)
			end

			if self._loadAnim then
				self._loadAnim:Play(animName, 0, progress or 0)
			end

			if progress == 1 then
				self:_playSceneBgm(isSpace)
			else
				self:_playSceneAnimBgm(isSpace)
			end
		end
	end
end

function VersionActivity2_7DungeonMapScene:_playSceneBgm(isSpaceScene)
	local bgm = AudioEnum2_7.VersionActivity2_7SpaceBGM

	if isSpaceScene then
		if not bgm.play_2_7_yuzhou_ui_checkpoint_amb_space then
			local audioId = bgm.stop_2_7_yuzhou_ui_checkpoint_amb_space

			AudioMgr.instance:trigger(audioId)
		end
	end
end

function VersionActivity2_7DungeonMapScene:_playSceneAnimBgm(isSpaceScene)
	local bgm = AudioEnum2_7.VersionActivity2_7SpaceBGM

	if isSpaceScene then
		if not bgm.play_2_7_yuzhou_ui_checkinspace then
			local audioId = bgm.play_2_7_yuzhou_ui_checkoutspace

			AudioMgr.instance:trigger(audioId)
		end
	end
end

function VersionActivity2_7DungeonMapScene:_cutSpaceScene()
	self:_reallyCutScene()

	if self:_isSpaceScene() then
		self:_setCameraParam()
	end
end

function VersionActivity2_7DungeonMapScene:_spaceSceneAnimFinish()
	self:_setLoadParent(self.viewGO)
	gohelper.setActive(self._loadObj, false)

	local isSpace = self:_isSpaceScene()

	if not isSpace then
		self._mainCameraAnim.enabled = false
	end

	if self._sceneAnimType == VersionActivity2_7DungeonEnum.SceneAnimType.ReturnEarth then
		self.needTween = true

		TaskDispatcher.cancelTask(self._setMapPos, self)

		if self._curEpisodeIndex == self:_getFirstSpaceSceneEpisodeIndex() - 1 then
			self:_setMapPos()
		else
			TaskDispatcher.runDelay(self._setMapPos, self, delayCutSceneTime)
		end

		self._sceneAnimType = VersionActivity2_7DungeonEnum.SceneAnimType.Normal
	end

	self:_playSceneBgm(isSpace)
	self:_endBlock()
end

function VersionActivity2_7DungeonMapScene:_onLoadRes()
	if self._loader then
		self._loader:dispose()
	end

	local _resList = {
		VersionActivity2_7DungeonEnum.SceneLoadObj,
		VersionActivity2_7DungeonEnum.SceneLoadAnim
	}

	self._loader = MultiAbLoader.New()

	self._loader:setPathList(_resList)
	self._loader:startLoad(self._onLoadedFinish, self)
end

function VersionActivity2_7DungeonMapScene:_onLoadedFinish()
	local animRes = VersionActivity2_7DungeonEnum.SceneLoadAnim
	local loadRes = VersionActivity2_7DungeonEnum.SceneLoadObj
	local animInst = self._loader:getAssetItem(animRes):GetResource(animRes)
	local loadInst = self._loader:getAssetItem(loadRes):GetResource(loadRes)

	self._loadObj = gohelper.clone(loadInst, self.viewGO)
	self._loadAnim = gohelper.onceAddComponent(self._loadObj, typeof(UnityEngine.Animator))

	gohelper.setActive(self._loadObj, false)

	self._mainCameraAnim.runtimeAnimatorController = animInst
	self._mainCameraAnim.enabled = false

	if not self._animClipTime then
		self._animClipTime = {}

		if animInst then
			for i = 0, animInst.animationClips.Length - 1 do
				local clip = animInst.animationClips[i]

				self._animClipTime[clip.name] = clip.length
			end
		end
	end

	self:_playEnterOrReturnSpaceAnim(self:_isSpaceScene(), 1)
end

function VersionActivity2_7DungeonMapScene:_setCameraParam()
	self._mainCustomCameraData.usePostProcess = true
	self._mainCustomCameraData.volumeTrigger = self._ppVolumeGo.transform

	gohelper.setActive(self._unitCameraGO, true)

	self._unitCamera.enabled = false

	for key, value in pairs(self._ppvalue) do
		PostProcessingMgr.instance:setUnitPPValue(key, value)
	end

	PostProcessingMgr.instance:setIgnoreUIBlur(true)
end

function VersionActivity2_7DungeonMapScene:_resetCameraParam()
	self._mainCustomCameraData.usePostProcess = self._cameraParam.usePostProcess
	self._mainCustomCameraData.volumeTrigger = self._cameraParam.volumeTrigger

	gohelper.setActive(self._unitCameraGO, self._cameraParam.unitCameraGOActive)

	self._unitCamera.enabled = self._cameraParam.unitCameraEnable

	local unitPPValue = self._cameraParam.unitPPValue

	for key, _ in pairs(self._ppvalue) do
		PostProcessingMgr.instance:setUnitPPValue(key, unitPPValue[key])
	end

	PostProcessingMgr.instance:setIgnoreUIBlur(self._cameraParam.IgnoreUIBlur)
end

function VersionActivity2_7DungeonMapScene:_initCamera()
	if not self:_isSpaceScene() then
		VersionActivity2_7DungeonMapScene.super._initCamera(self)
	end
end

function VersionActivity2_7DungeonMapScene:_resetCamera()
	if not self:_isSpaceScene() then
		VersionActivity2_7DungeonMapScene.super._resetCamera(self)
	end
end

function VersionActivity2_7DungeonMapScene:_isSpaceScene(index)
	local cutSceneEpisodeIndex = VersionActivity2_7DungeonEnum.SpaceSceneEpisodeIndexs

	index = index or DungeonConfig.instance:getEpisodeLevelIndexByEpisodeId(self.activityDungeonMo.episodeId)

	for _, _index in ipairs(cutSceneEpisodeIndex) do
		if index == _index then
			return true
		end
	end
end

function VersionActivity2_7DungeonMapScene:_onDragBegin(param, pointerEventData)
	VersionActivity2_7DungeonMapScene.super._onDragBegin(self, param, pointerEventData)
	self:killTween()
end

function VersionActivity2_7DungeonMapScene:_onDrag(param, pointerEventData)
	if self:_isSpaceScene() then
		local deltaPosX = pointerEventData.delta.x
		local rx, ry, rz = transformhelper.getLocalRotation(self._mainRoot.transform)

		if ry > 200 then
			ry = ry - 360
		end

		ry = Mathf.Clamp(ry + deltaPosX, -35, 35)

		self:directSetCameraRotate(rx, ry, rz)
	else
		VersionActivity2_7DungeonMapScene.super._onDrag(self, param, pointerEventData)
	end
end

function VersionActivity2_7DungeonMapScene:_onDragEnd(param, pointerEventData)
	self:killTween()

	if self:_isSpaceScene() then
		local rx, ry, rz = transformhelper.getLocalRotation(self._mainRoot.transform)

		self._rotateTweenId = ZProj.TweenHelper.DOTweenFloat(ry, (ry > 200 or nil) and 360, VersionActivity2_7DungeonEnum.DragEndAnimTime, self.tweenFrameRotateCallback, self.tweenFinishRotateCallback, self, nil, EaseType.OutCubic)
	else
		self._dragBeginPos = nil
	end
end

function VersionActivity2_7DungeonMapScene:killTween()
	VersionActivity2_7DungeonMapScene.super.killTween(self)

	if self._rotateTweenId then
		ZProj.TweenHelper.KillById(self._rotateTweenId)
	end
end

function VersionActivity2_7DungeonMapScene:tweenFrameRotateCallback(value)
	self._mainRoot = self._mainRoot or CameraMgr.instance:getCameraTraceGO()

	local rx, ry, rz = transformhelper.getLocalRotation(self._mainRoot.transform)

	transformhelper.setLocalRotation(self._mainRoot.transform, rx, value, rz)
end

function VersionActivity2_7DungeonMapScene:tweenFinishRotateCallback()
	self._mainRoot = self._mainRoot or CameraMgr.instance:getCameraTraceGO()

	local rx, ry, rz = transformhelper.getLocalRotation(self._mainRoot.transform)
	local targetY = self._cameraParam.RotateY

	transformhelper.setLocalRotation(self._mainRoot.transform, rx, targetY, rz)
end

function VersionActivity2_7DungeonMapScene:directSetCameraRotate(rx, ry, rz)
	if not self._mainRoot or gohelper.isNil(self._mainRoot) then
		return
	end

	local speed = Time.deltaTime * VersionActivity2_7DungeonEnum.DragSpeed

	transformhelper.setLocalRotationLerp(self._mainRoot.transform, rx, ry, rz, speed)
	VersionActivityFixedDungeonController.instance:dispatchEvent(VersionActivityFixedDungeonEvent.OnMapPosChanged, self._scenePos, self.needTween)
	self:_updateElementArrow()
end

function VersionActivity2_7DungeonMapScene:onDestroyView()
	VersionActivity2_7DungeonMapScene.super.onDestroyView(self)

	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end

	if self._loadObj then
		gohelper.destroy(self._loadObj)

		self._loadObj = nil
		self._loadAnim = nil
	end
end

return VersionActivity2_7DungeonMapScene
