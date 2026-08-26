-- chunkname: @modules/logic/story/view/actChapter/StoryActivityChapterClose1_2.lua

module("modules.logic.story.view.actChapter.StoryActivityChapterClose1_2", package.seeall)

local StoryActivityChapterClose1_2 = class("StoryActivityChapterClose1_2", StoryActivityChapterBase)

function StoryActivityChapterClose1_2:onCtor()
	self.assetPath = "ui/viewres/story/v1a2/storyactivitychapterclose.prefab"
end

function StoryActivityChapterClose1_2:onInitView()
	self.node1 = gohelper.findChild(self.viewGO, "1")
	self.node2 = gohelper.findChild(self.viewGO, "2")
end

function StoryActivityChapterClose1_2:onUpdateView()
	local isend = tonumber(self.data) == 2

	gohelper.setActive(self.node1, not isend)
	gohelper.setActive(self.node2, isend)

	if isend then
		self._audioId = AudioEnum.Story.Activity1_2_Chapter_End or AudioEnum.Story.Activity1_2_Chapter_Continue
	end

	self:_playAudio()
end

function StoryActivityChapterClose1_2:_playAudio()
	if self._audioId then
		AudioEffectMgr.instance:playAudio(self._audioId)
	end
end

function StoryActivityChapterClose1_2:onHide()
	if self._audioId then
		AudioEffectMgr.instance:stopAudio(self._audioId)

		self._audioId = nil
	end
end

function StoryActivityChapterClose1_2:onDestory()
	if self._audioId then
		AudioEffectMgr.instance:stopAudio(self._audioId)

		self._audioId = nil
	end

	StoryActivityChapterClose1_2.super.onDestory(self)
end

return StoryActivityChapterClose1_2
