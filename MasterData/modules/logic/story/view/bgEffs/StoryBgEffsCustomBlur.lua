-- chunkname: @modules/logic/story/view/bgEffs/StoryBgEffsCustomBlur.lua

module("modules.logic.story.view.bgEffs.StoryBgEffsCustomBlur", package.seeall)

local StoryBgEffsCustomBlur = class("StoryBgEffsCustomBlur", StoryBgEffsBase)

function StoryBgEffsCustomBlur:ctor()
	StoryBgEffsCustomBlur.super.ctor(self)
end

function StoryBgEffsCustomBlur:init(bgCo)
	StoryBgEffsCustomBlur.super.init(self, bgCo)

	self._blurAnimPath = "ui/animations/dynamic/ui_blurtype.controller"

	table.insert(self._resList, self._blurAnimPath)

	self._blurTypeCo = StoryBlurTypeModel.instance:getStoryBlurByType(bgCo.effDegree)
	self._startAnimName = self._blurTypeCo.startname
	self._effLoaded = false
	self._angle = 0
end

function StoryBgEffsCustomBlur:setAngle(angle)
	self._angle = angle
end

function StoryBgEffsCustomBlur:start(callback, callbackObj)
	StoryBgEffsCustomBlur.super.start(self)

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

function StoryBgEffsCustomBlur:_btnskipOnClick()
	self._captureAnim:Play("idle", 0, 0)

	self._captureAnim.enabled = false

	PostProcessingMgr.instance:setBlurWeight(1)
end

function StoryBgEffsCustomBlur:_onOpenView(viewName)
	local isSetTopView = StoryModel.instance:isSetTopView(viewName)

	if isSetTopView then
		self:_setViewTop(false)
	end
end

function StoryBgEffsCustomBlur:_onCloseView(viewName)
	local isSetTopView = StoryModel.instance:isSetTopView(viewName)

	if isSetTopView then
		if self._capture then
			self._capture.enabled = true
		end

		if self._captureAnim then
			PostProcessingMgr.instance:setBlurWeight(0)

			self._captureAnim.enabled = true

			self._captureAnim:SetBool("isEnd", false)
			self._captureAnim:Play(self._startAnimName, 0, 0)
		end

		self:_setViewTop(true)
	end
end

function StoryBgEffsCustomBlur:_setViewTop(set)
	if set then
		StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UITop)
		StoryViewMgr.instance:setStoryLeadRoleSpineViewLayer(UnityLayer.UITop)
	else
		StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UISecond)
		StoryViewMgr.instance:setStoryLeadRoleSpineViewLayer(UnityLayer.UIThird)
	end
end

function StoryBgEffsCustomBlur:onLoadFinished()
	StoryBgEffsCustomBlur.super.onLoadFinished(self)

	self._effLoaded = true

	StoryTool.enablePostProcess(true)

	local animAssetItem = self._loader:getAssetItem(self._blurAnimPath)
	local blurAnim = animAssetItem:GetResource(self._blurAnimPath)

	if not self._captureGo or not self._captureGo.activeSelf then
		return
	end

	self._captureAnim = gohelper.onceAddComponent(self._captureGo, typeof(UnityEngine.Animator))
	self._captureAnim.runtimeAnimatorController = blurAnim
	self._captureAnim.enabled = true

	self._captureAnim:SetBool("isEnd", false)

	local transtime = self._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()]

	self._captureAnim.speed = transtime < 0.1 and 1 or self._blurTypeCo.animLength / transtime

	if self._capture and self._blurTypeCo.isRadial then
		self._capture.blurAngle = self._angle
	end

	self._captureAnim:Play(self._startAnimName, 0, 0)
	StoryController.instance:dispatchEvent(StoryEvent.PlayFullBlurIn, 3, 0)
end

function StoryBgEffsCustomBlur:reset(bgCo)
	StoryBgEffsCustomBlur.super.reset(self, bgCo)
	self:_setViewTop(true)
	StoryTool.enablePostProcess(true)

	self._capture.enabled = true

	if not self._effLoaded then
		return
	end

	if bgCo.effDegree > 0 then
		self._captureAnim.enabled = true

		self._captureAnim:SetBool("isEnd", false)

		local transtime = self._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()]

		self._captureAnim.speed = transtime < 0.1 and 1 or self._blurTypeCo.animLength / transtime

		if self._capture and self._blurTypeCo.isRadial then
			self._capture.blurAngle = self._angle
		end

		self._captureAnim:Play(self._startAnimName, 0, 0)

		return
	end

	if self._captureAnim then
		UIBlockMgr.instance:startBlock("outFocusEnding")
		TaskDispatcher.runDelay(self._onEffFinished, self, 1)
		self._captureAnim:SetBool("isEnd", true)
	end
end

function StoryBgEffsCustomBlur:_onEffFinished()
	UIBlockMgr.instance:endBlock("outFocusEnding")

	if self._finishedCallback then
		self._finishedCallback(self._finishedCallbackObj)

		self._finishedCallback = nil
		self._finishedCallbackObj = nil
	end
end

function StoryBgEffsCustomBlur:destroy()
	StoryBgEffsCustomBlur.super.destroy(self)
	UIBlockMgr.instance:endBlock("outFocusEnding")

	if self._captureAnim then
		self._captureAnim.speed = 1
		self._capture.enabled = false

		local player = SLFramework.AnimatorPlayer.Get(self._captureGo)

		if player then
			gohelper.removeComponent(self._captureGo, typeof(SLFramework.AnimatorPlayer))
		end

		gohelper.removeComponent(self._captureGo, typeof(UnityEngine.Animator))
	end

	if self._capture then
		self._capture.blurAngle = 0
		self._capture.blurIndex = 0
		self._capture.isUpDownSample = true
		self._capture.reduteRate = 4
		self._capture.desamplingRate = 8
		self._capture.blurFactor = 0
		self._capture.blurWeight = 0
		self._capture.blurIterations = 3
	end

	self:_setViewTop(false)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, self._onOpenView, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseView, self)
	StoryController.instance:unregisterCallback(StoryEvent.OnBtnSkipClick, self._btnskipOnClick, self)
	StoryController.instance:dispatchEvent(StoryEvent.PlayFullBlurOut, 0)

	self._finishedCallback = nil
	self._finishedCallbackObj = nil
end

return StoryBgEffsCustomBlur
