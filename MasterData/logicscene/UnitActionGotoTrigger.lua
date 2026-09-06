-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/action/UnitActionGotoTrigger.lua

module("logicscene.scene.unit.action.UnitActionGotoTrigger", package.seeall)

local UnitActionGotoTrigger = class("UnitActionGotoTrigger", UnitActionPathTo)

function UnitActionGotoTrigger:ctor(triggerId)
	UnitActionGotoTrigger.super.ctor(self)

	self._triggerId = triggerId
end

function UnitActionGotoTrigger:start(unit)
	self:_findDest()

	if self._isDone then
		self._elapsed = 0
		self._duration = 0
		self.isRunning = true

		return
	end

	UnitActionGotoTrigger.super.start(self, unit)
end

function UnitActionGotoTrigger:update(deltaTime)
	if self._isDone then
		return
	end

	UnitActionGotoTrigger.super.update(self, deltaTime)
end

function UnitActionGotoTrigger:isDone()
	if self._isDone then
		return true
	end

	return UnitActionGotoTrigger.super.isDone(self)
end

function UnitActionGotoTrigger:_findDest()
	self._isDone = nil

	local scene = SceneMgr.instance:getCurScene()
	local hasTrans, destX, destY = scene:getTriggerPos(self._triggerId, nil, nil)

	if not hasTrans then
		self._isDone = true
	else
		self._destX = destX
		self._destY = destY
	end
end

return UnitActionGotoTrigger
