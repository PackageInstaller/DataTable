-- chunkname: @modules/logic/scene/main/comp/MainSceneCameraComp.lua

module("modules.logic.scene.main.comp.MainSceneCameraComp", package.seeall)

local MainSceneCameraComp = class("MainSceneCameraComp", CommonSceneCameraComp)

function MainSceneCameraComp:_calcFovInternal(cameraConfig)
	local fovRatio = 1.7777777777777777 * (UnityEngine.Screen.height / UnityEngine.Screen.width)

	if BootNativeUtil.isWindows() and not SLFramework.FrameworkSettings.IsEditor then
		local w, h = SettingsModel.instance:getCurrentScreenSize()

		fovRatio = 16 * h / 9 / w
	end

	local fov = cameraConfig.fov * fovRatio

	if fovRatio > 1 then
		fov = fov * 0.85
	end

	local minFov, maxFov = self:_getMinMaxFov()

	fov = Mathf.Clamp(fov, minFov, maxFov)

	return fov
end

function MainSceneCameraComp:_getMinMaxFov()
	return 35, 100
end

function MainSceneCameraComp:onSceneClose()
	MainSceneCameraComp.super.onSceneClose(self)

	local animator = CameraMgr.instance:getCameraRootAnimator()

	animator.runtimeAnimatorController = nil

	local rootGO = CameraMgr.instance:getCameraRootGO()

	transformhelper.setPos(rootGO.transform, 0, 0, 0)

	local mainGO = CameraMgr.instance:getCameraTraceGO()

	transformhelper.setPos(mainGO.transform, 0, 0, 0)

	local trace = CameraMgr.instance:getCameraTrace()

	trace.enabled = true
end

return MainSceneCameraComp
