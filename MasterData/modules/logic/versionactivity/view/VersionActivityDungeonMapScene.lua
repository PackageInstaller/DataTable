-- chunkname: @modules/logic/versionactivity/view/VersionActivityDungeonMapScene.lua

module("modules.logic.versionactivity.view.VersionActivityDungeonMapScene", package.seeall)

local VersionActivityDungeonMapScene = class("VersionActivityDungeonMapScene", BaseView)

function VersionActivityDungeonMapScene:onInitView()
	self._gofullscreen = gohelper.findChild(self.viewGO, "#go_fullscreen")
	self._goarrow = gohelper.findChild(self.viewGO, "#go_arrow")
	self._gotoptipsbg = gohelper.findChild(self.viewGO, "#go_main/#go_toptipsbg")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivityDungeonMapScene:addEvents()
	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnRecheckElement, self._onRecheckElement, self)
end

function VersionActivityDungeonMapScene:removeEvents()
	self.removeEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnRecheckElement, self._onRecheckElement, self)
end

function VersionActivityDungeonMapScene:_editableInitView()
	if ViewMgr.instance:isOpen(ViewName.MainThumbnailView) then
		MainThumbnailHeroView.setCameraIdle()
	end

	self._tempVector = Vector3()
	self._dragDeltaPos = Vector3()

	self:_initCamera()
	self:_initMapRootNode()
	self:_initDrag()
end

function VersionActivityDungeonMapScene:_initDrag()
	self._drag = SLFramework.UGUI.UIDragListener.Get(self._gofullscreen)

	self._drag:AddDragBeginListener(self._onDragBegin, self)
	self._drag:AddDragEndListener(self._onDragEnd, self)
	self._drag:AddDragListener(self._onDrag, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

function VersionActivityDungeonMapScene:_onOpenView(viewName)
	if viewName == ViewName.StoryView then
		self:_disposeScene()
		GameGCMgr.instance:dispatchEvent(GameGCEvent.DelayFullGC, 0, self)
	end
end

function VersionActivityDungeonMapScene:_onCloseView(viewName)
	if viewName == ViewName.StoryView then
		self:_rebuildScene()
	end
end

function VersionActivityDungeonMapScene:_onDragBegin(param, pointerEventData)
	self._dragBeginPos = self:getDragWorldPos(pointerEventData)

	if self._sceneTrans then
		self._beginDragPos = self._sceneTrans.localPosition
	end
end

function VersionActivityDungeonMapScene:_onDragEnd(param, pointerEventData)
	self._dragBeginPos = nil
	self._beginDragPos = nil

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnSetClickDown)
end

function VersionActivityDungeonMapScene:_onDrag(param, pointerEventData)
	if not self._dragBeginPos then
		return
	end

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnSetClickDown)

	local deltaPos = self:getDragWorldPos(pointerEventData) - self._dragBeginPos

	self:drag(deltaPos)
end

function VersionActivityDungeonMapScene:drag(deltaPos)
	if not self._sceneTrans or not self._beginDragPos then
		return
	end

	self._dragDeltaPos.x = deltaPos.x
	self._dragDeltaPos.y = deltaPos.y

	local targetPos = self:vectorAdd(self._beginDragPos, self._dragDeltaPos)

	self:setScenePosSafety(targetPos)
	self:_updateElementArrow()
end

function VersionActivityDungeonMapScene:_updateElementArrow()
	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnUpdateElementArrow)
end

function VersionActivityDungeonMapScene:setScenePosSafety(targetPos, tween)
	if not self._sceneTrans then
		return
	end

	if targetPos.x < self._mapMinX then
		targetPos.x = self._mapMinX
	elseif targetPos.x > self._mapMaxX then
		targetPos.x = self._mapMaxX
	end

	if targetPos.y < self._mapMinY then
		targetPos.y = self._mapMinY
	elseif targetPos.y > self._mapMaxY then
		targetPos.y = self._mapMaxY
	end

	self._targetPos = targetPos

	if tween then
		if not self._tweenTime then
			ZProj.TweenHelper.DOLocalMove(self._sceneTrans, targetPos.x, targetPos.y, 0, self._tweenTime, self._localMoveDone, self, nil, EaseType.InOutQuart)
		end
	else
		self._sceneTrans.localPosition = targetPos
	end

	self:_updateElementArrow()
