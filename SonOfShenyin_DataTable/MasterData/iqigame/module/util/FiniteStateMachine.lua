-- chunkname: @IQIGame\\Module\\Util\\FiniteStateMachine.lua

FiniteStateMachine = class({
	states = {},
	triggers = {},
	bools = {},
	dataEx = {}
})

function FiniteStateMachine:AddState(state)
	local state = state

	state.FSM = self
	self.states[state.Name] = state

	return state
end

function FiniteStateMachine:RemoveState(stateName)
	local state = self.states[stateName]

	self.states[stateName] = nil

	return state
end

function FiniteStateMachine:ChangeStateByName(stateName)
	local nextState = self.states[stateName]

	if nextState then
		return self:ChangeState(nextState)
	else
		logError("there is no " .. stateName .. " State, or you forget to add " .. stateName .. " State to FSM")
	end

	return nil
end

function FiniteStateMachine:ChangeStateByPrototype(statePrototype)
	return self:ChangeStateByName(statePrototype.Name)
end

function FiniteStateMachine:ChangeState(nextState)
	self.NextState = nextState

	return nextState
end

function FiniteStateMachine:Update(deltaTime)
	if self.NextState ~= nil then
		if self.CurrentState ~= nil then
			self.CurrentState:OnExit()
		end

		self.PreviousState = self.CurrentState
		self.CurrentState = self.NextState
		self.NextState = nil

		self.CurrentState:OnEnter()

		if self.ChangeStateSuccessCallback ~= nil then
			self.ChangeStateSuccessCallback()

			self.ChangeStateSuccessCallback = nil
		end
	end

	if self.CurrentState then
		self.CurrentState:OnUpdate(deltaTime)
	end
end

function FiniteStateMachine:SetTrigger(trigger)
	self.triggers[trigger] = true
end

function FiniteStateMachine:SetBool(boolKey, boolValue)
	self.bools[boolKey] = boolValue
end

function FiniteStateMachine:CheckTrigger(triggerKey)
	if self.triggers[triggerKey] then
		self.triggers[triggerKey] = false

		return true
	else
		return false
	end
end

function FiniteStateMachine:CheckBool(boolKey)
	return self.bools[boolKey] == true
end

function FiniteStateMachine:SetData(key, data)
	self.dataEx[key] = data
end

function FiniteStateMachine:GetData(key)
	return self.dataEx[key]
end

return FiniteStateMachine
