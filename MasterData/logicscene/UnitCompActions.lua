-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/UnitCompActions.lua

module("logicscene.scene.unit.component.UnitCompActions", package.seeall)

local UnitCompActions = class("UnitCompActions", UnitComponentBase)

UnitCompActions.doNotStopAnimOnMoveActionFinish = nil

function UnitCompActions:ctor(unit)
	UnitCompActions.super.ctor(self, unit)

	self._actions = nil
	self._actionsAdd = nil
	self._actionsDel = nil
	self._isPause = nil
end

function UnitCompActions:onDestroy()
	self:stopAllActions()

	self._unit = nil
end

function UnitCompActions:update(deltaTime)
	self:_delActions()
	self:_addActions()
	self:_updateActions(deltaTime)
end

function UnitCompActions:isPaused()
	return self._isPause
end

function UnitCompActions:pause(pause)
	self._isPause = pause

	if self._actions then
		local cnt = #self._actions

		for i = 1, cnt do
			if pause then
				self._actions[i]:onPause()
			else
				self._actions[i]:onResume()
			end
		end
	end
end

function UnitCompActions:isRunningAction()
	if self._actions and #self._actions > 0 then
		return true
	end

	if self._actionsAdd and #self._actionsAdd > 0 then
		return true
	end
end

function UnitCompActions:getRunningActions()
	return self._actions
end

function UnitCompActions:runAction(action)
	self._actionsAdd = self._actionsAdd or {}

	table.insert(self._actionsAdd, 1, action)
end

function UnitCompActions:stopAction(action)
	if action.isRunning then
		action:notifyStoped()
		action:stop()

		self._actionsDel = self._actionsDel or {}

		table.insert(self._actionsDel, 1, action)
	elseif self._actionsAdd then
		local cnt = #self._actionsAdd

		for i = 1, cnt do
			if self._actionsAdd[i] == action then
				table.remove(self._actionsAdd, i)

				break
			end
		end
	end
end

function UnitCompActions:stopActionByTag(tag)
	if self._actions then
		local cnt = #self._actions

		for i = 1, cnt do
			if self._actionsAdd[i].tag == tag then
				self:stopAction(self._actionsAdd[i])
			end
		end
	end

	if self._actionsAdd then
		local cnt = #self._actionsAdd

		for i = cnt, 1, -1 do
			if self._actionsAdd[i].tag == tag then
				table.remove(self._actionsAdd, i)
			end
		end
	end
end

function UnitCompActions:stopAllActions()
	self._actionsAdd = nil
	self._actionsDel = nil

	if self._actions and self._actions then
		local cnt = #self._actions

		for i = 1, cnt do
			self._actions[i]:notifyStoped()
			self._actions[i]:stop()
		end

		self._actions = nil
	end
end

function UnitCompActions:stopAllActionsOnCrossScene()
	self:_delActions()
	self:_addActions()

	if self._actions then
		local cnt = #self._actions

		for i = 1, cnt do
			if not self._actions[i].dontStopCrossScene then
				self:stopAction(self._actions[i])
			end
		end

		self:_delActions()
	end
end

function UnitCompActions:_addActions()
	if self._actionsAdd then
		local cnt = #self._actionsAdd

		for i = cnt, 1, -1 do
			if not self._actionsAdd[i].isRunning then
				self._actionsAdd[i].isPause = self._isPause

				self._actionsAdd[i]:start(self._unit)

				self._actions = self._actions or {}
				self._actions[#self._actions + 1] = self._actionsAdd[i]
			end
		end

		table.clear(self._actionsAdd)
	end
end

function UnitCompActions:_delActions()
	if self._actionsDel then
		local cnt = #self._actionsDel

		for i = cnt, 1, -1 do
			self:_removeActions(self._actionsDel[i])
		end

		table.clear(self._actionsDel)
	end
end

function UnitCompActions:_updateActions(deltaTime)
	if self._actions and not self._isPause then
		local cnt = #self._actions

		for i = 1, cnt do
			if not self._actions then
				return
			end

			self._actions[i]:update(deltaTime)

			if self._actions and self._actions[i]:isDone() then
				self._actions[i]:notifyFinished()
				self:stopAction(self._actions[i])
			end
		end
	end
end

function UnitCompActions:_removeActions(action)
	if self._actions then
		local cnt = #self._actions

		for i = 1, cnt do
			if self._actions[i] == action then
				table.remove(self._actions, i)

				break
			end
		end
	end
end

return UnitCompActions
