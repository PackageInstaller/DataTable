-- chunkname: @modules/logic/story/view/actChapter/StoryActivityChapterClose1_6.lua

module("modules.logic.story.view.actChapter.StoryActivityChapterClose1_6", package.seeall)

local StoryActivityChapterClose1_6 = class("StoryActivityChapterClose1_6", StoryActivityChapterBase)

function StoryActivityChapterClose1_6:onCtor()
	self.assetPath = "ui/viewres/story/v1a6/storyactivitychapterclose.prefab"
end

function StoryActivityChapterClose1_6:onInitView()
	self._simageIcon = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG/title")
end

function StoryActivityChapterClose1_6:onUpdateView()
	local isend = tonumber(self.data) == 2

	self._audioId = AudioEnum.Story.play_activitysfx_shuori_chapter_continue

	if not isend then
		self._simageIcon:LoadImage("singlebg_lang/txt_v1a6_storyactivityopenclose/txt_v1a6_story_continue.png")
	else
		self._simageIcon:LoadImage("singlebg_lang/txt_v1a6_storyactivityopenclose/txt_v1a6_story_end.png")
	end

	self:_playAudio()
end

function StoryActivityChapterClose1_6:_playAudio()
	if self._audioId then
		AudioEffectMgr.instance:playAudio(self._audioId)
	end
end

function StoryActivityChapterClose1_6:onHide()
	if self._audioId then
		AudioEffectMgr.instance:stopAudio(self._audioId)

		self._audioId = nil
	end
end

function StoryActivityChapterClose1_6:onDestory()
	if self._simageIcon then
		self._simageIcon:UnLoadImage()
	end

	if self._audioId then
		AudioEffectMgr.instance:stopAudio(self._audioId)

		self._audioId = nil
	end

	StoryActivityChapterClose1_6.super.onDestory(self)
end

return StoryActivityChapterClose1_6
