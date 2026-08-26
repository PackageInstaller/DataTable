-- chunkname: @modules/logic/versionactivity1_3/versionactivity1_3dungeonbase/view/VersionActivity1_3DungeonBaseMapScene.lua

module("modules.logic.versionactivity1_3.versionactivity1_3dungeonbase.view.VersionActivity1_3DungeonBaseMapScene", package.seeall)

local VersionActivity1_3DungeonBaseMapScene = class("VersionActivity1_3DungeonBaseMapScene", BaseViewExtended)

function VersionActivity1_3DungeonBaseMapScene:onInitView()
	self._gofullscreen = gohelper.findChild(self.viewGO, "#go_fullscreen")
	self._goarrow = gohelper.findChild(self.viewGO, "#go_arrow")
	self._gotoptipsbg = gohelper.findChild(self.viewGO, "#go_main/#go_toptipsbg")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_3DungeonBaseMapScene:addEvents()
	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnRecheckElement, self._onRecheckElement, self)
end

function VersionActivity1_3DungeonBaseMapScene:removeEvents()
	self.removeEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnRecheckElement, self._onRecheckElement, self)
end

function VersionActivity1_3DungeonBaseMapScene:_editableInitView()
	if ViewMgr.instance:isOpen(ViewName.MainThumbnailView) then
		MainThumbnailHeroView.setCameraIdle()
	end

	self._tempVector = Vector3()
	self._dragDeltaPos = Vector3()

	self:_initMapRootNode()
	self:_initDrag()
end

function VersionActivity1_3DungeonBaseMapScene:_initDrag()
	self._drag = SLFramework.UGUI.UIDragListener.Get(self._gofullscreen)

	self._drag:AddDragBeginListener(self._onDragBegin, self)
	self._drag:AddDragEndListener(self._onDragEnd, self)
	self._drag:AddDragListener(self._onDrag, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

function VersionActivity1_3DungeonBaseMapScene:_onOpenView(viewName)
	if viewName == ViewName.StoryView then
		self:_disposeScene()
		GameGCMgr.instance:dispatchEvent(GameGCEvent.DelayFullGC, 0, self)
	end
end

function VersionActivity1_3DungeonBaseMapScene:_onCloseView(viewName)
	if viewName == ViewName.StoryView then
		self:_rebuildScene()
	end
end

function VersionActivity1_3DungeonBaseMapScene:_onDragBegin(param, pointerEventData)
	self._dragBeginPos = self:getDragWorldPos(pointerEventData)

	if self._sceneTrans then
		self._beginDragPos = self._sceneTrans.localPosition
	end
end

function VersionActivity1_3DungeonBaseMapScene:_onDragEnd(param, pointerEventData)
	self._dragBeginPos = nil
	self._beginDragPos = nil

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnSetClickDown)
end

function VersionActivity1_3DungeonBaseMapScene:_onDrag(param, pointerEventData)
	if not self._dragBeginPos then
		return
	end

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnSetClickDown)

	local deltaPos = self:getDragWorldPos(pointerEventData) - self._dragBeginPos

	self:drag(deltaPos)
end

function VersionActivity1_3DungeonBaseMapScene:drag(deltaPos)
	if not self._sceneTrans or not self._beginDragPos then
		return
	end

	self._dragDeltaPos.x = deltaPos.x
	self._dragDeltaPos.y = deltaPos.y

	local targetPos = self:vectorAdd(self._beginDragPos, self._dragDeltaPos)

	self:setScenePosSafety(targetPos)
	self:_updateElementArrow()
end

function VersionActivity1_3DungeonBaseMapScene:_updateElementArrow()
	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnUpdateElementArrow)
end

function VersionActivity1_3DungeonBaseMapScene:setScenePosSafety(targetPos, tween)
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

function VersionActivity1_3DungeonBaseMapScene:_localMoveDone()
	self:_updateElementArrow()
end

