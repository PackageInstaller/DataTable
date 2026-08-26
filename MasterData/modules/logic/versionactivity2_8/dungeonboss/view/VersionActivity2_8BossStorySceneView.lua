-- chunkname: @modules/logic/versionactivity2_8/dungeonboss/view/VersionActivity2_8BossStorySceneView.lua

module("modules.logic.versionactivity2_8.dungeonboss.view.VersionActivity2_8BossStorySceneView", package.seeall)

local VersionActivity2_8BossStorySceneView = class("VersionActivity2_8BossStorySceneView", BaseView)

function VersionActivity2_8BossStorySceneView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_8BossStorySceneView:addEvents()
	return
end

function VersionActivity2_8BossStorySceneView:removeEvents()
	return
end

function VersionActivity2_8BossStorySceneView:_editableInitView()
	self._gofullscreen = gohelper.findChild(self.viewGO, "#go_fullscreen")
	self._tempVector = Vector3()
	self._dragDeltaPos = Vector3()

	self:_initMap()
	self:_initDrag()
end

function VersionActivity2_8BossStorySceneView:_initMap()
	local mainTrans = CameraMgr.instance:getMainCameraTrs().parent
	local sceneRoot = CameraMgr.instance:getSceneRoot()

	self._sceneRoot = UnityEngine.GameObject.New("BossStoryScene")

	local x, y, z = transformhelper.getLocalPos(mainTrans)

	transformhelper.setLocalPos(self._sceneRoot.transform, 0, y, 0)
	gohelper.addChild(sceneRoot, self._sceneRoot)
end

function VersionActivity2_8BossStorySceneView:_initDrag()
	self._drag = SLFramework.UGUI.UIDragListener.Get(self._gofullscreen)

	self._drag:AddDragBeginListener(self._onDragBegin, self)
	self._drag:AddDragEndListener(self._onDragEnd, self)
	self._drag:AddDragListener(self._onDrag, self)
end

function VersionActivity2_8BossStorySceneView:getDragWorldPos(pointerEventData)
	local mainCamera = CameraMgr.instance:getMainCamera()
	local refPos = self._gofullscreen.transform.position

	return (SLFramework.UGUI.RectTrHelper.ScreenPosToWorldPos(pointerEventData.position, mainCamera, refPos))
end

function VersionActivity2_8BossStorySceneView:_onDragBegin(param, pointerEventData)
	self._dragBeginPos = self:getDragWorldPos(pointerEventData)

	if self._sceneTrans then
		self._beginDragPos = self._sceneTrans.localPosition
	end
end

function VersionActivity2_8BossStorySceneView:_onDragEnd(param, pointerEventData)
	self._dragBeginPos = nil
	self._beginDragPos = nil
end

function VersionActivity2_8BossStorySceneView:_onDrag(param, pointerEventData)
	if not self._dragBeginPos then
		return
	end

	local deltaPos = self:getDragWorldPos(pointerEventData) - self._dragBeginPos

	self:drag(deltaPos)
end

function VersionActivity2_8BossStorySceneView:drag(deltaPos)
	if not self._sceneTrans or not self._beginDragPos then
		return
	end

	self._dragDeltaPos.x = deltaPos.x
	self._dragDeltaPos.y = deltaPos.y

	local targetPos = self:vectorAdd(self._beginDragPos, self._dragDeltaPos)

	self:setScenePosSafety(targetPos)
end

function VersionActivity2_8BossStorySceneView:vectorAdd(v1, v2)
	local tempVector = self._tempVector

	tempVector.x = v1.x + v2.x
	tempVector.y = v1.y + v2.y

	return tempVector
end

function VersionActivity2_8BossStorySceneView:_changeMap(mapCfg)
	if not mapCfg then
		logError("VersionActivity2_8BossStorySceneView mapCfg is nil")

		return
	end

	if not self._oldMapLoader and self._sceneGo then
		self._oldMapLoader = self._mapLoader
		self._oldSceneGo = self._sceneGo
		self._mapLoader = nil
	end

	if self._mapLoader then
		self._mapLoader:dispose()

		self._mapLoader = nil
	end

	self._mapCfg = mapCfg
	self._mapLoader = MultiAbLoader.New()
	self._sceneUrl = string.format("scenes/%s.prefab", mapCfg.res)

	self._mapLoader:addPath(self._sceneUrl)
	self._mapLoader:startLoad(self._loadSceneFinish, self)
