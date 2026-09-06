-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/view/story/StoryViewAnimation.lua

module("logic.extensions.story.view.story.StoryViewAnimation", package.seeall)

local StoryViewAnimation = class("StoryViewAnimation", StoryViewComponent)

function StoryViewAnimation:_buildUI()
	StoryViewAnimation.super._buildUI(self)

	self._jumpBtn = Framework.ButtonAdapter.GetFrom(self.mainGO, "PassNode")

	self._jumpBtn.gameObject:SetActive(Framework.OSDef.isEditor)
	self.mainGO:SetActive(false)
end

function StoryViewAnimation:onEnter()
	StoryViewAnimation.super.onEnter(self)
	self.mainGO:SetActive(false)
	self._jumpBtn:AddClickListener(self._onClickJumpButton, self)
end

function StoryViewAnimation:prepareStory(currStory, finishCallback, finishCallbackTarget)
	self._currStory = currStory
	self._prepareCallback = finishCallback
	self._prepareCallbackTarget = finishCallbackTarget

	local scene = SceneMgr.instance:getCurScene()

	if scene and scene:getSceneType() ~= SceneType.Battle then
		scene:visibleOthersObjects(false)
	end

	SceneFacade.instance:showAllElements(true)
	SceneFacade.instance:visibleMainPlayer(true)

	local animName = currStory.animName

	if not string.find(animName, "txt") then
		animName = animName .. ".txt"
	end

	self._isPlayingStarted = nil
	StoryModel.instance.isPlayingAnimStory = true
	self._animPlayer = AnimationPlayer.play("storyconfig/animations/" .. animName, self._onAnimPlayFinish, self._onAnimPlayStart, self)
end

function StoryViewAnimation:startStory(currStory)
	self._currStory = currStory

	self._jumpBtn.gameObject:SetActive(not self._currStory.unpassable)
end

function StoryViewAnimation:endStory()
	self._animPlayer = nil
end

function StoryViewAnimation:onExit()
	StoryViewAnimation.super.onExit(self)
	self._jumpBtn:RemoveClickListener()

	self._currStory = nil

	self:_onAnimPlayFinish()

	self._isPlayingStarted = nil
end

function StoryViewAnimation:_onClickJumpButton()
	if not self._currStory then
		return
	end

	if self._currStory.unpassable then
		FloatWordMgr.instance:show(lang("ui_story_cantpass"))

		return
	end

	if self._view:isLoadingRes() then
		return
	end

	if self._isPlayingStarted and self._animPlayer and not self._isFadingIn and not self._isFadingOut then
		self._animPlayer:Stop()
		self:_onAnimPlayFinish()
	end
end

function StoryViewAnimation:_onAnimPlayStart()
	self._isPlayingStarted = true

	if self._prepareCallback then
		if self._prepareCallbackTarget then
			self._prepareCallback(self._prepareCallbackTarget)
		else
			self._prepareCallback()
		end
	end
end

function StoryViewAnimation:_onAnimPlayFinish()
	if self._animPlayer then
		local scene = SceneMgr.instance:getCurScene()

		if scene and scene:getSceneType() ~= SceneType.Battle then
			scene:visibleObjects(true)
		end

		SceneFacade.instance:showAllElements(true)

		StoryModel.instance.isPlayingAnimStory = nil

		local animPlayer = self._animPlayer

		self._animPlayer = nil

		animPlayer:Stop()
		self:finishStory()
	end
end

return StoryViewAnimation
