-- chunkname: @modules/logic/fight/system/work/FightWorkEntityPlayAct.lua

module("modules.logic.fight.system.work.FightWorkEntityPlayAct", package.seeall)

local FightWorkEntityPlayAct = class("FightWorkEntityPlayAct", BaseWork)

function FightWorkEntityPlayAct:ctor(entity, actName)
	self._entity = entity
	self._actName = actName
end

function FightWorkEntityPlayAct:onStart(context)
	self:_playAnim()
end

function FightWorkEntityPlayAct:_playAnim()
	if self._entity.spine and self._entity.spine:hasAnimation(self._actName) then
		TaskDispatcher.runDelay(self._delayDone, self, 30)
		self._entity.spine:addAnimEventCallback(self._onAnimEvent, self)
		self._entity.spine:play(self._actName, false, true)

		self._entity.spine.lockAct = true
	else
		self:onDone(true)
	end
end

function FightWorkEntityPlayAct:_delayDone()
	self:onDone(true)
end

function FightWorkEntityPlayAct:_onAnimEvent(actionName, eventName, eventArgs)
	if eventName == SpineAnimEvent.ActionComplete then
		self._entity.spine.lockAct = false

		self._entity.spine:removeAnimEventCallback(self._onAnimEvent, self)
		self._entity:resetAnimState()
		self:onDone(true)
	end
end

function FightWorkEntityPlayAct:clearWork()
	if self._entity.spine then
		self._entity.spine.lockAct = false

		self._entity.spine:removeAnimEventCallback(self._onAnimEvent, self)
	end

	TaskDispatcher.cancelTask(self._delayDone, self)
end

return FightWorkEntityPlayAct
