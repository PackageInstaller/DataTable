-- chunkname: @modules/logic/main/view/MainViewCamera.lua

module("modules.logic.main.view.MainViewCamera", package.seeall)

local MainViewCamera = class("MainViewCamera", BaseView)
local FocusBgmDeviceAniName = "bgm_open"
local ResetFocusBgmDeviceAniName = "bgm_close"

function MainViewCamera:addEvents()
	self.addEventCb(self, MainController.instance, MainEvent.FocusBGMDevice, self._cameraFocusBGMDevice, self)
	self.addEventCb(self, MainController.instance, MainEvent.FocusBGMDeviceReset, self._resetcameraFocusBGMDevice, self)
end

function MainViewCamera:removeEvents()
	self.removeEventCb(self, MainController.instance, MainEvent.FocusBGMDevice, self._cameraFocusBGMDevice, self)
	self.removeEventCb(self, MainController.instance, MainEvent.FocusBGMDeviceReset, self._resetcameraFocusBGMDevice, self)
end

function MainViewCamera:onOpen()
	self:_initCamera()
end

function MainViewCamera:onClose()
	return
end

function MainViewCamera:_initCamera()
	if self._cameraPlayer then
		return
	end

	local cameraGo = CameraMgr.instance:getCameraRootGO()

	self._cameraRootTrans = cameraGo.transform
	self._cameraAnimator = CameraMgr.instance:getCameraRootAnimator()
	self._cameraPlayer = CameraMgr.instance:getCameraRootAnimatorPlayer()
end

function MainViewCamera:_setCameraBGMDeviceAnimator(animatorPathIdx)
	local animatorPath = self.viewContainer:getSetting().otherRes[animatorPathIdx or 2]

	self._cameraAnimator.runtimeAnimatorController = self.viewContainer._abLoader:getAssetItem(animatorPath):GetResource()
end

function MainViewCamera:_playCameraAnimation(aniName)
	self:_startForceUpdateCameraPos()
	self._cameraPlayer:Play(aniName, self._onCameraAnimDone, self)
end

function MainViewCamera:_cameraFocusBGMDevice()
	self:_setCameraBGMDeviceAnimator(2)
	self:_playCameraAnimation(FocusBgmDeviceAniName)

	local golightspine = gohelper.findChild(self.viewGO, "#go_spine_scale/lightspine/#go_lightspine")

	gohelper.setActive(golightspine, false)
end

function MainViewCamera:_resetcameraFocusBGMDevice()
	self:_setCameraBGMDeviceAnimator(2)
	self:_playCameraAnimation(ResetFocusBgmDeviceAniName)

	local golightspine = gohelper.findChild(self.viewGO, "#go_spine_scale/lightspine/#go_lightspine")

	gohelper.setActive(golightspine, true)
end

function MainViewCamera:_onCameraAnimDone()
	self:_removeForceUpdateCameraPos()

	CameraMgr.instance:getCameraTrace().EnableTrace = true
	CameraMgr.instance:getCameraTrace().EnableTrace = false
end

function MainViewCamera:_startForceUpdateCameraPos()
	self:_removeForceUpdateCameraPos()
	LateUpdateBeat:Add(self._forceUpdateCameraPos, self)
end

function MainViewCamera:_removeForceUpdateCameraPos()
	LateUpdateBeat:Remove(self._forceUpdateCameraPos, self)
end

function MainViewCamera:_forceUpdateCameraPos()
	local trace = CameraMgr.instance:getCameraTrace()

	trace.EnableTrace = true
	trace.EnableTrace = false
	trace.enabled = false
end

return MainViewCamera