end

function VersionActivityDungeonMapScene:_localMoveDone()
	self:_updateElementArrow()
end

function VersionActivityDungeonMapScene:vectorAdd(v1, v2)
	local tempVector = self._tempVector

	tempVector.x = v1.x + v2.x
	tempVector.y = v1.y + v2.y

	return tempVector
end

function VersionActivityDungeonMapScene:getDragWorldPos(pointerEventData)
	local mainCamera = CameraMgr.instance:getMainCamera()
	local refPos = self._gofullscreen.transform.position

	return (SLFramework.UGUI.RectTrHelper.ScreenPosToWorldPos(pointerEventData.position, mainCamera, refPos))
end

function VersionActivityDungeonMapScene:_initCamera()
	local camera = CameraMgr.instance:getMainCamera()

	camera.orthographic = true

	local scale = GameUtil.getAdapterScale()

	camera.orthographicSize = VersionActivityEnum.DungeonMapCameraSize * scale
end

function VersionActivityDungeonMapScene:_resetCamera()
	local camera = CameraMgr.instance:getMainCamera()

	camera.orthographicSize = 5
	camera.orthographic = false
end

function VersionActivityDungeonMapScene:_initMapRootNode()
	local mainTrans = CameraMgr.instance:getMainCameraTrs().parent
	local sceneRoot = CameraMgr.instance:getSceneRoot()

	self._sceneRoot = UnityEngine.GameObject.New("VersionActivityDungeonMapScene")

	local x, y, z = transformhelper.getLocalPos(mainTrans)

	transformhelper.setLocalPos(self._sceneRoot.transform, 0, y, 0)
	gohelper.addChild(sceneRoot, self._sceneRoot)
end

function VersionActivityDungeonMapScene:getSceneGo()
	return self._sceneGo
end

function VersionActivityDungeonMapScene:refreshMap()
	VersionActivityFixedDungeonController.instance:dispatchEvent(VersionActivityFixedDungeonEvent.OnChangeMap)

	self._mapCfg = VersionActivityDungeonController.instance:getEpisodeMapConfig(self.activityDungeonMo.episodeId)

	if self._mapCfg.id == self._lastLoadMapId then
		self:refreshHardMapEffectAndAudio()

		self.dotTween = nil

		return
	end

	self._lastLoadMapId = self._mapCfg.id

	self:loadMap()
end

function VersionActivityDungeonMapScene:loadMap()
	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnChangeMap)

	if self.loadedDone then
		self._oldMapLoader = self._mapLoader
		self._oldSceneGo = self._sceneGo
		self._mapLoader = nil
	end

	if self._mapLoader then
		self._mapLoader:dispose()

		self._mapLoader = nil
	end

	self._tempMapCfg = nil
	self.loadedDone = false
	self._mapLoader = MultiAbLoader.New()

	local allResPath = {}

	self:buildLoadRes(allResPath, self._mapCfg)

	self._canvasUrl = allResPath[1]
	self._interactiveItemUrl = allResPath[2]
	self._sceneUrl = allResPath[3]
	self._mapAudioUrl = allResPath[4]
	self._mapLightUrl = allResPath[5]
	self._fogUrl = allResPath[6]

	self._mapLoader:addPath(self._sceneUrl)
	self._mapLoader:addPath(self._canvasUrl)
	self._mapLoader:addPath(self._interactiveItemUrl)
	self._mapLoader:addPath(self._mapAudioUrl)
	self._mapLoader:addPath(self._mapLightUrl)
	self._mapLoader:addPath(self._fogUrl)
	self._mapLoader:startLoad(self._loadSceneFinish, self)
end

