-- chunkname: @modules/logic/story/view/actChapter/StoryActivityChapterClose2_3.lua

module("modules.logic.story.view.actChapter.StoryActivityChapterClose2_3", package.seeall)

local StoryActivityChapterClose2_3 = class("StoryActivityChapterClose2_3", StoryActivityChapterBase)

function StoryActivityChapterClose2_3:onCtor()
	self.assetPath = "ui/viewres/story/v2a3/storyactivitychapterclose.prefab"
end

function StoryActivityChapterClose2_3:onInitView()
	self.goEnd = gohelper.findChild(self.viewGO, "#simage_FullBG/end")
	self.goContinued = gohelper.findChild(self.viewGO, "#simage_FullBG/continue")
end

function StoryActivityChapterClose2_3:onUpdateView()
	local isend = tonumber(self.data) == 2

	gohelper.setActive(self.goEnd, isend)
	gohelper.setActive(self.goContinued, not isend)

	self._audioId = AudioEnum.Story.play_activitysfx_shenghuo_chapter_continue

	self:_playAudio()
end

function StoryActivityChapterClose2_3:_playAudio()
	if self._audioId then
		AudioEffectMgr.instance:playAudio(self._audioId)
	end
end

function StoryActivityChapterClose2_3:onHide()
	if self._audioId then
		AudioEffectMgr.instance:stopAudio(self._audioId)

		self._audioId = nil
	end
end

function StoryActivityChapterClose2_3:onDestory()
	if self._audioId then
		AudioEffectMgr.instance:stopAudio(self._audioId)

		self._audioId = nil
	end

	StoryActivityChapterClose2_3.super.onDestory(self)
end

return StoryActivityChapterClose2_3
