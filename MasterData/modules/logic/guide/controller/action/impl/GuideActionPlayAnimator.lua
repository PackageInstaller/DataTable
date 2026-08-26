-- chunkname: @modules/logic/guide/controller/action/impl/GuideActionPlayAnimator.lua

module("modules.logic.guide.controller.action.impl.GuideActionPlayAnimator", package.seeall)

local GuideActionPlayAnimator = class("GuideActionPlayAnimator", BaseGuideAction)

function GuideActionPlayAnimator:onStart(context)
	GuideActionPlayAnimator.super.onStart(self, context)

	local temp = string.split(self.actionParam, "#")

	self._animRoot = temp[1]
	self._controllerPath = temp[2]
	self._endAnim = temp[3]
	self._endAnimTime = tonumber(temp[4])

	local loader = MultiAbLoader.New()

	self._loader = loader

	loader:addPath(self._controllerPath)
	loader:startLoad(self._loadedFinish, self)
	self:onDone(true)
end

function GuideActionPlayAnimator:_loadedFinish(multiAbLoader)
	local rootGo = gohelper.find(self._animRoot)
	local animatorInst = self._loader:getFirstAssetItem():GetResource()
	local animatorComp = gohelper.onceAddComponent(rootGo, typeof(UnityEngine.Animator))

	if not animatorComp then
		return
	end

	animatorComp.enabled = true
	animatorComp.runtimeAnimatorController = animatorInst
	self._animator = animatorComp
end

function GuideActionPlayAnimator:_stopAnimator()
	if self._animator then
		self._animator.runtimeAnimatorController = nil
		self._animator.enabled = false
	end
end

function GuideActionPlayAnimator:_clearAnimator()
	if self._animator and self._endAnimTime then
		TaskDispatcher.runDelay(self._stopAnimator, self, self._endAnimTime)
	end
end

function GuideActionPlayAnimator:onDestroy()
	GuideActionPlayAnimator.super.onDestroy(self)

	if self._animator and self._endAnim then
		self._animator:Play(self._endAnim)
	end

	self:_clearAnimator()

	if self._loader then
		self._loader:dispose()
	end
end

return GuideActionPlayAnimator
