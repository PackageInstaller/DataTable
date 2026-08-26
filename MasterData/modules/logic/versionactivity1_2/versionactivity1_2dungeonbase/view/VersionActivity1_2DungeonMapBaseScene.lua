-- chunkname: @modules/logic/versionactivity1_2/versionactivity1_2dungeonbase/view/VersionActivity1_2DungeonMapBaseScene.lua

module("modules.logic.versionactivity1_2.versionactivity1_2dungeonbase.view.VersionActivity1_2DungeonMapBaseScene", package.seeall)

local VersionActivity1_2DungeonMapBaseScene = class("VersionActivity1_2DungeonMapBaseScene", BaseViewExtended)

function VersionActivity1_2DungeonMapBaseScene:onInitView()
	self._gofullscreen = gohelper.findChild(self.viewGO, "#go_fullscreen")
	self._goarrow = gohelper.findChild(self.viewGO, "#go_arrow")
	self._gotoptipsbg = gohelper.findChild(self.viewGO, "#go_main/#go_toptipsbg")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_2DungeonMapBaseScene:addEvents()
	return
end

function VersionActivity1_2DungeonMapBaseScene:removeEvents()
	return
end

function VersionActivity1_2DungeonMapBaseScene:_editableInitView()
	if ViewMgr.instance:isOpen(ViewName.MainThumbnailView) then
		MainThumbnailHeroView.setCameraIdle()
	end

	self._tempVector = Vector3()
	self._dragDeltaPos = Vector3()

	self:_initMapRootNode()
	self:_initDrag()
	self:playBgm()
end

function VersionActivity1_2DungeonMapBaseScene:playBgm()
	return
end

function VersionActivity1_2DungeonMapBaseScene:_initDrag()
	self._drag = SLFramework.UGUI.UIDragListener.Get(self._gofullscreen)

	self._drag:AddDragBeginListener(self._onDragBegin, self)
	self._drag:AddDragEndListener(self._onDragEnd, self)
	self._drag:AddDragListener(self._onDrag, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

function VersionActivity1_2DungeonMapBaseScene:_onOpenView(viewName)
	if viewName == ViewName.StoryView then
		self:_disposeScene()
	end
end

function VersionActivity1_2DungeonMapBaseScene:_onCloseView(viewName)
	if viewName == ViewName.StoryView then
		self:_rebuildScene()
	end
end

function VersionActivity1_2DungeonMapBaseScene:_onDragBegin(param, pointerEventData)
	self._dragBeginPos = self:getDragWorldPos(pointerEventData)

	if self._sceneTrans then
		self._beginDragPos = self._sceneTrans.localPosition
	end
end

function VersionActivity1_2DungeonMapBaseScene:_onDragEnd(param, pointerEventData)
	self._dragBeginPos = nil
	self._beginDragPos = nil

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnSetClickDown)
end

function VersionActivity1_2DungeonMapBaseScene:_onDrag(param, pointerEventData)
	if not self._dragBeginPos then
		return
	end

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnSetClickDown)

	local deltaPos = self:getDragWorldPos(pointerEventData) - self._dragBeginPos

	self:drag(deltaPos)
	self:_showFocusBtnState()
end

function VersionActivity1_2DungeonMapBaseScene:drag(deltaPos)
	if not self._sceneTrans or not self._beginDragPos then
		return
	end

	self._dragDeltaPos.x = deltaPos.x
	self._dragDeltaPos.y = deltaPos.y

	local targetPos = self:vectorAdd(self._beginDragPos, self._dragDeltaPos)

	self:setScenePosSafety(targetPos)
	self:_updateElementArrow()
end

function VersionActivity1_2DungeonMapBaseScene:_updateElementArrow()
	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnUpdateElementArrow)
end

function VersionActivity1_2DungeonMapBaseScene:setScenePosSafety(targetPos, tween)
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

function VersionActivity1_2DungeonMapBaseScene:_localMoveDone()
	self:_updateElementArrow()
	self:_showFocusBtnState()
end

function VersionActivity1_2DungeonMapBaseScene:vectorAdd(v1, v2)
	local tempVector = self._tempVector

	tempVector.x = v1.x + v2.x
	tempVector.y = v1.y + v2.y

	return tempVector
end

