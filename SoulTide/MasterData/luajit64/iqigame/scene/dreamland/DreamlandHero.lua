-- chunkname: @IQIGame\\Scene\\Dreamland\\DreamlandHero.lua

local DreamlandElement = require("IQIGame.Scene.Dreamland.DreamlandElement")
local m = {
	MoveDuration = 0,
	StepSoundPlayId = 0,
	MoveSpeed = 0,
	IsOpeningCell = false,
	MoveElapsedTime = 0
}

m = extend(DreamlandElement, m)

function m.New(entityId, elementRoot, onLoadComplete)
	local obj = Clone(m)

	obj:Init(entityId, elementRoot, onLoadComplete)

	return obj
end

function m:Init(entityId, elementRoot, onLoadComplete)
	self.OnLoadCompleteCallback = onLoadComplete
	self.IsHero = true
	self.MoveSpeed = DreamlandSceneApi:GetString("HeroMoveSpeed")

	function self.DelegateOnStopInteract(element, changedStates)
		self:OnStopInteract(element, changedStates)
	end

	self:BaseInit(entityId, elementRoot)
end

function m:AddListeners()
	self:BaseAddListeners()
	EventDispatcher.AddEventListener(EventID.DreamlandStopInteract, self.DelegateOnStopInteract)
end

function m:RemoveListeners()
	self:BaseRemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.DreamlandStopInteract, self.DelegateOnStopInteract)
end

function m:OnShow()
	self:InitStateMachine(1010)

	if self.OnLoadCompleteCallback ~= nil then
		self.OnLoadCompleteCallback()

		self.OnLoadCompleteCallback = nil
	end
end

function m:IsMoving()
	return self.MoveNextNode ~= nil
end

function m:SetNode(node)
	self.Node = node
	DreamlandModule.MapData.roleX = node.CellPOD.x
	DreamlandModule.MapData.roleY = node.CellPOD.y

	EventDispatcher.Dispatch(EventID.DreamlandHeroArriveNode, node.CellPOD.x, node.CellPOD.y)
end

function m:SetMoveNextNodeData(nextNode)
	self.MoveNextNode = nextNode

	local pos = nextNode:GetPos()

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
		local cfgDreamMapListData = CfgDreamMapListTable[DreamlandModule.MapData.mapId]

		self.StepSoundPlayId = GameEntry.Sound:PlaySound(cfgDreamMapListData.WalkSound, Constant.SoundGroup.ENVIRONMENT)
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

	EventDispatcher.Dispatch(EventID.LockInput, Constant.LockInputReason.DreamlandMove, false)
end

function m:ResetPositionOnNode()
	self.gameObject.transform.position = self.Node:GetPos()
end

function m:SetOpeningCell(value)
	self.IsOpeningCell = value
end

function m:FinishOpenCell()
	self:SetOpeningCell(false)
	EventDispatcher.Dispatch(EventID.DreamlandOpenCellAnimationFinished)
end

function m:ResetInteractState()
	self:ClearExecState()
end

function m:OnStopInteract(element, changedStates)
	if not element.IsHero then
		self:ResetInteractState()
	end
end

function m:Dispose()
	self:BaseDispose()
end

return m
