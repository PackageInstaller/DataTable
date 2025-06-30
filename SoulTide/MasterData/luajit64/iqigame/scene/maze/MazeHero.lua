-- chunkname: @IQIGame\\Scene\\Maze\\MazeHero.lua

local MazeElement = require("IQIGame.Scene.Maze.MazeElement")
local m = {
	HaveShowed = false,
	StepSoundPlayId = 0,
	StateElapsedTime = 0,
	FirstLoadComplete = false,
	PreActionExecutionType = 0,
	EntityId = 0,
	State = 0,
	IsLoading = false,
	LastElementCid = 0,
	MoveDuration = 0,
	DirectionIndicatorEntityId = 0,
	Disposed = false,
	IsHero = false,
	MoveElapsedTime = 0,
	NeedToRemove = false,
	NeedChangeState = false,
	PauseMoveReasonList = {}
}

m = Clone(MazeElement)
m.DelayUpdateAppearanceTimer = nil
m.ExpiredEntityIds = nil
m.MoveSpeed = 0
m.MoveFinalNode = nil
m.MoveNextNode = nil
m.GatherCid = 0
m.TransportTargetNodeId = nil
m.TransportStateMachineConfirmed = true
m.ElementEntityCid = 0
m.BuffPerformanceController = nil
m.SpineGO = nil

local BuffPerformanceController = require("IQIGame.Scene.Maze.Component.MazeElement.BuffPerformanceController")
local MazeStateMachine = require("IQIGame.Scene.Maze.StateMachine.MazeStateMachine")

function m.New(elementPOD, parentTrans)
	local obj = Clone(m)

	obj:Init(elementPOD, parentTrans)

	return obj
end

function m:Init(elementPOD, parentTrans)
	self.IsHero = true
	self.ExpiredEntityIds = {}
	self.ElementEntityCid = 0
	self.FirstLoadComplete = false
	self.LoopEffectCidPlayIdMap = {}

	if MazeDataModule.IsScrollMaze() then
		self.MoveSpeed = Constant.Number.IntMaxValue
	else
		self.MoveSpeed = tonumber(CfgMazeGlobalTable[1001].Parameter)
	end

	self.ElementPOD = elementPOD
	self.ParentTrans = parentTrans

	function self.DelegateOnShowElementEntitySuccess(sender, args)
		self:OnShowElementEntitySuccess(sender, args)
	end

	function self.DelegateOnShowElementEntityFailure(sender, args)
		self:OnShowElementEntityFailure(sender, args)
	end

	function self.DelegateOnNodeUpdate(nodeData)
		self:OnNodeUpdate(nodeData)
	end

	function self.DelegateOnSoulDeadOrRevive()
		self:OnSoulDeadOrRevive()
	end

	function self.DelegateOnChangeHero()
		self:OnChangeHero()
	end

	self.BuffPerformanceController = BuffPerformanceController.New(self)

	self:AddEventListeners()
end

function m:AddEventListeners()
	self:BaseAddEventListeners()
	EventDispatcher.AddEventListener(EventID.MazeSoulDead, self.DelegateOnSoulDeadOrRevive)
	EventDispatcher.AddEventListener(EventID.MazeSoulRevive, self.DelegateOnSoulDeadOrRevive)
	EventDispatcher.AddEventListener(EventID.MazeChangeHero, self.DelegateOnChangeHero)
end

function m:RemoveEventListeners()
	self:BaseRemoveEventListeners()
	EventDispatcher.RemoveEventListener(EventID.MazeSoulDead, self.DelegateOnSoulDeadOrRevive)
	EventDispatcher.RemoveEventListener(EventID.MazeSoulRevive, self.DelegateOnSoulDeadOrRevive)
	EventDispatcher.RemoveEventListener(EventID.MazeChangeHero, self.DelegateOnChangeHero)
end

