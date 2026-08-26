-- chunkname: @modules/logic/story/view/actChapter/StoryActivityChapterClose2_5.lua

module("modules.logic.story.view.actChapter.StoryActivityChapterClose2_5", package.seeall)

local StoryActivityChapterClose2_5 = class("StoryActivityChapterClose2_5", StoryActivityChapterBase)

function StoryActivityChapterClose2_5:onCtor()
	self.assetPath = "ui/viewres/story/v2a5/storyactivitychapterclose.prefab"
end

function StoryActivityChapterClose2_5:onInitView()
	self.goEnd = gohelper.findChild(self.viewGO, "#simage_FullBG/end")
	self.goContinued = gohelper.findChild(self.viewGO, "#simage_FullBG/continue")
	self.simageBg = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG/simagebg")
	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function StoryActivityChapterClose2_5:onUpdateView()
	local isend = tonumber(self.data) == 2
	local isspecial = tonumber(self.data) == 3
	local isNormalEnd = tonumber(self.data) == 4

	if isend then
		self._anim:Play("close1", 0, 0)
	elseif isspecial then
		self._anim:Play("close2", 0, 0)
	elseif isNormalEnd then
		self._anim:Play("close3", 0, 0)
	else
		self._anim:Play("close", 0, 0)
	end

	gohelper.setActive(self.goEnd, isend or isNormalEnd)
	gohelper.setActive(self.goContinued, not isend and not isspecial)

	self._audioId = self:getAudioId(tonumber(self.data))

	self.simageBg:LoadImage(string.format("singlebg/v2a5_opening_singlebg/.jpg", isend and "end_bg" or "continued_bg"))
	self:_playAudio()
end

function StoryActivityChapterClose2_5:getAudioId(part)
	if part == 3 then
		return AudioEnum.Story.play_activitysfx_tangren_chapter_special_close
	end

	if part == 1 then
		return AudioEnum.Story.play_activitysfx_tangren_chapter_small_close
	end
end

function StoryActivityChapterClose2_5:_playAudio()
	if self._audioId then
		AudioEffectMgr.instance:playAudio(self._audioId)
	end
end

function StoryActivityChapterClose2_5:onHide()
	if self._audioId then
		AudioEffectMgr.instance:stopAudio(self._audioId)

		self._audioId = nil
	end
end

function StoryActivityChapterClose2_5:onDestory()
	if self._audioId then
		AudioEffectMgr.instance:stopAudio(self._audioId)

		self._audioId = nil
	end

	self.simageBg:UnLoadImage()
	StoryActivityChapterClose2_5.super.onDestory(self)
end

return StoryActivityChapterClose2_5
