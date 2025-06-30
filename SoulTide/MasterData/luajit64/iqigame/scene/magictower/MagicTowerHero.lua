-- chunkname: @IQIGame\\Scene\\MagicTower\\MagicTowerHero.lua

local MagicTowerElement = require("IQIGame.Scene.MagicTower.MagicTowerElement")
local m = {
	MoveDuration = 0,
	MoveSpeed = 0,
	MoveElapsedTime = 0,
	StepSoundPlayId = 0
}

m = extend(MagicTowerElement, m)

function m.New(entityId, elementRoot, cellPOD, sortingOrder)
	local obj = Clone(m)

	obj:Init(entityId, elementRoot, cellPOD, sortingOrder)

	return obj
end

function m:Init(entityId, elementRoot, cellPOD, sortingOrder)
	self.IsHero = true
	self.MoveSpeed = MagicTowerSceneApi:GetString("HeroMoveSpeed")

	function self.DelegateOnStopInteract(element, changedStates)
		self:OnStopInteract(element, changedStates)
	end

	local indexX, indexY = MagicTowerModule.NodeSeqXYToIndexXY(MagicTowerModule.MapData.currentFloor, cellPOD.x, cellPOD.y)
	local x, y = MagicTowerModule.NodeIndexXYToPositionXY(indexX, indexY)
	local position = Vector3(x, y, 0)

	self:BaseInit(entityId, elementRoot, cellPOD, position, sortingOrder)
end

function m:AddListeners()
	self:BaseAddListeners()
end

function m:RemoveListeners()
	self:BaseRemoveListeners()
end

function m:OnShow()
	self:InitStateMachine(1014)
end

function m:IsMoving()
	return self.MoveNextNode ~= nil
end

function m:SetNode(cellPOD)
	self.CellPOD = cellPOD
	MagicTowerModule.MapData.mapPOD.role.cellId = cellPOD.id
end

function m:SetMoveNextNodeData(nextNode)
	self.MoveNextNode = nextNode

	local pos = MagicTowerModule.NodeSeqXYToPosition(MagicTowerModule.MapData.currentFloor, nextNode.x, nextNode.y)

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
		self.StepSoundPlayId = GameEntry.Sound:PlaySound(2006, Constant.SoundGroup.ENVIRONMENT)
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
	self.MoveElapsedTime = 0

	EventDispatcher.Dispatch(EventID.LockInput, Constant.LockInputReason.MagicTowerMove, false)
	MagicTowerModule.MagicTowerScene:UpdateHeroOrder()
end

function m:ResetPositionOnNode()
	local position = MagicTowerModule.NodeSeqXYToPosition(MagicTowerModule.MapData.currentFloor, self.CellPOD.x, self.CellPOD.y)

	self.gameObject.transform.position = position
end

function m:ResetInteractState()
	self:ClearExecState()
end

function m:Dispose()
	self:BaseDispose()
end

return m