end

function VersionActivity2_8BossStorySceneView:_loadSceneFinish()
	self:_disposeOldMap()

	local assetUrl = self._sceneUrl
	local assetItem = self._mapLoader:getAssetItem(assetUrl)
	local mainPrefab = assetItem:GetResource(assetUrl)

	self._sceneGo = gohelper.clone(mainPrefab, self._sceneRoot)
	self._sceneTrans = self._sceneGo.transform
	self._animator = self._sceneGo:GetComponent("Animator")
	self._animator.enabled = false

	transformhelper.setLocalScale(self._sceneTrans, VersionActivity2_8BossEnum.SceneNearScale, VersionActivity2_8BossEnum.SceneNearScale, VersionActivity2_8BossEnum.SceneNearScale)
	MainCameraMgr.instance:addView(self.viewName, self._initCamera, nil, self)
	self:_initScene()
end

function VersionActivity2_8BossStorySceneView:_initCamera()
	local camera = CameraMgr.instance:getMainCamera()

	camera.orthographic = true

	local scale = GameUtil.getAdapterScale()

	camera.orthographicSize = 5 * scale
end

function VersionActivity2_8BossStorySceneView:_initScene()
	local sizeGo = gohelper.findChild(self._sceneGo, "root/size")
	local box = sizeGo:GetComponentInChildren(typeof(UnityEngine.BoxCollider))

	self._mapSize = box.size

	local sizeX = self._mapSize.x * VersionActivity2_8BossEnum.SceneNearScale
	local sizeY = self._mapSize.y * VersionActivity2_8BossEnum.SceneNearScale
	local canvasGo
	local scale = GameUtil.getAdapterScale()
	local worldcorners = (scale ~= 1 and ViewMgr.instance:getUILayer(UILayerName.Hud) or ViewMgr.instance:getUIRoot()).transform:GetWorldCorners()
	local posTL = worldcorners[1] * scale
	local posBR = worldcorners[3] * scale

	self._viewWidth = math.abs(posBR.x - posTL.x)
	self._viewHeight = math.abs(posBR.y - posTL.y)
	self._mapMinX = posTL.x - (sizeX - self._viewWidth)
	self._mapMaxX = posTL.x
	self._mapMinY = posTL.y
	self._mapMaxY = posTL.y + (sizeY - self._viewHeight)

	self:_setInitPos()
end

function VersionActivity2_8BossStorySceneView:_getInitPos()
	if ViewMgr.instance:isOpen(ViewName.VersionActivity2_8BossStoryLoadingView) and self._episodeId == VersionActivity2_8BossEnum.StoryBossSecondEpisode and not GuideController.instance:isForbidGuides() and not GuideModel.instance:isGuideFinish(VersionActivity2_8BossEnum.StoryBossSecondEpisodeGuideId) then
		return "-31.5#14.4"
	end

	if self._moveToTargetMap then
		local map = self._moveToTargetMap

		self._moveToTargetMap = nil

		return map.initPos
	end

	return self._mapCfg.initPos
end

function VersionActivity2_8BossStorySceneView:_setInitPos(tween)
	if not self._sceneTrans then
		return
	end

	local pos = self:_getInitPos()
	local posParam = string.splitToNumber(pos, "#")

	self:setScenePosSafety(Vector3(posParam[1], posParam[2], 0), tween)
	self:_moveMapPos()
end

function VersionActivity2_8BossStorySceneView:setScenePosSafety(targetPos, tween)
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
			self._tweenTime = nil

			UIBlockHelper.instance:startBlock("VersionActivity2_8BossStorySceneView", self._tweenTime, self.viewName)
			ZProj.TweenHelper.DOLocalMove(self._sceneTrans, targetPos.x, targetPos.y, 0, self._tweenTime, self._localMoveDone, self, nil, EaseType.InOutQuart)
		end
	else
		self._sceneTrans.localPosition = targetPos
	end
end

function VersionActivity2_8BossStorySceneView:_localMoveDone()
	return
end

