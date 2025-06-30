-- chunkname: @IQIGame\\Scene\\Dreamland\\StateMachine\\DreamlandStateMachine.lua

local m = {}

m = extend(StateMachine, m)

function m.New(controller, cid)
	local obj = Clone(m)

	obj:Init(controller, cid)

	return obj
end

function m:Init(controller, cid)
	self.controller = controller

	self:BaseInit(self.controller.gameObject, cid)
end

function m:RegisterAllNodeAction()
	self:BaseRegisterAllNodeAction()
	self.script:RegistActionFunc("removeElement", self:GetActionFunc(self.ActionRemoveElement))
	self.script:RegistActionFunc("setPrepared", self:GetActionFunc(self.ActionSetPrepared))
	self.script:RegistActionFunc("stopDig", self:GetActionFunc(self.ActionStopDig))
	self.script:RegistActionFunc("resetInteractState", self:GetActionFunc(self.ActionResetInteractState))
end

function m:RegisterAllNodeCondition()
	self:BaseRegisterAllNodeCondition()
	self.script:RegistConditionFunc("isReadyToStart", self:GetCOrACFunc(self.ConditionIsReadyToStart))
	self.script:RegistConditionFunc("isMoving", self:GetCOrACFunc(self.ConditionIsMoving))
	self.script:RegistConditionFunc("isDead", self:GetCOrACFunc(self.ConditionIsDead))
	self.script:RegistConditionFunc("isOpeningCell", self:GetCOrACFunc(self.ConditionIsOpeningCell))
	self.script:RegistConditionFunc("isFight", self:GetCOrACFunc(self.ConditionIsFight))
	self.script:RegistConditionFunc("isGather", self:GetCOrACFunc(self.ConditionIsGather))
end

function m:RegisterAllActionCondition()
	self:BaseRegisterAllActionCondition()
end

function m:ActionRemoveElement(param)
	DreamlandModule.DreamlandScene:RemoveElement(self.controller)
end

function m:ActionResetInteractState(param)
	self.controller:ResetInteractState()
end

function m:ActionSetPrepared(param)
	self.controller:SetPrepared()
end

function m:ActionStopDig(param)
	local controller = self.controller

	controller:FinishOpenCell()
end

function m:ConditionIsMoving(param)
	local sign = param:getParamAsBoolean(0)

	return self.controller:IsMoving() == sign
end

function m:ConditionIsReadyToStart(param)
	local sign = param:getParamAsBoolean(0)

	return DreamlandModule.DreamlandScene.IsReadyToStart == sign
end

function m:ConditionIsDead(param)
	local sign = param:getParamAsBoolean(0)

	return self.controller.IsRemoved == sign
end

function m:ConditionIsOpeningCell(param)
	local sign = param:getParamAsBoolean(0)
	local controller = self.controller

	return controller.IsOpeningCell == sign
end

function m:ConditionIsFight(param)
	local sign = param:getParamAsBoolean(0)

	return self.controller:IsInState(DreamExecStateEnum.Fight) == sign
end

function m:ConditionIsGather(param)
	local sign = param:getParamAsBoolean(0)

	return self.controller:IsInState(DreamExecStateEnum.Gather) == sign
end

function m:Dispose()
	self:BaseDispose()

	self.controller = nil
end

return m
