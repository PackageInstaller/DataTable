-- chunkname: @modules/logic/commandstation/view/CommandStationMapSceneView.lua

module("modules.logic.commandstation.view.CommandStationMapSceneView", package.seeall)

local CommandStationMapSceneView = class("CommandStationMapSceneView", BaseView)

function CommandStationMapSceneView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function CommandStationMapSceneView:addEvents()
	return
end

function CommandStationMapSceneView:removeEvents()
	return
end

function CommandStationMapSceneView:_editableInitView()
	self._gofullscreen = gohelper.findChild(self.viewGO, "#go_bg")
	self._tempVector = Vector3()
	self._dragDeltaPos = Vector3()

	self:_initMap()
	self:_initDrag()
end

function CommandStationMapSceneView:_initMap()
	local mainTrans = CameraMgr.instance:getMainCameraTrs().parent
	local sceneRoot = CameraMgr.instance:getSceneRoot()

	self._sceneRoot = UnityEngine.GameObject.New("CommandStationMapScene")

	local x, y, z = transformhelper.getLocalPos(mainTrans)

	transformhelper.setLocalPos(self._sceneRoot.transform, 0, y, 0)
	gohelper.addChild(sceneRoot, self._sceneRoot)
end

function CommandStationMapSceneView:_initDrag()
	self._drag = SLFramework.UGUI.UIDragListener.Get(self._gofullscreen)

	self._drag:AddDragBeginListener(self._onDragBegin, self)
	self._drag:AddDragEndListener(self._onDragEnd, self)
	self._drag:AddDragListener(self._onDrag, self)
end

function CommandStationMapSceneView:getDragWorldPos(pointerEventData)
	local mainCamera = CameraMgr.instance:getMainCamera()
	local refPos = self._gofullscreen.transform.position

	return (SLFramework.UGUI.RectTrHelper.ScreenPosToWorldPos(pointerEventData.position, mainCamera, refPos))
end

function CommandStationMapSceneView:_onDragBegin(param, pointerEventData)
	if ViewMgr.instance:isOpen(ViewName.CommandStationCharacterEventView) then
		return
	end

	self._dragBeginPos = self:getDragWorldPos(pointerEventData)

	if self._sceneTrans then
		self._beginDragPos = self._sceneTrans.localPosition
	end
end

function CommandStationMapSceneView:_onDragEnd(param, pointerEventData)
	self._dragBeginPos = nil
	self._beginDragPos = nil
end

function CommandStationMapSceneView:_onDrag(param, pointerEventData)
	if not self._dragBeginPos then
		return
	end

	local deltaPos = self:getDragWorldPos(pointerEventData) - self._dragBeginPos

	self:drag(deltaPos)
end

function CommandStationMapSceneView:drag(deltaPos)
	if not self._sceneTrans or not self._beginDragPos then
		return
	end

	self._dragDeltaPos.x = deltaPos.x
	self._dragDeltaPos.y = deltaPos.y

	local targetPos = self:vectorAdd(self._beginDragPos, self._dragDeltaPos)

	self:setScenePosSafety(targetPos)
end

function CommandStationMapSceneView:vectorAdd(v1, v2)
	local tempVector = self._tempVector

	tempVector.x = v1.x + v2.x
	tempVector.y = v1.y + v2.y

	return tempVector
end

function CommandStationMapSceneView:_changeMap(scenePath)
	if self._sceneUrl == scenePath then
		CommandStationController.instance:dispatchEvent(CommandStationEvent.MapLoadFinish, self._sceneGo)
		CommandStationController.instance:dispatchEvent(CommandStationEvent.MoveScene)

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

	self._sceneUrl = scenePath

	local loader = CommandStationMapModel.instance:getPreloadSceneLoader()
	local sceneGo = CommandStationMapModel.instance:getPreloadScene()

	if loader and sceneGo then
		CommandStationMapModel.instance:setPreloadScene(nil, nil)

		self._mapLoader = loader

		self:_initSceneGo(sceneGo)

		return
	end

	self._mapLoader = MultiAbLoader.New()

	self._mapLoader:addPath(self._sceneUrl)
	self._mapLoader:startLoad(self._loadSceneFinish, self)
end

function CommandStationMapSceneView:_loadSceneFinish()
	self:_disposeOldMap()

	local assetUrl = self._sceneUrl
	local assetItem = self._mapLoader:getAssetItem(assetUrl)
	local mainPrefab = assetItem:GetResource(assetUrl)
	local sceneGo = gohelper.clone(mainPrefab, self._sceneRoot)

	self:_initSceneGo(sceneGo)
