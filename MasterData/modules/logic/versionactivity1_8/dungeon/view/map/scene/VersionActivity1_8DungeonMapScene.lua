-- chunkname: @modules/logic/versionactivity1_8/dungeon/view/map/scene/VersionActivity1_8DungeonMapScene.lua

module("modules.logic.versionactivity1_8.dungeon.view.map.scene.VersionActivity1_8DungeonMapScene", package.seeall)

local VersionActivity1_8DungeonMapScene = class("VersionActivity1_8DungeonMapScene", BaseView)

function VersionActivity1_8DungeonMapScene:onInitView()
	self._gofullscreen = gohelper.findChild(self.viewGO, "#go_fullscreen")
	self._drag = SLFramework.UGUI.UIDragListener.Get(self._gofullscreen)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_8DungeonMapScene:addEvents()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenResize, self)
	self.addEventCb(self, VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnModeChange, self.onModeChange, self)
	self.addEventCb(self, VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnActivityDungeonMoChange, self.onActivityDungeonMoChange, self)
	self.addEventCb(self, VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnClickElement, self.onClickElement, self)
	self.addEventCb(self, VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.FocusElement, self.onFocusElement, self)
	self.addEventCb(self, VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.ManualClickElement, self.manualClickElement, self)
	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnRecheckElement, self._onRecheckElement, self)

	if self._drag then
		self._drag:AddDragBeginListener(self._onDragBegin, self)
		self._drag:AddDragEndListener(self._onDragEnd, self)
		self._drag:AddDragListener(self._onDrag, self)
	end
end

function VersionActivity1_8DungeonMapScene:removeEvents()
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.removeEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenResize, self)
	self.removeEventCb(self, VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnModeChange, self.onModeChange, self)
	self.removeEventCb(self, VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnActivityDungeonMoChange, self.onActivityDungeonMoChange, self)
	self.removeEventCb(self, VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnClickElement, self.onClickElement, self)
	self.removeEventCb(self, VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.FocusElement, self.onFocusElement, self)
	self.removeEventCb(self, VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.ManualClickElement, self.manualClickElement, self)
	self.removeEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnRecheckElement, self._onRecheckElement, self)

	if self._drag then
		self._drag:RemoveDragBeginListener()
		self._drag:RemoveDragListener()
		self._drag:RemoveDragEndListener()
	end
end

function VersionActivity1_8DungeonMapScene:_onOpenView(viewName)
	if viewName == ViewName.StoryView then
		self:_disposeScene()
		GameGCMgr.instance:dispatchEvent(GameGCEvent.DelayFullGC, 0, self)
	end
end

function VersionActivity1_8DungeonMapScene:_onCloseView(viewName)
	if viewName == ViewName.StoryView then
		self:_rebuildScene()
	end
end

function VersionActivity1_8DungeonMapScene:_rebuildScene()
	self:loadMap(self._tempMapCfg)

	self._tempMapCfg = nil
end

function VersionActivity1_8DungeonMapScene:_onScreenResize()
	if self._sceneGo then
		local camera = CameraMgr.instance:getMainCamera()
		local scale = GameUtil.getAdapterScale()

		camera.orthographicSize = VersionActivity1_8DungeonEnum.DungeonMapCameraSize * scale

		self:_initScene()
	end
end

function VersionActivity1_8DungeonMapScene:onModeChange()
	self:refreshMap()
end

function VersionActivity1_8DungeonMapScene:onActivityDungeonMoChange()
	self:refreshMap(true)
end

function VersionActivity1_8DungeonMapScene:onClickElement(elementId)
	local elementComp = self.mapSceneElementsView:getElementComp(elementId)

	if elementComp then
		local config = elementComp:getConfig()

		self:focusElementByCo(config)
	end
end

function VersionActivity1_8DungeonMapScene:onFocusElement(elementId, isForce)
	local elementComp = self.mapSceneElementsView:getElementComp(elementId)

	if elementComp or isForce then
		local config = elementComp and elementComp:getConfig() or DungeonConfig.instance:getChapterMapElement(elementId)

		if config then
			self:focusElementByCo(config)
		end
	else
		self:changeToElementEpisode(elementId)
	end