function VersionActivity1_3DungeonBaseMapScene:vectorAdd(v1, v2)
	local tempVector = self._tempVector

	tempVector.x = v1.x + v2.x
	tempVector.y = v1.y + v2.y

	return tempVector
end

function VersionActivity1_3DungeonBaseMapScene:getDragWorldPos(pointerEventData)
	local mainCamera = CameraMgr.instance:getMainCamera()
	local refPos = self._gofullscreen.transform.position

	return (SLFramework.UGUI.RectTrHelper.ScreenPosToWorldPos(pointerEventData.position, mainCamera, refPos))
end

function VersionActivity1_3DungeonBaseMapScene:_initCamera()
	local camera = CameraMgr.instance:getMainCamera()

	camera.orthographic = true

	local scale = GameUtil.getAdapterScale()

	camera.orthographicSize = VersionActivity1_3DungeonEnum.DungeonMapCameraSize * scale
end

function VersionActivity1_3DungeonBaseMapScene:_resetCamera()
	local camera = CameraMgr.instance:getMainCamera()

	camera.orthographicSize = 5
	camera.orthographic = false
end

function VersionActivity1_3DungeonBaseMapScene:_initMapRootNode()
	local mainTrans = CameraMgr.instance:getMainCameraTrs().parent
	local sceneRoot = CameraMgr.instance:getSceneRoot()

	self._sceneRoot = UnityEngine.GameObject.New("VersionActivity1_3DungeonBaseMapScene")

	local x, y, z = transformhelper.getLocalPos(mainTrans)

	transformhelper.setLocalPos(self._sceneRoot.transform, 0, y, 0)
	gohelper.addChild(sceneRoot, self._sceneRoot)
end

function VersionActivity1_3DungeonBaseMapScene:getSceneGo()
	return self._sceneGo
end

function VersionActivity1_3DungeonBaseMapScene:_isSameMap(curId, lastId)
	return curId == lastId
end

function VersionActivity1_3DungeonBaseMapScene:refreshMap()
	self._mapCfg = VersionActivity1_3DungeonController.instance:getEpisodeMapConfig(self.activityDungeonMo.episodeId)

	if self:_isSameMap(self._mapCfg.id, self._lastLoadMapId) then
		self:refreshHardMapEffectAndAudio()

		self.dotTween = nil

		VersionActivity1_3DungeonController.instance:dispatchEvent(VersionActivity1_3DungeonEvent.LoadSameScene)

		return
	end

	self._lastLoadMapId = self._mapCfg.id

	self:loadMap()

	self._lastEpisodeId = self.activityDungeonMo.episodeId
end

function VersionActivity1_3DungeonBaseMapScene:loadMap()
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
	self._mapLightUrl = allResPath[5]

	if self.activityDungeonMo:isHardMode() then
		self._fogUrl = allResPath[6]

		self._mapLoader:addPath(self._fogUrl)

		self._bigEffectUrl = allResPath[7]

		if self._bigEffectUrl then
			self._mapLoader:addPath(self._bigEffectUrl)
		end
	end

	self._mapLoader:addPath(self._sceneUrl)
	self._mapLoader:addPath(self._canvasUrl)
	self._mapLoader:addPath(self._interactiveItemUrl)

	if self._mapAudioUrl then
		self._mapLoader:addPath(self._mapAudioUrl)
	end

	self._mapLoader:addPath(self._mapLightUrl)
	self._mapLoader:startLoad(self._loadSceneFinish, self)
end

function VersionActivity1_3DungeonBaseMapScene:_loadSceneFinish()
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

	self.goRainEffect = gohelper.findChild(self._sceneGo, "SceneEffect")

	if self.activityDungeonMo:isHardMode() then
		if self._fogUrl then
			self.goFogEffect = gohelper.clone(self._mapLoader:getAssetItem(self._fogUrl):GetResource(self._fogUrl), self._sceneGo)
		end

		if self._bigEffectUrl then
			self.goBigEffect = gohelper.clone(self._mapLoader:getAssetItem(self._bigEffectUrl):GetResource(self._bigEffectUrl), self.goRainEffect)
		end
	end

	self:refreshHardMapEffectAndAudio()
	self:_initScene()
	self:_initCanvas()
	self:_addAllAudio()
	TaskDispatcher.runDelay(self._addMapLight, self, (VersionActivity1_3DungeonController.instance.directFocusDaily or nil) and 0)
