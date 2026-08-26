-- chunkname: @modules/logic/story/view/actChapter/StoryActivityChapterCloseSP02.lua

module("modules.logic.story.view.actChapter.StoryActivityChapterCloseSP02", package.seeall)

local StoryActivityChapterCloseSP02 = class("StoryActivityChapterCloseSP02", StoryActivityChapterBase)

function StoryActivityChapterCloseSP02:onCtor()
	self.assetPath = "ui/viewres/story/sp02/storyactivitychapterclose.prefab"
end

function StoryActivityChapterCloseSP02:onInitView()
	self.goEnd = gohelper.findChild(self.viewGO, "#simage_FullBG/end")
	self.goContinued = gohelper.findChild(self.viewGO, "#simage_FullBG/continue")
	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function StoryActivityChapterCloseSP02:onUpdateView()
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

function StoryActivityChapterCloseSP02:getAudioId(part)
	return AudioEnum.Story.play_activitysfx_langchao_chapter_continue
end

function StoryActivityChapterCloseSP02:_playAudio()
	if self._audioId then
		AudioEffectMgr.instance:playAudio(self._audioId)
	end
end

function StoryActivityChapterCloseSP02:onHide()
	if self._audioId then
		AudioEffectMgr.instance:stopAudio(self._audioId)

		self._audioId = nil
	end
end

function StoryActivityChapterCloseSP02:onDestory()
	if self._audioId then
		AudioEffectMgr.instance:stopAudio(self._audioId)

		self._audioId = nil
	end

	StoryActivityChapterCloseSP02.super.onDestory(self)
end

return StoryActivityChapterCloseSP02
