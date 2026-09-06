-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/view/story/StoryViewComponent.lua

module("logic.extensions.story.view.story.StoryViewComponent", package.seeall)

local StoryViewComponent = class("StoryViewComponent")

function StoryViewComponent:ctor(view, mainGO)
	self._view = view
	self.mainGO = mainGO

	self:_buildUI()
end

function StoryViewComponent:_buildUI()
	self._tweenIn = self.mainGO:GetComponent(UnityTweensType.UITweenFadeIn)
	self._tweenOut = self.mainGO:GetComponent(UnityTweensType.UITweenFadeOut)
	self._canvasGroup = self.mainGO:GetComponent("CanvasGroup")

	if self._tweenIn then
		self._tweenIn.time = StoryConst.FadeIn_Time
	end

	if self._tweenOut then
		self._tweenOut.time = StoryConst.FadeOut_Time
	end
end

function StoryViewComponent:onEnter()
	self.mainGO:SetActive(false)

	self._isFadingIn = nil
	self._isFadingOut = nil

	if self._tweenIn then
		self._tweenIn:AddListener(self._onTweenInFinish, self)
	end

	if self._tweenIn then
		self._tweenOut:AddListener(self._onTweenOutFinish, self)
	end

	if Framework.OSDef.isEditor then
		settimer(0, self._tickClickSpace, self)
	end
end

function StoryViewComponent:onExit()
	if Framework.OSDef.isEditor then
		removetimer(self._tickClickSpace, self)
	end

	self._loadedCallback = nil
	self._loadedCallbackTarget = nil
	self._isFadingIn = nil
	self._isFadingOut = nil

	if self._tweenIn then
		self._tweenIn:Stop()
		self._tweenIn:RemoveListener()
	end

	if self._tweenOut then
		self._tweenOut:Stop()
		self._tweenOut:RemoveListener()
	end
end

function StoryViewComponent:prepareStory(currStory, finishCallback, finishCallbackTarget)
	if finishCallback then
		if finishCallbackTarget then
			finishCallback(finishCallbackTarget)
		else
			finishCallback()
		end
	end
end

function StoryViewComponent:clearStory()
	return
end

function StoryViewComponent:startStory(currStory)
	return
end

function StoryViewComponent:startFadeIn()
	if self._tweenOut then
		self._tweenOut:Stop()
	end

	self._isFadingIn = nil
	self._isFadingOut = nil

	self.mainGO:SetActive(true)

	if self._canvasGroup then
		self._canvasGroup.alpha = 0
	end

	if self._tweenIn then
		self._isFadingIn = true

		self._tweenIn:Stop()
		self._tweenIn:Begin()
	end
end

function StoryViewComponent:startFadeOut(handler, tgt)
	if self._tweenIn then
		self._tweenIn:Stop()
	end

	self._isFadingIn = nil
	self._isFadingOut = nil

	if self._tweenOut then
		self._tweenOut:Stop()

		handler = handler or self._onTweenOutFinish
		tgt = tgt or self
		self._isFadingOut = true

		self._tweenOut:AddListener(handler, tgt)
		self._tweenOut:Begin()
	elseif handler then
		if tgt then
			self:_onTweenOutFinish()
		else
			handler()
		end
	end
end

function StoryViewComponent:beginFadeOut(handler, tgt)
	self:startFadeOut(handler, tgt)
end

function StoryViewComponent:endStory()
	return
end

function StoryViewComponent:isLoadingRes()
	return
end

function StoryViewComponent:finishStory(op, opParams)
	self._view:finishCurrStory(op, opParams)
end

function StoryViewComponent:setTransitionScene(isTransitionScene)
	self._isTransitionScene = isTransitionScene
end

function StoryViewComponent:setOpeningNpcIntrod(isOpeningNpcIntrod)
	self._isOpeningNpcIntrod = isOpeningNpcIntrod
end

function StoryViewComponent:onSceneLoadedStart()
	return
end

function StoryViewComponent:onSceneLoadedFinish()
	return
end

function StoryViewComponent:_onTweenInFinish()
	self._isFadingOut = nil
	self._isFadingIn = nil
end

function StoryViewComponent:_onTweenOutFinish()
	self._isFadingOut = nil
	self._isFadingIn = nil

	self.mainGO:SetActive(false)
end

function StoryViewComponent:_tickClickSpace()
	if self.mainGO.activeSelf and UGUIToolHelper.IsSpaceDown() then
		self:_onClickSpace()
	end
end

function StoryViewComponent:_onClickSpace()
	return
end

function StoryViewComponent:isUIInteractiveTargetStory()
	return TaskController.instance:isUIInteractiveTargetStory(self._currStory.id, self._currStory.storyIndex)
end

return StoryViewComponent
