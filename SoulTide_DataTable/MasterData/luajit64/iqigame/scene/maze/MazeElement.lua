-- chunkname: @IQIGame\\Scene\\Maze\\MazeElement.lua

local MazeStateMachine = require("IQIGame.Scene.Maze.StateMachine.MazeStateMachine")
local MazeElementWeakTypeGroup = require("IQIGame.Scene.Maze.MazeElementWeakTypeGroup")
local m = {
	HaveShowed = false,
	StepSoundPlayId = 0,
	PreActionExecutionType = 0,
	WeakTypeGroupEntityId = 0,
	FirstLoadComplete = false,
	EntityId = 0,
	State = 0,
	IsLoading = false,
	LastElementCid = 0,
	MoveDuration = 0,
	StateLoopTotalDuration = 0,
	DirectionIndicatorEntityId = 0,
	Disposed = false,
	IsHero = false,
	MoveElapsedTime = 0,
	NeedToRemove = false,
	NeedChangeState = false,
	DIR_PRIORITY = {
		{
			-1,
			-1
		},
		{
			-1,
			0
		},
		{
			-1,
			1
		},
		{
			0,
			1
		},
		{
			1,
			1
		},
		{
			1,
			0
		},
		{
			1,
			-1
		},
		{
			0,
			-1
		}
	},
	PauseMoveReasonList = {}
}

function m.New(elementPOD, parentTrans)
	local obj = Clone(m)

	obj:Init(elementPOD, parentTrans)

	return obj
end

function m:Init(elementPOD, parentTrans)
	self.ElementPOD = elementPOD
	self.ParentTrans = parentTrans
	self.UpdateElementFuncQueue = Queue.New()

	function self.DelegateOnShowElementEntitySuccess(sender, args)
		self:OnShowElementEntitySuccess(sender, args)
	end

	function self.DelegateOnShowElementEntityFailure(sender, args)
		self:OnShowElementEntityFailure(sender, args)
	end

	function self.DelegateOnNodeUpdate(nodeData, isNewActive)
		self:OnNodeUpdate(nodeData, isNewActive)
	end

	function self.DelegateOnElementUpdated(elementPod, oldNodeId)
		self:OnElementUpdated(elementPod, oldNodeId)
	end

	self:AddEventListeners()

	local cfgElementAllData = CfgElementAllTable[self.ElementPOD.CID]

	self.IsLoading = true
	self.LastElementCid = self.ElementPOD.CID

	self:Refresh(cfgElementAllData, parentTrans, self.ElementPOD.NodeId, self.ElementPOD.PrePathNodeId)
end

function m:Refresh(cfgElementAllData, parentTrans, nodeId, prePathNodeId)
	self.CfgElementAllData = cfgElementAllData
	self.NeedChangeState = cfgElementAllData.IsChangeState
	self.ChangeStateDuration = {}

	for i = 1, #cfgElementAllData.ChangeStateDuration do
		self.ChangeStateDuration[i] = cfgElementAllData.ChangeStateDuration[i]
	end

	if self.NeedChangeState then
		if cfgElementAllData.InitialStateDuration ~= 0 then
			self.InitialStateDuration = cfgElementAllData.InitialStateDuration
		end

		self.StateLoopTotalDuration = 0

		for i = 1, #self.ChangeStateDuration do
			self.StateLoopTotalDuration = self.StateLoopTotalDuration + self.ChangeStateDuration[i]
		end
	end

	self:ShowElement(cfgElementAllData.EntityId, parentTrans, nodeId, self.CfgElementAllData.IgnoreMask)

	if cfgElementAllData.CanMove then
		self.NextMoveNode = self:GetNextMoveNode(prePathNodeId)

		if self.DirectionIndicatorEntityId == 0 then
			self:ShowMoveElementDirection()
		end
	else
		self:HideDir()
	end
end

function m:ShowElement(entityCid, parentTrans, nodeId, ignoreMask)
	self.EntityId = GameEntry.Entity:GenerateEntityID()
	self.NodeData = MazeDataModule.GetNodeDataById(nodeId)

	local localPosition = Vector3(self.NodeData.x, self.NodeData.y, 0)

	GameEntry.Entity:ShowElement(self.EntityId, entityCid, 0, parentTrans, localPosition, nil, not ignoreMask)
