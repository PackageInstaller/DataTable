-- chunkname: @IQIGame\\Scene\\DualTeamExplore\\DualTeamExploreHero.lua

local DualTeamExploreElement = require("IQIGame.Scene.DualTeamExplore.DualTeamExploreElement")
local m = {
	MoveDuration = 0,
	IsOpeningCell = false,
	StepSoundPlayId = 0,
	IsClientTransporting = false,
	MoveElapsedTime = 0,
	MoveSpeed = 0,
	TeamIndex = 0,
	PauseMoveReasonList = {}
}

m = extend(DualTeamExploreElement, m)

function m.New(entityId, elementRoot, teamIndex, onLoadComplete)
	local obj = Clone(m)

	obj:Init(entityId, elementRoot, teamIndex, onLoadComplete)

	return obj
end

function m:Init(entityId, elementRoot, teamIndex, onLoadComplete)
	self.TeamIndex = teamIndex
	self.OnLoadCompleteCallback = onLoadComplete
	self.IsHero = true
	self.MoveSpeed = DualTeamExploreSceneApi:GetString("HeroMoveSpeed")

	self:BaseInit(entityId, elementRoot, false)
end

function m:AddListeners()
	self:BaseAddListeners()
end

function m:RemoveListeners()
	self:BaseRemoveListeners()
end

function m:OnShow()
	self:InitStateMachine(1012)

	if self.OnLoadCompleteCallback ~= nil then
		self.OnLoadCompleteCallback()

		self.OnLoadCompleteCallback = nil
	end
end

function m:IsMoving()
	return self.MoveNextNode ~= nil
end

function m:SetNode(nodeData, byMove)
	self.NodeData = nodeData

	if byMove then
		local team = DualTeamExploreModule.GetHeroTeam(self.TeamIndex)

		team.currNodeId = nodeData.id
	end
end

function m:SetMoveNextNodeData(nextNode)
	self.MoveNextNode = nextNode

	local node = DualTeamExploreModule.DualTeamExploreScene:GetNodeById(nextNode.id)
	local pos = node:GetPos()

	self.MoveNextPosition = Vector3(pos.x, pos.y, 0)
end

function m:Update()
	if self:IsMoving() then
		self:KeepPlayStepSound()
	else
		self:StopPlayStepSound()
	end
end

function m:KeepPlayStepSound()
	if self.StepSoundPlayId == 0 then
		local cfgDualTeamExploreLevelData = CfgDualTeamExploreLevelTable[DualTeamExploreModule.LevelPOD.levelCid]

		self.StepSoundPlayId = GameEntry.Sound:PlaySound(cfgDualTeamExploreLevelData.WalkSound, Constant.SoundGroup.ENVIRONMENT)
	end
end

function m:StopPlayStepSound()
	if self.StepSoundPlayId ~= 0 then
		GameEntry.Sound:StopSound(self.StepSoundPlayId)

		self.StepSoundPlayId = 0
	end
end

function m:StopMove()
	self:ResetPositionOnNode()

	self.MoveNextNode = nil
	self.MoveNextPosition = nil
	self.MoveFinalNode = nil
	self.MoveElapsedTime = 0

	EventDispatcher.Dispatch(EventID.LockInput, Constant.LockInputReason.DualTeamExploreMove, false)
end

function m:ResetPositionOnNode()
	local node = DualTeamExploreModule.DualTeamExploreScene:GetNodeById(self.NodeData.id)

	self.gameObject.transform.position = node:GetPos()
end

function m:ResetInteractState()
	self:ClearExecState()
end

function m:StartTransport(nodeId)
	self.TransportTargetNodeId = nodeId
	self.IsClientTransporting = true
end

function m:TransportToTargetPos()
	local nodeData = DualTeamExploreModule.GetNodeDataById(self.TransportTargetNodeId)

	warning("状态机传送完成。Hero team index：" .. self.TeamIndex .. "，TransportTargetNodeId：" .. tostring(self.TransportTargetNodeId))
	self:SetNode(nodeData, true)
	self:StopMove()

	self.IsClientTransporting = false

	if self.IsActive then
		warning("发送传送到达。Node id：" .. self.TransportTargetNodeId)
		DualTeamExploreModule.SendArriveNode(self.TransportTargetNodeId)
	end
end

function m:SetTransportArrived()
	self.TransportTargetNodeId = nil
end

function m:Dispose()
	self:BaseDispose()
end

return m