end

function CommandStationMapSceneView:_initSceneGo(go)
	gohelper.setActive(go, true)

	self._sceneGo = go

	gohelper.addChild(self._sceneRoot, go)

	self._sceneTrans = self._sceneGo.transform

	transformhelper.setLocalPos(self._sceneTrans, 0, 0, 0)
	transformhelper.setLocalScale(self._sceneTrans, 1, 1, 1)
	CommandStationMapModel.instance:setSceneGo(self._sceneGo)
	MainCameraMgr.instance:addView(self.viewName, self._initCamera, self._resetCamera, self)
	MainCameraMgr.instance:setCloseViewFinishReset(self.viewName, true)
	self:_initScene()
	CommandStationController.instance:dispatchEvent(CommandStationEvent.MapLoadFinish, self._sceneGo)
end

function CommandStationMapSceneView:getSceneGo()
	return self._sceneGo
end

function CommandStationMapSceneView:_setBlur(value)
	if value then
		self._blurOriginalParam = self._blurOriginalParam or {
			dofFactor = PostProcessingMgr.instance:getUnitPPValue("dofFactor"),
			dofDistance = PostProcessingMgr.instance:getUnitPPValue("dofDistance"),
			dofSampleScale = PostProcessingMgr.instance:getUnitPPValue("dofSampleScale"),
			dofRT1Scale = PostProcessingMgr.instance:getUnitPPValue("dofRT1Scale"),
			dofRT2Scale = PostProcessingMgr.instance:getUnitPPValue("dofRT2Scale"),
			dofRT3Scale = PostProcessingMgr.instance:getUnitPPValue("dofRT3Scale"),
			dofTotalScale = PostProcessingMgr.instance:getUnitPPValue("dofTotalScale"),
			rolesStoryMaskActive = PostProcessingMgr.instance:getUnitPPValue("rolesStoryMaskActive"),
			bloomActive = PostProcessingMgr.instance:getUnitPPValue("bloomActive")
		}

		if self._tweenFactorFinish then
			PostProcessingMgr.instance:setUnitPPValue("dofFactor", 1)
		end

		PostProcessingMgr.instance:setUnitPPValue("dofDistance", 0)
		PostProcessingMgr.instance:setUnitPPValue("dofSampleScale", Vector4(0.1, 0.1, 2, 0))
		PostProcessingMgr.instance:setUnitPPValue("dofRT1Scale", 1)
		PostProcessingMgr.instance:setUnitPPValue("dofRT2Scale", 1)
		PostProcessingMgr.instance:setUnitPPValue("dofRT3Scale", 2)
		PostProcessingMgr.instance:setUnitPPValue("dofTotalScale", 1)
		PostProcessingMgr.instance:setUnitPPValue("rolesStoryMaskActive", false)
		PostProcessingMgr.instance:setUnitPPValue("bloomActive", false)
		gohelper.setActive(CameraMgr.instance:getUnitCameraGO(), true)
	else
		if not self._blurOriginalParam then
			return
		end

		if ViewMgr.instance:isOpen(ViewName.CommandStationEnterView) then
			gohelper.setActive(CameraMgr.instance:getUnitCameraGO(), false)
		end

		PostProcessingMgr.instance:setUnitPPValue("dofFactor", self._blurOriginalParam.dofFactor)
		PostProcessingMgr.instance:setUnitPPValue("dofDistance", self._blurOriginalParam.dofDistance)
		PostProcessingMgr.instance:setUnitPPValue("dofSampleScale", self._blurOriginalParam.dofSampleScale)
		PostProcessingMgr.instance:setUnitPPValue("dofRT1Scale", self._blurOriginalParam.dofRT1Scale)
		PostProcessingMgr.instance:setUnitPPValue("dofRT2Scale", self._blurOriginalParam.dofRT2Scale)
		PostProcessingMgr.instance:setUnitPPValue("dofRT3Scale", self._blurOriginalParam.dofRT3Scale)
		PostProcessingMgr.instance:setUnitPPValue("dofTotalScale", self._blurOriginalParam.dofTotalScale)
		PostProcessingMgr.instance:setUnitPPValue("rolesStoryMaskActive", self._blurOriginalParam.rolesStoryMaskActive)
		PostProcessingMgr.instance:setUnitPPValue("bloomActive", self._blurOriginalParam.bloomActive)

		self._blurOriginalParam = nil
	end