function VersionActivityDungeonMapScene:_loadSceneFinish()
	self.loadedDone = true

	self:disposeOldMap()

	local assetUrl = self._sceneUrl
	local assetItem = self._mapLoader:getAssetItem(assetUrl)
	local mainPrefab = assetItem:GetResource(assetUrl)

	self._sceneGo = gohelper.clone(mainPrefab, self._sceneRoot, self._mapCfg.id)
	self._sceneTrans = self._sceneGo.transform

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnLoadSceneFinish, {
		self._mapCfg,
		self._sceneGo,
		self
	})
	DungeonController.instance:dispatchEvent(DungeonEvent.OnShowMap)

	self.goFogEffect = gohelper.clone(self._mapLoader:getAssetItem(self._fogUrl):GetResource(self._fogUrl), self._sceneGo)
	self.goRainEffect = gohelper.findChild(self._sceneGo, "SceneEffect")

	local goBigRain = gohelper.findChild(self._sceneGo, "SceneEffect/big")

	gohelper.setActive(goBigRain, true)
	self:refreshHardMapEffectAndAudio()
	self:_initScene()
	self:_initCanvas()
	self:_addAllAudio()
	TaskDispatcher.runDelay(self._addMapLight, self, 0.3)
end

function VersionActivityDungeonMapScene:_addAllAudio()
	self:_addMapAudio()
end

function VersionActivityDungeonMapScene:buildLoadRes(allResPath, mapCfg)
	table.insert(allResPath, "ui/viewres/dungeon/chaptermap/chaptermapscenecanvas.prefab")
	table.insert(allResPath, "ui/viewres/dungeon/chaptermap/dungeonmapinteractiveitem.prefab")
	table.insert(allResPath, ResUrl.getDungeonMapRes(mapCfg.res))
	table.insert(allResPath, "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_audio_1_1.prefab")
	table.insert(allResPath, "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_light.prefab")
	table.insert(allResPath, "scenes/m_s14_hddt_hd01/prefab/s08_hddt_hd_01_fog.prefab")
end

function VersionActivityDungeonMapScene:_disposeScene()
	self._oldScenePos = self._targetPos
	self._tempMapCfg = self._mapCfg

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnDisposeScene)

	if self._mapAudioGo then
		self._mapAudioGo = nil

		AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_noise_allarea)
	end

	if self._sceneGo then
		gohelper.destroy(self._sceneGo)

		self._sceneGo = nil
	end

	self._sceneTrans = nil
	self._elementRoot = nil

	if self._mapLoader then
		self._mapLoader:dispose()

		self._mapLoader = nil
	end

	TaskDispatcher.cancelTask(self._addMapLight, self)
	TaskDispatcher.cancelTask(self._addAllAudio, self)

	self._mapAudioGo = nil
end

function VersionActivityDungeonMapScene:_rebuildScene()
	self:loadMap(self._tempMapCfg)

	self._tempMapCfg = nil
end

function VersionActivityDungeonMapScene:_addMapLight()
	local assetUrl = self._mapLightUrl
	local assetItem = self._mapLoader:getAssetItem(assetUrl)
	local mainPrefab = assetItem:GetResource(assetUrl)

	gohelper.clone(mainPrefab, self._sceneGo)
	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnInitElements)
	VersionActivityFixedDungeonController.instance:dispatchEvent(VersionActivityFixedDungeonEvent.OnActDungeonInitElements)
end

function VersionActivityDungeonMapScene:_addMapAudio()
	local assetUrl = self._mapAudioUrl
	local assetItem = self._mapLoader:getAssetItem(assetUrl)
	local mainPrefab = assetItem:GetResource(assetUrl)

	self._mapAudioGo = gohelper.clone(mainPrefab, self._sceneGo, "audio")

	gohelper.addChild(self._sceneGo, self._mapAudioGo)
	gohelper.setActive(self._mapAudioGo, true)
	transformhelper.setLocalPos(self._mapAudioGo.transform, 0, 0, 0)

	local areaAudio = self._mapCfg.areaAudio

	if string.nilorempty(areaAudio) then
		return
	end

	local audioGo = gohelper.findChild(self._mapAudioGo, "audio")

	if areaAudio == "all" then
		local transform = audioGo.transform
		local itemCount = transform.childCount

		for i = 1, itemCount do
			local child = transform:GetChild(i - 1)

			gohelper.setActive(child.gameObject, true)
		end

		return
	end

	local areaList = string.split(areaAudio, "#")

	for i, areaName in ipairs(areaList) do
		local areaGo = gohelper.findChild(audioGo, areaName)

		gohelper.setActive(areaGo, true)
	end