function VersionActivity1_2DungeonMapBaseScene:getDragWorldPos(pointerEventData)
	local mainCamera = CameraMgr.instance:getMainCamera()
	local refPos = self._gofullscreen.transform.position

	return (SLFramework.UGUI.RectTrHelper.ScreenPosToWorldPos(pointerEventData.position, mainCamera, refPos))
end

function VersionActivity1_2DungeonMapBaseScene:_initCamera()
	local camera = CameraMgr.instance:getMainCamera()

	camera.orthographic = true

	local scale = GameUtil.getAdapterScale()

	camera.orthographicSize = VersionActivityEnum.DungeonMapCameraSize * scale
end

function VersionActivity1_2DungeonMapBaseScene:_initMapRootNode()
	local mainTrans = CameraMgr.instance:getMainCameraTrs().parent
	local sceneRoot = CameraMgr.instance:getSceneRoot()

	self._sceneRoot = UnityEngine.GameObject.New("VersionActivity1_2DungeonMapBaseScene")

	local x, y, z = transformhelper.getLocalPos(mainTrans)

	transformhelper.setLocalPos(self._sceneRoot.transform, 0, y, 20)
	gohelper.addChild(sceneRoot, self._sceneRoot)
end

function VersionActivity1_2DungeonMapBaseScene:getSceneGo()
	return self._sceneGo
end

function VersionActivity1_2DungeonMapBaseScene:changeMap(mapCfg, forcePos)
	self._forcePos = forcePos

	if self._mapCfg and self._mapCfg.id == mapCfg.id then
		return
	end

	self._mapCfg = mapCfg

	self:initMap()
end

function VersionActivity1_2DungeonMapBaseScene:initMap()
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

function VersionActivity1_2DungeonMapBaseScene:_loadSceneFinish()
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
	VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.guideOnLoadSceneFinish, self._mapCfg.id)

	self.goFogEffect = gohelper.clone(self._mapLoader:getAssetItem(self._fogUrl):GetResource(self._fogUrl), self._sceneGo)

	transformhelper.setLocalPos(self.goFogEffect.transform, 0, 0, -5)

	self.goRainEffect = gohelper.findChild(self._sceneGo, "SceneEffect")

	self:changeDungeonMode(self.isHardDungeonMode)
	self:_initScene()
	self:_initCanvas()
	self:_addAllAudio()
	self:_onLoadSceneFinish()
end

function VersionActivity1_2DungeonMapBaseScene:_onLoadSceneFinish()
	return
end

function VersionActivity1_2DungeonMapBaseScene:_addAllAudio()
	self:_addMapAudio()
end

function VersionActivity1_2DungeonMapBaseScene:buildLoadRes(allResPath, mapCfg)
	table.insert(allResPath, "ui/viewres/dungeon/chaptermap/chaptermapscenecanvas.prefab")
	table.insert(allResPath, "ui/viewres/dungeon/chaptermap/dungeonmapinteractiveitem.prefab")
	table.insert(allResPath, ResUrl.getDungeonMapRes(mapCfg.res))
	table.insert(allResPath, "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_audio_1_1.prefab")
	table.insert(allResPath, "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_light.prefab")
	table.insert(allResPath, "scenes/m_s08_hddt/prefab/s08_hddt_hd_01_fog.prefab")
end

function VersionActivity1_2DungeonMapBaseScene:setVisible(isVisible)
	gohelper.setActive(self._sceneRoot, isVisible)

	if isVisible then
		self:_initCamera()
	end
end

function VersionActivity1_2DungeonMapBaseScene:_disposeScene()
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

function VersionActivity1_2DungeonMapBaseScene:_rebuildScene()
	self:initMap(self._tempMapCfg)

	self._tempMapCfg = nil
end

function VersionActivity1_2DungeonMapBaseScene:_addMapLight()
	if self._mapLoader then
		local assetUrl = self._mapLightUrl
		local assetItem = self._mapLoader:getAssetItem(assetUrl)
		local mainPrefab = assetItem:GetResource(assetUrl)

		gohelper.clone(mainPrefab, self._sceneGo)
	end

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnNormalDungeonInitElements)
end

function VersionActivity1_2DungeonMapBaseScene:_addMapAudio()
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

