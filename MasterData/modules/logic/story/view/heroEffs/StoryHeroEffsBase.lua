-- chunkname: @modules/logic/story/view/heroEffs/StoryHeroEffsBase.lua

module("modules.logic.story.view.heroEffs.StoryHeroEffsBase", package.seeall)

local StoryHeroEffsBase = class("StoryHeroEffsBase", LuaCompBase)

function StoryHeroEffsBase:ctor()
	self._resList = {}
	self._transInTime = 0
	self._transOutTime = 0
	self._loader = MultiAbLoader.New()
end

function StoryHeroEffsBase:init()
	return
end

function StoryHeroEffsBase:start()
	return
end

function StoryHeroEffsBase:loadRes()
	self._loader:setPathList(self._resList)
	self._loader:startLoad(self.onLoadFinished, self)
end

function StoryHeroEffsBase:onLoadFinished()
	return
end

function StoryHeroEffsBase:destroy()
	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end

	self._resList = nil
end

return StoryHeroEffsBase
