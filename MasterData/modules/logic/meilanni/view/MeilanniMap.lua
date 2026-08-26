-- chunkname: @modules/logic/meilanni/view/MeilanniMap.lua

module("modules.logic.meilanni.view.MeilanniMap", package.seeall)

local MeilanniMap = class("MeilanniMap", BaseView)

function MeilanniMap:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function MeilanniMap:addEvents()
	return
end

function MeilanniMap:removeEvents()
	return
end

function MeilanniMap:_editableInitView()
	self:_initMap()
end

function MeilanniMap:setScenePosSafety(targetPos, tween)
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

	if tween then
		ZProj.TweenHelper.DOLocalMove(self._sceneTrans, targetPos.x, targetPos.y, 0, 0.26)
	else
		self._sceneTrans.localPosition = targetPos
	end
end

function MeilanniMap:_initCamera()
	local camera = CameraMgr.instance:getMainCamera()

	camera.orthographic = true

	transformhelper.setLocalRotation(camera.transform, 0, 0, 0)

	local scale = GameUtil.getAdapterScale()

	camera.orthographicSize = MeilanniEnum.orthographicSize * scale
end

function MeilanniMap:_resetCamera()
	local camera = CameraMgr.instance:getMainCamera()

	camera.orthographicSize = MeilanniEnum.orthographicSize
	camera.orthographic = false
end

function MeilanniMap:_initMap()
	local mainTrans = CameraMgr.instance:getMainCameraTrs().parent
	local sceneRoot = CameraMgr.instance:getSceneRoot()

	self._sceneRoot = UnityEngine.GameObject.New("MeilanniMap")

	local x, y, z = transformhelper.getLocalPos(mainTrans)

	transformhelper.setLocalPos(self._sceneRoot.transform, 0, y, 0)
	gohelper.addChild(sceneRoot, self._sceneRoot)
end

function MeilanniMap:onUpdateParam()
	return
end

function MeilanniMap:_showMap()
	local episodeInfo = self._mapInfo:getCurEpisodeInfo()
	local curMap = episodeInfo.episodeConfig

	self:_changeMap(curMap)
end

function MeilanniMap:_changeMap(curMap)
	if self._mapCfg == curMap then
		return
	end

	if not self._oldMapLoader then
		self._oldMapLoader = self._mapLoader
		self._oldSceneGo = self._sceneGo
		self._oldSceneTrans = self._sceneTrans
	elseif self._mapLoader then
		self._mapLoader:dispose()

		self._mapLoader = nil
	end

	self._mapCfg = curMap

	local url = curMap.res

	self:_loadMap(url)
end

function MeilanniMap:_loadMap(url)
	self._mapLoader = MultiAbLoader.New()

	self._mapLoader:addPath(url)
	self._mapLoader:startLoad(function(multiAbLoader)
		local oldSceneGo = self._oldSceneGo

		self._oldSceneGo = nil

		self:disposeOldMap()

		local assetItem = self._mapLoader:getAssetItem(url)
		local mainPrefab = assetItem:GetResource(url)

		self._sceneGo = gohelper.clone(mainPrefab, self._sceneRoot)

		gohelper.setActive(self._sceneGo, true)

		self._sceneTrans = self._sceneGo.transform

		self:_startFade(oldSceneGo, self._sceneGo)
	end)
end

function MeilanniMap:_startFade(oldSceneGo, newSceneGo)
	if not oldSceneGo then
		return
	end

	local animator = newSceneGo:GetComponent(typeof(UnityEngine.Animator))

	animator.enabled = false

	gohelper.setAsLastSibling(oldSceneGo)

	self._oldSceneGoAnim = oldSceneGo
	self._newSceneGoAnim = newSceneGo
	self._oldMats = self:_collectMats(oldSceneGo)
	self._newMats = self:_collectMats(newSceneGo)

	self:_frameUpdateNew(0)
	self:_fadeOld()

	local delayTime = 0.5

	TaskDispatcher.runDelay(self._fadeNew, self, delayTime)
end

function MeilanniMap:_fadeOld()
	local oldStartValue = 1
	local oldEndValue = 0
	local oldFadeTime = 2

	ZProj.TweenHelper.DOTweenFloat(oldStartValue, oldEndValue, oldFadeTime, self._frameUpdateOld, self._fadeInFinishOld, self)
end

function MeilanniMap:_fadeNew()
	local newStartValue = 0
	local newEndValue = 1
	local newFadeTime = 1.5

	ZProj.TweenHelper.DOTweenFloat(newStartValue, newEndValue, newFadeTime, self._frameUpdateNew, self._fadeInFinishNew, self)
end

function MeilanniMap:_collectMats(go)
	local mats = {}
	local meshRenderList = go:GetComponentsInChildren(typeof(UnityEngine.Renderer))

	for i = 0, meshRenderList.Length - 1 do
		local mat = meshRenderList[i].material

		table.insert(mats, mat)
	end

	return mats
