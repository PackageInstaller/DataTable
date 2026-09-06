-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/action/UnitActionBase.lua

module("logicscene.scene.unit.action.UnitActionBase", package.seeall)

local UnitActionBase = class("UnitActionBase")

function UnitActionBase:ctor()
	self._elapsed = 0
	self._duration = 0
	self._unit = nil
	self.tag = nil
	self.isRunning = nil
	self._percent = nil
	self.onFinished = nil
	self.onFinishedObj = nil
	self.onStoped = nil
	self.onStopedObj = nil
	self.dontStopCrossScene = nil
end

function UnitActionBase:start(unit)
	self.isRunning = true
	self._elapsed = 0
	self._percent = 0
	self._unit = unit
end

function UnitActionBase:stop()
	self._unit = nil
	self.isRunning = nil
	self._elapsed = nil
	self._percent = nil
	self.onFinished = nil
	self.onFinishedObj = nil
	self.onStoped = nil
	self.onStopedObj = nil
end

function UnitActionBase:onPause()
	return
end

function UnitActionBase:onResume()
	return
end

function UnitActionBase:update(deltaTime)
	self._elapsed = self._elapsed + deltaTime
	self._percent = self._duration == 0 and 1 or math.min(1, math.max(0, self._elapsed / self._duration))

	self:step()
end

function UnitActionBase:notifyFinished()
	self.onStoped = nil
	self.onStopedObj = nil

	if self.onFinished then
		if self.onFinishedObj then
			self.onFinished(self.onFinishedObj)
		else
			self.onFinished()
		end
	end
end

function UnitActionBase:notifyStoped()
	self.onFinished = nil
	self.onFinishedObj = nil

	if self.onStoped then
		if self.onStopedObj then
			self.onStoped(self.onStopedObj)
		else
			self.onStoped()
		end
	end
end

function UnitActionBase:isInvalid()
	return false
end

function UnitActionBase:step()
	return
end

function UnitActionBase:isDone()
	return self._elapsed >= self._duration
end

function UnitActionBase:reverse()
	return nil
end

return UnitActionBase
