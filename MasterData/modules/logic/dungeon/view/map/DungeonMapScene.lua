-- chunkname: @modules/logic/dungeon/view/map/DungeonMapScene.lua

module("modules.logic.dungeon.view.map.DungeonMapScene", package.seeall)

local DungeonMapScene = class("DungeonMapScene", BaseView)
local SceneChangeAnimState = {
	OpenEnd = 3,
	NoStart = 1,
	ResLoad = 2,
	None = 0
}

function DungeonMapScene:onInitView()
	self._gofullscreen = gohelper.findChild(self.viewGO, "#go_fullscreen")
	self._goarrow = gohelper.findChild(self.viewGO, "#go_arrow")
	self._goinvestigatepos = gohelper.findChild(self.viewGO, "go_investigatepos")
	self._gotoptipsbg = gohelper.findChild(self.viewGO, "#go_main/#go_toptipsbg")
	self._animchangeScene = gohelper.findChild(self.viewGO, "#go_scenechange"):GetComponent(typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DungeonMapScene:addEvents()
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnChangeMap, self._OnChangeMap, self)
	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnFocusElement, self._focusElementById, self)
	self.addEventCb(self, StoryController.instance, StoryEvent.Finish, self._onStoryFinish, self)
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenResize, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.CheckEnterDungeonMapView, self._delaySendGuideEnterDungeonMapEvent, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.CheckEnterEpisodeDungeonMapView, self._delaySendGuideEnterEpisodeDungeonMapView, self)
	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnRecheckElement, self._onRecheckElement, self)
end

function DungeonMapScene:removeEvents()
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.OnChangeMap, self._OnChangeMap, self)
	self.removeEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnFocusElement, self._focusElementById, self)
	self.removeEventCb(self, StoryController.instance, StoryEvent.Finish, self._onStoryFinish, self)
	self.removeEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenResize, self)
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.CheckEnterDungeonMapView, self._delaySendGuideEnterDungeonMapEvent, self)
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.CheckEnterEpisodeDungeonMapView, self._delaySendGuideEnterEpisodeDungeonMapView, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.removeEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnRecheckElement, self._onRecheckElement, self)
end

function DungeonMapScene:_editableInitView()
	if ViewMgr.instance:isOpen(ViewName.MainThumbnailView) then
		MainThumbnailHeroView.setCameraIdle()
	end

	self._tempVector = Vector3()
	self._dragDeltaPos = Vector3()

	self:_initMap()
	self:_initDrag()
end

function DungeonMapScene:_initDrag()
	self._drag = SLFramework.UGUI.UIDragListener.Get(self._gofullscreen)

	self._drag:AddDragBeginListener(self._onDragBegin, self)
	self._drag:AddDragEndListener(self._onDragEnd, self)
	self._drag:AddDragListener(self._onDrag, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function DungeonMapScene:_onOpenView(viewName)
	if viewName == ViewName.StoryView then
		TaskDispatcher.cancelTask(self._checkSceneVisible, self)
		self:_disposeScene()
		GameGCMgr.instance:dispatchEvent(GameGCEvent.DelayFullGC, 0, self)
	end
end

function DungeonMapScene:_onCloseView(viewName)
	if viewName == ViewName.StoryView then
		self:_rebuildScene()
	end
end

function DungeonMapScene:_onCloseViewFinish(viewName)
	if viewName == ViewName.StoryFrontView and not gohelper.isNil(self._sceneRoot) and not self._sceneRoot.activeSelf and ViewHelper.instance:checkViewOnTheTop(ViewName.DungeonMapView) then
		logError("DungeonMapScene scene is hided!")
		self:setSceneVisible(true)
	end
end

function DungeonMapScene:setSceneVisible(isVisible)
	gohelper.setActive(self._sceneRoot, isVisible and true or false)

	if isVisible then
		local chapterId = self.viewParam.chapterId

		DungeonController.instance:dispatchEvent(DungeonEvent.OnEnterDungeonMapView, chapterId)
	end
end

function DungeonMapScene:_onDragBegin(param, pointerEventData)
	self._dragBeginPos = self:getDragWorldPos(pointerEventData)

	if self._sceneTrans then
		self._beginDragPos = self._sceneTrans.localPosition
	end
end

function DungeonMapScene:_onDragEnd(param, pointerEventData)
	self._dragBeginPos = nil
	self._beginDragPos = nil

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnSetClickDown)
end