end

function VersionActivity1_8DungeonMapScene:changeToElementEpisode(elementId)
	local config = lua_chapter_map_element.configDict[elementId]

	if not config then
		return
	end

	local mapId = config.mapId

	self._mapCfg = lua_chapter_map.configDict[mapId]

	local pos = string.splitToNumber(config.pos, "#")

	self.tempInitPosX = -pos[1] or 0
	self.tempInitPosY = -pos[2] or 0

	local episodeId = DungeonConfig.instance:getEpisodeIdByMapCo(self._mapCfg)

	if VersionActivityDungeonBaseEnum.DungeonMode.Story ~= self.activityDungeonMo.mode then
		self.activityDungeonMo:changeMode(VersionActivityDungeonBaseEnum.DungeonMode.Story)
	end

	self.activityDungeonMo:changeEpisode(episodeId)
end

function VersionActivity1_8DungeonMapScene:focusElementByCo(elementCo)
	local pos = string.splitToNumber(elementCo.pos, "#")

	if not -pos[2] then
		local x, y = -pos[1] or 0, 0

		self._tempVector:Set(x, y, 0)
		self:tweenSetScenePos(self._tempVector)
	end
end

function VersionActivity1_8DungeonMapScene:manualClickElement(elementId)
	local elementComp = self.mapSceneElementsView:getElementComp(elementId)

	if elementComp then
		self.mapSceneElementsView:manualClickElement(elementId)
	else
		self.mapSceneElementsView:setInitClickElement(elementId)
		self:changeToElementEpisode(elementId)
	end
end

function VersionActivity1_8DungeonMapScene:_onDragBegin(param, pointerEventData)
	self._dragBeginPos = self:getDragWorldPos(pointerEventData)

	DungeonController.instance:dispatchEvent(DungeonEvent.OnBeginDragMap)
end

function VersionActivity1_8DungeonMapScene:_onDragEnd(param, pointerEventData)
	self._dragBeginPos = nil
end

function VersionActivity1_8DungeonMapScene:_onDrag(param, pointerEventData)
	if not self._dragBeginPos then
		return
	end

	local pos = self:getDragWorldPos(pointerEventData)
	local deltaPos = pos - self._dragBeginPos

	self._dragBeginPos = pos

	self._tempVector:Set(self._scenePos.x + deltaPos.x, self._scenePos.y + deltaPos.y)
	self:directSetScenePos(self._tempVector)
end

function VersionActivity1_8DungeonMapScene:getDragWorldPos(pointerEventData)
	local mainCamera = CameraMgr.instance:getMainCamera()
	local refPos = self._gofullscreen.transform.position

	return (SLFramework.UGUI.RectTrHelper.ScreenPosToWorldPos(pointerEventData.position, mainCamera, refPos))
end

function VersionActivity1_8DungeonMapScene:_editableInitView()
	self.mapSceneElementsView = self.viewContainer.mapSceneElements

	if ViewMgr.instance:isOpen(ViewName.MainThumbnailView) then
		MainThumbnailHeroView.setCameraIdle()
	end

	self._tempVector = Vector3()
	self._dragDeltaPos = Vector3()
	self._scenePos = Vector3()

	self:_initMapRootNode()
end

function VersionActivity1_8DungeonMapScene:_initMapRootNode()
	self._sceneRoot = UnityEngine.GameObject.New(VersionActivity1_8DungeonEnum.SceneRootName)

	local mainTrans = CameraMgr.instance:getMainCameraTrs().parent
	local _, y, _ = transformhelper.getLocalPos(mainTrans)

	transformhelper.setLocalPos(self._sceneRoot.transform, 0, y, 0)

	local sceneRoot = CameraMgr.instance:getSceneRoot()

	gohelper.addChild(sceneRoot, self._sceneRoot)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnCreateMapRootGoDone, self._sceneRoot)
end

function VersionActivity1_8DungeonMapScene:onUpdateParam()
	self:refreshMap()
end