end

function m:AddEventListeners()
	self:BaseAddEventListeners()
	EventDispatcher.AddEventListener(EventID.MazeUpdateElement, self.DelegateOnElementUpdated)
end

function m:RemoveEventListeners()
	self:BaseRemoveEventListeners()
	EventDispatcher.RemoveEventListener(EventID.MazeUpdateElement, self.DelegateOnElementUpdated)
end

function m:BaseAddEventListeners()
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntityFailureEventArgs.EventId, self.DelegateOnShowElementEntityFailure)
	EventDispatcher.AddEventListener(EventID.MazeUpdateNodeData, self.DelegateOnNodeUpdate)
end

function m:BaseRemoveEventListeners()
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntityFailureEventArgs.EventId, self.DelegateOnShowElementEntityFailure)
	EventDispatcher.RemoveEventListener(EventID.MazeUpdateNodeData, self.DelegateOnNodeUpdate)
end

function m:OnShowElementEntitySuccess(sender, args)
	self:OnShow(args.Entity)
end

function m:OnShowElementEntityFailure(sender, args)
	if args.EntityId == self.EntityId then
		self.IsLoading = false

		EventDispatcher.Dispatch(EventID.MazeLoadEntityComplete, self, self.IsHero and Constant.Maze.EntityTypeMazeHero or Constant.Maze.EntityTypeMazeElement)
		logError("MazeElement资源加载失败，资源路径：" .. tostring(args.EntityAssetName))
	end
end

function m:OnShow(entity)
	if entity == nil then
		logError("迷宫错误：IQIGame/Scene/Maze/MazeElement: attempt to index local 'entity' (a nil value)")

		return
	end

	if entity.Id == self.EntityId then
		self.gameObject = entity.gameObject

		local stateMachineId = 1002
		local cfgElementAllData = CfgElementAllTable[self.ElementPOD.CID]
		local cfgElementEntityData = CfgElementEntityTable[cfgElementAllData.EntityId]

		if cfgElementEntityData.StateMachineId ~= 0 then
			stateMachineId = cfgElementEntityData.StateMachineId
		end

		MazeModule.MazeScene.StateMachineMgr:AddStateMachine(MazeStateMachine, self, stateMachineId)
		self:UpdateByNode()
		self:UpdateMoveTriggerCount()
		self:UpdateNumber(cfgElementEntityData.ShowNumbers)

		self.IsLoading = false
		self.HaveShowed = true

		EventDispatcher.Dispatch(EventID.MazeLoadEntityComplete, self, self.IsHero and Constant.Maze.EntityTypeMazeHero or Constant.Maze.EntityTypeMazeElement)

		if not self.FirstLoadComplete then
			self.FirstLoadComplete = true

			EventDispatcher.Dispatch(EventID.MazeElementCreate, self.ElementPOD, self.NodeData)
		end

		if self.ShowDirectIndicatorAfterShowSelf ~= nil then
			self.ShowDirectIndicatorAfterShowSelf()

			self.ShowDirectIndicatorAfterShowSelf = nil
		end

		if self.UpdateNodeFunc ~= nil then
			self.UpdateNodeFunc()

			self.UpdateNodeFunc = nil
		end

		if cfgElementAllData.WeakTypeShow == nil or #cfgElementAllData.WeakTypeShow == 0 then
			self:HideWeakTypeGroup()
		else
			self:ShowWeakTypeGroup(self.gameObject, Constant.MountPoint.PointHead, self.EntityId)
		end
	elseif entity.Id == self.DirectionIndicatorEntityId then
		self.DirectionIndicatorObj = entity.gameObject

		EventDispatcher.Dispatch(EventID.MazeNotifyMaskManually, self.DirectionIndicatorObj, false)

		local function showIndicator()
			self:DirectionIndicatorIfNodeIsActive()
			self:UpdateElementDirection()
		end

		if self.gameObject == nil then
			self.ShowDirectIndicatorAfterShowSelf = showIndicator
		else
			showIndicator()
		end
	elseif entity.Id == self.WeakTypeGroupEntityId then
		EventDispatcher.Dispatch(EventID.MazeNotifyMaskManually, entity.gameObject, false)

		local cfgElementAllData = CfgElementAllTable[self.ElementPOD.CID]

		self.WeakTypeGroup = MazeElementWeakTypeGroup.New(entity.gameObject)

		self.WeakTypeGroup:SetData(cfgElementAllData.WeakTypeShow)
		self.WeakTypeGroup:SetVisible(self.IsVisible)
	end