end

function VersionActivityDungeonMapScene:_initCanvas()
	local assetItem = self._mapLoader:getAssetItem(self._canvasUrl)
	local mainPrefab = assetItem:GetResource(self._canvasUrl)

	self._sceneCanvasGo = gohelper.clone(mainPrefab, self._sceneGo)
	self._sceneCanvas = self._sceneCanvasGo:GetComponent("Canvas")
	self._sceneCanvas.worldCamera = CameraMgr.instance:getMainCamera()
	assetItem = self._mapLoader:getAssetItem(self._interactiveItemUrl)
	self._itemPrefab = assetItem:GetResource(self._interactiveItemUrl)
end

function VersionActivityDungeonMapScene:getInteractiveItem()
	self._uiGo = gohelper.clone(self._itemPrefab, self._sceneCanvasGo)
	self._interactiveItem = MonoHelper.addLuaComOnceToGo(self._uiGo, DungeonMapInteractiveItem)

	self._interactiveItem:setBtnClosePosZ(-5)
	gohelper.setActive(self._uiGo, false)

	return self._interactiveItem
end

function VersionActivityDungeonMapScene:showInteractiveItem()
	return not gohelper.isNil(self._uiGo)
end

function VersionActivityDungeonMapScene:_initScene()
	local sizeGo = gohelper.findChild(self._sceneGo, "root/size")
	local box = sizeGo:GetComponentInChildren(typeof(UnityEngine.BoxCollider))

	self._mapSize = box.size

	local canvasGo
	local scale = GameUtil.getAdapterScale()
	local worldcorners = (scale ~= 1 and ViewMgr.instance:getUILayer(UILayerName.Hud) or ViewMgr.instance:getUIRoot()).transform:GetWorldCorners()
	local uiCamera = CameraMgr.instance:getUICamera()

	if uiCamera then
		if not uiCamera.orthographicSize then
			local uiCameraSize = 5
			local cameraSizeRate = VersionActivityEnum.DungeonMapCameraSize / uiCameraSize
			local posTL = worldcorners[1] * scale * cameraSizeRate
			local posBR = worldcorners[3] * scale * cameraSizeRate

			self._viewWidth = math.abs(posBR.x - posTL.x)
			self._viewHeight = math.abs(posBR.y - posTL.y)
			self._mapMinX = posTL.x - (self._mapSize.x - self._viewWidth)
			self._mapMaxX = posTL.x
			self._mapMinY = posTL.y
			self._mapMaxY = posTL.y + (self._mapSize.y - self._viewHeight)

			if self._oldScenePos then
				self._sceneTrans.localPosition = self._oldScenePos
			end

			if self.dotTween then
				self:_setInitPos(false)
			else
				self:_setInitPos(self._oldScenePos)
			end

			self.dotTween = nil
			self._oldScenePos = nil
		end
	end
end

function VersionActivityDungeonMapScene:_setInitPos(tween)
	if not self._mapCfg then
		return
	end

	local pos = self._mapCfg.initPos
	local posParam = string.splitToNumber(pos, "#")

	self:setScenePosSafety(Vector3(posParam[1], posParam[2], 0), tween)
end

function VersionActivityDungeonMapScene:disposeOldMap()
	self._oldScenePos = self._sceneTrans and self._sceneTrans.localPosition or nil

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnDisposeOldMap, self.viewName)

	if self._oldSceneGo then
		gohelper.destroy(self._oldSceneGo)

		self._oldSceneGo = nil
	end

	if self._mapAudioGo then
		self._mapAudioGo = nil

		AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_noise_allarea)
	end

	if self._oldMapLoader then
		self._oldMapLoader:dispose()

		self._oldMapLoader = nil
	end

	TaskDispatcher.cancelTask(self._addAllAudio, self)
	TaskDispatcher.cancelTask(self._addMapLight, self)
