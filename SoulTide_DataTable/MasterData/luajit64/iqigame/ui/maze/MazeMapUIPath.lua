-- chunkname: @IQIGame\\UI\\Maze\\MazeMapUIPath.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	function self.DelegateOnNodeUpdate(nodeData, isNewActive)
		self:OnNodeUpdate(nodeData, isNewActive)
	end

	self.NormalView = self.View.transform:Find("Path_Normal").gameObject
	self.CompleteView = self.View.transform:Find("Path_Complete").gameObject

	self:AddEventListeners()
end

function m:AddEventListeners()
	EventDispatcher.AddEventListener(EventID.MazeUpdateNodeData, self.DelegateOnNodeUpdate)
end

function m:RemoveEventListeners()
	EventDispatcher.RemoveEventListener(EventID.MazeUpdateNodeData, self.DelegateOnNodeUpdate)
end

function m:SetData(position, rotation, length, parentHeight, startNodeData, endNodeData)
	self.StartNodeData = startNodeData
	self.EndNodeData = endNodeData

	local isActive = self.StartNodeData.IsActive and self.EndNodeData.IsActive
	local trans = self.View.transform
	local sizeDelta = trans.sizeDelta

	sizeDelta.x = length * Constant.Maze.SceneSizeToUI
	trans.sizeDelta = sizeDelta

	local pos = trans.anchoredPosition

	pos.x = position.x * Constant.Maze.SceneSizeToUI
	pos.y = position.y * Constant.Maze.SceneSizeToUI - parentHeight
	trans.anchoredPosition = pos
	pos = self.NormalView.transform.anchoredPosition3D
	pos.z = length * Constant.Maze.SceneSizeToUI * 0.5
	self.NormalView.transform.anchoredPosition3D = pos
	self.CompleteView.transform.anchoredPosition3D = pos
	trans.rotation = rotation

	self:ChangeView(isActive, self.StartNodeData.IsComplete, self.EndNodeData.IsComplete)
end

function m:ChangeView(isActive, isStartNodeComplete, isEndNodeComplete)
	local startNodeCfg = CfgMazePathNodeTable[self.StartNodeData.CID]
	local endNodeCfg = CfgMazePathNodeTable[self.EndNodeData.CID]
	local isStartNodeVisible = startNodeCfg.Type ~= Constant.Maze.NodeTypeSecretPassage or self.StartNodeData.IsComplete
	local isEndNodeVisible = endNodeCfg.Type ~= Constant.Maze.NodeTypeSecretPassage or self.EndNodeData.IsComplete

	self.NormalView:SetActive(isActive and isStartNodeVisible and isEndNodeVisible and (not self.StartNodeData.IsComplete or not self.EndNodeData.IsComplete))
	self.CompleteView:SetActive(isActive and isStartNodeComplete and isEndNodeComplete)
end

function m:OnNodeUpdate(nodeData, isNewActive)
	if nodeData.NodeId == self.StartNodeData.NodeId or nodeData.NodeId == self.EndNodeData.NodeId then
		local isActive = self.StartNodeData.IsActive and self.EndNodeData.IsActive

		self:ChangeView(isActive, self.StartNodeData.IsComplete, self.EndNodeData.IsComplete)
	end
end

function m:Dispose()
	self:RemoveEventListeners()

	self.View = nil
end

return m