function DungeonMapScene:_onDrag(param, pointerEventData)
	if not self._dragBeginPos then
		return
	end

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnSetClickDown)

	local deltaPos = self:getDragWorldPos(pointerEventData) - self._dragBeginPos

	self:drag(deltaPos)
end

function DungeonMapScene:drag(deltaPos)
	if not self._sceneTrans or not self._beginDragPos then
		return
	end

	self._dragDeltaPos.x = deltaPos.x
	self._dragDeltaPos.y = deltaPos.y

	local targetPos = self:vectorAdd(self._beginDragPos, self._dragDeltaPos)

	self:setScenePosSafety(targetPos)
	self:_updateElementArrow()
end

function DungeonMapScene:_updateElementArrow()
	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnUpdateElementArrow)
end

function DungeonMapScene:setScenePosSafety(targetPos, tween)
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
			UIBlockHelper.instance:startBlock("DungeonMapSceneTweenPos", self._tweenTime, self.viewName)
			ZProj.TweenHelper.DOLocalMove(self._sceneTrans, targetPos.x, targetPos.y, 0, self._tweenTime, self._localMoveDone, self, nil, EaseType.OutQuad)
		end
	else
		self._sceneTrans.localPosition = targetPos

		self:_updateElementArrow()
	end

	DungeonController.instance:dispatchEvent(DungeonEvent.OnMapPosChanged, targetPos, tween)
end

function DungeonMapScene:_localMoveDone()
	self:_updateElementArrow()
end

function DungeonMapScene:vectorAdd(v1, v2)
	local tempVector = self._tempVector

	tempVector.x = v1.x + v2.x
	tempVector.y = v1.y + v2.y

	return tempVector
end

function DungeonMapScene:getDragWorldPos(pointerEventData)
	local mainCamera = CameraMgr.instance:getMainCamera()
	local refPos = self._gofullscreen.transform.position

	return (SLFramework.UGUI.RectTrHelper.ScreenPosToWorldPos(pointerEventData.position, mainCamera, refPos))
end

function DungeonMapScene:_initCamera()
	local camera = CameraMgr.instance:getMainCamera()

	camera.orthographic = true

	local scale = GameUtil.getAdapterScale()

	camera.orthographicSize = 5 * scale
end

function DungeonMapScene:_initMap()
	local mainTrans = CameraMgr.instance:getMainCameraTrs().parent
	local sceneRoot = CameraMgr.instance:getSceneRoot()

	self._sceneRoot = UnityEngine.GameObject.New("DungeonMapScene")

	local x, y, z = transformhelper.getLocalPos(mainTrans)

	transformhelper.setLocalPos(self._sceneRoot.transform, 0, y, 0)
	gohelper.addChild(sceneRoot, self._sceneRoot)
end

function DungeonMapScene:getSceneGo()
	return self._sceneGo
end

function DungeonMapScene:getChangeMapStatus()
	if not self._compareCur or not self._compareLast then
		return
	end

	if self._compareCur.mapState ~= self._compareLast.mapState then
		return self._compareCur.mapState
	end
end

