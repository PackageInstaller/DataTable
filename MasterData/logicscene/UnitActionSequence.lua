-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/action/UnitActionSequence.lua

module("logicscene.scene.unit.action.UnitActionSequence", package.seeall)

local UnitActionSequence = class("UnitActionSequence", UnitActionBase)

function UnitActionSequence:ctor(actions, loop)
	UnitActionSequence.super.ctor(self)

	self._actions = actions
	self._currIdx = nil
	self._loop = loop
	self._actionsCnt = #self._actions
end

function UnitActionSequence:start(unit)
	UnitActionSequence.super.start(self, unit)

	self._currIdx = 1
end

function UnitActionSequence:stop()
	UnitActionSequence.super.stop(self)

	if self._currIdx and self._currIdx >= 1 and self._currIdx <= self._actionsCnt then
		self._actions[self._currIdx]:stop()
	end

	self._currIdx = nil
end

function UnitActionSequence:update(deltaTime)
	if self._actions and self._currIdx >= 1 and self._currIdx <= self._actionsCnt then
		if not self._actions[self._currIdx].isRunning then
			self._actions[self._currIdx]:start(self._unit)
		end

		if self._currIdx and self._actions and self._actions[self._currIdx] then
			self._actions[self._currIdx]:update(deltaTime)
		end

		if self._currIdx and self._actions[self._currIdx]:isDone() then
			self._actions[self._currIdx]:notifyFinished()
			self._actions[self._currIdx]:stop()

			self._currIdx = self._currIdx + 1

			if self:isDone() and self._loop then
				self._currIdx = 1
			end
		end
	end
end

function UnitActionSequence:isDone()
	if not self._currIdx or not self._actionsCnt then
		return
	end

	return self._currIdx > self._actionsCnt
end

function UnitActionSequence:reverse()
	local actions = {}

	for i = self._actionsCnt, 1, -1 do
		actions[self._actionsCnt - i + 1] = self._actions[i]:reverse()
	end

	return UnitActionSequence.New(actions, self._loop)
end

return UnitActionSequence
