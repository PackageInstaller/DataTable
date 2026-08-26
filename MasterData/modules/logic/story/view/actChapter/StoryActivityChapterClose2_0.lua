-- chunkname: @modules/logic/story/view/actChapter/StoryActivityChapterClose2_0.lua

module("modules.logic.story.view.actChapter.StoryActivityChapterClose2_0", package.seeall)

local StoryActivityChapterClose2_0 = class("StoryActivityChapterClose2_0", StoryActivityChapterBase)

function StoryActivityChapterClose2_0:onCtor()
	self.assetPath = "ui/viewres/story/v2a0/storyactivitychapterclose.prefab"
end

function StoryActivityChapterClose2_0:onInitView()
	self._simageIcon = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG/title")
end

function StoryActivityChapterClose2_0:onUpdateView()
	local isend = tonumber(self.data) == 2

	self._audioId = AudioEnum.Story.play_ui_feichi_closing

	if not isend then
		self._simageIcon:LoadImage("singlebg_lang/txt_v2a0_opening_singlebg/continued.png")
	else
		self._simageIcon:LoadImage("singlebg_lang/txt_v2a0_opening_singlebg/end.png")
	end

	self:_playAudio()
end

function StoryActivityChapterClose2_0:_playAudio()
	if self._audioId then
		AudioEffectMgr.instance:playAudio(self._audioId)
	end
end

function StoryActivityChapterClose2_0:onHide()
	if self._audioId then
		AudioEffectMgr.instance:stopAudio(self._audioId)

		self._audioId = nil
	end
end

function StoryActivityChapterClose2_0:onDestory()
	if self._simageIcon then
		self._simageIcon:UnLoadImage()
	end

	if self._audioId then
		AudioEffectMgr.instance:stopAudio(self._audioId)

		self._audioId = nil
	end

	StoryActivityChapterClose2_0.super.onDestory(self)
end

return StoryActivityChapterClose2_0