function VersionActivity1_8DungeonMapScene:onOpen()
	MainCameraMgr.instance:addView(self.viewName, self._initCamera, nil, self)
	self:refreshMap()
end

function VersionActivity1_8DungeonMapScene:_initCamera()
	local camera = CameraMgr.instance:getMainCamera()

	camera.orthographic = true

	local scale = GameUtil.getAdapterScale()

	camera.orthographicSize = VersionActivity1_8DungeonEnum.DungeonMapCameraSize * scale
end

function VersionActivity1_8DungeonMapScene:refreshMap(needTween)
	self._mapCfg = VersionActivity1_8DungeonConfig.instance:getEpisodeMapConfig(self.activityDungeonMo.episodeId)

	if self._mapCfg.id == self._lastLoadMapId then
		self:_initElements()
	else
		self.needTween = needTween
		self._lastLoadMapId = self._mapCfg.id

		self:loadMap()
	end
end

function VersionActivity1_8DungeonMapScene:_initElements()
	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnInitElements)
end

function VersionActivity1_8DungeonMapScene:loadMap()
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

	self._sceneUrl = allResPath[1]
	self._mapLightUrl = allResPath[2]
	self._mapAudioUrl = allResPath[3]

	self._mapLoader:addPath(self._sceneUrl)
	self._mapLoader:addPath(self._mapLightUrl)
	self._mapLoader:addPath(self._mapAudioUrl)
	self._mapLoader:startLoad(self._loadSceneFinish, self)
end

function VersionActivity1_8DungeonMapScene:buildLoadRes(allResPath, mapCfg)
	table.insert(allResPath, ResUrl.getDungeonMapRes(mapCfg.res))
	table.insert(allResPath, "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_light.prefab")
end

function VersionActivity1_8DungeonMapScene:_loadSceneFinish()
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
	self:_initScene()
	self:_setMapPos()
	self:_addMapLight()
	self:_initElements()
	self:_addMapAudio()
end

function VersionActivity1_8DungeonMapScene:disposeOldMap()
	self._oldScenePos = self._sceneTrans and self._scenePos or nil

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
end

function VersionActivity1_8DungeonMapScene:_initScene()
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
			local cameraSizeRate = VersionActivity1_8DungeonEnum.DungeonMapCameraSize / uiCameraSize
			local posTL = worldcorners[1] * scale * cameraSizeRate
			local posBR = worldcorners[3] * scale * cameraSizeRate

			self._viewWidth = math.abs(posBR.x - posTL.x)
			self._viewHeight = math.abs(posBR.y - posTL.y)
			self._mapMinX = posTL.x - (self._mapSize.x - self._viewWidth)
			self._mapMaxX = posTL.x
			self._mapMinY = posTL.y
			self._mapMaxY = posTL.y + (self._mapSize.y - self._viewHeight)
		end
	end
end

function VersionActivity1_8DungeonMapScene:_setMapPos()
	if self.tempInitPosX then
		self._tempVector:Set(self.tempInitPosX, self.tempInitPosY, 0)

		self.tempInitPosX = nil
		self.tempInitPosY = nil
	else
		local pos = self._mapCfg.initPos
		local posParam = string.splitToNumber(pos, "#")

		self._tempVector:Set(posParam[1], posParam[2], 0)
	end

	if self.needTween then
		self:tweenSetScenePos(self._tempVector, self._oldScenePos)

		self.needTween = nil
	else
		self:directSetScenePos(self._tempVector)
	end
end

function VersionActivity1_8DungeonMapScene:_addMapLight()
	local assetUrl = self._mapLightUrl
	local assetItem = self._mapLoader:getAssetItem(assetUrl)
	local mainPrefab = assetItem:GetResource(assetUrl)

	gohelper.clone(mainPrefab, self._sceneGo)
end

function VersionActivity1_8DungeonMapScene:_addMapAudio()
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

function VersionActivity1_8DungeonMapScene:tweenSetScenePos(targetPos, srcPos)
	self._tweenTargetPosX, self._tweenTargetPosY = self:getTargetPos(targetPos)
	self._tweenStartPosX, self._tweenStartPosY = self:getTargetPos(srcPos or self._scenePos)

	self:killTween()

	self.tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, DungeonEnum.DefaultTweenMapTime, self.tweenFrameCallback, self.tweenFinishCallback, self)

	self:tweenFrameCallback(0)
