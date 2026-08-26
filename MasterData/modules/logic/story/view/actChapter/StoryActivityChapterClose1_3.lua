-- chunkname: @modules/logic/story/view/actChapter/StoryActivityChapterClose1_3.lua

module("modules.logic.story.view.actChapter.StoryActivityChapterClose1_3", package.seeall)

local StoryActivityChapterClose1_3 = class("StoryActivityChapterClose1_3", StoryActivityChapterBase)

function StoryActivityChapterClose1_3:onCtor()
	self.assetPath = "ui/viewres/story/v1a3/storyactivitychapterclose.prefab"
end

function StoryActivityChapterClose1_3:onInitView()
	self._simageFullBg = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simageIcon = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG/title")

	self._simageFullBg:LoadImage("singlebg/v1a3_opening_singlebg/v1a3_tobecontinued_bg.png")
end

function StoryActivityChapterClose1_3:onUpdateView()
	local isend = tonumber(self.data) == 2

	self._audioId = AudioEnum.Story.Activity1_3_Chapter_End

	if not isend then
		self._simageIcon:LoadImage("singlebg/v1a3_opening_singlebg/v1a3_tobecontinued.png")
	else
		self._simageIcon:LoadImage("singlebg/v1a3_opening_singlebg/v1a3_theend.png")
	end

	self:_playAudio()
end

function StoryActivityChapterClose1_3:_playAudio()
	if self._audioId then
		AudioEffectMgr.instance:playAudio(self._audioId)
	end
end

function StoryActivityChapterClose1_3:onHide()
	if self._audioId then
		AudioEffectMgr.instance:stopAudio(self._audioId)

		self._audioId = nil
	end
end

function StoryActivityChapterClose1_3:onDestory()
	if self._simageFullBg then
		self._simageFullBg:UnLoadImage()
	end

	if self._simageIcon then
		self._simageIcon:UnLoadImage()
	end

	if self._audioId then
		AudioEffectMgr.instance:stopAudio(self._audioId)

		self._audioId = nil
	end

	StoryActivityChapterClose1_3.super.onDestory(self)
end

return StoryActivityChapterClose1_3