function DungeonMapScene:_changeMap(curMap, force)
	if not curMap or self._mapCfg == curMap and not force then
		return
	end

	self._showSceneChangeAnimState = SceneChangeAnimState.None

	if self._mapCfg then
		local preGroup = self._mapCfg.mapIdGroup
		local nowGroup = curMap.mapIdGroup

		if ToughBattleModel.instance:getIsJumpActElement() or preGroup and preGroup > 0 and nowGroup and nowGroup ~= preGroup then
			self._showSceneChangeAnimState = SceneChangeAnimState.NoStart
		end
	end

	self._compareLast = self._mapCfg
	self._compareCur = curMap

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnChangeMap)

	self._tempMapCfg = nil

	if not self._oldMapLoader and self._sceneGo then
		self._oldMapLoader = self._mapLoader
		self._oldSceneGo = self._sceneGo
		self._mapLoader = nil
	end

	if self._mapLoader then
		self._mapLoader:dispose()

		self._mapLoader = nil
	end

	self._mapCfg = curMap
	self._mapLoader = MultiAbLoader.New()

	local allResPath = {}

	DungeonMapScene._preloadRes(allResPath, self._mapCfg)

	self._canvasUrl = allResPath[1]
	self._interactiveItemUrl = allResPath[2]
	self._sceneUrl = allResPath[3]

	self._mapLoader:addPath(self._sceneUrl)

	self._mapAudioUrl = allResPath[4]
	self._mapLightUrl = allResPath[5]

	self._mapLoader:addPath(self._canvasUrl)
	self._mapLoader:addPath(self._interactiveItemUrl)
	self._mapLoader:addPath(self._mapAudioUrl)
	self._mapLoader:addPath(self._mapLightUrl)

	self._mapExEffectPath = DungeonEnum.MapExEffectPath[self._mapCfg.id]

	if self._mapExEffectPath then
		self._mapLoader:addPath(self._mapExEffectPath)
	end

	self:preloadElementRes(self._mapLoader)

	if self._showSceneChangeAnimState == SceneChangeAnimState.NoStart then
		self._animchangeScene:Play("open", 0, 0)
		gohelper.setActive(self._animchangeScene, true)
		TaskDispatcher.cancelTask(self._delayShowScene, self)
		TaskDispatcher.runDelay(self._delayShowScene, self, 0.5)
		UIBlockHelper.instance:startBlock("DungeonSceneChangeAnimStart", 0.5, self.viewName)
	end

	self._mapLoader:startLoad(self._loadSceneFinish, self)
end

function DungeonMapScene:_delayShowScene()
	if self._showSceneChangeAnimState == SceneChangeAnimState.ResLoad then
		self._showSceneChangeAnimState = SceneChangeAnimState.OpenEnd

		self:_loadSceneFinish()
	elseif self._showSceneChangeAnimState == SceneChangeAnimState.NoStart then
		self._showSceneChangeAnimState = SceneChangeAnimState.OpenEnd
	end
end

function DungeonMapScene:playSceneChangeClose()
	self._animchangeScene:Play("close", 0, 0)
	TaskDispatcher.runDelay(self._delayCloseEnd, self, 0.5)
	UIBlockHelper.instance:startBlock("DungeonSceneChangeAnimEnd", 0.5, self.viewName)
end

function DungeonMapScene:_delayCloseEnd()
	self._showSceneChangeAnimState = SceneChangeAnimState.None

	gohelper.setActive(self._animchangeScene, false)
end

function DungeonMapScene:preloadElementRes(loader)
	local elements = DungeonMapModel.instance:getElements(self._mapCfg.id)

	for _, co in pairs(elements) do
		if co.type == DungeonEnum.ElementType.ToughBattle and not string.nilorempty(co.res) then
			loader:addPath(co.res)
		end
	end
end

function DungeonMapScene:_loadSceneFinish()
	if gohelper.isNil(self._sceneRoot) then
		logError("DungeonMapScene 节点没了？？？" .. self.viewContainer._viewStatus)

		return
	end

	if self._showSceneChangeAnimState == SceneChangeAnimState.NoStart then
		self._showSceneChangeAnimState = SceneChangeAnimState.ResLoad

		return
	elseif self._showSceneChangeAnimState == SceneChangeAnimState.OpenEnd then
		self:playSceneChangeClose()
	end

	if self._curMapAreaAudio ~= self._mapCfg.areaAudio then
		self:_stopAreaAudio()
	elseif self._mapAudioGo then
		gohelper.addChild(self._sceneRoot, self._mapAudioGo)
	end

	self:disposeOldMap()

	local assetUrl = self._sceneUrl
	local assetItem = self._mapLoader:getAssetItem(assetUrl)
	local mainPrefab = assetItem:GetResource(assetUrl)

	self._sceneGo = gohelper.clone(mainPrefab, self._sceneRoot, self._mapCfg.id)
	self._sceneTrans = self._sceneGo.transform

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnLoadSceneFinish, {
		self._mapCfg,
		self._sceneGo,
		self,
		episodeConfig = self._episodeConfig
	})
	DungeonController.instance:dispatchEvent(DungeonEvent.OnShowMap)
	TaskDispatcher.runDelay(self._addAllAudio, self, 0.2)
	MainCameraMgr.instance:addView(self.viewName, self._initCamera, nil, self)
	self:_initScene()
	self:_initCanvas()
	self:_initExEffect()
	DungeonController.instance:dispatchEvent(DungeonEvent.OnEnterEpisodeDungeonMapView, self._mapCfg.id)

	if self._mapCfg.id == 10721 or self._mapCfg.id == 10728 then
		TaskDispatcher.runDelay(self._addMapLight, self, 0)
	else
		TaskDispatcher.runDelay(self._addMapLight, self, 0.3)
	end

	self:_showMapTip()

	self._switchState1 = gohelper.findChild(self._sceneGo, "Obj-Plant/all/switch/state_1")
	self._switchState2 = gohelper.findChild(self._sceneGo, "Obj-Plant/all/switch/state_2")

	self:_updateSwitchState()
