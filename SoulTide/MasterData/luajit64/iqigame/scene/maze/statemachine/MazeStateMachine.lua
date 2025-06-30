-- chunkname: @IQIGame\\Scene\\Maze\\StateMachine\\MazeStateMachine.lua

local m = {}

m = extend(StateMachine, m)

function m.New(elementController, cid)
	local obj = Clone(m)

	obj:Init(elementController, cid)

	return obj
end

function m:Init(elementController, cid)
	self.controller = elementController

	self:BaseInit(self.controller.gameObject, cid)
end

function m:RegisterAllNodeAction()
	self:BaseRegisterAllNodeAction()
	self.script:RegistActionFunc("setGatherAnimation", self:GetActionFunc(self.ActionSetGatherAnimation))
	self.script:RegistActionFunc("removeElement", self:GetActionFunc(self.ActionRemoveElement))
	self.script:RegistActionFunc("transportToTargetPos", self:GetActionFunc(self.ActionTransportToTargetPos))
	self.script:RegistActionFunc("preExecutionEnd", self:GetActionFunc(self.ActionPreExecutionEnd))
	self.script:RegistActionFunc("playCustomAnimation", self:GetActionFunc(self.ActionPlayCustomAnimation))
end

function m:RegisterAllNodeCondition()
	self:BaseRegisterAllNodeCondition()
	self.script:RegistConditionFunc("isMoving", self:GetCOrACFunc(self.ConditionIsMoving))
	self.script:RegistConditionFunc("isDead", self:GetCOrACFunc(self.ConditionIsDead))
	self.script:RegistConditionFunc("isGathering", self:GetCOrACFunc(self.ConditionIsGathering))
	self.script:RegistConditionFunc("isTransporting", self:GetCOrACFunc(self.ConditionIsTransporting))
	self.script:RegistConditionFunc("isEnterMaze", self:GetCOrACFunc(self.ConditionIsEnterMaze))
	self.script:RegistConditionFunc("isNeedPreExecAnimation", self:GetCOrACFunc(self.ConditionIsNeedPreExecAnimation))
	self.script:RegistConditionFunc("needPlayCustomAnimation", self:GetCOrACFunc(self.ConditionNeedPlayCustomAnimation))
	self.script:RegistConditionFunc("isState", self:GetCOrACFunc(self.ConditionIsState))
end

function m:RegisterAllActionCondition()
	self:BaseRegisterAllActionCondition()
end

function m:ActionSetGatherAnimation(param)
	local cfgMazeGatherData = CfgMazeGatherTable[self.controller.GatherCid]

	self:PlayAnimation(cfgMazeGatherData.RoleAction, true)
end

function m:PlayAnimation(animationName, loop)
	self.controller.CustomAnimation = nil

	self:BasePlayAnimation(animationName, loop)
end

function m:ActionRemoveElement(param)
	MazeModule.MazeScene:RemoveElement(self.controller)
end

function m:ActionTransportToTargetPos(param)
	self.controller:TransportToTargetPos()
	MazeModule.MazeScene:CameraStartFollowHero()
end

function m:ActionPreExecutionEnd(param)
	self.controller.PreActionExecutionType = 0
end

function m:ActionPlayCustomAnimation(param)
	self:PlayAnimation(self.controller.CustomAnimation, false)
end

function m:ConditionIsMoving(param)
	local sign = param:getParamAsBoolean(0)

	return self.controller:IsMoving() == sign
end

function m:ConditionIsDead(param)
	local sign = param:getParamAsBoolean(0)

	return self.controller.ElementPOD.IsRemoved == sign
end

function m:ConditionIsGathering(param)
	local sign = param:getParamAsBoolean(0)

	return (self.controller.GatherCid ~= nil and self.controller.GatherCid ~= 0) == sign
end

function m:ConditionIsTransporting(param)
	local sign = param:getParamAsBoolean(0)

	return (self.controller.TransportTargetNodeId ~= nil and not self.controller.TransportStateMachineConfirmed) == sign
end

function m:ConditionIsEnterMaze(param)
	local sign = param:getParamAsBoolean(0)

	return MazeModule.MazeScene.MazePrepared == sign
end

function m:ConditionIsNeedPreExecAnimation(param)
	local sign = param:getParamAsBoolean(0)

	return self.controller.PreActionExecutionType ~= 0 == sign
end

function m:ConditionNeedPlayCustomAnimation(param)
	return self.controller.CustomAnimation ~= nil
end

function m:ConditionIsState(param)
	local state = param:GetParamAsInt(0)
	local flag = param:getParamAsBoolean(1)

	return self.controller.State == state == flag
end

function m:Dispose()
	self:BaseDispose()

	self.controller = nil
end

return m
