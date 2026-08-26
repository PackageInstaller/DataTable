-- chunkname: @modules/logic/scene/udimo/entitycomp/UdimoFsmComp.lua

module("modules.logic.scene.udimo.entitycomp.UdimoFsmComp", package.seeall)

local UdimoFsmComp = class("UdimoFsmComp", LuaCompBase)

function UdimoFsmComp:ctor(entity)
	self.entity = entity
end

function UdimoFsmComp:init(go)
	local stateEnum = UdimoEnum.UdimoState

	self._fsm = UdimoFSM.New(self.entity)

	self._fsm:registerState(UdimoIdleState.New(stateEnum.Idle))

	local udimoId = self.entity:getId()
	local udimoType = UdimoConfig.instance:getUdimoType(udimoId)

	if udimoType == UdimoEnum.UdimoType.Air then
		self._fsm:registerState(UdimoFlyWalkState.New(stateEnum.Walk))
	else
		self._fsm:registerState(UdimoWalkState.New(stateEnum.Walk))
	end

	self._fsm:registerState(UdimoPickedUpState.New(stateEnum.PickedUp))
	self._fsm:registerState(UdimoWaitInteractState.New(stateEnum.WaitInteract))
	self._fsm:registerState(UdimoInteractState.New(stateEnum.Interact))
	self._fsm:registerTransition(UdimoIdleTransition.New(stateEnum.Idle))
	self._fsm:registerTransition(UdimoWalkTransition.New(stateEnum.Walk))
	self._fsm:registerTransition(UdimoPickedUpTransition.New(stateEnum.PickedUp))
	self._fsm:registerTransition(UdimoWaitTransition.New(stateEnum.WaitInteract))
	self._fsm:registerTransition(UdimoInteractTransition.New(stateEnum.Interact))
	self._fsm:start(stateEnum.Idle)
end

function UdimoFsmComp:triggerEvent(eventId, param)
	if not self._fsm then
		return
	end

	self._fsm:triggerEvent(eventId, param)
end

function UdimoFsmComp:onUpdate()
	if not self._fsm then
		return
	end

	return self._fsm:onUpdate()
end

function UdimoFsmComp:getCurStateName()
	if not self._fsm then
		return
	end

	return self._fsm.curStateName
end

function UdimoFsmComp:isInTranslating()
	if not self._fsm then
		return
	end

	return self._fsm.isTranslating
end

function UdimoFsmComp:triggerFSMEvent(eventId, param)
	if not self._fsm then
		return
	end

	self._fsm:triggerEvent(eventId, param)
end

function UdimoFsmComp:updateFSMStateParam(state, param)
	if not self._fsm then
		return
	end

	self._fsm:updateStateParam(state, param)
end

function UdimoFsmComp:releaseFSM()
	if not self._fsm then
		return
	end

	self._fsm:release()

	self._fsm = nil
end

function UdimoFsmComp:beforeDestroy()
	self:releaseFSM()
end

function UdimoFsmComp:onDestroy()
	self:releaseFSM()
end

return UdimoFsmComp
