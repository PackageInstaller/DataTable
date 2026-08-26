-- chunkname: @modules/logic/story/view/actChapter/StoryActivityChapterClose1_5.lua

module("modules.logic.story.view.actChapter.StoryActivityChapterClose1_5", package.seeall)

local StoryActivityChapterClose1_5 = class("StoryActivityChapterClose1_5", StoryActivityChapterBase)

function StoryActivityChapterClose1_5:onCtor()
	self.assetPath = "ui/viewres/story/v1a5/storyactivitychapterclose.prefab"
end

function StoryActivityChapterClose1_5:onInitView()
	self._simageIcon = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG/title")
end

function StoryActivityChapterClose1_5:onUpdateView()
	local isend = tonumber(self.data) == 2

	self._audioId = AudioEnum.Story.Activity1_3_Chapter_End

	if not isend then
		self._simageIcon:LoadImage("singlebg_lang/txt_v1a5_storyactivityopenclose/txt_v1a5_story_continue.png")
	else
		self._simageIcon:LoadImage("singlebg_lang/txt_v1a5_storyactivityopenclose/txt_v1a5_story_end.png")
	end

	self:_playAudio()
end

function StoryActivityChapterClose1_5:_playAudio()
	if self._audioId then
		AudioEffectMgr.instance:playAudio(self._audioId)
	end
end

function StoryActivityChapterClose1_5:onHide()
	if self._audioId then
		AudioEffectMgr.instance:stopAudio(self._audioId)

		self._audioId = nil
	end
end

function StoryActivityChapterClose1_5:onDestory()
	if self._simageIcon then
		self._simageIcon:UnLoadImage()
	end

	if self._audioId then
		AudioEffectMgr.instance:stopAudio(self._audioId)

		self._audioId = nil
	end

	StoryActivityChapterClose1_5.super.onDestory(self)
end

return StoryActivityChapterClose1_5
