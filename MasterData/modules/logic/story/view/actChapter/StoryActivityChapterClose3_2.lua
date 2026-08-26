-- chunkname: @modules/logic/story/view/actChapter/StoryActivityChapterClose3_2.lua

module("modules.logic.story.view.actChapter.StoryActivityChapterClose3_2", package.seeall)

local StoryActivityChapterClose3_2 = class("StoryActivityChapterClose3_2", StoryActivityChapterBase)

function StoryActivityChapterClose3_2:onCtor()
	self.assetPath = "ui/viewres/story/v3a2/storyactivitychapterclose.prefab"
end

function StoryActivityChapterClose3_2:onInitView()
	self.goEnd = gohelper.findChild(self.viewGO, "#simage_FullBG/end")
	self.goContinued = gohelper.findChild(self.viewGO, "#simage_FullBG/continue")
	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function StoryActivityChapterClose3_2:onUpdateView()
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

function StoryActivityChapterClose3_2:getAudioId(part)
	return AudioEnum.Story.play_activitysfx_shengyan_chapter_continue
end

function StoryActivityChapterClose3_2:_playAudio()
	if self._audioId then
		AudioEffectMgr.instance:playAudio(self._audioId)
	end
end

function StoryActivityChapterClose3_2:onHide()
	if self._audioId then
		AudioEffectMgr.instance:stopAudio(self._audioId)

		self._audioId = nil
	end
end

function StoryActivityChapterClose3_2:onDestory()
	if self._audioId then
		AudioEffectMgr.instance:stopAudio(self._audioId)

		self._audioId = nil
	end

	StoryActivityChapterClose3_2.super.onDestory(self)
end

return StoryActivityChapterClose3_2
