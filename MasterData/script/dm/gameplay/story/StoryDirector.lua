-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/story/StoryDirector.lua

module("story", package.seeall)

StoryDirector = class("StoryDirector", DisposableObject)

StoryDirector:has("_eventDispatcher", {
	is = "r"
})
StoryDirector:has("_guideAgent", {
	is = "r"
})
StoryDirector:has("_storyAgent", {
	is = "r"
})

function StoryDirector:initialize()
	super.initialize(self)

	self._eventDispatcher = EventDispatcher:new()
	self._clickEnvs = {}
end

function StoryDirector:userInject(injector)
	self._guideAgent = injector:injectInto(GuideAgent:new())

	self._guideAgent:setDirector(self)

	self._storyAgent = injector:injectInto(StoryAgent:new())

	self._storyAgent:setDirector(self)
end

function StoryDirector:dispose()
	if self._eventDispatcher ~= nil then
		self._eventDispatcher:clearAllListeners()

		self._eventDispatcher = nil
	end

	if self._guideAgent then
		self._guideAgent:dispose()

		self._guideAgent = nil
	end

	if self._storyAgent then
		self._storyAgent:dispose()

		self._storyAgent = nil
	end

	super.dispose(self)
end

function StoryDirector:setClickEnv(id, targetNode, onClick)
	if self._clickEnvs[id] == nil then
		self._clickEnvs[id] = {}
	end

	if targetNode then
		self._clickEnvs[id].targetNode = targetNode

		targetNode:atExit(function(node)
			self._clickEnvs[id] = nil
		end)
	end

	if onClick then
		self._clickEnvs[id].onClick = onClick
	end
end

function StoryDirector:getClickEnv(id)
	return self._clickEnvs[id]
end

function StoryDirector:addEventListener(type, target, listener, priority)
	if self._eventDispatcher ~= nil then
		self._eventDispatcher:addEventListener(type, target, listener, false, priority or 0)
	end
end

function StoryDirector:removeEventListener(type, target, listener)
	if self._eventDispatcher ~= nil then
		self._eventDispatcher:removeEventListener(type, target, listener, false)
	end
end

function StoryDirector:removeEventListenerById(id)
	if self._removeEvents[id] then
		local removeFunc = self._removeEvents[id]

		self._removeEvents[id] = nil

		removeFunc()
	end
end

function StoryDirector:dispatch(event)
	if self._eventDispatcher then
		self._eventDispatcher:dispatchEvent(event)
	end
end

function StoryDirector:registerRemoveEvents(id, removeFunc)
	if id == nil then
		return
	end

	if self._removeEvents == nil then
		self._removeEvents = {}
	end

	self:removeEventListenerById(id)

	self._removeEvents[id] = removeFunc
end

function StoryDirector:notifyWaiting(signal, data)
	print("notifyWaiting", signal)

	local event = Event:new(signal, data)

	self:dispatch(event)
end
