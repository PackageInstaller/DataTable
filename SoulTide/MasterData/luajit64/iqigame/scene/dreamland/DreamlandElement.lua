-- chunkname: @IQIGame\\Scene\\Dreamland\\DreamlandElement.lua

local m = {
	IsHero = false,
	IsRemoved = false,
	EntityId = 0,
	TempDirection = 0,
	EntityCid = 0,
	ExecutionStates = {}
}
local DreamlandStateMachine = require("IQIGame.Scene.Dreamland.StateMachine.DreamlandStateMachine")

function m.New(entityId, elementRoot, node)
	local obj = Clone(m)

	obj:Init(entityId, elementRoot, node)

	return obj
end

function m:Init(entityId, elementRoot, node)
	self.Node = node

	self:BaseInit(entityId, elementRoot)
end

function m:BaseInit(entityId, elementRoot)
	self.EntityCid = entityId

	function self.DelegateOnShowElementEntitySuccess(sender, args)
		self:OnShowElementEntitySuccess(sender, args)
	end

	function self.DelegateOnShowElementEntityFailure(sender, args)
		self:OnShowElementEntityFailure(sender, args)
	end

	self:AddListeners()
	self:ShowElement(entityId, elementRoot)
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

function m:ShowElement(entityCid, elementRoot)
	self.EntityCid = entityCid
	self.EntityId = GameEntry.Entity:GenerateEntityID()

	local localPosition

	if self.Node ~= nil then
		localPosition = self.Node:GetNpcNodePos()
	else
		localPosition = Vector3.zero
	end

	GameEntry.Entity:ShowElement(self.EntityId, entityCid, 0, elementRoot, localPosition)
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
		self.SpineGO = self.gameObject:GetComponentInChildren(typeof(UnityEngine.Renderer)).gameObject

		if self.TempDirection ~= 0 then
			self:LookAtDirection(self.TempDirection)

			self.TempDirection = 0
		end

		self:OnShow()
	end
end

function m:OnShowElementEntityFailure(sender, args)
	if args.EntityId == self.EntityId then
		logError("load maze element error")
	end
end

function m:OnShow()
	self:InitStateMachine(1011)
end

function m:InitStateMachine(defaultCid)
	local stateMachineId = defaultCid
	local cfgElementEntityData = CfgElementEntityTable[self.EntityCid]

	if cfgElementEntityData.StateMachineId ~= 0 then
		stateMachineId = cfgElementEntityData.StateMachineId
	end

	DreamlandModule.DreamlandScene.StateMachineMgr:AddStateMachine(DreamlandStateMachine, self, stateMachineId)
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
		gameObject = self.Node.View
	end

	position.x = gameObject.transform.position.x
	position.y = gameObject.transform.position.y + DreamlandSceneApi:GetString("CameraLookHeroOffsetY")
	position.z = DreamlandModule.DreamlandScene.MainCamera.transform.position.z

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
		EventDispatcher.Dispatch(EventID.DreamlandStopInteract, self, changedStates)
	end
end

function m:SetPrepared()
	EventDispatcher.Dispatch(EventID.DreamlandElementPrepared, self)
end

function m:LookAtDirection(dir)
	if self.SpineGO == nil then
		self.TempDirection = dir

		return
	end

	self.SpineGO.transform.rotation = Quaternion.Euler(0, dir > 0 and 180 or 0, 0)
end

function m:Dispose()
	self:BaseDispose()
end

function m:BaseDispose()
	self:RemoveListeners()
	DreamlandModule.DreamlandScene.StateMachineMgr:RemoveStateMachine(self)
	self:HideEntity()
end

return m
