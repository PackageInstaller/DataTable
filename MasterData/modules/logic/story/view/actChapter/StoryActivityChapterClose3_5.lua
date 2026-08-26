-- chunkname: @modules/logic/story/view/actChapter/StoryActivityChapterClose3_5.lua

module("modules.logic.story.view.actChapter.StoryActivityChapterClose3_5", package.seeall)

local StoryActivityChapterClose3_5 = class("StoryActivityChapterClose3_5", StoryActivityChapterBase)

function StoryActivityChapterClose3_5:onCtor()
	self.assetPath = "ui/viewres/story/v3a5/storyactivitychapterclose.prefab"
end

function StoryActivityChapterClose3_5:onInitView()
	self.goEnd = gohelper.findChild(self.viewGO, "#simage_FullBG/end")
	self.goContinued = gohelper.findChild(self.viewGO, "#simage_FullBG/continue")
	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function StoryActivityChapterClose3_5:onUpdateView()
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

function StoryActivityChapterClose3_5:getAudioId(part)
	local isend = part == 2

	return (isend or nil) and (AudioEnum.Story.play_activitysfx_lusongshi_chapter_close or AudioEnum.Story.play_activitysfx_lusongshi_subsection_close)
end

function StoryActivityChapterClose3_5:_playAudio()
	if self._audioId then
		AudioEffectMgr.instance:playAudio(self._audioId)
	end
end

function StoryActivityChapterClose3_5:onHide()
	if self._audioId then
		AudioEffectMgr.instance:stopAudio(self._audioId)

		self._audioId = nil
	end
end

function StoryActivityChapterClose3_5:onDestory()
	if self._audioId then
		AudioEffectMgr.instance:stopAudio(self._audioId)

		self._audioId = nil
	end

	StoryActivityChapterClose3_5.super.onDestory(self)
end

return StoryActivityChapterClose3_5
