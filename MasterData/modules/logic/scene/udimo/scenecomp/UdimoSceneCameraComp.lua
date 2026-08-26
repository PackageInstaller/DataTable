-- chunkname: @modules/logic/scene/udimo/scenecomp/UdimoSceneCameraComp.lua

module("modules.logic.scene.udimo.scenecomp.UdimoSceneCameraComp", package.seeall)

local UdimoSceneCameraComp = class("UdimoSceneCameraComp", CommonSceneCameraComp)

function UdimoSceneCameraComp:_calcFovInternal(cameraConfig)
	local fovRatio = 1.7777777777777777 * (UnityEngine.Screen.height / UnityEngine.Screen.width)

	if BootNativeUtil.isWindows() and not SLFramework.FrameworkSettings.IsEditor then
		local w, h = SettingsModel.instance:getCurrentScreenSize()

		fovRatio = 16 * h / 9 / w
	end

	local fov = cameraConfig.fov * fovRatio
	local minFov, maxFov = self:_getMinMaxFov()

	fov = Mathf.Clamp(fov, minFov, maxFov)

	return fov
end

function UdimoSceneCameraComp:_getMinMaxFov()
	return 25, 120
end

function UdimoSceneCameraComp:tweenCameraFocusX(toX, finishCb, finishCbObj)
	self:_killTween()

	self._tweenFinishCallback = finishCb
	self._tweenFinishCallbackObj = finishCbObj

	local focusTrs = CameraMgr.instance:getFocusTrs()

	self._fromX = transformhelper.getPos(focusTrs)

	local scaleFactor = 0
	local baseAspect = 1.7777777777777777
	local maxAspect = 2.4
	local curAspect = UnityEngine.Screen.width / UnityEngine.Screen.height

	if BootNativeUtil.isWindows() and not SLFramework.FrameworkSettings.IsEditor then
		local w, h = SettingsModel.instance:getCurrentScreenSize()

		curAspect = w / h
	end

	scaleFactor = curAspect <= baseAspect and 1 or (maxAspect - curAspect) / (maxAspect - baseAspect)
	scaleFactor = GameUtil.clamp(scaleFactor, 0, 1)

	local useBg = UdimoItemModel.instance:getUseBg()
	local minX, maxX = UdimoConfig.instance:getCameraMoveRange(useBg)
	local minFocusX = minX * scaleFactor
	local maxFocusX = maxX * scaleFactor

	self._toX = GameUtil.clamp(toX or 0, minFocusX, maxFocusX)
	self._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, UdimoEnum.Const.CamTraceDecorationTime, self._onTweenCamera, self._onTweenCameraFinish, self)
end

function UdimoSceneCameraComp:_onTweenCamera(value)
	local x = self._fromX + (self._toX - self._fromX) * value

	self:setFocusX(x)
	self:applyDirectly()
	UdimoController.instance:dispatchEvent(UdimoEvent.OnUdimoCameraTweening)
end

function UdimoSceneCameraComp:_onTweenCameraFinish()
	self._tweenId = nil

	if self._tweenFinishCallback then
		self._tweenFinishCallback(self._tweenFinishCallbackObj)
	end

	self._tweenFinishCallback = nil
	self._tweenFinishCallbackObj = nil
end

function UdimoSceneCameraComp:_killTween()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)
	end

	self._tweenId = nil
end

function UdimoSceneCameraComp:onSceneClose()
	self:_killTween()
	UdimoSceneCameraComp.super.onSceneClose(self)
end

return UdimoSceneCameraComp
