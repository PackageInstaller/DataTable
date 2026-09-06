-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/view/StoryBgmMgr.lua

module("logic.extensions.story.view.StoryBgmMgr", package.seeall)

local StoryBgmMgr = class("StoryBgmMgr")

function StoryBgmMgr:ctor()
	self._currPlayBgmId = 0
	self._defaultBgmId = 0
	self._sceneBgmId = 0
	self._preStoryBgmId = 0
	self.triggerView = nil
end

function StoryBgmMgr:startStory(triggerView)
	self.triggerView = triggerView

	local scene = SceneMgr.instance:getCurScene()

	self._sceneBgmId = scene.bgm:getBgmId()
	self._currPlayBgmId = self._sceneBgmId

	if scene:getSceneType() == SceneType.Battle then
		self._defaultBgmId = BattleController.instance:getOriginSceneBgm()

		if not self._defaultBgmId or self._defaultBgmId == 0 then
			self._defaultBgmId = self._currPlayBgmId
		end
	else
		self._defaultBgmId = self._currPlayBgmId
	end

	if OpSummaryController.instance:isPlayingBgm() then
		self._currPlayBgmId = OpSummaryController.instance:getBgmMusicId()
		self._defaultBgmId = self._currPlayBgmId
		self._sceneBgmId = self._currPlayBgmId
	end
end

function StoryBgmMgr:stopStory(triggerView)
	if self.triggerView ~= triggerView then
		return
	end

	self:playBgmById(self._sceneBgmId)

	self._currPlayBgmId = 0
	self._defaultBgmId = 0
	self._sceneBgmId = 0
	self._preStoryBgmId = 0
	self.triggerView = nil
end

function StoryBgmMgr:playStoryBgm(story)
	if not story.bgMusic then
		local bgMusic = 0

		if story.bgMusic == 0 and self._preStoryBgmId ~= 0 then
			bgMusic = self._preStoryBgmId
		end

		if story.bgMusic ~= 0 then
			self._preStoryBgmId = story.bgMusic
		end

		self:playBgmById(story.bgMusic)
	end
end

function StoryBgmMgr:playBgmById(bgMusic)
	if bgMusic == 0 then
		bgMusic = self._defaultBgmId
	end

	if bgMusic ~= self._currPlayBgmId and (self._currPlayBgmId == 0 or true) then
		self._currPlayBgmId = bgMusic

		AudioPlayerEx.instance:playMusic(bgMusic)
	end
end

StoryBgmMgr.instance = StoryBgmMgr.New()

return StoryBgmMgr
