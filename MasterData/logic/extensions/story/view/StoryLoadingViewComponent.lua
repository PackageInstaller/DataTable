-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/view/StoryLoadingViewComponent.lua

module("logic.extensions.story.view.StoryLoadingViewComponent", package.seeall)

local M = class("StoryLoadingViewComponent", ViewComponent)

function M:buildUI()
	self._loadingBg = self:getImage("plotloadingview_1082656517")
	self._maskGo = self:getGo("storyloadingview_-281682224")

	goutil.setActive(self._maskGo, false)
	self:_closeAllView()
end

function M:onEnter()
	StoryDispatcher:addEventListener(StoryNotifyName.DoStoryFadeTween, self._onStartBlackTween, self)
end

function M:onExit()
	StoryDispatcher:removeEventListener(StoryNotifyName.DoStoryFadeTween, self._onStartBlackTween, self)
	removetimer(self._onFadeLoadingFinish, self)

	if self._blackTween then
		TweenUtil.killTween(self._blackTween)

		self._blackTween = nil
	end

	removetimer(self._blackTweenShowing, self)

	self._fadeInCallback = false
	self._fadeInCallbackHandle = false
	self._fadeOutCallBack = false
	self._fadeOutCallBackHandle = false

	goutil.setActive(self._maskGo, false)
end

function M:destroyUI()
	self._directors = nil
	self._openTimelineListener = nil
	self._closeTimelineListener = nil
end

function M:_onFadeLoadingFinish()
	self:_closeAllView()
end

function M:_closeAllView()
	removetimer(self._onFadeLoadingFinish, self)

	self._loadingBg.color = Color.New(0, 0, 0, 0)
end

function M:_onStartBlackTween(_, param)
	local fadeColors = param.fadeColor or Color.New(0, 0, 0, 1)
	local fadeType = param.fadeType
	local fadeInTime = param.fadeInTime or 1
	local fadeOutTime = param.fadeOutTime or 1

	self._fadeInCallback = param.fadeInCallBack or false
	self._fadeInCallbackHandle = param.fadeInCallBackHandle or false
	self._fadeOutCallBack = param.fadeOutCallBack or false
	self._fadeOutCallBackHandle = param.fadeOutCallBackHandle or false

	print("剧情 Fade Animation with FadeType Color", fadeType, fadeColors)

	if self._loadingBg then
		self._loadingBg:DOKill(false)
	end

	if self._loadingViewSequence then
		self._loadingViewSequence:Kill()
	end

	if fadeType == StoryConstDef.EFadeType.StartStory then
		self._loadingBg:DOFade(0, fadeOutTime):SetDelay(0.3):OnComplete(self._onShowFadeOutFinish, self):SetAutoKill(true)
	elseif fadeType == StoryConstDef.EFadeType.WaitStory then
		self._loadingBg.color = Color.New(fadeColors.r, fadeColors.g, fadeColors.b, 1)

		settimer(fadeInTime, self._onFadeLoadingFinish, self, false)
	elseif fadeType == StoryConstDef.EFadeType.EndStory then
		self._loadingBg.color = Color.New(fadeColors.r, fadeColors.g, fadeColors.b, 0)
		self._loadingViewSequence = DG.Tweening.DOTween.Sequence()

		self._loadingViewSequence:Insert(0, self._loadingBg:DOFade(1, fadeInTime))
		self._loadingViewSequence:InsertCallback(fadeInTime, self._onShowFadeInFinish, self)
		self._loadingViewSequence:AppendInterval(0.3)
		self._loadingViewSequence:Append(self._loadingBg:DOFade(0, fadeOutTime))
		self._loadingViewSequence:AppendCallback(self._onShowFadeOutFinish, self)
		self._loadingViewSequence:SetAutoKill(true)
		self._loadingViewSequence:SetTarget(self._loadingBg.gameObject)
	elseif fadeType == StoryConstDef.EFadeType.StartNode then
		self._loadingBg.color = Color.New(fadeColors.r, fadeColors.g, fadeColors.b, 0)
		self._loadingViewSequence = DG.Tweening.DOTween.Sequence()

		self._loadingViewSequence:Insert(0, self._loadingBg:DOFade(1, fadeInTime))
		self._loadingViewSequence:InsertCallback(fadeInTime, self._onShowFadeInFinish, self)
		self._loadingViewSequence:AppendInterval(0.5)
		self._loadingViewSequence:AppendCallback(self._onShowFadeOutFinish, self)
		self._loadingViewSequence:Append(self._loadingBg:DOFade(0, fadeOutTime))
		self._loadingViewSequence:SetAutoKill(true)
		self._loadingViewSequence:SetTarget(self._loadingBg.gameObject)
	elseif fadeType == StoryConstDef.EFadeType.Start2dBg then
		self._loadingBg.color = Color.New(0, 0, 0, 0)
		self._loadingViewSequence = DG.Tweening.DOTween.Sequence()

		self._loadingViewSequence:Insert(0, self._loadingBg:DOFade(1, fadeInTime))
		self._loadingViewSequence:AppendCallback(self._onShowFadeInFinish, self)
		self._loadingViewSequence:AppendInterval(0.5)
		self._loadingViewSequence:Append(self._loadingBg:DOFade(0, fadeOutTime))
		self._loadingViewSequence:AppendCallback(self._onShowFadeOutFinish, self)
		self._loadingViewSequence:SetAutoKill(true)
		self._loadingViewSequence:SetTarget(self._loadingBg.gameObject)
	elseif fadeType == StoryConstDef.EFadeType.Jump2FadeIn then
		goutil.setActive(self._maskGo, true)
		self._loadingBg:DOFade(1, fadeInTime):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true):OnComplete(self._onShowFadeInFinish, self)
	elseif fadeType == StoryConstDef.EFadeType.Jump2FadeOut then
		self._loadingBg:DOFade(0, fadeOutTime):SetDelay(1):OnComplete(self._onJumpAnimFinish, self):SetAutoKill(true)
	end
end

function M:_onJumpAnimFinish()
	goutil.setActive(self._maskGo, false)
	StoryModel.instance:setJumpAnimState(false)
	self:_onShowFadeOutFinish()
end

function M:_onShowFadeInFinish()
	if self._fadeInCallback then
		self._fadeInCallback(self._fadeInCallbackHandle)
	end

	self._fadeInCallback = false
	self._fadeInCallbackHandle = false
end

function M:_onShowFadeOutFinish()
	if self._fadeOutCallBack then
		self._fadeOutCallBack(self._fadeOutCallBackHandle)
	end

	self._fadeOutCallBack = false
	self._fadeOutCallBackHandle = false
end

return M
