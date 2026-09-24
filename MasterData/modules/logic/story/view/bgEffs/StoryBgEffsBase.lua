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
	self._alive = true
	self.hasStarted = false
end

function StoryBgEffsBase:start(callback, callbackObj)
	self._finishedCallback = callback
	self._finishedCallbackObj = callbackObj

	self:onStartEffect()
	self:loadRes()

	self.hasStarted = true
end

function StoryBgEffsBase:onStartEffect()
	return
end

function StoryBgEffsBase:isAlive()
	return self._alive == true
end

function StoryBgEffsBase:reset(bgCo)
	self._bgCo = bgCo
end

function StoryBgEffsBase:loadRes()
	if #self._resList <= 0 then
		self:onLoadFinished()

		return
	end

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

function StoryBgEffsBase:callFinished()
	if self._finishedCallback then
		self._finishedCallback(self._finishedCallbackObj, self)

		self._finishedCallback = nil
		self._finishedCallbackObj = nil
	end
end

function StoryBgEffsBase:destroy()
	self._finishedCallback = nil
	self._finishedCallbackObj = nil
	self._alive = false

	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end

	self._resList = nil
end

return StoryBgEffsBase
