-- chunkname: @modules/logic/story/view/dialogEffs/StoryDialogEffsBase.lua

module("modules.logic.story.view.dialogEffs.StoryDialogEffsBase", package.seeall)

local StoryDialogEffsBase = class("StoryDialogEffsBase", LuaCompBase)

function StoryDialogEffsBase:ctor()
	self._resList = {}
	self._loader = MultiAbLoader.New()
end

function StoryDialogEffsBase:init()
	return
end

function StoryDialogEffsBase:start(stepCo)
	self._stepCo = stepCo
end

function StoryDialogEffsBase:reset(stepCo)
	self._stepCo = stepCo
end

function StoryDialogEffsBase:loadRes()
	self._loader:setPathList(self._resList)
	self._loader:startLoad(self.onLoadFinished, self)
end

function StoryDialogEffsBase:getEffType()
	return self._stepCo.conversation.effType
end

function StoryDialogEffsBase:onLoadFinished()
	return
end

function StoryDialogEffsBase:onEffInFinished()
	return
end

function StoryDialogEffsBase:onEffKeepFinished()
	return
end

function StoryDialogEffsBase:onEffOutFinished()
	return
end

function StoryDialogEffsBase:destroy()
	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end

	self._resList = nil
end

return StoryDialogEffsBase
