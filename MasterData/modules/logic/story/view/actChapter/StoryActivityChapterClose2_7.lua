-- chunkname: @modules/logic/story/view/actChapter/StoryActivityChapterClose2_7.lua

module("modules.logic.story.view.actChapter.StoryActivityChapterClose2_7", package.seeall)

local StoryActivityChapterClose2_7 = class("StoryActivityChapterClose2_7", StoryActivityChapterBase)

function StoryActivityChapterClose2_7:onCtor()
	self.assetPath = "ui/viewres/story/v2a7/storyactivitychapterclose.prefab"
end

function StoryActivityChapterClose2_7:onInitView()
	self.goEnd = gohelper.findChild(self.viewGO, "#simage_FullBG/end")
	self.goContinued = gohelper.findChild(self.viewGO, "#simage_FullBG/continue")
	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function StoryActivityChapterClose2_7:onUpdateView()
	local isend = tonumber(self.data) == 2

	if isend then
		self._anim:Play("close1", 0, 0)
	else
		self._anim:Play("close", 0, 0)
	end

	gohelper.setActive(self.goEnd, isend)
	gohelper.setActive(self.goContinued, not isend)

	self._audioId = self:getAudioId(tonumber(self.data))

	self:_playAudio()
end

function StoryActivityChapterClose2_7:getAudioId(part)
	return AudioEnum.Story.play_activitysfx_yuzhou_chapter_continue
end

function StoryActivityChapterClose2_7:_playAudio()
	if self._audioId then
		AudioEffectMgr.instance:playAudio(self._audioId)
	end
end

function StoryActivityChapterClose2_7:onHide()
	if self._audioId then
		AudioEffectMgr.instance:stopAudio(self._audioId)

		self._audioId = nil
	end
end

function StoryActivityChapterClose2_7:onDestory()
	if self._audioId then
		AudioEffectMgr.instance:stopAudio(self._audioId)

		self._audioId = nil
	end

	StoryActivityChapterClose2_7.super.onDestory(self)
end

return StoryActivityChapterClose2_7
