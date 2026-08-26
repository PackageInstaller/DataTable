-- chunkname: @modules/logic/story/view/actChapter/StoryActivityChapterClose2_4.lua

module("modules.logic.story.view.actChapter.StoryActivityChapterClose2_4", package.seeall)

local StoryActivityChapterClose2_4 = class("StoryActivityChapterClose2_4", StoryActivityChapterBase)

function StoryActivityChapterClose2_4:onCtor()
	self.assetPath = "ui/viewres/story/v2a4/storyactivitychapterclose.prefab"
end

function StoryActivityChapterClose2_4:onInitView()
	self.goEnd = gohelper.findChild(self.viewGO, "#simage_FullBG/end")
	self.goContinued = gohelper.findChild(self.viewGO, "#simage_FullBG/continue")
	self.simageBg = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG/simagebg")
end

function StoryActivityChapterClose2_4:onUpdateView()
	local isend = tonumber(self.data) == 2

	gohelper.setActive(self.goEnd, isend)
	gohelper.setActive(self.goContinued, not isend)

	self._audioId = AudioEnum.Story.play_activitysfx_diqiu_chapter_continue

	self.simageBg:LoadImage(string.format("singlebg/v2a4_opening_singlebg/bg%s.jpg", isend and 3 or 2))
	self:_playAudio()
end

function StoryActivityChapterClose2_4:_playAudio()
	if self._audioId then
		AudioEffectMgr.instance:playAudio(self._audioId)
	end
end

function StoryActivityChapterClose2_4:onHide()
	if self._audioId then
		AudioEffectMgr.instance:stopAudio(self._audioId)

		self._audioId = nil
	end
end

function StoryActivityChapterClose2_4:onDestory()
	if self._audioId then
		AudioEffectMgr.instance:stopAudio(self._audioId)

		self._audioId = nil
	end

	self.simageBg:UnLoadImage()
	StoryActivityChapterClose2_4.super.onDestory(self)
end

return StoryActivityChapterClose2_4
