-- chunkname: @modules/logic/story/view/bgEffs/StoryBgEffsOutFocus.lua

module("modules.logic.story.view.bgEffs.StoryBgEffsOutFocus", package.seeall)

local StoryBgEffsOutFocus = class("StoryBgEffsOutFocus", StoryBgEffsBase)

function StoryBgEffsOutFocus:ctor()
	StoryBgEffsOutFocus.super.ctor(self)
end

function StoryBgEffsOutFocus:init(bgCo)
	StoryBgEffsOutFocus.super.init(self, bgCo)

	self._outFocusAnimPath = "ui/animations/dynamic/ui_gaussianeffect.controller"

	table.insert(self._resList, self._outFocusAnimPath)

	self._effLoaded = false
end

function StoryBgEffsOutFocus:start(callback, callbackObj)
	StoryBgEffsOutFocus.super.start(self)

	self._finishedCallback = callback
	self._finishedCallbackObj = callbackObj

	self:_setViewTop(true)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self._onOpenView, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseView, self)
	StoryController.instance:registerCallback(StoryEvent.OnBtnSkipClick, self._btnskipOnClick, self)

	self._captureGo = PostProcessingMgr.instance:getCaptureView()
	self._capture = self._captureGo:GetComponent(typeof(UrpCustom.UIGaussianEffect))

	self:loadRes()
end

function StoryBgEffsOutFocus:_btnskipOnClick()
	self._captureAnim:Play("idle", 0, 0)

	self._captureAnim.enabled = false

	PostProcessingMgr.instance:setBlurWeight(1)
end

function StoryBgEffsOutFocus:_onOpenView(viewName)
	local isSetTopView = StoryModel.instance:isSetTopView(viewName)

	if isSetTopView then
		self:_setViewTop(false)
	end
end

function StoryBgEffsOutFocus:_onCloseView(viewName)
	local isSetTopView = StoryModel.instance:isSetTopView(viewName)

	if isSetTopView then
		if self._capture then
			self._capture.enabled = true
		end

		if self._captureAnim then
			PostProcessingMgr.instance:setBlurWeight(0)

			self._captureAnim.enabled = true

			self._captureAnim:SetBool("isEnd", false)
			self._captureAnim:Play("loop", 0, 0)
		end

		self:_setViewTop(true)
	end
end

function StoryBgEffsOutFocus:_setViewTop(set)
	if set then
		StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UITop)
		StoryViewMgr.instance:setStoryLeadRoleSpineViewLayer(UnityLayer.UITop)
	else
		StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UISecond)
		StoryViewMgr.instance:setStoryLeadRoleSpineViewLayer(UnityLayer.UIThird)
	end
end

function StoryBgEffsOutFocus:onLoadFinished()
	StoryBgEffsOutFocus.super.onLoadFinished(self)

	self._effLoaded = true

	StoryTool.enablePostProcess(true)

	local animAssetItem = self._loader:getAssetItem(self._outFocusAnimPath)
	local focusAnim = animAssetItem:GetResource(self._outFocusAnimPath)

	if not self._captureGo or not self._captureGo.activeSelf then
		return
	end

	self._captureAnim = gohelper.onceAddComponent(self._captureGo, typeof(UnityEngine.Animator))
	self._captureAnim.runtimeAnimatorController = focusAnim
	self._captureAnim.enabled = true

	self._captureAnim:SetBool("isEnd", false)
	self._captureAnim:Play("loop", 0, 0)
	StoryController.instance:dispatchEvent(StoryEvent.PlayFullBlurIn, 3, 0)
end

function StoryBgEffsOutFocus:reset(bgCo)
	StoryBgEffsOutFocus.super.reset(self, bgCo)
	self:_setViewTop(true)
	StoryTool.enablePostProcess(true)

	self._capture.enabled = true

	if not self._effLoaded then
		return
	end

	if bgCo.effDegree == 0 then
		self._captureAnim.enabled = true

		self._captureAnim:SetBool("isEnd", false)
		self._captureAnim:Play("loop", 0, 0)

		return
	end

	if self._captureAnim then
		UIBlockMgr.instance:startBlock("outFocusEnding")
		TaskDispatcher.runDelay(self._onEffFinished, self, 1)
		self._captureAnim:SetBool("isEnd", true)
	end
end

function StoryBgEffsOutFocus:_onEffFinished()
	UIBlockMgr.instance:endBlock("outFocusEnding")

	if self._finishedCallback then
		self._finishedCallback(self._finishedCallbackObj)

		self._finishedCallback = nil
		self._finishedCallbackObj = nil
	end
end

function StoryBgEffsOutFocus:destroy()
	StoryBgEffsOutFocus.super.destroy(self)
	UIBlockMgr.instance:endBlock("outFocusEnding")

	if self._captureAnim then
		self._capture.enabled = false

		local player = SLFramework.AnimatorPlayer.Get(self._captureGo)

		if player then
			gohelper.removeComponent(self._captureGo, typeof(SLFramework.AnimatorPlayer))
		end

		gohelper.removeComponent(self._captureGo, typeof(UnityEngine.Animator))

		self._captureAnim = false
	end

	self:_setViewTop(false)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, self._onOpenView, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseView, self)
	StoryController.instance:unregisterCallback(StoryEvent.OnBtnSkipClick, self._btnskipOnClick, self)
	StoryController.instance:dispatchEvent(StoryEvent.PlayFullBlurOut, 0)

	self._finishedCallback = nil
	self._finishedCallbackObj = nil
end

return StoryBgEffsOutFocus
