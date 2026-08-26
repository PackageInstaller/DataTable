-- chunkname: @modules/logic/main/view/skininteraction/CameraBehavior.lua

module("modules.logic.main.view.skininteraction.CameraBehavior", package.seeall)

local CameraBehavior = class("CameraBehavior", BaseSkinInteractionBehavior)

function CameraBehavior:_onInit()
	local config = lua_skin_body_camera.configDict[self._skinId]

	if not self._effectLoader then
		self._animationControllerName = config.res
		self._effectUrl = string.format("ui/animations/dynamic/%s.controller", self._animationControllerName)
		self._effectLoader = MultiAbLoader.New()

		self._effectLoader:addPath(self._effectUrl)
		self._effectLoader:startLoad(self._loadEffectFinished, self)
	end

	self._bodyCameraName = {}
	self._bodyRevertCameraName = {}

	for i, v in ipairs(config.body) do
		if SLFramework.FrameworkSettings.IsEditor and string.find(v, "b_") ~= 1 then
			logError("CameraBehavior body name must start with b_ name:", v)
		end

		self._bodyCameraName[v] = config.camera[i]
		self._bodyRevertCameraName[v] = config.camera_revert[i]
	end

	if #config.body ~= #config.camera then
		logError("CameraBehavior body and camera count not equal")
	end

	if #config.body ~= #config.camera_revert then
		logError("CameraBehavior body and camera_revert count not equal")
	end
end

function CameraBehavior:_loadEffectFinished()
	return
end

function CameraBehavior:_onBodyChange(prevBodyName, curBodyName)
	TaskDispatcher.cancelTask(self._delayClearCameraAnim, self)

	self._curBodyName = curBodyName
	self._prevBodyName = prevBodyName

	local revertAnimName = self._bodyRevertCameraName[prevBodyName]

	if revertAnimName then
		self:_playCameraAnim(revertAnimName)
		TaskDispatcher.runDelay(self._delayClearCameraAnim, self, 0)

		return
	end

	local animName = self._bodyCameraName[self._curBodyName]

	if animName then
		self:_playCameraAnim(animName)
	end
end

function CameraBehavior:_delayClearCameraAnim()
	local animName = self._bodyCameraName[self._curBodyName]

	if animName then
		self:_playCameraAnim(animName)

		return
	end

	self:_clearCameraController()
end

function CameraBehavior:_playCameraAnim(animName)
	if not self._effectLoader or self._effectLoader.isLoading then
		return
	end

	local animator = CameraMgr.instance:getCameraRootAnimator()
	local animatorInst = animator.runtimeAnimatorController

	if animator.enabled and animatorInst and animatorInst.name ~= self._animationControllerName then
		return
	end

	local path = self._effectUrl

	animator.runtimeAnimatorController = self._effectLoader:getAssetItem(path):GetResource()
	animator.enabled = true

	animator:Play(animName, 0, 0)
end

function CameraBehavior:_clearCameraController()
	local animator = CameraMgr.instance:getCameraRootAnimator()
	local animatorInst = animator.runtimeAnimatorController

	if not animatorInst or animatorInst.name ~= self._animationControllerName then
		return
	end

	animator.runtimeAnimatorController = nil
end

function CameraBehavior:_onDestroy()
	if self._effectLoader then
		self._effectLoader:dispose()
	end

	self:_clearCameraController()
	TaskDispatcher.cancelTask(self._delayClearCameraAnim, self)
end

return CameraBehavior
