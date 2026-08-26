-- chunkname: @modules/logic/scene/explore/comp/ExploreSceneCameraComp.lua

module("modules.logic.scene.explore.comp.ExploreSceneCameraComp", package.seeall)

local ExploreSceneCameraComp = class("ExploreSceneCameraComp", CommonSceneCameraComp)

function ExploreSceneCameraComp:onInit()
	self._scene = self:getCurScene()
	self._rawcameraTrace = CameraMgr.instance:getCameraTrace()
	self._cameraTrace = self._rawcameraTrace
	self._cameraCO = nil
end

function ExploreSceneCameraComp:_onScreenResize()
	local focusTrs = CameraMgr.instance:getFocusTrs()
	local x, y, z = transformhelper.getPos(focusTrs)

	self._cameraTrace:SetTargetFocusPos(x, y, z)

	if self._nowFov then
		self:setFov(self._nowFov)
		self._cameraTrace:ApplyDirectly()
	end
end

function ExploreSceneCameraComp:onSceneStart(...)
	self._rawcameraTrace.enabled = false
	self._cameraTrace = gohelper.onceAddComponent(self._rawcameraTrace, typeof(ZProj.ExploreCameraTrace))

	self._cameraTrace:SetEaseTime(ExploreConstValue.CameraTraceTime)
	ExploreSceneCameraComp.super.onSceneStart(self, ...)
end

function ExploreSceneCameraComp:setFocus(x, y, z)
	local focusTrs = CameraMgr.instance:getFocusTrs()

	transformhelper.setPos(focusTrs, x, y, z)
	self._cameraTrace:SetTargetFocusPos(x, y, z)
end

function ExploreSceneCameraComp:setFov(fov)
	local fovRatio = 1.7777777777777777 * (UnityEngine.Screen.height / UnityEngine.Screen.width)

	fovRatio = math.max(fovRatio, 1)
	self._nowFov = fov

	self._cameraTrace:SetTargetFov(fov * fovRatio)
end

function ExploreSceneCameraComp:onSceneClose(...)
	self._rawcameraTrace.enabled = true

	gohelper.destroy(self._cameraTrace)

	self._cameraTrace = self._rawcameraTrace

	ExploreSceneCameraComp.super.onSceneClose(self, ...)
end

return ExploreSceneCameraComp
