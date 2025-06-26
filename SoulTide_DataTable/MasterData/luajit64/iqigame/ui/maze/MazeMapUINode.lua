-- chunkname: @IQIGame\\UI\\Maze\\MazeMapUINode.lua

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

	self.NormalView = self.View.transform:Find("Normal").gameObject
	self.CompleteView = self.View.transform:Find("Complete").gameObject

	self:AddEventListeners()
end

function m:AddEventListeners()
	EventDispatcher.AddEventListener(EventID.MazeUpdateNodeData, self.DelegateOnNodeUpdate)
end

function m:RemoveEventListeners()
	EventDispatcher.RemoveEventListener(EventID.MazeUpdateNodeData, self.DelegateOnNodeUpdate)
end

function m:SetData(areaNodeData, parentHeight)
	self.NodeData = areaNodeData

	local trans = self.View.transform
	local position = trans.anchoredPosition

	position.x = areaNodeData.x * Constant.Maze.SceneSizeToUI
	position.y = areaNodeData.y * Constant.Maze.SceneSizeToUI - parentHeight
	trans.anchoredPosition = position

	self:ChangeView(areaNodeData.IsActive, areaNodeData.IsComplete)
end

function m:ChangeView(isActive, isComplete)
	local cfgMazePathNodeData = CfgMazePathNodeTable[self.NodeData.CID]

	self.NormalView:SetActive(isActive and not isComplete and cfgMazePathNodeData.Type ~= Constant.Maze.NodeTypeSecretPassage)
	self.CompleteView:SetActive(isActive and isComplete)
end

function m:OnNodeUpdate(nodeData, isNewActive)
	if nodeData.NodeId == self.NodeData.NodeId then
		self:ChangeView(nodeData.IsActive, nodeData.IsComplete)
	end
end

function m:Dispose()
	self:RemoveEventListeners()

	self.View = nil
end

return m
