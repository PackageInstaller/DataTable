-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/view/story/StoryViewVideo.lua

module("logic.extensions.story.view.story.StoryViewVideo", package.seeall)

local StoryViewVideo = class("StoryViewVideo", StoryViewComponent)

function StoryViewVideo:_buildUI()
	StoryViewVideo.super._buildUI(self)

	self._jumpBtn = Framework.ButtonAdapter.GetFrom(self.mainGO, "PassNode")

	self._jumpBtn.gameObject:SetActive(Framework.OSDef.isEditor)
	self.mainGO:SetActive(false)
end

function StoryViewVideo:onEnter()
	StoryViewVideo.super.onEnter(self)
	self.mainGO:SetActive(false)
	self._jumpBtn:AddClickListener(self._onClickJumpButton, self)
end

function StoryViewVideo:prepareStory(currStory, finishCallback, finishCallbackTarget)
	self._isPlayingStarted = nil
	self._currStory = currStory
	self._prepareCallback = finishCallback
	self._prepareCallbackTarget = finishCallbackTarget

	self._jumpBtn.gameObject:SetActive(Framework.OSDef.isEditor or not self._currStory.unpassable)

	if AudioPlayerEx.isInitialized then
		AudioVoicePlayer.instance:stopVoice(true, true)

		self._musicVolume = AudioPlayerEx.instance:getMusicVolume()

		AudioPlayerEx.instance:setMusicVolume(0)
	end

	VideoFacade.instance:play(self._currStory.animName, false, nil, self._onMoviePlayStart, self._onMoviePlayFinish, self)
end

function StoryViewVideo:startStory(currStory)
	self._isStoped = nil

	SceneFacade.instance:showAllElements(false)

	self._currStory = currStory
end

function StoryViewVideo:endStory()
	self:_resumeBgMusicVolume()
	SceneFacade.instance:showAllElements(true)
end

function StoryViewVideo:onExit()
	StoryViewVideo.super.onExit(self)
	self._jumpBtn:RemoveClickListener()

	self._currStory = nil
	self._isPlayingStarted = nil

	self:_resumeBgMusicVolume()
	VideoFacade.instance:stop()
end

function StoryViewVideo:_onClickJumpButton()
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

	if self._isPlayingStarted and not self._isStoped and not self._isFadingIn and not self._isFadingOut then
		TipsFacade.instance:openPopupWindow(lang("tip"), "确定跳过此段动画吗？", function()
			self._isStoped = true

			VideoFacade.instance:stop()
		end, function()
			return
		end, "确定", "取消")
	end
end

function StoryViewVideo:_onMoviePlayStart()
	self._isPlayingStarted = true

	if self._prepareCallback then
		if self._prepareCallbackTarget then
			self._prepareCallback(self._prepareCallbackTarget)
		else
			self._prepareCallback()
		end
	end
end

function StoryViewVideo:_onMoviePlayFinish()
	self:_resumeBgMusicVolume()

	if self._currStory then
		self._isStoped = true

		self:finishStory()
	end
end

function StoryViewVideo:_resumeBgMusicVolume()
	if self._musicVolume then
		if self._musicVolume ~= 0 then
			AudioPlayerEx.instance:setMusicVolume(self._musicVolume)
		end

		self._musicVolume = nil
	end
end

return StoryViewVideo