end

function DungeonMapScene:_initExEffect()
	if self._mapExEffectPath then
		local assetItem = self._mapLoader:getAssetItem(self._mapExEffectPath)
		local mainPrefab = assetItem:GetResource(self._mapExEffectPath)

		gohelper.clone(mainPrefab, self._sceneGo)
	end
end

function DungeonMapScene:_addAllAudio()
	self:_addMapAudio()
	self:_addEffectAudio()
end

function DungeonMapScene:_updateSwitchState()
	if not self._switchState1 or not self._switchState2 then
		return
	end

	if not self._episodeConfig then
		return
	end

	local finished = DungeonModel.instance:hasPassLevelAndStory(self._episodeConfig.id)

	gohelper.setActive(self._switchState1, not finished)
	gohelper.setActive(self._switchState2, finished)
end

function DungeonMapScene.getInteractiveItemPath(chapterId)
	if chapterId == DungeonEnum.ChapterId.Main1_10 then
		return "ui/viewres/dungeon/chaptermap/dungeonmapinteractiveitem_110.prefab"
	end

	if chapterId == DungeonEnum.ChapterId.Main1_11 then
		return "ui/viewres/dungeon/chaptermap/dungeonmapinteractiveitem_111.prefab"
	end

	if chapterId == DungeonEnum.ChapterId.Main1_12 then
		return "ui/viewres/dungeon/chaptermap/dungeonmapinteractiveitem_112.prefab"
	end

	return "ui/viewres/dungeon/chaptermap/dungeonmapinteractiveitem.prefab"
end

function DungeonMapScene.getInteractiveItemCls(chapterId)
	if chapterId == DungeonEnum.ChapterId.Main1_10 then
		return DungeonMapInteractiveItem110
	end

	return DungeonMapInteractiveItem
end

function DungeonMapScene._preloadRes(allResPath, mapCfg, chapterId, jumpEpisodeId)
	table.insert(allResPath, "ui/viewres/dungeon/chaptermap/chaptermapscenecanvas.prefab")
	table.insert(allResPath, DungeonMapScene.getInteractiveItemPath(mapCfg.chapterId))

	if chapterId then
		mapCfg = DungeonMapChapterLayout.getFocusMap(chapterId, jumpEpisodeId)
		DungeonMapModel.instance.preloadMapCfg = mapCfg
	end

	if not mapCfg then
		return
	end

	if not chapterId then
		if DungeonMapModel.instance.preloadMapCfg and DungeonMapModel.instance.preloadMapCfg ~= mapCfg then
			logError(string.format("DungeonMapScene preload error preload:%s,normal:%s", DungeonMapModel.instance.preloadMapCfg.id, mapCfg.id))
		end

		DungeonMapModel.instance.preloadMapCfg = nil
	end

	table.insert(allResPath, ResUrl.getDungeonMapRes(mapCfg.res))
	DungeonMapScene._addAudioAndLight(allResPath, mapCfg)
end

function DungeonMapScene._addAudioAndLight(allResPath, mapCfg)
	if mapCfg.chapterId == 103 then
		table.insert(allResPath, "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_audio_03.prefab")
		table.insert(allResPath, "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_light_03.prefab")
	elseif mapCfg.chapterId == 104 then
		table.insert(allResPath, "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_audio_04.prefab")
		table.insert(allResPath, "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_light_04.prefab")
	elseif mapCfg.chapterId == 105 then
		table.insert(allResPath, "scenes/v1a4_m_s08_hddt/scenes_prefab/v1a4_m_s08_hddt_audio.prefab")
		table.insert(allResPath, "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_light.prefab")
	elseif mapCfg.chapterId == 310 then
		table.insert(allResPath, "scenes/v1a4_m_s08_hddt_jz/scene_prefab/v1a4_m_s08_hddt_jz_audio.prefab")
		table.insert(allResPath, "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_light.prefab")
	elseif mapCfg.chapterId == DungeonEnum.ChapterId.Main1_6 then
		table.insert(allResPath, "scenes/v1a7_m_s08_hddt/scenes_prefab/v1a7_m_s08_hddt_audio.prefab")
		table.insert(allResPath, "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_light.prefab")
	else
		table.insert(allResPath, "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_audio.prefab")
		table.insert(allResPath, "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_light.prefab")
	end