function VersionActivity2_8BossStorySceneView:setSceneVisible(isVisible)
	gohelper.setActive(self._sceneRoot, isVisible and true or false)
end

function VersionActivity2_8BossStorySceneView:onOpen()
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenResize, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.BossStoryReset, self._onBossStoryReset, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.BossStoryMoveMap, self._onBossStoryMoveMap, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.BossStoryMoveMapAnim, self._onBossStoryMoveMapAnim, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.BossStoryPreMoveMapPos, self._onBossStoryPreMoveMapPos, self)
	self:_startChangeMap()
end

function VersionActivity2_8BossStorySceneView.getMap()
	local episodeId = VersionActivity2_8BossModel.instance:getStoryBossCurEpisodeId()
	local mapId = VersionActivity2_8BossConfig.instance:getEpisodeMapId(episodeId)
	local map = lua_chapter_map.configDict[mapId]

	return map, episodeId
end

function VersionActivity2_8BossStorySceneView:_startChangeMap()
	self._map, self._episodeId = VersionActivity2_8BossStorySceneView.getMap()

	if self._map then
		self:_changeMap(self._map)
	else
		logError(string.format("map is not exist,episodeId:%s", self._episodeId))
	end
end

function VersionActivity2_8BossStorySceneView:_onScreenResize()
	if self._sceneGo then
		self:_initScene()
	end
end

function VersionActivity2_8BossStorySceneView:_onBossStoryMoveMap(param)
	self._tweenMapPosParam = string.splitToNumber(param, "_")

	self:_moveMapPos()
end

function VersionActivity2_8BossStorySceneView:_onBossStoryMoveMapAnim(param)
	self._animator.enabled = true

	self._animator:Play(param, 0, 0)
end

function VersionActivity2_8BossStorySceneView:_onBossStoryPreMoveMapPos(param)
	if not ViewMgr.instance:isOpen(ViewName.VersionActivity2_8BossStoryLoadingView) then
		return
	end

	local episodeId = tonumber(param)
	local mapId = VersionActivity2_8BossConfig.instance:getEpisodeMapId(episodeId)

	self._moveToTargetMap = lua_chapter_map.configDict[mapId]

	self:_setInitPos()
end

function VersionActivity2_8BossStorySceneView:_moveMapPos()
	if not self._sceneTrans then
		return
	end

	if not self._tweenMapPosParam then
		return
	end

	local fromEpisodeId = self._tweenMapPosParam[1]
	local toEpisodeId = self._tweenMapPosParam[2]

	self._tweenMapPosParam = nil
	self._tweenTime = self._tweenMapPosParam[3]

	local mapId = VersionActivity2_8BossConfig.instance:getEpisodeMapId(fromEpisodeId)
	local map = lua_chapter_map.configDict[mapId]
	local mapId2 = VersionActivity2_8BossConfig.instance:getEpisodeMapId(toEpisodeId)
	local map2 = lua_chapter_map.configDict[mapId2]
	local pos = map.initPos
	local posParam = string.splitToNumber(pos, "#")

	self:setScenePosSafety(Vector3(posParam[1], posParam[2], 0))

	local pos2 = map2.initPos
	local posParam2 = string.splitToNumber(pos2, "#")

	self:setScenePosSafety(Vector3(posParam2[1], posParam2[2], 0), true)
end

function VersionActivity2_8BossStorySceneView:_onBossStoryReset()
	self:_startChangeMap()
end

function VersionActivity2_8BossStorySceneView:_disposeOldMap()
	if self._oldSceneGo then
		gohelper.destroy(self._oldSceneGo)

		self._oldSceneGo = nil
	end

	if self._oldMapLoader then
		self._oldMapLoader:dispose()

		self._oldMapLoader = nil
	end
end

function VersionActivity2_8BossStorySceneView:onClose()
	gohelper.destroy(self._sceneRoot)

	if self._mapLoader then
		self._mapLoader:dispose()
	end

	self:_disposeOldMap()
	self._drag:RemoveDragBeginListener()
	self._drag:RemoveDragListener()
	self._drag:RemoveDragEndListener()
end

function VersionActivity2_8BossStorySceneView:onDestroyView()
	return
end

return VersionActivity2_8BossStorySceneView
