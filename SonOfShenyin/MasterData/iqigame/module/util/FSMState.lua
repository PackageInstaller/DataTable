-- chunkname: @IQIGame\\Module\\Util\\FSMState.lua

FSMState = class({})

function FSMState:ctor(fsm)
	self.FSM = fsm
end

function FSMState:ChangeStateByName(stateName)
	return self.FSM:ChangeStateByName(stateName)
end

function FSMState:ChangeStateByPrototype(statePrototype)
	return self.FSM:ChangeStateByName(statePrototype.Name)
end

function FSMState:OnEnter()
	return
end

function FSMState:OnUpdate(deltaTime)
	return
end

function FSMState:OnFixedUpdate(fixedDeltaTime)
	return
end

function FSMState:OnExit()
	return
end

return FSMState
