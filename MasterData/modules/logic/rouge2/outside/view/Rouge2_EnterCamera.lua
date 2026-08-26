-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_EnterCamera.lua

module("modules.logic.rouge2.outside.view.Rouge2_EnterCamera", package.seeall)

local Rouge2_EnterCamera = class("Rouge2_EnterCamera", BaseView)

function Rouge2_EnterCamera:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_EnterCamera:_editableInitView()
	return
end

function Rouge2_EnterCamera:onOpen()
	local cameraRoot = CameraMgr.instance:getCameraTraceGO()
	local cameraAnimator = gohelper.onceAddComponent(cameraRoot, typeof(UnityEngine.Animator))
	local path = self.viewContainer._viewSetting.otherRes[6]

	cameraAnimator.runtimeAnimatorController = self.viewContainer:getRes(path)

	cameraAnimator:Rebind()
	cameraAnimator:Play("open", 0, 0)

	self._cameraRootAnimator = cameraAnimator
end

function Rouge2_EnterCamera:onClose()
	if self._cameraRootAnimator then
		self._cameraRootAnimator:Rebind()
		self._cameraRootAnimator:Play(UIAnimationName.Close, 0, 0)
		TaskDispatcher.runDelay(Rouge2_EnterCamera.delayRemoveAnimator, self, 0.1)
	end
end

function Rouge2_EnterCamera.delayRemoveAnimator()
	local cameraRoot = CameraMgr.instance:getCameraTraceGO()
	local cameraRootAnimator = gohelper.onceAddComponent(cameraRoot, typeof(UnityEngine.Animator))

	if cameraRootAnimator then
		gohelper.removeComponent(cameraRootAnimator.gameObject, typeof(UnityEngine.Animator))
	end
end

return Rouge2_EnterCamera