function VersionActivity1_2DungeonMapBaseScene:_initCanvas()
	local assetItem = self._mapLoader:getAssetItem(self._canvasUrl)
	local mainPrefab = assetItem:GetResource(self._canvasUrl)

	self._sceneCanvasGo = gohelper.clone(mainPrefab, self._sceneGo)
	self._sceneCanvas = self._sceneCanvasGo:GetComponent("Canvas")
	self._sceneCanvas.worldCamera = CameraMgr.instance:getMainCamera()
	assetItem = self._mapLoader:getAssetItem(self._interactiveItemUrl)
	self._itemPrefab = assetItem:GetResource(self._interactiveItemUrl)
end

function VersionActivity1_2DungeonMapBaseScene:getInteractiveItem()
	self._uiGo = gohelper.clone(self._itemPrefab, self._sceneCanvasGo)
	self._interactiveItem = MonoHelper.addLuaComOnceToGo(self._uiGo, DungeonMapInteractiveItem)

	self._interactiveItem:setBtnClosePosZ(-5)
	gohelper.setActive(self._uiGo, false)

	return self._interactiveItem
end

function VersionActivity1_2DungeonMapBaseScene:showInteractiveItem()
	return not gohelper.isNil(self._uiGo)
end

function VersionActivity1_2DungeonMapBaseScene:_initScene()
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

			if self._forcePos then
				self._oldScenePos = nil
			end

			self._forcePos = nil

			self:_setInitPos(self._oldScenePos)

			self._oldScenePos = nil
		end
	end
end

function VersionActivity1_2DungeonMapBaseScene:_setInitPos(tween)
	if not self._mapCfg then
		return
	end

	local pos = self._mapCfg.initPos
	local posParam = string.splitToNumber(pos, "#")

	self:setScenePosSafety(Vector3(posParam[1], posParam[2], 0), tween)
end

function VersionActivity1_2DungeonMapBaseScene:disposeOldMap()
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

function VersionActivity1_2DungeonMapBaseScene:_showMapTip()
	gohelper.setActive(self._gotoptipsbg, false)
end

function VersionActivity1_2DungeonMapBaseScene:_hideMapTip()
	gohelper.setActive(self._gotoptipsbg, false)
end

function VersionActivity1_2DungeonMapBaseScene:onOpen()
	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnFocusElement, self._focusElementById, self)
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenResize, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnSetEpisodeListVisible, self._setEpisodeListVisible, self)
end

function VersionActivity1_2DungeonMapBaseScene:_setEpisodeListVisible(value)
	gohelper.setActive(self._gofullscreen, value)
end

function VersionActivity1_2DungeonMapBaseScene:_onScreenResize()
	if self._sceneGo then
		local camera = CameraMgr.instance:getMainCamera()
		local scale = GameUtil.getAdapterScale()

		camera.orthographicSize = VersionActivityEnum.DungeonMapCameraSize * scale

		self:_initScene()
	end
end

function VersionActivity1_2DungeonMapBaseScene:_focusElementById(id)
	if id and type(id) == "string" then
		id = tonumber(id)
	end

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

function VersionActivity1_2DungeonMapBaseScene:changeDungeonMode(isHard)
	if isHard then
		AudioEffectMgr.instance:playAudio(AudioEnum.Story.Play_Chapter_Start)
	else
		AudioEffectMgr.instance:stopAudio(AudioEnum.Story.Play_Chapter_Start)
	end

	self.isHardDungeonMode = isHard

	if self.goRainEffect then
		gohelper.setActive(self.goRainEffect, isHard)
	end

	if self.goFogEffect then
		gohelper.setActive(self.goFogEffect, isHard)
	end
end

function VersionActivity1_2DungeonMapBaseScene:onClose()
	self._drag:RemoveDragBeginListener()
	self._drag:RemoveDragListener()
	self._drag:RemoveDragEndListener()
end

function VersionActivity1_2DungeonMapBaseScene:onDestroyView()
	self:disposeOldMap()

	if self._mapLoader then
		self._mapLoader:dispose()

		self._mapLoader = nil
	end

	TaskDispatcher.cancelTask(self._hideMapTip, self)
	gohelper.destroy(self._sceneRoot)
end

return VersionActivity1_2DungeonMapBaseScene