end

function VersionActivity1_3DungeonBaseMapScene:_addAllAudio()
	self:_addMapAudio()
end

function VersionActivity1_3DungeonBaseMapScene:buildLoadRes(allResPath, mapCfg)
	table.insert(allResPath, "ui/viewres/dungeon/chaptermap/chaptermapscenecanvas.prefab")
	table.insert(allResPath, "ui/viewres/versionactivity_1_3/map/v1a3_dungeonmapinteractiveitem.prefab")
	table.insert(allResPath, ResUrl.getDungeonMapRes(mapCfg.res))
	table.insert(allResPath, "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_audio_1_1.prefab")
	table.insert(allResPath, "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_light.prefab")

	local episodeId = self.activityDungeonMo.episodeId

	if VersionActivity1_3DungeonController.instance:isDayTime(episodeId) then
		table.insert(allResPath, "scenes/v1a3_m_s14_hddt_hd03/prefab/s08_hddt_hd_03_fog_a.prefab")
	else
		table.insert(allResPath, "scenes/v1a3_m_s14_hddt_hd03/prefab/s08_hddt_hd_03_fog_b.prefab")
		table.insert(allResPath, "scenes/v1a3_m_s14_hddt_hd03/prefab/big.prefab")
	end
end

function VersionActivity1_3DungeonBaseMapScene:_disposeScene()
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

function VersionActivity1_3DungeonBaseMapScene:_rebuildScene()
	self:loadMap(self._tempMapCfg)

	self._tempMapCfg = nil
end

function VersionActivity1_3DungeonBaseMapScene:_addMapLight()
	local assetUrl = self._mapLightUrl
	local assetItem = self._mapLoader:getAssetItem(assetUrl)
	local mainPrefab = assetItem:GetResource(assetUrl)

	gohelper.clone(mainPrefab, self._sceneGo)
	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnInitElements)
end

function VersionActivity1_3DungeonBaseMapScene:_addMapAudio()
	if not self._mapAudioUrl then
		return
	end

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

function VersionActivity1_3DungeonBaseMapScene:_initCanvas()
	local assetItem = self._mapLoader:getAssetItem(self._canvasUrl)
	local mainPrefab = assetItem:GetResource(self._canvasUrl)

	self._sceneCanvasGo = gohelper.clone(mainPrefab, self._sceneGo)
	self._sceneCanvas = self._sceneCanvasGo:GetComponent("Canvas")
	self._sceneCanvas.worldCamera = CameraMgr.instance:getMainCamera()
	assetItem = self._mapLoader:getAssetItem(self._interactiveItemUrl)
	self._itemPrefab = assetItem:GetResource(self._interactiveItemUrl)
end

function VersionActivity1_3DungeonBaseMapScene:getInteractiveItem()
	self._uiGo = gohelper.clone(self._itemPrefab, self._sceneCanvasGo)
	self._interactiveItem = MonoHelper.addLuaComOnceToGo(self._uiGo, DungeonMapInteractive1_3ItemComp)

	gohelper.setActive(self._uiGo, false)

	return self._interactiveItem
end

function VersionActivity1_3DungeonBaseMapScene:showInteractiveItem()
	return not gohelper.isNil(self._uiGo)
end

function VersionActivity1_3DungeonBaseMapScene:_initScene()
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
			local cameraSizeRate = VersionActivity1_3DungeonEnum.DungeonMapCameraSize / uiCameraSize
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

