-- chunkname: @modules/logic/story/view/actChapter/StoryActivityChapterClose3_6.lua

module("modules.logic.story.view.actChapter.StoryActivityChapterClose3_6", package.seeall)

local StoryActivityChapterClose3_6 = class("StoryActivityChapterClose3_6", StoryActivityChapterBase)

function StoryActivityChapterClose3_6:onCtor()
	self.assetPath = "ui/viewres/story/v3a6/storyactivitychapterclose.prefab"
end

function StoryActivityChapterClose3_6:onInitView()
	self.goEnd = gohelper.findChild(self.viewGO, "#simage_FullBG/end")
	self.goContinued = gohelper.findChild(self.viewGO, "#simage_FullBG/continue")
	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function StoryActivityChapterClose3_6:onUpdateView()
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

function StoryActivityChapterClose3_6:getAudioId(part)
	if part == 2 then
		return AudioEnum.Story.play_activitysfx_renmen_avg_end
	end

	return AudioEnum.Story.play_activitysfx_renmen_avg_continue
end

function StoryActivityChapterClose3_6:_playAudio()
	if self._audioId then
		AudioEffectMgr.instance:playAudio(self._audioId)
	end
end

function StoryActivityChapterClose3_6:onHide()
	if self._audioId then
		AudioEffectMgr.instance:stopAudio(self._audioId)

		self._audioId = nil
	end
end

function StoryActivityChapterClose3_6:onDestory()
	if self._audioId then
		AudioEffectMgr.instance:stopAudio(self._audioId)

		self._audioId = nil
	end

	StoryActivityChapterClose3_6.super.onDestory(self)
end

return StoryActivityChapterClose3_6
