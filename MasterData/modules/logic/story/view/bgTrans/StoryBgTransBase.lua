-- chunkname: @modules/logic/story/view/bgTrans/StoryBgTransBase.lua

module("modules.logic.story.view.bgTrans.StoryBgTransBase", package.seeall)

local StoryBgTransBase = class("StoryBgTransBase", LuaCompBase)

function StoryBgTransBase:ctor()
	self._resList = {}
	self._transInTime = 0
	self._transOutTime = 0
	self._loader = MultiAbLoader.New()
end

function StoryBgTransBase:init()
	return
end

function StoryBgTransBase:start()
	return
end

function StoryBgTransBase:loadRes()
	self._loader:setPathList(self._resList)
	self._loader:startLoad(self.onLoadFinished, self)
end

function StoryBgTransBase:onLoadFinished()
	return
end

function StoryBgTransBase:onSwitchBg()
	StoryController.instance:dispatchEvent(StoryEvent.RefreshBackground)
end

function StoryBgTransBase:onTransFinished()
	return
end

function StoryBgTransBase:destroy()
	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end

	self._resList = nil
end

return StoryBgTransBase