function VersionActivity1_3DungeonBaseMapScene:_setInitPos(tween)
	if not self._mapCfg then
		return
	end

	if VersionActivity1_3DungeonController.instance.directFocusDaily then
		tween = false
	end

	local pos = self._mapCfg.initPos
	local posParam = string.splitToNumber(pos, "#")

	self:setScenePosSafety(Vector3(posParam[1], posParam[2], 0), tween)
end

function VersionActivity1_3DungeonBaseMapScene:disposeOldMap()
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

function VersionActivity1_3DungeonBaseMapScene:_showMapTip()
	gohelper.setActive(self._gotoptipsbg, false)
end

function VersionActivity1_3DungeonBaseMapScene:_hideMapTip()
	gohelper.setActive(self._gotoptipsbg, false)
end

function VersionActivity1_3DungeonBaseMapScene:onUpdateParam()
	self:refreshMap()
end

function VersionActivity1_3DungeonBaseMapScene:onOpen()
	self.activityDungeonMo = self.viewContainer.versionActivityDungeonBaseMo

	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnFocusElement, self._focusElementById, self)
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenResize, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnSetEpisodeListVisible, self._setEpisodeListVisible, self)
	self.addEventCb(self, VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnModeChange, self.onModeChange, self)
	self:refreshMap()
end

function VersionActivity1_3DungeonBaseMapScene:onModeChange()
	self.dotTween = true

	self:refreshMap()
end

function VersionActivity1_3DungeonBaseMapScene:_setEpisodeListVisible(value)
	if value and self._interactiveItem then
		self._interactiveItem:_onOutAnimationFinished()
	end

	gohelper.setActive(self._gofullscreen, value)
end

function VersionActivity1_3DungeonBaseMapScene:_onScreenResize()
	if self._sceneGo then
		local camera = CameraMgr.instance:getMainCamera()
		local scale = GameUtil.getAdapterScale()

		camera.orthographicSize = VersionActivity1_3DungeonEnum.DungeonMapCameraSize * scale

		self:_initScene()
	end
end

function VersionActivity1_3DungeonBaseMapScene:_focusElementById(id)
	local config = lua_chapter_map_element.configDict[id]
	local pos = string.splitToNumber(config.pos, "#")

	if not pos[2] then
		local x, y = pos[1] or 0, 0
		local offsetPos = string.splitToNumber(config.offsetPos, "#")

		x = x + (offsetPos[1] or 0)
		y = y + (offsetPos[2] or 0)
		x = self._mapMaxX - x + self._viewWidth / 2
		y = self._mapMinY - y - self._viewHeight / 2 + 2

		local tween = not DungeonMapModel.instance.directFocusElement

		if VersionActivity1_3DungeonController.instance.directFocusDaily then
			tween = nil
			VersionActivity1_3DungeonController.instance.directFocusDaily = false
		end

		self:setScenePosSafety(Vector3(x, y, 0), tween)
	end
end

function VersionActivity1_3DungeonBaseMapScene:refreshHardMapEffectAndAudio()
	local isHard = self.activityDungeonMo:isHardMode()

	if isHard then
		-- block empty
	end

	if self.goRainEffect then
		gohelper.setActive(self.goRainEffect, isHard)
	end

	if self.goFogEffect then
		gohelper.setActive(self.goFogEffect, isHard)
	end

	if self.goBigEffect then
		gohelper.setActive(self.goBigEffect, isHard)
	end
end

function VersionActivity1_3DungeonBaseMapScene:setVisible(isVisible)
	gohelper.setActive(self._sceneRoot, isVisible)

	if isVisible then
		self:_initCamera()
	end
end

function VersionActivity1_3DungeonBaseMapScene:_onRecheckElement(elementId, isGM)
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

function VersionActivity1_3DungeonBaseMapScene:onClose()
	return
end

function VersionActivity1_3DungeonBaseMapScene:onDestroyView()
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

return VersionActivity1_3DungeonBaseMapScene
