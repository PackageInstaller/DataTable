-- chunkname: @IQIGame\\Scene\\DualTeamExplore\\DualTeamExploreElement.lua

local m = {
	IsRemoved = false,
	EntityId = 0,
	IsClientTransporting = false,
	IsActive = true,
	TempDirection = 0,
	IsHero = false,
	IsBuilding = false,
	IsLoading = false,
	EntityCid = 0,
	ExecutionStates = {}
}
local DualTeamExploreStateMachine = require("IQIGame.Scene.DualTeamExplore.StateMachine.DualTeamExploreStateMachine")

function m.New(entityId, elementRoot, nodeData, isBuilding)
	local obj = Clone(m)

	obj:Init(entityId, elementRoot, nodeData, isBuilding)

	return obj
end

function m:Init(entityId, elementRoot, nodeData, isBuilding)
	self.NodeData = nodeData

	self:BaseInit(entityId, elementRoot, isBuilding)
end

function m:BaseInit(entityId, elementRoot, isBuilding)
	self.EntityCid = entityId
	self.ElementRoot = elementRoot
	self.IsBuilding = isBuilding

	function self.DelegateOnShowElementEntitySuccess(sender, args)
		self:OnShowElementEntitySuccess(sender, args)
	end

	function self.DelegateOnShowElementEntityFailure(sender, args)
		self:OnShowElementEntityFailure(sender, args)
	end

	self:AddListeners()
	self:ShowElement(entityId)
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

function m:ShowElement(entityCid)
	self.EntityCid = entityCid
	self.EntityId = GameEntry.Entity:GenerateEntityID()
	self.IsLoading = true

	GameEntry.Entity:ShowElement(self.EntityId, entityCid, 0, self.ElementRoot, Vector3.zero)
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
		logError("迷宫错误：IQIGame/Scene/DualTeamExplore/DualTeamExploreElement: attempt to index local 'entity' (a nil value)")

		return
	end

	if args.Entity.Id == self.EntityId then
		self.IsLoading = false
		self.gameObject = args.Entity.gameObject
		self.SpineGO = self.gameObject:GetComponentInChildren(typeof(UnityEngine.Renderer)).gameObject

		if self.TempDirection ~= 0 then
			self:LookAtDirection(self.TempDirection)

			self.TempDirection = 0
		end

		self:OnShow()
		self:SetActive(self.IsActive)
		EventDispatcher.Dispatch(EventID.DualTeamExploreEntityLoaded, true)
	end
end

function m:OnShowElementEntityFailure(sender, args)
	if args.EntityId == self.EntityId then
		self.IsLoading = false

		logError("load maze element error")
		EventDispatcher.Dispatch(EventID.DualTeamExploreEntityLoaded, false)
	end
end

function m:OnShow()
	local stateMachineId = 1013
	local cfgElementEntityData = CfgElementEntityTable[self.EntityCid]

	if cfgElementEntityData.StateMachineId ~= 0 then
		stateMachineId = cfgElementEntityData.StateMachineId
	end

	self:InitStateMachine(stateMachineId)

	local node = DualTeamExploreModule.DualTeamExploreScene:GetNodeById(self.NodeData.id)
	local position = node:GetElementPos(self.IsBuilding)

	self.gameObject.transform.position = position
end

function m:InitStateMachine(defaultCid)
	local stateMachineId = defaultCid
	local cfgElementEntityData = CfgElementEntityTable[self.EntityCid]

	if cfgElementEntityData.StateMachineId ~= 0 then
		stateMachineId = cfgElementEntityData.StateMachineId
	end

	DualTeamExploreModule.DualTeamExploreScene.StateMachineMgr:AddStateMachine(DualTeamExploreStateMachine, self, stateMachineId)
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

	position.x = gameObject.transform.position.x
	position.y = gameObject.transform.position.y + DualTeamExploreSceneApi:GetString("CameraLookHeroOffsetY")
	position.z = DualTeamExploreModule.DualTeamExploreScene.MainCamera.transform.position.z

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
		-- block empty
	end
end

function m:LookAtDirection(dir)
	if self.SpineGO == nil then
		self.TempDirection = dir

		return
	end

	self.SpineGO.transform.rotation = Quaternion.Euler(0, dir > 0 and 180 or 0, 0)
end

function m:SetActive(value)
	self.IsActive = value

	self:SetVisible(value)
end

function m:SetVisible(value)
	if self.gameObject ~= nil then
		local renderers = self.gameObject:GetComponentsInChildren(typeof(UnityEngine.Renderer))

		for i = 0, renderers.Length - 1 do
			local renderer = renderers[i]

			renderer.enabled = value
		end
	end
end

function m:TransportToTargetPos()
	logError("TransportToTargetPos not implement")
end

function m:Dispose()
	self:BaseDispose()
end

function m:BaseDispose()
	self:RemoveListeners()
	DualTeamExploreModule.DualTeamExploreScene.StateMachineMgr:RemoveStateMachine(self)
	self:HideEntity()
end

return m