end

function m:UpdateMoveTriggerCount()
	if self.gameObject == nil then
		return
	end

	local textField = self.gameObject:GetComponentInChildren(typeof(UnityEngine.UI.Text))

	if textField ~= nil then
		textField.text = self.ElementPOD.MoveTriggerCount
	end
end

function m:OnNodeUpdate(nodeData, isNewActive)
	if self.NodeData.NodeId == nodeData.NodeId then
		if self.DelayRefreshAfterNodeUpdateTimer ~= nil then
			self.DelayRefreshAfterNodeUpdateTimer:Stop()

			self.DelayRefreshAfterNodeUpdateTimer = nil
		end

		self.DelayRefreshAfterNodeUpdateTimer = Timer.New(function()
			self.DelayRefreshAfterNodeUpdateTimer = nil

			self:UpdateByNode()
			self:DirectionIndicatorIfNodeIsActive()
		end, 0.8)

		self.DelayRefreshAfterNodeUpdateTimer:Start()
	end
end

function m:UpdateByNode(isActive)
	if isActive == nil then
		isActive = self.NodeData.IsActive
	end

	self:SetVisible(isActive and not self:IsHideByNodeEffect() and MazeDataModule.IsShowOnLayer(self.NodeData))
end

function m:UpdateNumber(value)
	local numComponent = self.gameObject:GetComponentInChildren(typeof(IQIGame.Onigao.Game.ImageNumberEntityComponent))

	if numComponent ~= nil then
		for i = 0, numComponent.transform.childCount - 1 do
			local child = numComponent.transform:GetChild(i)

			child.gameObject:SetActive(value ~= -1)
		end

		if value ~= -1 then
			numComponent:SetNumber(value)
		end
	end
end

function m:IsHideByNodeEffect()
	local isHideElement = false

	if self.NodeData.EffectType ~= 0 then
		local cfgMazePathNodeEffectData = CfgMazePathNodeEffectTable[self.NodeData.EffectType]

		isHideElement = cfgMazePathNodeEffectData.IsElementHide
	end

	return isHideElement
end

function m:SetVisible(value)
	self.IsVisible = value

	if self.gameObject ~= nil then
		local renderers = self.gameObject:GetComponentsInChildren(typeof(UnityEngine.Renderer), true)

		for i = 0, renderers.Length - 1 do
			renderers[i].enabled = value
		end
	end

	if self.DirectionIndicatorObj ~= nil then
		local renderers = self.DirectionIndicatorObj:GetComponentsInChildren(typeof(UnityEngine.Renderer), true)

		for i = 0, renderers.Length - 1 do
			renderers[i].enabled = value
		end
	end

	if self.WeakTypeGroup ~= nil then
		self.WeakTypeGroup:SetVisible(value)
	end
end

