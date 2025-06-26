-- chunkname: @IQIGame\\Scene\\DualTeamExplore\\DualTeamExplorePath.lua

local m = {
	EntityId = 0,
	AdjustedLength = 0,
	Length = 0,
	IsConnectedReversely = false,
	GAP = 0.8,
	IsLoading = false
}

function m.New(nodeData1, nodeData2, parentTrans, isConnectedReversely)
	local obj = Clone(m)

	obj:Init(nodeData1, nodeData2, parentTrans, isConnectedReversely)

	return obj
end

function m:Init(nodeData1, nodeData2, parentTrans, isConnectedReversely)
	self.StartNodeData = nodeData1
	self.EndNodeData = nodeData2
	self.IsConnectedReversely = isConnectedReversely

	function self.DelegateOnShowElementEntitySuccess(sender, args)
		self:OnShowElementEntitySuccess(sender, args)
	end

	function self.DelegateOnShowElementEntityFailure(sender, args)
		self:OnShowElementEntityFailure(sender, args)
	end

	function self.DelegateOnChangeNextNode(startNodeData, endNodeData, isAdd)
		self:OnChangeNextNode(startNodeData, endNodeData)
	end

	self:AddEventListeners()

	self.EntityId = GameEntry.Entity:GenerateEntityID()

	local node = DualTeamExploreModule.DualTeamExploreScene:GetNodeById(self.StartNodeData.id)
	local position = Vector3(node.gameObject.transform.position.x, node.gameObject.transform.position.y, 0)

	self.IsLoading = true

	GameEntry.Entity:ShowMazePath(self.EntityId, DualTeamExploreSceneApi:GetString("PathAsset"), 0, parentTrans, position)
end

function m:AddEventListeners()
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntityFailureEventArgs.EventId, self.DelegateOnShowElementEntityFailure)
	EventDispatcher.AddEventListener(EventID.DualTeamExploreChangeNextNode, self.DelegateOnChangeNextNode)
end

function m:RemoveEventListeners()
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntityFailureEventArgs.EventId, self.DelegateOnShowElementEntityFailure)
	EventDispatcher.RemoveEventListener(EventID.DualTeamExploreChangeNextNode, self.DelegateOnChangeNextNode)
end

function m:OnShowElementEntitySuccess(sender, args)
	if args.Entity.Id == self.EntityId then
		self.IsLoading = false

		GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
		GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntityFailureEventArgs.EventId, self.DelegateOnShowElementEntityFailure)

		self.gameObject = args.Entity.gameObject

		self:OnShow()
		EventDispatcher.Dispatch(EventID.DualTeamExploreEntityLoaded, true)
	end
end

function m:OnShowElementEntityFailure(sender, args)
	if args.Entity.Id == self.EntityId then
		self.IsLoading = false

		GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
		GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntityFailureEventArgs.EventId, self.DelegateOnShowElementEntityFailure)
		EventDispatcher.Dispatch(EventID.DualTeamExploreEntityLoaded, false)
	end
end

function m:OnShow()
	self.SpriteRenderer = self.gameObject:GetComponentInChildren(typeof(UnityEngine.SpriteRenderer))

	local node1 = DualTeamExploreModule.DualTeamExploreScene:GetNodeById(self.StartNodeData.id)
	local node2 = DualTeamExploreModule.DualTeamExploreScene:GetNodeById(self.EndNodeData.id)
	local from1To2 = Vector3(node2.gameObject.transform.position.x, node2.gameObject.transform.position.y, 0) - Vector3(node1.gameObject.transform.position.x, node1.gameObject.transform.position.y, 0)
	local rotation = Quaternion.LookRotation(from1To2, Vector3.right)

	self.gameObject.transform.rotation = rotation
	self.Length = from1To2.magnitude
	self.AdjustedLength = self.Length - m.GAP

	self:RefreshArrow()
end

function m:Resize(ratio)
	local size = self.SpriteRenderer.size

	size.x = self.AdjustedLength * ratio
	self.SpriteRenderer.size = size

	local zPos = size.x * 0.5 + m.GAP * 0.5
	local position = Vector3(0, 0, zPos)

	self.SpriteRenderer.transform.localPosition = position

	local activeArrowNum = 0

	for i = 1, 2 do
		local arrowTrans = self.SpriteRenderer.transform:Find("Arrow" .. i)

		if arrowTrans.gameObject.activeSelf then
			activeArrowNum = activeArrowNum + 1
		end
	end

	for i = 1, 2 do
		local arrowTrans = self.SpriteRenderer.transform:Find("Arrow" .. i)
		local offsetDir = activeArrowNum == 2 and (i == 1 and -1 or 1) or 0

		arrowTrans.localPosition = Vector3(0.05 * offsetDir, 0.1 * offsetDir, 0)
	end
end

function m:RefreshArrow()
	if self.SpriteRenderer == nil then
		return
	end

	self.SpriteRenderer.transform:Find("Arrow2").gameObject:SetActive(self.IsConnectedReversely)
	self:Resize(1)
end

function m:OnChangeNextNode(startNodeData, endNodeData)
	if self.StartNodeData.id == startNodeData.id and self.EndNodeData.id == endNodeData.id or self.StartNodeData.id == endNodeData.id and self.EndNodeData.id == startNodeData.id then
		self.IsConnectedReversely = table.indexOf(self.StartNodeData.nextNodes, self.EndNodeData) ~= -1 and table.indexOf(self.EndNodeData.nextNodes, self.StartNodeData) ~= -1

		self:RefreshArrow()
	end
end

function m:Dispose()
	self:RemoveEventListeners()
	GameEntry.Entity:HideEntityWithData(self.EntityId)

	self.gameObject = nil
	self.StartNodeData = nil
	self.EndNodeData = nil
	self.SpriteRenderer = nil
end

return m