end

function VersionActivity1_8DungeonMapScene:getTargetPos(targetPos)
	local x, y = targetPos.x, targetPos.y

	if not self._mapMinX or not self._mapMaxX or not self._mapMinY or not self._mapMaxY then
		if self._mapCfg then
			local pos = self._mapCfg.initPos
			local posParam = string.splitToNumber(pos, "#")

			x = posParam[1] or 0
			y = posParam[2] or 0
		end
	else
		if x < self._mapMinX then
			x = self._mapMinX
		elseif x > self._mapMaxX then
			x = self._mapMaxX
		end

		if y < self._mapMinY then
			y = self._mapMinY
		elseif y > self._mapMaxY then
			y = self._mapMaxY
		end
	end

	return x, y
end

function VersionActivity1_8DungeonMapScene:tweenFrameCallback(value)
	local x = Mathf.Lerp(self._tweenStartPosX, self._tweenTargetPosX, value)
	local y = Mathf.Lerp(self._tweenStartPosY, self._tweenTargetPosY, value)

	self._tempVector:Set(x, y, 0)
	self:directSetScenePos(self._tempVector)
end

function VersionActivity1_8DungeonMapScene:tweenFinishCallback()
	self._tempVector:Set(self._tweenTargetPosX, self._tweenTargetPosY, 0)
	self:directSetScenePos(self._tempVector)
end

function VersionActivity1_8DungeonMapScene:directSetScenePos(targetPos)
	local x, y = self:getTargetPos(targetPos)

	self._scenePos.x = x
	self._scenePos.y = y

	if not self._sceneTrans or gohelper.isNil(self._sceneTrans) then
		return
	end

	transformhelper.setLocalPos(self._sceneTrans, self._scenePos.x, self._scenePos.y, 0)
	VersionActivity1_8DungeonController.instance:dispatchEvent(VersionActivity1_8DungeonEvent.OnMapPosChanged)
	self:_updateElementArrow()
end

function VersionActivity1_8DungeonMapScene:_updateElementArrow()
	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnUpdateElementArrow)
end

function VersionActivity1_8DungeonMapScene:setVisible(isVisible)
	gohelper.setActive(self._sceneRoot, isVisible)

	if isVisible then
		self:_initCamera()
	end
end

function VersionActivity1_8DungeonMapScene:getSceneGo()
	return self._sceneGo
end

function VersionActivity1_8DungeonMapScene:onClose()
	self:killTween()
	self:_resetCamera()
end

function VersionActivity1_8DungeonMapScene:killTween()
	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)
	end
end

function VersionActivity1_8DungeonMapScene:_resetCamera()
	local camera = CameraMgr.instance:getMainCamera()

	camera.orthographicSize = 5
	camera.orthographic = false
end

function VersionActivity1_8DungeonMapScene:_onRecheckElement(elementId, isGM)
	local elementCo = lua_chapter_map_element.configDict[elementId]

	if not self.viewParam.chapterId then
		local chapterId = self.viewContainer:_getChapterId()

		if not DungeonController.instance:isNeedRecheckInteractive(elementCo) then
			DungeonController.instance:onRecheckElement(elementId, self.viewParam.chapterId)

			return
		end

		local item = self.viewContainer:getInteractiveItem()
		local pos = self._sceneTrans.localPosition

		DungeonController.instance:onRecheckElement(elementId, self.viewParam.chapterId, item, pos, isGM)
	end
end

function VersionActivity1_8DungeonMapScene:onDestroyView()
	gohelper.destroy(self._sceneRoot)
	self:disposeOldMap()
	self:_disposeScene()

	if self._mapLoader then
		self._mapLoader:dispose()
	end
end

function VersionActivity1_8DungeonMapScene:_disposeScene()
	self._oldScenePos = self._scenePos
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

	self._mapAudioGo = nil
end

return VersionActivity1_8DungeonMapScene
