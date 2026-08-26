-- chunkname: @modules/logic/scene/rouge/comp/RougeSceneCameraComp.lua

module("modules.logic.scene.rouge.comp.RougeSceneCameraComp", package.seeall)

local RougeSceneCameraComp = class("RougeSceneCameraComp", BaseSceneComp)

function RougeSceneCameraComp:onInit()
	return
end

function RougeSceneCameraComp:onSceneStart(sceneId, levelId)
	RougeMapController.instance:registerCallback(RougeMapEvent.onLoadMapDone, self.onLoadMapDone, self)
	RougeMapController.instance:registerCallback(RougeMapEvent.onExitPieceChoiceEvent, self.onExitPieceChoiceEvent, self)
	RougeMapController.instance:registerCallback(RougeMapEvent.onMiddleActorBeforeMove, self.onMiddleActorBeforeMove, self)
	RougeMapController.instance:registerCallback(RougeMapEvent.onPathSelectMapFocus, self.onPathSelectMapFocus, self)
	RougeMapController.instance:registerCallback(RougeMapEvent.focusChangeCameraSize, self.focusChangeCameraSize, self)

	self._tranCameraTrace = CameraMgr.instance:getCameraTraceGO().transform

	TaskDispatcher.runRepeat(self._resetCamera, self, 1)
end

function RougeSceneCameraComp:focusChangeCameraSize()
	if self.camera then
		self.camera.orthographicSize = RougeMapModel.instance:getCameraSize()
	end
end

function RougeSceneCameraComp:onLoadMapDone()
	self:initCameraSize()
end

local fixCount = 0
local fixDt

function RougeSceneCameraComp:_resetCamera()
	local posX, posY, posZ = transformhelper.getLocalPos(self._tranCameraTrace)

	if posX ~= 0 or posY ~= 0 or posZ ~= 0 then
		local cameraTrace = CameraMgr.instance:getCameraTrace()
		local isEnableTrace = cameraTrace and cameraTrace.EnableTrace

		if fixDt and os.clock() - fixDt > 10 then
			fixCount = 0
		end

		fixCount = fixCount + 1
		fixDt = os.clock()

		if isEnableTrace then
			cameraTrace.EnableTrace = false
		end

		transformhelper.setLocalPos(self._tranCameraTrace, 0, 0, 0)
	end
end

function RougeSceneCameraComp:initCameraSize()
	gohelper.setActive(CameraMgr.instance:getVirtualCameraGO(), false)
	transformhelper.setLocalPos(CameraMgr.instance:getMainCameraTrs(), 0, 0, 0)
	transformhelper.setLocalRotation(CameraMgr.instance:getMainCameraTrs(), 0, 0, 0)

	local cameraTrace = CameraMgr.instance:getCameraTrace()

	if cameraTrace then
		cameraTrace.EnableTrace = false
	end

	self.camera = CameraMgr.instance:getMainCamera()
	self.camera.orthographic = true
	self.camera.orthographicSize = RougeMapModel.instance:getCameraSize()
end

function RougeSceneCameraComp:clearCamera()
	if self.camera then
		self.camera.orthographicSize = 5
		self.camera.orthographic = false
	end
end

function RougeSceneCameraComp:onSceneClose()
	self:clearCamera()

	self.camera = nil

	RougeMapController.instance:unregisterCallback(RougeMapEvent.onLoadMapDone, self.onLoadMapDone, self)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onExitPieceChoiceEvent, self.onExitPieceChoiceEvent, self)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onMiddleActorBeforeMove, self.onMiddleActorBeforeMove, self)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onPathSelectMapFocus, self.onPathSelectMapFocus, self)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.focusChangeCameraSize, self.focusChangeCameraSize, self)
	TaskDispatcher.cancelTask(self._resetCamera, self)
	self:clearTween()
end

function RougeSceneCameraComp:clearTween()
	if self.movingTweenId then
		ZProj.TweenHelper.KillById(self.movingTweenId)
	end

	self.movingTweenId = nil
end

function RougeSceneCameraComp:onMiddleActorBeforeMove()
	AudioMgr.instance:trigger(AudioEnum.UI.MiddleLayerFocus)
	self:clearTween()

	self.movingTweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, RougeMapEnum.RevertDuration, self.frameCallback, self.onTweenDone, self, nil, RougeMapEnum.CameraTweenLine)
end

function RougeSceneCameraComp:onExitPieceChoiceEvent()
	if not RougeMapModel.instance:isMiddle() then
		return
	end

	self:clearTween()

	self.movingTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, RougeMapEnum.RevertDuration, self.frameCallback, self.onTweenDone, self, nil, RougeMapEnum.CameraTweenLine)
end

function RougeSceneCameraComp:frameCallback(value)
	local initCameraSize = RougeMapModel.instance:getCameraSize()
	local focusCameraSize = RougeMapEnum.MiddleLayerCameraSizeRate * initCameraSize
	local offset = initCameraSize - focusCameraSize
	local cameraSize = focusCameraSize + value * offset

	self.camera.orthographicSize = cameraSize

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onCameraSizeChange, cameraSize)
end

function RougeSceneCameraComp:onPathSelectMapFocus(focusCameraSize)
	self:clearTween()

	self.targetCameraSize = focusCameraSize
	self.movingTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, RougeMapEnum.RevertDuration, self.pathSelectMapFrameCallback, self.onTweenDone, self, nil, RougeMapEnum.CameraTweenLine)
end

function RougeSceneCameraComp:pathSelectMapFrameCallback(value)
	local initCameraSize = RougeMapModel.instance:getCameraSize()
	local offset = self.targetCameraSize - initCameraSize
	local cameraSize = initCameraSize + value * offset

	self.camera.orthographicSize = cameraSize

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onCameraSizeChange, cameraSize)
end

function RougeSceneCameraComp:onTweenDone()
	self.movingTweenId = nil
end

return RougeSceneCameraComp
