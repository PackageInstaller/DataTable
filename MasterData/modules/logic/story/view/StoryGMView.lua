-- chunkname: @modules/logic/story/view/StoryGMView.lua

module("modules.logic.story.view.StoryGMView", package.seeall)

local StoryGMView = class("StoryGMView", LuaCompBase)

function StoryGMView:ctor(go)
	self._btnLog = gohelper.findChildButtonWithAudio(go, "#btn_storylog")

	self._btnLog:AddClickListener(self._btnLogClick, self)
end

function StoryGMView:_btnLogClick()
	local curStoryId = StoryController.instance._curStoryId
	local curStepId = StoryController.instance._curStepId

	logError(string.format("curStoryId : %s  curStepId : %s", curStoryId, curStepId))
end

function StoryGMView:destroy()
	self._btnLog:RemoveClickListener()
end

return StoryGMView
