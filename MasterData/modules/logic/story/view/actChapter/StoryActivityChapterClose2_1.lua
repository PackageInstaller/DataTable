-- chunkname: @modules/logic/story/view/actChapter/StoryActivityChapterClose2_1.lua

module("modules.logic.story.view.actChapter.StoryActivityChapterClose2_1", package.seeall)

local StoryActivityChapterClose2_1 = class("StoryActivityChapterClose2_1", StoryActivityChapterBase)

function StoryActivityChapterClose2_1:onCtor()
	self.assetPath = "ui/viewres/story/v2a1/storyactivitychapterclose.prefab"
end

function StoryActivityChapterClose2_1:onInitView()
	self.goEnd = gohelper.findChild(self.viewGO, "#simage_FullBG/end")
	self.goContinued = gohelper.findChild(self.viewGO, "#simage_FullBG/continue")
end

function StoryActivityChapterClose2_1:onUpdateView()
	local isend = tonumber(self.data) == 2

	gohelper.setActive(self.goEnd, isend)
	gohelper.setActive(self.goContinued, not isend)

	if isend then
		self._audioId = AudioEnum.Story.play_activitysfx_wangshi_chapter_close or AudioEnum.Story.play_activitysfx_wangshi_subsection_close
	end

	self:_playAudio()
end

function StoryActivityChapterClose2_1:_playAudio()
	if self._audioId then
		AudioEffectMgr.instance:playAudio(self._audioId)
	end
end

function StoryActivityChapterClose2_1:onHide()
	if self._audioId then
		AudioEffectMgr.instance:stopAudio(self._audioId)

		self._audioId = nil
	end
end

function StoryActivityChapterClose2_1:onDestory()
	if self._audioId then
		AudioEffectMgr.instance:stopAudio(self._audioId)

		self._audioId = nil
	end

	StoryActivityChapterClose2_1.super.onDestory(self)
end

return StoryActivityChapterClose2_1
