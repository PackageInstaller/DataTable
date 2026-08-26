-- chunkname: @modules/logic/story/view/bgEffs/StoryBgEffsCameraEffect.lua

module("modules.logic.story.view.bgEffs.StoryBgEffsCameraEffect", package.seeall)

local StoryBgEffsCameraEffect = class("StoryBgEffsCameraEffect", StoryBgEffsBase)

function StoryBgEffsCameraEffect:ctor()
	StoryBgEffsCameraEffect.super.ctor(self)
end

function StoryBgEffsCameraEffect:init(bgCo)
	StoryBgEffsCameraEffect.super.init(self, bgCo)

	self._effMo = StoryCameraEffectModel.instance:getStoryCameraEffectByType(bgCo.effDegree)
	self._cameraAnimPath = string.format("ui/animations/dynamic/%s.controller", self._effMo.controllerName)

	table.insert(self._resList, self._cameraAnimPath)
end

function StoryBgEffsCameraEffect:start(callback, callbackObj)
	StoryBgEffsCameraEffect.super.start(self)

	self._finishedCallback = callback
	self._finishedCallbackObj = callbackObj

	self:_setViewTop(true)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self._onOpenView, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseView, self)
	self:loadRes()
end

function StoryBgEffsCameraEffect:onLoadFinished()
	StoryBgEffsCameraEffect.super.onLoadFinished(self)

	self._effLoaded = true

	StoryTool.enablePostProcess(true)

	local anim = self._loader:getAssetItem(self._cameraAnimPath):GetResource()

	self._cameraAnim = CameraMgr.instance:getCameraRootAnimator()
	self._preAnimEnabled = self._cameraAnim.enabled
	self._preRuntimeAnimatorController = self._cameraAnim.runtimeAnimatorController
	self._cameraAnim.enabled = true
	self._cameraAnim.runtimeAnimatorController = anim

	self._cameraAnim:Play("start", 0, 0)
end

function StoryBgEffsCameraEffect:_onOpenView(viewName)
	local isSetTopView = StoryModel.instance:isSetTopView(viewName)

	if isSetTopView then
		self:_setViewTop(false)
	end
end

function StoryBgEffsCameraEffect:_onCloseView(viewName)
	local isSetTopView = StoryModel.instance:isSetTopView(viewName)

	if isSetTopView then
		self:_setViewTop(true)
	end
end

function StoryBgEffsCameraEffect:_setViewTop(set)
	if self._effMo then
		if not self._effMo then
			if set then
				StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UITop)
				StoryViewMgr.instance:setStoryLeadRoleSpineViewLayer(UnityLayer.UITop)
			else
				StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UISecond)
				StoryViewMgr.instance:setStoryLeadRoleSpineViewLayer(UnityLayer.UIThird)
			end
		end

		if self._effMo then
			local isHeroEff = self._effMo.heroEff

			if not isHeroEff then
				if set then
					StoryViewMgr.instance:setStoryHeroViewLayer(UnityLayer.UIThird)
				else
					StoryViewMgr.instance:setStoryHeroViewLayer(UnityLayer.UISecond)
				end
			end
		end
	end
end

function StoryBgEffsCameraEffect:reset(bgCo)
	StoryBgEffsCameraEffect.super.reset(self, bgCo)
	self:_setViewTop(true)

	if bgCo.effDegree > 0 then
		return
	end

	if self._cameraAnim then
		self._cameraAnim:Play("end", 0, 0)
		UIBlockMgr.instance:startBlock("outFocusEnding")

		if self._effMo then
			if not self._effMo.endTime then
				local endTime = 1

				TaskDispatcher.runDelay(self._onEffFinished, self, endTime)
			end
		end
	end
end

function StoryBgEffsCameraEffect:_onEffFinished()
	UIBlockMgr.instance:endBlock("outFocusEnding")

	if self._finishedCallback then
		self._finishedCallback(self._finishedCallbackObj)

		self._finishedCallback = nil
		self._finishedCallbackObj = nil
	end
end

function StoryBgEffsCameraEffect:destroy()
	self:_setViewTop(false)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, self._onOpenView, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseView, self)
	StoryBgEffsCameraEffect.super.destroy(self)

	if self._cameraAnim then
		self._cameraAnim:Play("end", 0, 1)

		self._cameraAnim.runtimeAnimatorController = self._preRuntimeAnimatorController
		self._cameraAnim.enabled = self._preAnimEnabled
	end
end

return StoryBgEffsCameraEffect
