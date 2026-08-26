-- chunkname: @modules/logic/story/view/actChapter/StoryActivityChapterClose3_9.lua

module("modules.logic.story.view.actChapter.StoryActivityChapterClose3_9", package.seeall)

local StoryActivityChapterClose3_9 = class("StoryActivityChapterClose3_9", StoryActivityChapterBase)

function StoryActivityChapterClose3_9:onCtor()
	self.assetPath = "ui/viewres/story/v3a9/storyactivitychapterclose.prefab"
end

function StoryActivityChapterClose3_9:onInitView()
	self.goEnd = gohelper.findChild(self.viewGO, "#simage_FullBG/end")
	self.goContinued = gohelper.findChild(self.viewGO, "#simage_FullBG/continue")
	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function StoryActivityChapterClose3_9:onUpdateView()
	local isend = tonumber(self.data) == 2

	if isend then
		self._anim:Play("end", 0, 0)
	else
		self._anim:Play("continue", 0, 0)
	end

	gohelper.setActive(self.goEnd, isend)
	gohelper.setActive(self.goContinued, not isend)

	self._audioId = self:getAudioId(tonumber(self.data))

	self:_playAudio()
end

function StoryActivityChapterClose3_9:getAudioId(part)
	if part == 2 then
		return AudioEnum.Story.play_activitysfx_chongran_chapter_end
	end

	return AudioEnum.Story.play_activitysfx_chongran_chapter_continue
end

function StoryActivityChapterClose3_9:_playAudio()
	if self._audioId then
		AudioEffectMgr.instance:playAudio(self._audioId)
	end
end

function StoryActivityChapterClose3_9:onHide()
	if self._audioId then
		AudioEffectMgr.instance:stopAudio(self._audioId)

		self._audioId = nil
	end
end

function StoryActivityChapterClose3_9:onDestory()
	if self._audioId then
		AudioEffectMgr.instance:stopAudio(self._audioId)

		self._audioId = nil
	end

	StoryActivityChapterClose3_9.super.onDestory(self)
end

return StoryActivityChapterClose3_9