function m:OnElementUpdated(elementPOD, oldNodeId)
	if self.ElementPOD.ID == elementPOD.ID then
		local cfgElementAllData = CfgElementAllTable[elementPOD.CID]

		if self.ElementPOD.NodeId ~= oldNodeId then
			if not cfgElementAllData.CanMove then
				logError("更新元素错误：元素[" .. elementPOD.CID .. "]不能移动（ElementAll.CanMove == false），但ElementPOD.NodeId发生了变化。MazeCid = " .. MazeDataModule.MazeInstanceID)

				return
			end

			local function updateNode()
				self.MoveStartPosition = self.gameObject.transform.position
				self.NodeData = MazeDataModule.GetNodeDataById(elementPOD.NodeId)
				self.MoveNextPosition = Vector3(self.NodeData.x, self.NodeData.y, 0)
				self.MoveDuration = MazeModule.MazeScene.Hero.MoveDuration
				self.MoveElapsedTime = 0

				local oldNodeData = MazeDataModule.GetNodeDataById(oldNodeId)

				if math.abs(oldNodeData.XIndex - self.NodeData.XIndex) > 1 or math.abs(oldNodeData.YIndex - self.NodeData.YIndex) > 1 then
					self.gameObject.transform.position = self.MoveNextPosition

					self:StopMove()
				end
			end

			if self.gameObject == nil then
				self.UpdateNodeFunc = updateNode
			else
				updateNode()
			end
		end

		local elementPODCid = elementPOD.CID
		local elementPODNodeId = elementPOD.NodeId
		local elementPODPrePathNodeId = elementPOD.PrePathNodeId

		local function updateElementFunc()
			if self.LastElementCid ~= elementPODCid then
				MazeModule.MazeScene.StateMachineMgr:RemoveStateMachine(self)
				GameEntry.Entity:HideEntityWithData(self.EntityId)

				self.EntityId = 0

				if self.DelayRefreshAfterNodeUpdateTimer ~= nil then
					self.DelayRefreshAfterNodeUpdateTimer:Stop()

					self.DelayRefreshAfterNodeUpdateTimer = nil
				end

				self.gameObject = nil
				self.LastElementCid = elementPODCid

				self:Refresh(cfgElementAllData, self.ParentTrans, elementPODNodeId, elementPODPrePathNodeId)
			end
		end

		self.UpdateElementFuncQueue:Enqueue(updateElementFunc)
		self:UpdateMoveTriggerCount()

		if cfgElementAllData.CanMove then
			self.NextMoveNode = self:GetNextMoveNode(oldNodeId)

			if self.DirectionIndicatorObj ~= nil then
				self.DirectionIndicatorObj:SetActive(false)
			end
		end
	end
end

function m:GetNextMoveNode(elementLastNodeId)
	local canMoveNodes = {}

	for i = 1, #self.NodeData.NextNodes do
		local nodeId = self.NodeData.NextNodes[i]

		if nodeId ~= 0 then
			local nextNodeData = MazeDataModule.GetNodeDataById(nodeId)
			local cfgMazePathNodeData = CfgMazePathNodeTable[nextNodeData.CID]

			if cfgMazePathNodeData.PatrolPoint == 1 then
				table.insert(canMoveNodes, nextNodeData)
			end
		end
	end

	for i = 1, #self.NodeData.ParentNodes do
		local nodeId = self.NodeData.ParentNodes[i]

		if nodeId ~= 0 then
			local nextNodeData = MazeDataModule.GetNodeDataById(nodeId)
			local cfgMazePathNodeData = CfgMazePathNodeTable[nextNodeData.CID]

			if cfgMazePathNodeData.PatrolPoint == 1 then
				table.insert(canMoveNodes, nextNodeData)
			end
		end
	end

	if #canMoveNodes == 0 then
		local directionIndicatorName = ""

		if self.DirectionIndicatorObj ~= nil then
			if LuaCodeInterface.GameObjIsDestroy(self.DirectionIndicatorObj) then
				directionIndicatorName = "Destroyed"
			else
				directionIndicatorName = self.DirectionIndicatorObj.name
			end
		else
			directionIndicatorName = "nil"
		end

		xpcall(function()
			local cfgElementAllData = CfgElementAllTable[self.ElementPOD.CID]

			logError("在与当前节点关联的节点中，找不到任何可移动的节点。Element cid：" .. self.ElementPOD.CID .. "，当前节点 cid：" .. self.NodeData.CID .. "，当前迷宫：" .. MazeDataModule.MazeInstanceID .. " self.DirectionIndicatorEntityId " .. self.DirectionIndicatorEntityId .. " self.DirectionIndicatorObj " .. directionIndicatorName .. " CanMove " .. tostring(cfgElementAllData.CanMove))
		end, function(msg)
			logError(tostring(msg))
		end)

		return nil
	end

	local targetNode

	if elementLastNodeId == 0 then
		targetNode = canMoveNodes[1]
	else
		local lastNodeData = MazeDataModule.GetNodeDataById(elementLastNodeId)
		local xDis = lastNodeData.XIndex - self.NodeData.XIndex
		local yDis = lastNodeData.YIndex - self.NodeData.YIndex
		local index = 0

		for i = 1, #m.DIR_PRIORITY do
			if m.DIR_PRIORITY[i][1] == xDis and m.DIR_PRIORITY[i][2] == yDis then
				index = i

				break
			end
		end

		for i = index + 1, #m.DIR_PRIORITY do
			if targetNode ~= nil then
				break
			end

			for j = 1, #canMoveNodes do
				local canMoveNode = canMoveNodes[j]

				if self.NodeData.XIndex + m.DIR_PRIORITY[i][1] == canMoveNode.XIndex and self.NodeData.YIndex + m.DIR_PRIORITY[i][2] == canMoveNode.YIndex then
					targetNode = canMoveNode

					break
				end
			end
		end

		for i = 1, index do
			if targetNode ~= nil then
				break
			end

			for j = 1, #canMoveNodes do
				local canMoveNode = canMoveNodes[j]

				if self.NodeData.XIndex + m.DIR_PRIORITY[i][1] == canMoveNode.XIndex and self.NodeData.YIndex + m.DIR_PRIORITY[i][2] == canMoveNode.YIndex then
					targetNode = canMoveNode

					break
				end
			end
		end
	end

	if targetNode == nil then
		logError("找不到移动怪的下一个目标节点")
	end

	return targetNode