end

function CommandStationMapSceneView:_initCamera()
	if self._sceneVisible == false then
		return
	end

	self._targetOrghographic = false
	self._targetFov = CommandStationMapSceneView.getFov(CommandStationEnum.CameraFov)
	self._targetPosZ = -7.5
	self._targetRotation = CommandStationEnum.CameraRotation + 360

	local camera = CameraMgr.instance:getMainCamera()

	camera.orthographic = self._targetOrghographic
	camera.fieldOfView = self._targetFov

	local mainGo = CameraMgr.instance:getCameraTraceGO()

	transformhelper.setLocalPos(mainGo.transform, 0, 0, self._targetPosZ)
	transformhelper.setLocalRotation(mainGo.transform, self._targetRotation, 0, 0)
	self:_setBlur(true)
end

function CommandStationMapSceneView.getFov(fovValue)
	local fovRatio = 1.7777777777777777 * (UnityEngine.Screen.height / UnityEngine.Screen.width)

	if BootNativeUtil.isWindows() and not SLFramework.FrameworkSettings.IsEditor then
		local w, h = SettingsModel.instance:getCurrentScreenSize()

		fovRatio = 16 * h / 9 / w
	end

	return fovValue * fovRatio
end

function CommandStationMapSceneView:_resetCamera()
	self:_doScreenResize()
	self:_setBlur(false)
end

function CommandStationMapSceneView:_doScreenResize()
	local gameScreenState = GameGlobalMgr.instance:getScreenState()
	local width, height = gameScreenState:getScreenSize()

	GameGlobalMgr.instance:dispatchEvent(GameStateEvent.OnScreenResize, width, height)
end

function CommandStationMapSceneView:_initScene()
	if self._sceneVisible == false then
		return
	end

	self:_initCamera()

	local sizeGo = gohelper.findChild(self._sceneGo, "root/size")
	local box = sizeGo and sizeGo:GetComponentInChildren(typeof(UnityEngine.BoxCollider))

	if box then
		self._mapSize = box.size
	else
		logError(string.format("CommandStationMapSceneView _initScene scene:%s 的root/size 缺少 BoxCollider,请联系地编处理", self._sceneUrl))

		self._mapSize = Vector2()
	end

	local sizeX = self._mapSize.x
	local sizeY = self._mapSize.y
	local targetCamera = CameraMgr.instance:getMainCamera()
	local screenWidth = UnityEngine.Screen.width
	local screenHeight = UnityEngine.Screen.height
	local screenTopLeft = Vector3(0, screenHeight, 0)
	local screenBottomRight = Vector3(screenWidth, 0, 0)
	local planeNormal = Vector3.forward
	local planePoint = Vector3.zero
	local posTL = self:_getRayPlaneIntersection(targetCamera:ScreenPointToRay(screenTopLeft), planeNormal, planePoint)
	local posBR = self:_getRayPlaneIntersection(targetCamera:ScreenPointToRay(screenBottomRight), planeNormal, planePoint)

	self._viewWidth = math.abs(posBR.x - posTL.x)
	self._viewHeight = math.abs(posBR.y - posTL.y)
	self._halfViewWidth = self._viewWidth / 2
	self._halfViewHeight = self._viewHeight / 2

	local rootPos = self._sceneRoot.transform.position
	local offsetMinX = 1
	local offsetMaxX = -1
	local offsetMinY = 1
	local offsetMaxY = -1

	self._mapMinX = posTL.x - (sizeX - self._viewWidth) - rootPos.x + offsetMinX
	self._mapMaxX = posTL.x - rootPos.x + offsetMaxX
	self._mapMinY = posTL.y - rootPos.y + offsetMinY
	self._mapMaxY = posTL.y + (sizeY - self._viewHeight) - rootPos.y + offsetMaxY

	local leftUpRange = self._sceneConfig.leftUpRange
	local rightDownRange = self._sceneConfig.rightDownRange
	local mapMinX = -rightDownRange[1] + self._halfViewWidth
	local mapMaxX = -leftUpRange[1] - self._halfViewWidth
	local mapMinY = -leftUpRange[2] + self._halfViewHeight
	local mapMaxY = -rightDownRange[2] - self._halfViewHeight

	self._dragMapMinX = math.min(mapMinX, mapMaxX)
	self._dragMapMaxX = math.max(mapMinX, mapMaxX)
	self._dragMapMinY = math.min(mapMinY, mapMaxY)
	self._dragMapMaxY = math.max(mapMinY, mapMaxY)

	self:_setInitPos()