end

function DungeonMapScene:_disposeScene()
	self._oldScenePos = self._targetPos
	self._tempMapCfg = self._mapCfg

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnDisposeScene)

	if self._sceneGo then
		gohelper.destroy(self._sceneGo)

		self._sceneGo = nil
	end

	self._sceneTrans = nil

	if self._mapLoader then
		self._mapLoader:dispose()

		self._mapLoader = nil
	end

	TaskDispatcher.cancelTask(self._addMapLight, self)
	TaskDispatcher.cancelTask(self._addAllAudio, self)
	self:_removeEffectAudio(true)
	self:_stopAreaAudio()
	AudioMgr.instance:trigger(AudioEnum.UI.stop_uinoise_bus)
end

function DungeonMapScene:_rebuildScene()
	self:_changeMap(self._tempMapCfg, true)

	self._tempMapCfg = nil
end

function DungeonMapScene:_removeEffectAudio(force)
	if not self._effectAudio then
		return
	end

	if self._effectAudio == self._mapCfg.effectAudio and not force then
		return
	end

	AudioEffectMgr.instance:stopAudio(AudioEnum.Story.Play_Chapter_Start)

	self._effectAudio = nil
end

function DungeonMapScene:_addEffectAudio()
	if self._effectAudio == self._mapCfg.effectAudio or self._mapCfg.effectAudio <= 0 then
		return
	end

	self._effectAudio = self._mapCfg.effectAudio

	AudioEffectMgr.instance:playAudio(AudioEnum.Story.Play_Chapter_Start)
end

function DungeonMapScene:_addMapLight()
	local assetUrl = self._mapLightUrl
	local assetItem = self._mapLoader:getAssetItem(assetUrl)
	local mainPrefab = assetItem:GetResource(assetUrl)

	gohelper.clone(mainPrefab, self._sceneGo)
	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnInitElements)
	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnNormalDungeonInitElements)
end

function DungeonMapScene:_addMapAudio()
	if self._mapAudioGo then
		gohelper.addChild(self._sceneGo, self._mapAudioGo)

		return
	end

	if self._mapCfg.chapterId == DungeonEnum.ChapterId.Main1_6 and not self.playingMain1_6Effect then
		self.playingMain1_6Effect = true

		AudioEffectMgr.instance:playAudio(AudioEnum.Bgm.Main1_6Effect)
	end

	local assetUrl = self._mapAudioUrl
	local assetItem = self._mapLoader:getAssetItem(assetUrl)
	local mainPrefab = assetItem:GetResource(assetUrl)

	self._mapAudioGo = gohelper.clone(mainPrefab, self._sceneGo, "audio")

	gohelper.addChild(self._sceneGo, self._mapAudioGo)
	transformhelper.setLocalPos(self._mapAudioGo.transform, 0, 0, 0)

	local areaAudio = self._mapCfg.areaAudio

	if string.nilorempty(areaAudio) then
		return
	end

	self._curMapAreaAudio = areaAudio

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

function DungeonMapScene:_initCanvas()
	local assetItem = self._mapLoader:getAssetItem(self._canvasUrl)
	local mainPrefab = assetItem:GetResource(self._canvasUrl)

	self._sceneCanvasGo = gohelper.clone(mainPrefab, self._sceneGo)
	self._sceneCanvas = self._sceneCanvasGo:GetComponent("Canvas")
	self._sceneCanvas.worldCamera = CameraMgr.instance:getMainCamera()
	assetItem = self._mapLoader:getAssetItem(self._interactiveItemUrl)
	self._itemPrefab = assetItem:GetResource(self._interactiveItemUrl)
end

