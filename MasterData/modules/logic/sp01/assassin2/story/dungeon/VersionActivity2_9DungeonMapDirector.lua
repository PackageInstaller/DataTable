-- chunkname: @modules/logic/sp01/assassin2/story/dungeon/VersionActivity2_9DungeonMapDirector.lua

module("modules.logic.sp01.assassin2.story.dungeon.VersionActivity2_9DungeonMapDirector", package.seeall)

local VersionActivity2_9DungeonMapDirector = class("VersionActivity2_9DungeonMapDirector", BaseView)

function VersionActivity2_9DungeonMapDirector:onInitView()
	self:initWorkMap()
end

function VersionActivity2_9DungeonMapDirector:addEvents()
	self.addEventCb(self, VersionActivity2_9DungeonController.instance, VersionActivity2_9Event.OnOneWorkLoadDone, self._onOneWorkLoadDone, self)
	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnChangeMap, self._onChangeMap, self)
	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnDisposeScene, self._onDisposeScene, self)
end

function VersionActivity2_9DungeonMapDirector:initWorkMap()
	self.statusMap = {}

	for _, workType in pairs(VersionActivity2_9DungeonEnum.LoadWorkType) do
		self.statusMap[workType] = false
	end
end

function VersionActivity2_9DungeonMapDirector:_onChangeMap()
	self.statusMap[VersionActivity2_9DungeonEnum.LoadWorkType.Scene] = false
end

function VersionActivity2_9DungeonMapDirector:_onDisposeScene()
	self.statusMap[VersionActivity2_9DungeonEnum.LoadWorkType.Scene] = false
end

function VersionActivity2_9DungeonMapDirector:_onOneWorkLoadDone(workType)
	self.statusMap[workType] = true

	self:checkIsAllWorkLoadDone()
end

function VersionActivity2_9DungeonMapDirector:checkIsAllWorkLoadDone()
	local isAllDone = self:isAllWorkLoadDone()

	if not isAllDone then
		return
	end

	self:onAllWorkLoadDone()
end

function VersionActivity2_9DungeonMapDirector:onAllWorkLoadDone()
	VersionActivity2_9DungeonController.instance:dispatchEvent(VersionActivity2_9Event.OnAllWorkLoadDone)
end

function VersionActivity2_9DungeonMapDirector:isAllWorkLoadDone()
	for _, isDone in pairs(self.statusMap) do
		if not isDone then
			return
		end
	end

	return true
end

return VersionActivity2_9DungeonMapDirector