end

function CommandStationMapSceneView:_getRayPlaneIntersection(ray, planeNormal, planePoint)
	local rayOrigin = ray.origin
	local rayDirection = ray.direction
	local denominator = Vector3.Dot(rayDirection, planeNormal)
	local t = Vector3.Dot(planePoint - rayOrigin, planeNormal) / denominator

	return rayOrigin + rayDirection * t
end

function CommandStationMapSceneView:_getInitPos()
	return "-8#4"
end

function CommandStationMapSceneView:_setInitPos(tween)
	if not self._sceneTrans then
		return
	end

	if self._targetPos then
		self:setScenePosSafety(self._targetPos, tween, self._skipInBoundary)

		return
	end

	local pos = self:_getInitPos()
	local posParam = string.splitToNumber(pos, "#")

	self:setScenePosSafety(Vector3(posParam[1], posParam[2], 0), tween)
end

function CommandStationMapSceneView:_getMapInfo(skipInBoundary)
	if skipInBoundary then
		return self._mapMinX, self._mapMinY, self._mapMaxX, self._mapMaxY
	else
		return self._dragMapMinX, self._dragMapMinY, self._dragMapMaxX, self._dragMapMaxY
	end
end

function CommandStationMapSceneView:setScenePosSafety(targetPos, tween, skipInBoundary)
	if not self._sceneTrans then
		return
	end

	self._skipInBoundary = skipInBoundary

	local mapMinX, mapMinY, mapMaxX, mapMaxY = self:_getMapInfo(skipInBoundary)

	targetPos.x = Mathf.Clamp(targetPos.x, mapMinX, mapMaxX)
	targetPos.y = Mathf.Clamp(targetPos.y, mapMinY, mapMaxY)
	self._targetPos = targetPos

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	if tween then
		CommandStationController.instance:dispatchEvent(CommandStationEvent.MoveScene, true)

		if not self._tweenTime then
			self._tweenTime = nil

			UIBlockHelper.instance:startBlock("CommandStationMapSceneView", self._tweenTime, self.viewName)

			self._tweenId = ZProj.TweenHelper.DOLocalMove(self._sceneTrans, targetPos.x, targetPos.y, 0, self._tweenTime, self._localMoveDone, self, nil, EaseType.InOutCubic)
		end
	else
		self._sceneTrans.localPosition = targetPos

		CommandStationController.instance:dispatchEvent(CommandStationEvent.MoveScene)
	end
end

function CommandStationMapSceneView:_localMoveDone()
	CommandStationController.instance:dispatchEvent(CommandStationEvent.MoveScene)
end

function CommandStationMapSceneView:setSceneVisible(isVisible)
	self._sceneVisible = isVisible

	gohelper.setActive(self._sceneRoot, isVisible and true or false)
	self:_setBlur(isVisible)
	self:_doScreenResize()
end

function CommandStationMapSceneView:onOpen()
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenResize, self, LuaEventSystem.Low)
	self.addEventCb(self, CommandStationController.instance, CommandStationEvent.SelectTimePoint, self._onSelectTimePoint, self)
	self.addEventCb(self, CommandStationController.instance, CommandStationEvent.SceneFocusPos, self._onSceneFocusPos, self)
	self.addEventCb(self, CommandStationController.instance, CommandStationEvent.RTGoHide, self._onRTGoHide, self)
	self.addEventCb(self, PostProcessingMgr.instance, PostProcessingEvent.onUnitCameraVisibleChange, self._onUnitCameraVisibleChange, self, LuaEventSystem.Low)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.BeforeOpenView, self._onBeforeOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.ReOpenWhileOpen, self._onReOpenWhileOpen, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._OnCloseView, self)
	self:_showTimeId(CommandStationMapModel.instance:getTimeId())
	TaskDispatcher.runRepeat(self._protectedCamera, self, 0)
end

