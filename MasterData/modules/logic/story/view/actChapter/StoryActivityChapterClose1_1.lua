-- chunkname: @modules/logic/story/view/actChapter/StoryActivityChapterClose1_1.lua

module("modules.logic.story.view.actChapter.StoryActivityChapterClose1_1", package.seeall)

local StoryActivityChapterClose1_1 = class("StoryActivityChapterClose1_1", StoryActivityChapterBase)

function StoryActivityChapterClose1_1:onCtor()
	self.assetPath = "ui/viewres/story/v1a1/storyactivitychapterclose.prefab"
end

function StoryActivityChapterClose1_1:onInitView()
	self._txtCloseNum = gohelper.findChildText(self.viewGO, "icon/#txt_chaptercloseNum")
end

function StoryActivityChapterClose1_1:onUpdateView()
	self._txtCloseNum.text = self.data or ""
	self._audioId = self:getAudioId()

	local delayTime = 1

	TaskDispatcher.cancelTask(self._playAudio, self)
	TaskDispatcher.runDelay(self._playAudio, self, delayTime)
end

function StoryActivityChapterClose1_1:getAudioId(part)
	return AudioEnum.Story.Activity_Chapter_End
end

function StoryActivityChapterClose1_1:_playAudio()
	if self._audioId then
		AudioEffectMgr.instance:playAudio(self._audioId)
	end
end

function StoryActivityChapterClose1_1:onHide()
	TaskDispatcher.cancelTask(self._playAudio, self)

	if self._audioId then
		AudioEffectMgr.instance:stopAudio(self._audioId)

		self._audioId = nil
	end
end

function StoryActivityChapterClose1_1:onDestory()
	TaskDispatcher.cancelTask(self._playAudio, self)

	if self._audioId then
		AudioEffectMgr.instance:stopAudio(self._audioId)

		self._audioId = nil
	end

	StoryActivityChapterClose1_1.super.onDestory(self)
end

return StoryActivityChapterClose1_1