function m:LoadOnInit(onLoadComplete)
	local data = MazeDataModule.GetSoulAvatarData()

	if data == nil then
		logError("找不到人偶形象数据")
		onLoadComplete(true)

		return
	end

	self.OnLoadComplete = onLoadComplete

	self:UpdateAppearance()
end

function m:UpdateAppearance()
	local soulAvatarData = MazeDataModule.GetSoulAvatarData()

	if soulAvatarData == nil then
		return
	end

	if soulAvatarData.entityCid == 0 then
		logError("队长人偶SoulAvatar.EntityId == 0")

		return
	end

	if self.ElementEntityCid == soulAvatarData.entityCid then
		return
	end

	self.ElementEntityCid = soulAvatarData.entityCid

	if self.gameObject ~= nil then
		MazeModule.MazeScene.StateMachineMgr:RemoveStateMachine(self)
	end

	self.BuffPerformanceController:StopAllEffect()

	self.IsLoading = true

	if self.EntityId ~= 0 then
		table.insert(self.ExpiredEntityIds, self.EntityId)
	end

	self:ShowElement(soulAvatarData.entityCid, self.ParentTrans, self.ElementPOD.NodeId, false)
end

function m:OnShow(entity)
	if entity == nil then
		logError("迷宫错误：IQIGame/Scene/Maze/MazeHero: attempt to index local 'entity' (a nil value)")

		return
	end

	if entity.Id == self.EntityId then
		for i = 1, #self.ExpiredEntityIds do
			GameEntry.Entity:HideEntityWithData(self.ExpiredEntityIds[i])
		end

		self.ExpiredEntityIds = {}
		self.gameObject = entity.gameObject
		self.SpineGO = self.gameObject:GetComponentInChildren(typeof(UnityEngine.Renderer)).gameObject

		MazeModule.MazeScene.StateMachineMgr:AddStateMachine(MazeStateMachine, self, 1000)

		local nextNodeData

		for i = 1, #self.NodeData.NextNodes do
			local nodeId = self.NodeData.NextNodes[i]

			if nodeId ~= 0 then
				nextNodeData = MazeDataModule.GetNodeDataById(nodeId)

				break
			end
		end

		if nextNodeData ~= nil then
			local dir = nextNodeData.x - self.gameObject.transform.position.x

			self:LookAtDirection(dir)
		end

		self.BuffPerformanceController:OnShow()

		self.HaveShowed = true
		self.IsLoading = false

		if self.OnLoadComplete ~= nil then
			self.OnLoadComplete(false)

			self.OnLoadComplete = nil
		end

		EventDispatcher.Dispatch(EventID.MazeLoadEntityComplete, self, self.IsHero and Constant.Maze.EntityTypeMazeHero or Constant.Maze.EntityTypeMazeElement)

		if not self.FirstLoadComplete then
			self.FirstLoadComplete = true

			local areaNodeData = MazeDataModule.GetNodeDataById(self.ElementPOD.NodeId)

			EventDispatcher.Dispatch(EventID.MazeElementCreate, self.ElementPOD, areaNodeData)
		end
	end
end

function m:StartTransport(nodeId)
	self.TransportTargetNodeId = nodeId
	self.TransportStateMachineConfirmed = false
end

function m:TransportToTargetPos()
	local nodeData = MazeDataModule.GetNodeDataById(self.TransportTargetNodeId)

	self.gameObject.transform.position = Vector3(nodeData.x, nodeData.y, 0)
	self.TransportStateMachineConfirmed = true

	self:SetNodeData(self.TransportTargetNodeId)
	MazeModule.MazeScene:SendMoveArriveOrder(self.TransportTargetNodeId)
end

function m:SetTransportArrived()
	self.TransportTargetNodeId = nil

	EventDispatcher.Dispatch(EventID.MazeHeroMove, self.gameObject.transform.position)
end

function m:OnSoulDeadOrRevive()
	self:DelayUpdateAppearance()
end

function m:OnChangeHero()
	self:DelayUpdateAppearance()
