-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/BattleExtension.lua

BattleExtension = class("BattleExtension")

function BattleExtension:initialize(dispatcher)
	super.initialize(self)

	self._eventDispatcher = dispatcher or EventDispatcher:new()
end

function BattleExtension:getStoryDispatcher()
	assert(self._eventDispatcher ~= nil, "Story dispatcher can't be nil!!!")

	return self._eventDispatcher
end

function BattleExtension:_registerEvent(type, target, listener, priority)
	assert(self._eventDispatcher ~= nil, "Story dispatcher can't be nil!!!")
	self._eventDispatcher:addEventListener(type, target, listener, false, priority or 0)
end

BattleStoryExtension = class("BattleStoryExtension", BattleExtension)

function BattleStoryExtension:initialize(pointId, dispatcher)
	super.initialize(self, dispatcher)

	self._pointId = pointId

	self._registerEvent(self, EVT_BATTLE_POINT_READY, self, self.onReady)
end

function BattleStoryExtension:onReady(event)
	local storyName = ConfigReader:getDataByNameIdAndKey("BlockPoint", self._pointId, "BattleStory")

	if storyName == nil or storyName == "" then
		return
	end

	if not event or not event:getData() then
		return
	end

	local data = event:getData()
	local mainMediator = data.mainMediator

	if not mainMediator then
		return
	end

	mainMediator:pause()

	local storyDirector = mainMediator:getInjector():getInstance(story.StoryDirector)
	local storyAgent = storyDirector:getStoryAgent()

	storyAgent:setSkipCheckSave(true)
	storyAgent:trigger(storyName.enter, nil, function()
		mainMediator:resume()
	end)
end
