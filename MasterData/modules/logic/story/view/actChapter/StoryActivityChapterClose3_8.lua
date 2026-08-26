-- chunkname: @modules/logic/story/view/actChapter/StoryActivityChapterClose3_8.lua

module("modules.logic.story.view.actChapter.StoryActivityChapterClose3_8", package.seeall)

local StoryActivityChapterClose3_8 = class("StoryActivityChapterClose3_8", StoryActivityChapterBase)

function StoryActivityChapterClose3_8:onCtor()
	self.assetPath = "ui/viewres/story/v3a8/storyactivitychapterclose.prefab"
end

function StoryActivityChapterClose3_8:onInitView()
	self.goEnd = gohelper.findChild(self.viewGO, "#simage_FullBG/end")
	self.goContinued = gohelper.findChild(self.viewGO, "#simage_FullBG/continue")
	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function StoryActivityChapterClose3_8:onUpdateView()
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

function StoryActivityChapterClose3_8:getAudioId(part)
	if part == 2 then
		return AudioEnum.Story.play_activitysfx_shiji3_8_end
	end

	return AudioEnum.Story.play_activitysfx_shiji3_8_continue
end

function StoryActivityChapterClose3_8:_playAudio()
	if self._audioId then
		AudioEffectMgr.instance:playAudio(self._audioId)
	end
end

function StoryActivityChapterClose3_8:onHide()
	if self._audioId then
		AudioEffectMgr.instance:stopAudio(self._audioId)

		self._audioId = nil
	end
end

function StoryActivityChapterClose3_8:onDestory()
	if self._audioId then
		AudioEffectMgr.instance:stopAudio(self._audioId)

		self._audioId = nil
	end

	StoryActivityChapterClose3_8.super.onDestory(self)
end

return StoryActivityChapterClose3_8
