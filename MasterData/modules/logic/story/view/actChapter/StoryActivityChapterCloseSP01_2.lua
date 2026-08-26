-- chunkname: @modules/logic/story/view/actChapter/StoryActivityChapterCloseSP01_2.lua

module("modules.logic.story.view.actChapter.StoryActivityChapterCloseSP01_2", package.seeall)

local StoryActivityChapterCloseSP01_2 = class("StoryActivityChapterCloseSP01_2", StoryActivityChapterBase)

function StoryActivityChapterCloseSP01_2:onCtor()
	self.assetPath = "ui/viewres/story/sp01/storyactivitychapterclose2.prefab"
end

function StoryActivityChapterCloseSP01_2:onInitView()
	self.goEnd = gohelper.findChild(self.viewGO, "#simage_FullBG/end")
	self.goContinued = gohelper.findChild(self.viewGO, "#simage_FullBG/continue")
	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function StoryActivityChapterCloseSP01_2:onUpdateView()
	local isend = tonumber(self.data) == 2

	if isend then
		self._anim:Play("close1", 0, 0)
	else
		self._anim:Play("close", 0, 0)
	end

	gohelper.setActive(self.goEnd, isend)
	gohelper.setActive(self.goContinued, not isend)

	self._audioId = self:getAudioId(tonumber(self.data))

	self:_playAudio()
end

function StoryActivityChapterCloseSP01_2:getAudioId(part)
	return AudioEnum.Story.play_activitysfx_cikexia_chapter_continue
end

function StoryActivityChapterCloseSP01_2:_playAudio()
	if self._audioId then
		AudioEffectMgr.instance:playAudio(self._audioId)
	end
end

function StoryActivityChapterCloseSP01_2:onHide()
	if self._audioId then
		AudioEffectMgr.instance:stopAudio(self._audioId)

		self._audioId = nil
	end
end

function StoryActivityChapterCloseSP01_2:onDestory()
	if self._audioId then
		AudioEffectMgr.instance:stopAudio(self._audioId)

		self._audioId = nil
	end

	StoryActivityChapterCloseSP01_2.super.onDestory(self)
end

return StoryActivityChapterCloseSP01_2
