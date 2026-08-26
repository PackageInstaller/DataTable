-- chunkname: @modules/logic/story/view/actChapter/StoryActivityChapterClose1_8.lua

module("modules.logic.story.view.actChapter.StoryActivityChapterClose1_8", package.seeall)

local StoryActivityChapterClose1_8 = class("StoryActivityChapterClose1_8", StoryActivityChapterBase)

function StoryActivityChapterClose1_8:onCtor()
	self.assetPath = "ui/viewres/story/v1a8/storyactivitychapterclose.prefab"
end

function StoryActivityChapterClose1_8:onInitView()
	self._simageIcon = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG/title")
end

function StoryActivityChapterClose1_8:onUpdateView()
	local isend = tonumber(self.data) == 2

	self._audioId = AudioEnum.Story.play_activitysfx_shiji_chapter_continue

	if not isend then
		self._simageIcon:LoadImage("singlebg_lang/txt_v1a8_storyactivityopenclose/txt_v1a8_story_continue.png")
	else
		self._simageIcon:LoadImage("singlebg_lang/txt_v1a8_storyactivityopenclose/txt_v1a8_story_end.png")
	end

	self:_playAudio()
end

function StoryActivityChapterClose1_8:_playAudio()
	if self._audioId then
		AudioEffectMgr.instance:playAudio(self._audioId)
	end
end

function StoryActivityChapterClose1_8:onHide()
	if self._audioId then
		AudioEffectMgr.instance:stopAudio(self._audioId)

		self._audioId = nil
	end
end

function StoryActivityChapterClose1_8:onDestory()
	if self._simageIcon then
		self._simageIcon:UnLoadImage()
	end

	if self._audioId then
		AudioEffectMgr.instance:stopAudio(self._audioId)

		self._audioId = nil
	end

	StoryActivityChapterClose1_8.super.onDestory(self)
end

return StoryActivityChapterClose1_8
