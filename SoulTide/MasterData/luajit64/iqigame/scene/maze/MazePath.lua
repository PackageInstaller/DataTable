-- chunkname: @IQIGame\\Scene\\Maze\\MazePath.lua

local m = {
	GAP = 0.8,
	EntityId = 0,
	Length = 0,
	PlayingActiveAnim = 0,
	IsEndNodeTransparent = false,
	TYPE_COMPLETE = 2,
	IsStartNodeTransparent = false,
	IsLoading = false,
	ACTIVE_ANIM_TYPE_PRE = 1,
	NeedToRemove = false,
	TYPE_NORMAL = 1,
	ACTIVE_ANIM_TYPE_NEXT = 2,
	SpriteRenderers = {}
}

function m.New(areaNodeData, endNodeData, parentTrans)
	local obj = Clone(m)

	obj:Init(areaNodeData, endNodeData, parentTrans)

	return obj
end

function m:Init(startNodeData, endNodeData, parentTrans)
	self.StartNodeData = startNodeData
	self.EndNodeData = endNodeData

	function self.DelegateOnShowElementEntitySuccess(sender, args)
		self:OnShowElementEntitySuccess(sender, args)
	end

	function self.DelegateOnShowElementEntityFailure(sender, args)
		self:OnShowElementEntityFailure(sender, args)
	end

	function self.DelegateOnNodeUpdate(nodeData, isNewActive)
		self:OnNodeUpdate(nodeData, isNewActive)
	end

	self:AddEventListeners()

	self.EntityId = GameEntry.Entity:GenerateEntityID()

	local cfgMazeLevelResData = CfgMazeLevelResTable[MazeDataModule.MazeLevelResID]
	local position = Vector3(startNodeData.x, startNodeData.y, 0)

	self.IsLoading = true

	local startNodeCfg = CfgMazePathNodeTable[self.StartNodeData.CID]
	local endNodeCfg = CfgMazePathNodeTable[self.EndNodeData.CID]

	self.IsStartNodeTransparent = startNodeCfg.Type == Constant.Maze.NodeTypeSecretPassage
	self.IsEndNodeTransparent = endNodeCfg.Type == Constant.Maze.NodeTypeSecretPassage

	GameEntry.Entity:ShowMazePath(self.EntityId, "Assets/03_Prefabs/ART_Prefabs/Scene" .. cfgMazeLevelResData.PathPrefab .. ".prefab", 0, parentTrans, position)
end

function m:AddEventListeners()
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntityFailureEventArgs.EventId, self.DelegateOnShowElementEntityFailure)
	EventDispatcher.AddEventListener(EventID.MazeUpdateNodeData, self.DelegateOnNodeUpdate)
end

function m:RemoveEventListeners()
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntityFailureEventArgs.EventId, self.DelegateOnShowElementEntityFailure)
	EventDispatcher.RemoveEventListener(EventID.MazeUpdateNodeData, self.DelegateOnNodeUpdate)
end

function m:OnShowElementEntitySuccess(sender, args)
	if args.Entity.Id == self.EntityId then
		GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
		GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntityFailureEventArgs.EventId, self.DelegateOnShowElementEntityFailure)

		self.gameObject = args.Entity.gameObject

		self:OnShow()

		self.IsLoading = false

		EventDispatcher.Dispatch(EventID.MazeLoadEntityComplete, self, Constant.Maze.EntityTypeMazePath)
	end
end

function m:OnShowElementEntityFailure(sender, args)
	if args.Entity.Id == self.EntityId then
		GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
		GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntityFailureEventArgs.EventId, self.DelegateOnShowElementEntityFailure)

		self.IsLoading = false

		EventDispatcher.Dispatch(EventID.MazeLoadEntityComplete, self, Constant.Maze.EntityTypeMazePath)
	end
end