end

function m:DelayUpdateAppearance()
	if self.DelayUpdateAppearanceTimer ~= nil then
		self.DelayUpdateAppearanceTimer:Stop()
	end

	self.DelayUpdateAppearanceTimer = FrameTimer.New(function()
		self.DelayUpdateAppearanceTimer = nil

		self:UpdateAppearance()
	end, 1)

	self.DelayUpdateAppearanceTimer:Start()
end

function m:SetMoveNextNodeData(areaNodeData)
	self.MoveNextNode = areaNodeData
	self.MoveNextPosition = Vector3(areaNodeData.x, areaNodeData.y, 0)
end

function m:IsMoving()
	return not self:IsPauseMove() and self.MoveNextNode ~= nil
end

function m:StopMove(nodeId)
	local areaNodeData = MazeDataModule.GetNodeDataById(nodeId)
	local position = Vector3(areaNodeData.x, areaNodeData.y, 0)

	self.gameObject.transform.position = position
	self.MoveNextNode = nil
	self.MoveNextPosition = nil
	self.MoveFinalNode = nil
	self.MoveElapsedTime = 0

	EventDispatcher.Dispatch(EventID.MazeHeroStopMove)
end

function m:SetNodeData(nodeId)
	self.PrevNodeData = self.NodeData
	self.NodeData = MazeDataModule.GetNodeDataById(nodeId)
	self.ElementPOD.NodeId = nodeId
end

function m:LookAtDirection(dir)
	self.SpineGO.transform.rotation = Quaternion.Euler(0, dir > 0 and 180 or 0, 0)
end

function m:GetNodeIndex()
	return self.NodeData.XIndex, self.NodeData.YIndex
end

function m:GetPrevNodeIndex()
	if self.PrevNodeData then
		return self.PrevNodeData.XIndex, self.PrevNodeData.YIndex
	end

	return 0, 0
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
		local cfgMazeLevelResData = CfgMazeLevelResTable[MazeDataModule.MazeLevelResID]

		self.StepSoundPlayId = GameEntry.Sound:PlaySound(cfgMazeLevelResData.WalkSound, Constant.SoundGroup.ENVIRONMENT)
	end
end

function m:StopPlayStepSound()
	if self.StepSoundPlayId ~= 0 then
		GameEntry.Sound:StopSound(self.StepSoundPlayId)

		self.StepSoundPlayId = 0
	end
end

function m:IsHideByNodeEffect()
	return false
end

function m:RefreshLoopEffect(effectCid, needPlay)
	local effectPlayId = self.LoopEffectCidPlayIdMap[effectCid]

	if effectPlayId == nil and needPlay then
		self.LoopEffectCidPlayIdMap[effectCid] = self:PlayMountEffect(effectCid, Constant.MountPoint.PointRoot)
	elseif effectPlayId ~= nil and not needPlay then
		GameEntry.Effect:StopEffect(effectPlayId)

		self.LoopEffectCidPlayIdMap[effectCid] = nil
	end
end

function m:PlayMountEffect(effectCid, mountPointCid, delay)
	if delay == nil then
		delay = 0
	end

	return GameEntry.Effect:PlayMountPointEffect(effectCid, mountPointCid, self.EntityId, self.gameObject, delay, 0, 0, LuaCodeInterface.SortingLayerNameToID("Element"), self.gameObject:GetComponentInChildren(typeof(UnityEngine.Renderer)).sortingOrder, 1, true)
end

function m:Dispose()
	if self.Disposed then
		logError("销毁元素错误，元素已被销毁。")

		return
	end

	self.Disposed = true

	self:RemoveEventListeners()

	if self.DelayUpdateAppearanceTimer ~= nil then
		self.DelayUpdateAppearanceTimer:Stop()

		self.DelayUpdateAppearanceTimer = nil
	end

	self.BuffPerformanceController:Dispose()
	self:BaseDispose()
end

return m