function DungeonMapScene:getInteractiveItem()
	self._uiGo = gohelper.clone(self._itemPrefab, self._sceneCanvasGo)
	self._interactiveItem = MonoHelper.addLuaComOnceToGo(self._uiGo, DungeonMapScene.getInteractiveItemCls(self._mapCfg.chapterId))

	gohelper.setActive(self._uiGo, false)

	return self._interactiveItem
end

function DungeonMapScene:showInteractiveItem()
	return not gohelper.isNil(self._uiGo)
end

function DungeonMapScene:_initScene()
	local sizeGo = gohelper.findChild(self._sceneGo, "root/size")
	local box = sizeGo:GetComponentInChildren(typeof(UnityEngine.BoxCollider))

	if box then
		self._mapSize = box.size
	else
		self._mapSize = Vector2()

		logError(string.format("DungeonMapScene _initScene scene:%s 的root/size 缺少 BoxCollider,请联系地编处理", self._mapCfg.res))
	end

	local canvasGo
	local scale = GameUtil.getAdapterScale()
	local worldcorners = (scale ~= 1 and ViewMgr.instance:getUILayer(UILayerName.Hud) or ViewMgr.instance:getUIRoot()).transform:GetWorldCorners()
	local posTL = worldcorners[1] * scale
	local posBR = worldcorners[3] * scale

	self._viewWidth = math.abs(posBR.x - posTL.x)
	self._viewHeight = math.abs(posBR.y - posTL.y)
	self._mapMinX = posTL.x - (self._mapSize.x - self._viewWidth)
	self._mapMaxX = posTL.x
	self._mapMinY = posTL.y
	self._mapMaxY = posTL.y + (self._mapSize.y - self._viewHeight)

	if self._oldScenePos then
		self._sceneTrans.localPosition = self._oldScenePos
	end

	self:_setInitPos(self._oldScenePos)

	self._oldScenePos = nil
end

function DungeonMapScene:_setInitPos(tween)
	if not self._mapCfg then
		return
	end

	if ToughBattleModel.instance:getIsJumpActElement() then
		DungeonMapModel.instance.directFocusElement = true

		self:_focusElementById(ToughBattleEnum.ActElementId)

		DungeonMapModel.instance.directFocusElement = false

		return
	end

	if self:_focusBossElement() then
		return
	end

	local pos = self._mapCfg.initPos
	local posParam = string.splitToNumber(pos, "#")

	self:setScenePosSafety(Vector3(posParam[1], posParam[2], 0), tween)
end

function DungeonMapScene:_focusBossElement()
	local elementList = DungeonMapModel.instance:getElements(self._mapCfg.id)
	local hasBoss = false

	for i, v in ipairs(elementList) do
		if v.id == VersionActivity2_8BossEnum.ElementId then
			hasBoss = true

			break
		end
	end

	if hasBoss and (DungeonModel.instance:chapterIsPass(DungeonEnum.ChapterId.BossStory) or VersionActivity2_8BossModel.instance:isFocusElement()) then
		VersionActivity2_8BossModel.instance:setFocusElement(false)

		DungeonMapModel.instance.directFocusElement = true

		self:_focusElementById(VersionActivity2_8BossEnum.ElementId)

		DungeonMapModel.instance.directFocusElement = false

		return true
	end
end

function DungeonMapScene:disposeOldMap()
	self._oldScenePos = self._sceneTrans and self._sceneTrans.localPosition or nil

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnDisposeOldMap, self.viewName)

	if self._oldSceneGo then
		gohelper.destroy(self._oldSceneGo)

		self._oldSceneGo = nil
	end

	if self._oldMapLoader then
		self._oldMapLoader:dispose()

		self._oldMapLoader = nil
	end

	TaskDispatcher.cancelTask(self._addAllAudio, self)
	self:_removeEffectAudio()
	TaskDispatcher.cancelTask(self._addMapLight, self)
end

function DungeonMapScene:_stopAreaAudio()
	if self._mapAudioGo then
		gohelper.destroy(self._mapAudioGo)

		self._mapAudioGo = nil

		AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_noise_allarea)
		AudioMgr.instance:trigger(AudioEnum.Bgm.Stop_FightingMusic)
	end
end

function DungeonMapScene:_showMapTip()
	gohelper.setActive(self._gotoptipsbg, false)