end

function MeilanniMap:_updateMatAlpha(mats, value)
	for i, mat in ipairs(mats) do
		if mat:HasProperty("_MainCol") then
			local color = mat:GetColor("_MainCol")

			color.a = value

			mat:SetColor("_MainCol", color)
		end
	end
end

function MeilanniMap:_frameUpdateNew(value)
	self:_updateMatAlpha(self._newMats, value)
end

function MeilanniMap:_fadeInFinishNew(value)
	self:_updateMatAlpha(self._newMats, 1)

	self._newSceneGoAnim = nil
end

function MeilanniMap:_frameUpdateOld(value)
	self:_updateMatAlpha(self._oldMats, value)
end

function MeilanniMap:_fadeInFinishOld(value)
	if self._oldSceneGoAnim then
		gohelper.destroy(self._oldSceneGoAnim)

		self._oldSceneGoAnim = nil
	end
end

function MeilanniMap:_initCanvas()
	local assetItem = self._mapLoader:getAssetItem(self._canvasUrl)
	local mainPrefab = assetItem:GetResource(self._canvasUrl)

	self._sceneCanvasGo = gohelper.clone(mainPrefab, self._sceneGo)
	self._sceneCanvas = self._sceneCanvasGo:GetComponent("Canvas")
	self._sceneCanvas.worldCamera = CameraMgr.instance:getMainCamera()
end

function MeilanniMap:_initScene()
	local sizeGo = gohelper.findChild(self._sceneGo, "root/size")
	local box = sizeGo:GetComponentInChildren(typeof(UnityEngine.BoxCollider))

	self._mapSize = box.size

	local canvasGo
	local scale = GameUtil.getAdapterScale()
	local worldcorners = (scale ~= 1 and ViewMgr.instance:getUILayer(UILayerName.Hud) or ViewMgr.instance:getUIRoot()).transform:GetWorldCorners()
	local posTL = worldcorners[1]
	local posBR = worldcorners[3]

	self._viewWidth = math.abs(posBR.x - posTL.x)
	self._viewHeight = math.abs(posBR.y - posTL.y)
	self._mapMinX = posTL.x - (self._mapSize.x - self._viewWidth)
	self._mapMaxX = posTL.x
	self._mapMinY = posTL.y
	self._mapMaxY = posTL.y + (self._mapSize.y - self._viewHeight)

	if self._oldScenePos then
		self._sceneTrans.localPosition = self._oldScenePos
	end

	self._oldScenePos = nil
end

function MeilanniMap:_setInitPos(tween)
	if not self._mapCfg then
		return
	end

	local pos = self._mapCfg.initPos
	local posParam = string.splitToNumber(pos, "#")

	self:setScenePosSafety(Vector3(posParam[1], posParam[2], 0), tween)
end

function MeilanniMap:disposeOldMap()
	self._oldScenePos = self._sceneTrans and self._sceneTrans.localPosition or nil

	if self._oldMapLoader then
		self._oldMapLoader:dispose()

		self._oldMapLoader = nil
	end

	if self._oldSceneGo then
		gohelper.destroy(self._oldSceneGo)

		self._oldSceneGo = nil
	end
end

function MeilanniMap:onOpen()
	self._mapId = MeilanniModel.instance:getCurMapId()
	self._mapInfo = MeilanniModel.instance:getMapInfo(self._mapId)

	self.addEventCb(self, MainController.instance, MainEvent.OnSceneClose, self._onSceneClose, self)
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenResize, self)
	self.addEventCb(self, MeilanniController.instance, MeilanniEvent.episodeInfoUpdate, self._episodeInfoUpdate, self)
	self.addEventCb(self, MeilanniController.instance, MeilanniEvent.resetMap, self._resetMap, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self:_initCamera()
	self:_showMap()
end

function MeilanniMap:_onCloseView(viewName)
	if viewName == ViewName.DungeonMapView then
		self:_initCamera()
	end
end

function MeilanniMap:_resetMap()
	self:_showMap()
end

function MeilanniMap:_episodeInfoUpdate()
	MeilanniAnimationController.instance:addDelayCall(self._showMap, self, nil, MeilanniEnum.changeMapTime, MeilanniAnimationController.changeMapLayer)
end

function MeilanniMap:_onScreenResize()
	local camera = CameraMgr.instance:getMainCamera()
	local scale = GameUtil.getAdapterScale()

	camera.orthographicSize = MeilanniEnum.orthographicSize * scale
end

function MeilanniMap:_onSceneClose()
	return
end

function MeilanniMap:onClose()
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self:_resetCamera()
end

function MeilanniMap:onDestroyView()
	gohelper.destroy(self._sceneRoot)
	self:disposeOldMap()

	if self._mapLoader then
		self._mapLoader:dispose()
	end
end

return MeilanniMap
