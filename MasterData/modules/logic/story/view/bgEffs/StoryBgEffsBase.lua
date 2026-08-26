-- chunkname: @modules/logic/story/view/bgEffs/StoryBgEffsBase.lua

module("modules.logic.story.view.bgEffs.StoryBgEffsBase", package.seeall)

local StoryBgEffsBase = class("StoryBgEffsBase", LuaCompBase)

function StoryBgEffsBase:ctor()
	self._resList = {}
	self._effInTime = 0
	self._effKeepTime = 0
	self._effOutTime = 0
	self._loader = MultiAbLoader.New()
end

function StoryBgEffsBase:init(bgCo)
	self._bgCo = bgCo
end

function StoryBgEffsBase:start()
	return
end

function StoryBgEffsBase:reset(bgCo)
	self._bgCo = bgCo
end

function StoryBgEffsBase:loadRes()
	self._loader:setPathList(self._resList)
	self._loader:startLoad(self.onLoadFinished, self)
end

function StoryBgEffsBase:getEffType()
	return self._bgCo.effType
end

function StoryBgEffsBase:onLoadFinished()
	return
end

function StoryBgEffsBase:onEffInFinished()
	return
end

function StoryBgEffsBase:onEffKeepFinished()
	return
end

function StoryBgEffsBase:onEffOutFinished()
	return
end

function StoryBgEffsBase:destroy()
	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end

	self._resList = nil
end

return StoryBgEffsBase