end

function m:ShowMoveElementDirection()
	local path = "Assets/03_Prefabs/ART_Prefabs/Scene/Common/MoveDirection.prefab"

	self.DirectionIndicatorEntityId = GameEntry.Entity:GenerateEntityID()

	GameEntry.Entity:ShowCommonEntity(self.DirectionIndicatorEntityId, path, 0, MazeModule.MazeScene.ElementFootRoot, Vector3.zero)
end

function m:ShowWeakTypeGroup(parentGO, mountId, parentEntityId)
	local path = "Assets/03_Prefabs/ART_Prefabs/Element/Maze/Element/Common/WeakTypeGroup.prefab"

	self.WeakTypeGroupEntityId = GameEntry.Entity:GenerateEntityID()

	local mountPointTrans = getMountPoint(parentGO.transform, mountId)

	GameEntry.Entity:ShowCommonEntity(self.WeakTypeGroupEntityId, path, parentEntityId, mountPointTrans, Vector3.zero)
end

function m:DirectionIndicatorIfNodeIsActive()
	if self.DirectionIndicatorObj ~= nil then
		self.DirectionIndicatorObj:SetActive(self.NodeData.IsActive and self.MoveNextPosition == nil)
	end
end

function m:UpdateElementDirection()
	if self.gameObject ~= nil and self.DirectionIndicatorObj ~= nil then
		local localPosition = Vector3(self.NodeData.x, self.NodeData.y, 0)

		self.DirectionIndicatorObj.transform.localPosition = localPosition

		if self.NextMoveNode == nil then
			logError("self.NextMoveNode == nil.")

			self.NextMoveNode = self:GetNextMoveNode(self.ElementPOD.PrePathNodeId)
		end

		local fromStartToEnd = Vector3(self.NextMoveNode.x, self.NextMoveNode.y, 0) - localPosition
		local rotation = Quaternion.LookRotation(fromStartToEnd, Vector3.right)

		if rotation == nil then
			rotation = Quaternion.identity
		end

		self.DirectionIndicatorObj.transform.rotation = rotation

		local dir = self.NextMoveNode.x - self.NodeData.x

		self.gameObject.transform.rotation = Quaternion.Euler(0, dir > 0 and 180 or 0, 0)
	end
end

function m:StopMove()
	self.MoveStartPosition = nil
	self.MoveNextPosition = nil
	self.MoveDuration = 0
	self.MoveElapsedTime = 0

	self:DirectionIndicatorIfNodeIsActive()
	self:UpdateElementDirection()
end

function m:IsMoving()
	return not self:IsPauseMove() and self.MoveNextPosition ~= nil
end

function m:IsPauseMove()
	return #self.PauseMoveReasonList > 0
end

function m:GetCameraFocusPosition()
	local position = Vector3.zero

	if self.HaveShowed then
		position.x = self.gameObject.transform.position.x
		position.y = self.gameObject.transform.position.y + MazeSceneApi:GetString("CameraLookHeroOffsetY")
		position.z = MazeModule.MazeScene.MainCamera.transform.position.z
	else
		logError("logic error, must init  " .. tostring(self.HaveShowed))
	end

	return position
