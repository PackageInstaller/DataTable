-- chunkname: @modules/logic/main/view/skininteraction/CameraBehaviorContinue.lua

module("modules.logic.main.view.skininteraction.CameraBehaviorContinue", package.seeall)

local CameraBehaviorContinue = class("CameraBehaviorContinue", CameraBehavior)

function CameraBehaviorContinue:_onBodyChange(prevBodyName, curBodyName)
	TaskDispatcher.cancelTask(self._delayClearCameraAnim, self)

	self._curBodyName = curBodyName
	self._prevBodyName = prevBodyName

	local animName = self._bodyCameraName[self._curBodyName]

	if animName then
		self:_playCameraAnim(animName)

		return
	end

	local revertAnimName = self._bodyRevertCameraName[prevBodyName]

	if revertAnimName then
		self:_playCameraAnim(revertAnimName)
		TaskDispatcher.runDelay(self._delayClearCameraAnim, self, 0)

		return
	end
end

function CameraBehaviorContinue:_playCameraAnim(animName)
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

	animator:Play(animName)
end

return CameraBehaviorContinue