end

function DungeonMapScene:_hideMapTip()
	gohelper.setActive(self._gotoptipsbg, false)
end

function DungeonMapScene:onOpen()
	self._showSceneChangeAnimState = SceneChangeAnimState.None

	gohelper.setActive(self._animchangeScene, false)
end

function DungeonMapScene:_onScreenResize()
	if self._sceneGo then
		self:_initScene()
	end
end

function DungeonMapScene:_onStoryFinish()
	TaskDispatcher.cancelTask(self._checkSceneVisible, self)
	TaskDispatcher.runRepeat(self._checkSceneVisible, self, 0)
	self:_updateSwitchState()
end

function DungeonMapScene:_checkSceneVisible()
	if ViewHelper.instance:checkViewOnTheTop(ViewName.DungeonMapView) then
		TaskDispatcher.cancelTask(self._checkSceneVisible, self)

		if not gohelper.isNil(self._sceneRoot) and not self._sceneRoot.activeSelf then
			logError("DungeonMapScene _checkSceneVisible is hided!")
			self:setSceneVisible(true)
		end
	end
end

function DungeonMapScene:_focusElementById(id)
	id = tonumber(id)

	local x, y = self:_getFocusPos(id)

	self:setScenePosSafety(Vector3(x, y, 0), not DungeonMapModel.instance.directFocusElement)
end

function DungeonMapScene:_getFocusPos(id)
	local config = lua_chapter_map_element.configDict[id]
	local pos = string.splitToNumber(config.pos, "#")

	if not pos[2] then
		local x, y = pos[1] or 0, 0
		local offsetPos = string.splitToNumber(config.offsetPos, "#")

		x = x + (offsetPos[1] or 0)
		y = y + (offsetPos[2] or 0)
		x = self._mapMaxX - x + self._viewWidth / 2
		y = self._mapMinY - y - self._viewHeight / 2 + 2

		return x, y
	end
end

function DungeonMapScene:_OnChangeMap(param)
	local mapCfg = param[1]

	self._episodeConfig = param[2]

	if mapCfg == self._mapCfg then
		self:_setInitPos(true)

		return
	end

	self:_changeMap(mapCfg)
end

function DungeonMapScene:_delaySendGuideEnterDungeonMapEvent()
	TaskDispatcher.runDelay(self._sendGuideEnterDungeonMapEvent, self, 0.5)
end

function DungeonMapScene:_sendGuideEnterDungeonMapEvent()
	local chapterId = self.viewParam.chapterId

	DungeonController.instance:dispatchEvent(DungeonEvent.OnEnterDungeonMapView, chapterId)
end

function DungeonMapScene:_delaySendGuideEnterEpisodeDungeonMapView()
	TaskDispatcher.runDelay(self._sendGuideEnterEpisodeDungeonMapView, self, 0.1)
end

function DungeonMapScene:_sendGuideEnterEpisodeDungeonMapView()
	if self._mapCfg then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnEnterEpisodeDungeonMapView, self._mapCfg.id)
	end
end

function DungeonMapScene:_onRecheckElement(elementId, isGM)
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

function DungeonMapScene:onClose()
	AudioMgr.instance:trigger(AudioEnum.UI.stop_uinoise_bus)
	AudioEffectMgr.instance:stopAudio(AudioEnum.Bgm.Main1_6Effect)
	TaskDispatcher.cancelTask(self._delayShowScene, self)
	TaskDispatcher.cancelTask(self._delayCloseEnd, self)
	TaskDispatcher.cancelTask(self._sendGuideEnterDungeonMapEvent, self)
	TaskDispatcher.cancelTask(self._delaySendGuideEnterEpisodeDungeonMapView, self)
	TaskDispatcher.cancelTask(self._checkSceneVisible, self)
	gohelper.destroy(self._sceneRoot)
	self:_stopAreaAudio()
	self:disposeOldMap()
	self:_removeEffectAudio(true)

	if self._mapLoader then
		self._mapLoader:dispose()
	end

	self._drag:RemoveDragBeginListener()
	self._drag:RemoveDragListener()
	self._drag:RemoveDragEndListener()
	self:removeEvents()
end

function DungeonMapScene:onDestroyView()
	TaskDispatcher.cancelTask(self._hideMapTip, self)
end

return DungeonMapScene