function CommandStationMapSceneView:_protectedCamera()
	if self._sceneVisible == false or not self._sceneGo then
		return
	end

	local camera = CameraMgr.instance:getMainCamera()
	local mainGo = CameraMgr.instance:getCameraTraceGO()
	local rotation = transformhelper.getLocalRotation(mainGo.transform)
	local x, y, z = transformhelper.getLocalPos(mainGo.transform)

	if camera.orthographic ~= self._targetOrghographic or z ~= self._targetPosZ or rotation ~= self._targetRotation then
		self:_initCamera()
	end
end

function CommandStationMapSceneView:_onRTGoHide()
	self._tweenFactor = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.5, self._tweenUpdate, self._tweenFinish, self)
end

function CommandStationMapSceneView:_tweenUpdate(value)
	if not self._blurOriginalParam then
		return
	end

	PostProcessingMgr.instance:setUnitPPValue("dofFactor", value)
end

function CommandStationMapSceneView:_tweenFinish()
	self._tweenFactorFinish = true
end

function CommandStationMapSceneView:onOpenFinish()
	TaskDispatcher.cancelTask(self._protectedCamera, self)
end

function CommandStationMapSceneView:_onUnitCameraVisibleChange(show)
	if not show and self._blurOriginalParam and self._sceneVisible ~= false then
		gohelper.setActive(CameraMgr.instance:getUnitCameraGO(), true)
	end
end

function CommandStationMapSceneView:_OnCloseView(viewName)
	if ViewMgr.instance:isFull(viewName) and ViewHelper.instance:checkViewOnTheTop(self.viewName) then
		self._sceneVisible = true

		self:_doScreenResize()
	end
end

function CommandStationMapSceneView:_onBeforeOpenView(viewName)
	if viewName == ViewName.StoreView then
		return
	end

	if ViewMgr.instance:isFull(viewName) and viewName ~= self.viewName then
		self.viewContainer:setVisibleInternal(false)

		local dispatchEventMainView = ViewMgr.instance:getContainer(ViewName.CommandStationDispatchEventMainView)

		if dispatchEventMainView then
			dispatchEventMainView:setVisibleInternal(false)
		end
	end
end

function CommandStationMapSceneView:_onReOpenWhileOpen(viewName)
	if self.viewName == viewName then
		ViewMgr.instance:closeView(ViewName.CommandStationDispatchEventMainView)

		return
	end

	if ViewMgr.instance:isFull(viewName) and viewName ~= self.viewName then
		self.viewContainer:setVisibleInternal(false)
	end
end

function CommandStationMapSceneView:_onSceneFocusPos(pos, inBoundary)
	pos.x = -pos.x
	pos.y = -pos.y - 0.5
	pos.z = 0

	self:setScenePosSafety(pos, true, not inBoundary)
end

function CommandStationMapSceneView:_onSelectTimePoint(timeId)
	self:_showTimeId(timeId)
end

function CommandStationMapSceneView:_showTimeId(timeId)
	if not timeId then
		return
	end

	if self._timeId == timeId then
		return
	end

	self._timeId = timeId

	CommandStationMapModel.instance:setTimeId(timeId)

	local sceneConfig = CommandStationMapModel.instance:getCurTimeIdScene()

	if not sceneConfig then
		return
	end

	self._sceneConfig = sceneConfig

	local scenePath = sceneConfig.scene

	self:_changeMap(scenePath)
end

function CommandStationMapSceneView:_onScreenResize()
	if self._sceneGo then
		self:_initScene()
	end
end

function CommandStationMapSceneView:_disposeOldMap()
	if self._oldSceneGo then
		gohelper.destroy(self._oldSceneGo)

		self._oldSceneGo = nil
	end

	if self._oldMapLoader then
		self._oldMapLoader:dispose()

		self._oldMapLoader = nil
	end
end

function CommandStationMapSceneView:onClose()
	self.removeEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenResize, self)
	self._drag:RemoveDragBeginListener()
	self._drag:RemoveDragListener()
	self._drag:RemoveDragEndListener()
	CommandStationMapModel.instance:clearSceneInfo()
	TaskDispatcher.cancelTask(self._protectedCamera, self)

	if self._tweenFactor then
		ZProj.TweenHelper.KillById(self._tweenFactor)

		self._tweenFactor = nil
	end

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

function CommandStationMapSceneView:onCloseFinish()
	return
end

function CommandStationMapSceneView:onDestroyView()
	gohelper.destroy(self._sceneRoot)

	if self._mapLoader then
		self._mapLoader:dispose()
	end

	self:_disposeOldMap()
end

return CommandStationMapSceneView