end

function VersionActivityDungeonMapScene:_showMapTip()
	gohelper.setActive(self._gotoptipsbg, false)
end

function VersionActivityDungeonMapScene:_hideMapTip()
	gohelper.setActive(self._gotoptipsbg, false)
end

function VersionActivityDungeonMapScene:onUpdateParam()
	self:refreshMap()
end

function VersionActivityDungeonMapScene:onOpen()
	self.activityDungeonMo = self.viewContainer.versionActivityDungeonBaseMo

	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnFocusElement, self._focusElementById, self)
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenResize, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnSetEpisodeListVisible, self._setEpisodeListVisible, self)
	self.addEventCb(self, VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnModeChange, self.onModeChange, self)
	self:refreshMap()
end

function VersionActivityDungeonMapScene:onModeChange()
	self.dotTween = true

	self:refreshMap()
end

function VersionActivityDungeonMapScene:_setEpisodeListVisible(value)
	if value and self._interactiveItem then
		self._interactiveItem:_onOutAnimationFinished()
	end

	gohelper.setActive(self._gofullscreen, value)
end

function VersionActivityDungeonMapScene:_onScreenResize()
	if self._sceneGo then
		local camera = CameraMgr.instance:getMainCamera()
		local scale = GameUtil.getAdapterScale()

		camera.orthographicSize = VersionActivityEnum.DungeonMapCameraSize * scale

		self:_initScene()
	end
end

function VersionActivityDungeonMapScene:_focusElementById(id)
	local config = lua_chapter_map_element.configDict[id]
	local pos = string.splitToNumber(config.pos, "#")

	if not pos[2] then
		local x, y = pos[1] or 0, 0
		local offsetPos = string.splitToNumber(config.offsetPos, "#")

		x = x + (offsetPos[1] or 0)
		y = y + (offsetPos[2] or 0)
		x = self._mapMaxX - x + self._viewWidth / 2
		y = self._mapMinY - y - self._viewHeight / 2 + 2

		self:setScenePosSafety(Vector3(x, y, 0), not DungeonMapModel.instance.directFocusElement)
	end
end

function VersionActivityDungeonMapScene:refreshHardMapEffectAndAudio()
	local isHard = self.activityDungeonMo:isHardMode()

	if isHard then
		AudioEffectMgr.instance:playAudio(AudioEnum.Story.Play_Chapter_Start)
	else
		AudioEffectMgr.instance:stopAudio(AudioEnum.Story.Play_Chapter_Start)
	end

	if self.goRainEffect then
		gohelper.setActive(self.goRainEffect, isHard)
	end

	if self.goFogEffect then
		gohelper.setActive(self.goFogEffect, isHard)
	end
end

function VersionActivityDungeonMapScene:setVisible(isVisible)
	gohelper.setActive(self._sceneRoot, isVisible)

	if isVisible then
		self:_initCamera()
	end
end

function VersionActivityDungeonMapScene:_onRecheckElement(elementId, isGM)
	local elementCo = lua_chapter_map_element.configDict[elementId]

	if not self.viewParam.chapterId then
		local chapterId = self.viewContainer:_getChapterId()

		if not DungeonController.instance:isNeedRecheckInteractive(elementCo) then
			DungeonController.instance:onRecheckElement(elementId, self.viewParam.chapterId)

			return
		end

		local item = self:getInteractiveItem()
		local pos = self._sceneTrans.localPosition

		DungeonController.instance:onRecheckElement(elementId, self.viewParam.chapterId, item, pos, isGM)
	end
end

function VersionActivityDungeonMapScene:onClose()
	self:_resetCamera()
end

function VersionActivityDungeonMapScene:onDestroyView()
	gohelper.destroy(self._sceneRoot)
	self:disposeOldMap()

	if self._mapLoader then
		self._mapLoader:dispose()
	end

	self._drag:RemoveDragBeginListener()
	self._drag:RemoveDragListener()
	self._drag:RemoveDragEndListener()
	TaskDispatcher.cancelTask(self._hideMapTip, self)
end

return VersionActivityDungeonMapScene
