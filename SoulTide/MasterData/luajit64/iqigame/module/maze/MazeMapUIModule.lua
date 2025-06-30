-- chunkname: @IQIGame\\Module\\Maze\\MazeMapUIModule.lua

local m = {
	NodeDataList = {},
	PathDataList = {},
	ElementDataList = {}
}

function m.New()
	local obj = Clone(m)

	obj:Init()

	return obj
end

function m:Init()
	function self.DelegateOnCreateNode(areaNodeData)
		self:OnCreateNode(areaNodeData)
	end

	function self.DelegateOnDisposeNode(areaNodeData)
		self:OnDisposeNode(areaNodeData)
	end

	function self.DelegateOnCreatePath(position, rotation, length, startNodeData, endNodeData)
		self:OnCreatePath(position, rotation, length, startNodeData, endNodeData)
	end

	function self.DelegateOnDisposePath(startNodeData, endNodeData)
		self:OnDisposePath(startNodeData, endNodeData)
	end

	function self.DelegateOnCreateElement(elementPOD, nodeData)
		self:OnCreateElement(elementPOD, nodeData)
	end

	function self.DelegateOnDisposeElement(elementPOD)
		self:OnDisposeElement(elementPOD)
	end

	self:AddEventListeners()
end

function m:AddEventListeners()
	EventDispatcher.AddEventListener(EventID.MazeNodeCreate, self.DelegateOnCreateNode)
	EventDispatcher.AddEventListener(EventID.MazeNodeDispose, self.DelegateOnDisposeNode)
	EventDispatcher.AddEventListener(EventID.MazePathCreate, self.DelegateOnCreatePath)
	EventDispatcher.AddEventListener(EventID.MazePathDispose, self.DelegateOnDisposePath)
	EventDispatcher.AddEventListener(EventID.MazeElementCreate, self.DelegateOnCreateElement)
	EventDispatcher.AddEventListener(EventID.MazeElementDispose, self.DelegateOnDisposeElement)
end

function m:RemoveEventListeners()
	EventDispatcher.RemoveEventListener(EventID.MazeNodeCreate, self.DelegateOnCreateNode)
	EventDispatcher.RemoveEventListener(EventID.MazeNodeDispose, self.DelegateOnDisposeNode)
	EventDispatcher.RemoveEventListener(EventID.MazePathCreate, self.DelegateOnCreatePath)
	EventDispatcher.RemoveEventListener(EventID.MazePathDispose, self.DelegateOnDisposePath)
	EventDispatcher.RemoveEventListener(EventID.MazeElementCreate, self.DelegateOnCreateElement)
	EventDispatcher.RemoveEventListener(EventID.MazeElementDispose, self.DelegateOnDisposeElement)
end

function m:OnCreateNode(areaNodeData)
	if MazeDataModule.MapUILimitType == Constant.Maze.MapUILimitTypeArea and areaNodeData.AreaIx ~= MazeModule.MazeScene.Hero.NodeData.AreaIx then
		return
	end

	table.insert(self.NodeDataList, areaNodeData)
end

function m:OnDisposeNode(areaNodeData)
	if MazeDataModule.MapUILimitType == Constant.Maze.MapUILimitTypeArea and areaNodeData.AreaIx ~= MazeModule.MazeScene.Hero.NodeData.AreaIx then
		return
	end

	for i = 1, #self.NodeDataList do
		local lAreaNodeData = self.NodeDataList[i]

		if lAreaNodeData.NodeId == areaNodeData.NodeId then
			table.remove(self.NodeDataList, i)

			break
		end
	end
end

function m:OnCreatePath(position, rotation, length, startNodeData, endNodeData)
	if MazeDataModule.MapUILimitType == Constant.Maze.MapUILimitTypeArea and (startNodeData.AreaIx ~= MazeModule.MazeScene.Hero.NodeData.AreaIx or endNodeData.AreaIx ~= MazeModule.MazeScene.Hero.NodeData.AreaIx) then
		return
	end

	table.insert(self.PathDataList, {
		position = position,
		rotation = rotation,
		length = length,
		startNodeData = startNodeData,
		endNodeData = endNodeData
	})
end

function m:OnDisposePath(startNodeData, endNodeData)
	if MazeDataModule.MapUILimitType == Constant.Maze.MapUILimitTypeArea and (startNodeData.AreaIx ~= MazeModule.MazeScene.Hero.NodeData.AreaIx or endNodeData.AreaIx ~= MazeModule.MazeScene.Hero.NodeData.AreaIx) then
		return
	end

	for i = 1, #self.PathDataList do
		local pathData = self.PathDataList[i]

		if pathData.startNodeData.NodeId == startNodeData.NodeId and pathData.endNodeData == endNodeData.NodeId then
			table.remove(self.PathDataList, i)

			break
		end
	end
end

function m:OnCreateElement(elementPOD, areaNodeData)
	if MazeDataModule.MapUILimitType == Constant.Maze.MapUILimitTypeArea and areaNodeData.AreaIx ~= MazeModule.MazeScene.Hero.NodeData.AreaIx then
		return
	end

	table.insert(self.ElementDataList, {
		elementPOD = elementPOD,
		nodeData = areaNodeData
	})
end

function m:OnDisposeElement(elementPOD)
	if MazeDataModule.MapUILimitType == Constant.Maze.MapUILimitTypeArea then
		local areaNodeData = MazeDataModule.GetNodeDataById(elementPOD.NodeId)

		if areaNodeData.AreaIx ~= MazeModule.MazeScene.Hero.NodeData.AreaIx then
			return
		end
	end

	for i = 1, #self.ElementDataList do
		local lElementPOD = self.ElementDataList[i].elementPOD

		if lElementPOD.ID == elementPOD.ID then
			table.remove(self.ElementDataList, i)

			break
		end
	end
end

function m:Dispose()
	self:RemoveEventListeners()
end

return m
