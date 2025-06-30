-- chunkname: @IQIGame\\Scene\\MagicTower\\MagicTowerElement.lua

local m = {
	SortingOrder = 0,
	IsRemoved = false,
	EntityId = 0,
	IsHero = false,
	IsLoading = false,
	TempDirection = 0,
	EntityCid = 0,
	ExecutionStates = {}
}
local MagicTowerStateMachine = require("IQIGame.Scene.MagicTower.StateMachine.MagicTowerStateMachine")

function m.New(entityId, elementRoot, cellPOD, position, sortingOrder)
	local obj = Clone(m)

	obj:Init(entityId, elementRoot, cellPOD, position, sortingOrder)

	return obj
end

function m:Init(entityId, elementRoot, cellPOD, position, sortingOrder)
	self:BaseInit(entityId, elementRoot, cellPOD, position, sortingOrder)
end

function m:BaseInit(entityId, elementRoot, cellPOD, position, sortingOrder)
	self.EntityCid = entityId
	self.CellPOD = cellPOD
	self.SortingOrder = sortingOrder

	function self.DelegateOnShowElementEntitySuccess(sender, args)
		self:OnShowElementEntitySuccess(sender, args)
	end

	function self.DelegateOnShowElementEntityFailure(sender, args)
		self:OnShowElementEntityFailure(sender, args)
	end

	self:AddListeners()
	self:ShowElement(entityId, elementRoot, position)
end

function m:AddListeners()
	self:BaseAddListeners()
end

function m:RemoveListeners()
	self:BaseRemoveListeners()
end

function m:BaseAddListeners()
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntityFailureEventArgs.EventId, self.DelegateOnShowElementEntityFailure)
end

function m:BaseRemoveListeners()
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntityFailureEventArgs.EventId, self.DelegateOnShowElementEntityFailure)
end

function m:ShowElement(entityCid, elementRoot, position)
	self.EntityCid = entityCid
	self.EntityId = GameEntry.Entity:GenerateEntityID()
	self.IsLoading = true

	GameEntry.Entity:ShowElement(self.EntityId, entityCid, 0, elementRoot, position)
end

function m:HideEntity()
	if self.EntityId ~= 0 then
		GameEntry.Entity:HideEntityWithData(self.EntityId)

		self.EntityId = 0
		self.gameObject = nil
		self.SpineGO = nil
	end
end

function m:OnShowElementEntitySuccess(sender, args)
	if args.Entity == nil then
		logError("迷宫错误：IQIGame/Scene/Maze/MazeElement: attempt to index local 'entity' (a nil value)")

		return
	end

	if args.Entity.Id == self.EntityId then
		self.gameObject = args.Entity.gameObject

		setGameObjectLayers(self.gameObject.transform, "Default")

		local spineRenderer = self.gameObject:GetComponentInChildren(typeof(UnityEngine.Renderer))

		spineRenderer.sortingLayerID = LuaCodeInterface.SortingLayerNameToID("Element")
		spineRenderer.sortingOrder = self.SortingOrder
		self.SpineGO = spineRenderer.gameObject

		if self.TempDirection ~= 0 then
			self:LookAtDirection(self.TempDirection)

			self.TempDirection = 0
		end

		self:OnShow()

		self.IsLoading = false

		EventDispatcher.Dispatch(EventID.MagicTowerLoadEntityComplete)
	end
end

function m:OnShowElementEntityFailure(sender, args)
	if args.EntityId == self.EntityId then
		logError("load maze element error")

		self.IsLoading = false

		EventDispatcher.Dispatch(EventID.MagicTowerLoadEntityComplete)
	end
end

function m:OnShow()
	self:InitStateMachine(1015)
end

function m:InitStateMachine(defaultCid)
	local stateMachineId = defaultCid
	local cfgElementEntityData = CfgElementEntityTable[self.EntityCid]

	if cfgElementEntityData.StateMachineId ~= 0 then
		stateMachineId = cfgElementEntityData.StateMachineId
	end

	MagicTowerModule.MagicTowerScene.StateMachineMgr:AddStateMachine(MagicTowerStateMachine, self, stateMachineId)
end

function m:IsMoving()
	return false
end

function m:SetRemoved()
	self.IsRemoved = true
end

function m:GetCameraFocusPosition()
	local position = Vector3.zero
	local gameObject = self.gameObject

	if self.gameObject == nil then
		local indexX, indexY = MagicTowerModule.NodeSeqXYToIndexXY(MagicTowerModule.MapData.currentFloor, self.CellPOD.x, self.CellPOD.y)
		local node = MagicTowerModule.MagicTowerScene:GetNodeByXY(indexX, indexY)

		if node ~= nil then
			gameObject = node.gameObject
		end
	end

	if self.gameObject == nil then
		gameObject = Vector3.zero

		logError("找不到节点的gameObject")
	end

	position.x = gameObject.transform.position.x
	position.y = gameObject.transform.position.y + MagicTowerSceneApi:GetString("CameraLookHeroOffsetY")
	position.z = MagicTowerModule.MagicTowerScene.MainCamera.transform.position.z

	return position
end

function m:SetExecState(type, value)
	local index = table.indexOf(self.ExecutionStates, type)

	if value and index == -1 then
		table.insert(self.ExecutionStates, type)
	elseif not value and index ~= -1 then
		table.remove(self.ExecutionStates, index)
	end
end

function m:ClearExecState()
	local changedStates = {}

	for i = 1, #self.ExecutionStates do
		local state = self.ExecutionStates[i]

		table.insert(changedStates, state)
	end

	self.ExecutionStates = {}

	return changedStates
end

function m:IsInState(type)
	local index = table.indexOf(self.ExecutionStates, type)

	return index ~= -1
end

function m:ResetInteractState()
	local changedStates = self:ClearExecState()

	if #changedStates > 0 then
		EventDispatcher.Dispatch(EventID.MagicTowerStopInteract, self, changedStates)
	end
end

function m:LookAtDirection(dir)
	if self.SpineGO == nil then
		self.TempDirection = dir

		return
	end

	self.SpineGO.transform.rotation = Quaternion.Euler(0, dir > 0 and 180 or 0, 0)
end

function m:SetSortingOrder(order)
	self.SortingOrder = order

	if self.gameObject ~= nil then
		local spineRenderer = self.gameObject:GetComponentInChildren(typeof(UnityEngine.Renderer))

		spineRenderer.sortingOrder = self.SortingOrder
	end
end

function m:Dispose()
	self:BaseDispose()
	EventDispatcher.Dispatch(EventID.MagicTowerRemoveElement)
end

function m:BaseDispose()
	self:RemoveListeners()
	MagicTowerModule.MagicTowerScene.StateMachineMgr:RemoveStateMachine(self)
	self:HideEntity()
end

return m