end

function m:PauseMove(reason)
	self:SetPauseMove(reason, true)
end

function m:ResumeMove(reason)
	self:SetPauseMove(reason, false)
end

function m:SetPauseMove(reason, isLock)
	local index = table.indexOf(self.PauseMoveReasonList, reason)

	if isLock and index == -1 then
		table.insert(self.PauseMoveReasonList, reason)
	elseif not isLock and index ~= -1 then
		table.remove(self.PauseMoveReasonList, index)
	end
end

function m:Update()
	if self.NeedChangeState then
		local durationRatio = MazeDataModule.ChangeStateElementRatio
		local timeAfterInitDuration = UnityEngine.Time.realtimeSinceStartup - self.InitialStateDuration * durationRatio
		local elapsedTimeInLoop = timeAfterInitDuration % (self.StateLoopTotalDuration * durationRatio)
		local curState
		local tempTime = 0
		local idx = self.CfgElementAllData.InitialState == 0 and 1 or self.CfgElementAllData.InitialState

		idx = idx + 1

		if idx > #self.ChangeStateDuration then
			idx = 1
		end

		for i = 1, #self.ChangeStateDuration do
			curState = idx
			tempTime = tempTime + self.ChangeStateDuration[idx] * durationRatio

			if elapsedTimeInLoop < tempTime then
				break
			end

			idx = idx + 1

			if idx > #self.ChangeStateDuration then
				idx = 1
			end
		end

		if self.State == 0 or curState ~= self.State then
			self.State = curState

			if MazeModule.MazeScene.Hero.NodeData.NodeId == self.NodeData.NodeId and not MazeModule.MazeScene.Hero:IsMoving() then
				MazeModule.MazeScene:SendStateTriggerOrder(self.ElementPOD.ID, self.State)
			end
		end
	end

	if self.UpdateElementFuncQueue.Size > 0 then
		local updateElementFunc = self.UpdateElementFuncQueue:Dequeue()

		updateElementFunc()
	end
end

function m:HideDir()
	if self.DirectionIndicatorEntityId ~= 0 then
		self.DirectionIndicatorObj:SetActive(true)
		EventDispatcher.Dispatch(EventID.MazeNotifyMaskManually, self.DirectionIndicatorObj, true)

		self.DirectionIndicatorObj = nil

		local directionIndicatorEntityId = self.DirectionIndicatorEntityId

		self.DirectionIndicatorEntityId = 0

		GameEntry.Entity:HideEntityWithData(directionIndicatorEntityId)
	end
end

function m:HideWeakTypeGroup()
	if self.WeakTypeGroupEntityId ~= 0 then
		EventDispatcher.Dispatch(EventID.MazeNotifyMaskManually, self.WeakTypeGroup.View, true)

		local entityId = self.WeakTypeGroupEntityId

		self.WeakTypeGroupEntityId = 0

		self.WeakTypeGroup:SetVisible(true)
		self.WeakTypeGroup:Dispose()

		self.WeakTypeGroup = nil

		GameEntry.Entity:HideEntityWithData(entityId)
	end
end

function m:Dispose()
	if self.Disposed then
		logError("销毁元素错误，元素已被销毁。")

		return
	end

	self.Disposed = true

	self:RemoveEventListeners()
	self:BaseDispose()
end

function m:BaseDispose()
	if self.DelayRefreshAfterNodeUpdateTimer ~= nil then
		self.DelayRefreshAfterNodeUpdateTimer:Stop()

		self.DelayRefreshAfterNodeUpdateTimer = nil
	end

	MazeModule.MazeScene.StateMachineMgr:RemoveStateMachine(self)
	GameEntry.Entity:HideEntityWithData(self.EntityId)

	self.EntityId = 0

	self:HideDir()
	self:HideWeakTypeGroup()
	EventDispatcher.Dispatch(EventID.MazeElementDispose, self.ElementPOD)

	self.gameObject = nil
	self.ElementPOD = nil
	self.NodeData = nil
	self.ParentTrans = nil
	self.DirectionIndicatorObj = nil
	self.NextMoveNode = nil
end

return m
