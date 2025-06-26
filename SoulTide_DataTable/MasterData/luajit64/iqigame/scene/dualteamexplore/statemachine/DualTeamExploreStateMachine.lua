-- chunkname: @IQIGame\\Scene\\DualTeamExplore\\StateMachine\\DualTeamExploreStateMachine.lua

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
	self.script:RegistActionFunc("transportToTargetPos", self:GetActionFunc(self.ActionTransportToTargetPos))
end

function m:RegisterAllNodeCondition()
	self:BaseRegisterAllNodeCondition()
	self.script:RegistConditionFunc("isReadyToStart", self:GetCOrACFunc(self.ConditionIsReadyToStart))
	self.script:RegistConditionFunc("isMoving", self:GetCOrACFunc(self.ConditionIsMoving))
	self.script:RegistConditionFunc("isDead", self:GetCOrACFunc(self.ConditionIsDead))
	self.script:RegistConditionFunc("isGather", self:GetCOrACFunc(self.ConditionIsGather))
	self.script:RegistConditionFunc("isTransporting", self:GetCOrACFunc(self.ConditionIsTransporting))
end

function m:RegisterAllActionCondition()
	self:BaseRegisterAllActionCondition()
end

function m:ActionRemoveElement(param)
	DualTeamExploreModule.DualTeamExploreScene:RemoveElement(self.controller.NodeData.id, self.controller.IsBuilding)
end

function m:ActionTransportToTargetPos(param)
	self.controller:TransportToTargetPos()
	DualTeamExploreModule.DualTeamExploreScene:MoveCameraToCurrentHero()
end

function m:ConditionIsMoving(param)
	local sign = param:getParamAsBoolean(0)

	return self.controller:IsMoving() == sign
end

function m:ConditionIsReadyToStart(param)
	local sign = param:getParamAsBoolean(0)

	return DualTeamExploreModule.DualTeamExploreScene.IsReadyToStart == sign
end

function m:ConditionIsDead(param)
	local sign = param:getParamAsBoolean(0)

	return self.controller.IsRemoved == sign
end

function m:ConditionIsGather(param)
	local sign = param:getParamAsBoolean(0)

	return self.controller:IsInState(DualTeamExploreExecStateEnum.Gather) == sign
end

function m:ConditionIsTransporting(param)
	local sign = param:getParamAsBoolean(0)

	return self.controller.IsClientTransporting == sign
end

function m:ActionSetVisible(param)
	local needShow = param:getParamAsBoolean(2)

	if needShow and not self.controller.IsActive then
		return
	end

	self.controller:SetVisible(needShow)
end

function m:Dispose()
	self:BaseDispose()

	self.controller = nil
end

return m