function m:OnShow()
	local normalView = self.gameObject.transform:Find("Path_Normal").gameObject
	local completeView = self.gameObject.transform:Find("Path_Complete").gameObject

	self.SpriteRenderers[m.TYPE_NORMAL] = normalView:GetComponentInChildren(typeof(UnityEngine.SpriteRenderer))
	self.SpriteRenderers[m.TYPE_COMPLETE] = completeView:GetComponentInChildren(typeof(UnityEngine.SpriteRenderer))

	local fromStartToEnd = Vector3(self.EndNodeData.x, self.EndNodeData.y, 0) - Vector3(self.StartNodeData.x, self.StartNodeData.y, 0)
	local rotation = Quaternion.LookRotation(fromStartToEnd, Vector3.right)

	self.gameObject.transform.rotation = rotation
	self.Length = fromStartToEnd.magnitude
	self.AdjustedLength = self.Length - m.GAP

	local isAllNodeActive = self.StartNodeData.IsActive and self.EndNodeData.IsActive
	local isCompleteState = self.StartNodeData.IsComplete and self.EndNodeData.IsComplete

	for i = 1, #self.SpriteRenderers do
		self.SpriteRenderers[i].sortingOrder = -1
		self.SpriteRenderers[i].enabled = isAllNodeActive and (i == m.TYPE_NORMAL and not isCompleteState or i == m.TYPE_COMPLETE and isCompleteState)
	end

	self:RefreshVisible(isAllNodeActive, isCompleteState)
	self:Resize(isAllNodeActive and 1 or 0)

	local isTransparent = self.IsStartNodeTransparent and not self.StartNodeData.IsComplete or self.IsEndNodeTransparent and not self.EndNodeData.IsComplete

	EntityShowUtil.SetAlpha(self.SpriteRenderers[m.TYPE_NORMAL].gameObject, isTransparent and MazeSceneApi:GetString("Type3NodeAlpha") or 1)
	EventDispatcher.Dispatch(EventID.MazePathCreate, self.gameObject.transform.localPosition, rotation, self.Length, self.StartNodeData, self.EndNodeData)
end

function m:RefreshVisible(isAllNodeActive, isCompleteState)
	if self.gameObject == nil then
		return
	end

	local isPathVisible = false

	for i = 1, #self.SpriteRenderers do
		local isVisible = isAllNodeActive and (i == m.TYPE_NORMAL and not isCompleteState or i == m.TYPE_COMPLETE and isCompleteState)

		self.SpriteRenderers[i].enabled = isVisible

		if isVisible then
			isPathVisible = true
		end
	end

	self.IsVisible = isPathVisible
end

function m:Resize(ratio)
	if self.IsEndNodeTransparent then
		ratio = 1
	end

	for i = 1, #self.SpriteRenderers do
		local size = self.SpriteRenderers[i].size

		size.x = self.AdjustedLength * ratio
		self.SpriteRenderers[i].size = size

		local zPos = 0

		if self.PlayingActiveAnim == m.ACTIVE_ANIM_TYPE_PRE then
			zPos = self.Length - size.x * 0.5 - m.GAP * 0.5
		else
			zPos = size.x * 0.5 + m.GAP * 0.5
		end

		local position = Vector3(0, 0, zPos)

		self.SpriteRenderers[i].transform.localPosition = position
	end
end

function m:OnNodeUpdate(nodeData, isNodeNewActive)
	if nodeData.NodeId == self.StartNodeData.NodeId or nodeData.NodeId == self.EndNodeData.NodeId then
		local isAllNodeActive = self.StartNodeData.IsActive and self.EndNodeData.IsActive
		local isCompleteState = self.StartNodeData.IsComplete and self.EndNodeData.IsComplete

		if self.PlayingActiveAnim == 0 and isNodeNewActive and isAllNodeActive then
			if nodeData.NodeId == self.StartNodeData.NodeId then
				self.PlayingActiveAnim = m.ACTIVE_ANIM_TYPE_PRE
			else
				self.PlayingActiveAnim = m.ACTIVE_ANIM_TYPE_NEXT
			end
		end

		self:RefreshVisible(isAllNodeActive, isCompleteState)

		local isTransparent = self.IsStartNodeTransparent and not self.StartNodeData.IsComplete or self.IsEndNodeTransparent and not self.EndNodeData.IsComplete

		EntityShowUtil.SetAlpha(self.SpriteRenderers[m.TYPE_NORMAL].gameObject, isTransparent and MazeSceneApi:GetString("Type3NodeAlpha") or 1)
	end
end

function m:Update()
	if self.gameObject == nil then
		return
	end

	if self.PlayingActiveAnim ~= 0 then
		if self.SpriteRenderers[1].size.x < self.AdjustedLength then
			self:Resize((self.SpriteRenderers[1].size.x + UnityEngine.Time.deltaTime / 1 * self.AdjustedLength) / self.AdjustedLength)
		else
			self:Resize(1)

			self.PlayingActiveAnim = 0
		end
	end
end

function m:Dispose()
	self:RemoveEventListeners()
	GameEntry.Entity:HideEntityWithData(self.EntityId)
	EventDispatcher.Dispatch(EventID.MazePathDispose, self.StartNodeData, self.EndNodeData)

	self.gameObject = nil
	self.StartNodeData = nil
	self.EndNodeData = nil
	self.SpriteRenderers = nil
end

return m
