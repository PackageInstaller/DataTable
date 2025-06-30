-- chunkname: @IQIGame\\UI\\Maze\\MazeSmallMapPanel.lua

local m = {
	BigMapMode = false
}
local MazeMapUINode = require("IQIGame.UI.Maze.MazeMapUINode")
local MazeMapUIPath = require("IQIGame.UI.Maze.MazeMapUIPath")
local MazeMapUIElement = require("IQIGame.UI.Maze.MazeMapUIElement")
local MazeBigMapController = require("IQIGame.UI.Maze.MazeBigMapController")

function m.New(view, uiController)
	local obj = Clone(m)

	obj:Init(view, uiController)

	return obj
end

function m:Init(view, uiController)
	self.View = view
	self.UIController = uiController
	self.NodeViews = {}
	self.PathViews = {}
	self.ElementViews = {}

	LuaCodeInterface.BindOutlet(self.View, self)

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

	function self.DelegateOnMazeCameraMove(cameraPos, isNotMoveOrSet)
		self:OnMazeCameraMove(cameraPos, isNotMoveOrSet)
	end

	function self.DelegateOnCreateElement(elementPOD, nodeData)
		self:OnCreateElement(elementPOD, nodeData)
	end

	function self.DelegateOnDisposeElement(elementPOD)
		self:OnDisposeElement(elementPOD)
	end

	function self.DelegateOnBigMapClose()
		self:OnBigMapClose()
	end

	function self.DelegateOnCloseManualUI()
		self:OnCloseManualUI()
	end

	self.BigMapController = MazeBigMapController.New(self.BigMap, self.SmallMapRoot, self.DelegateOnBigMapClose)

	self:AddEventListeners()
end

function m:AddEventListeners()
	self.BigMapController:AddEventListeners()
	EventDispatcher.AddEventListener(EventID.MazeNodeCreate, self.DelegateOnCreateNode)
	EventDispatcher.AddEventListener(EventID.MazeNodeDispose, self.DelegateOnDisposeNode)
	EventDispatcher.AddEventListener(EventID.MazePathCreate, self.DelegateOnCreatePath)
	EventDispatcher.AddEventListener(EventID.MazePathDispose, self.DelegateOnDisposePath)
	EventDispatcher.AddEventListener(EventID.MazeCameraMove, self.DelegateOnMazeCameraMove)
	EventDispatcher.AddEventListener(EventID.MazeElementCreate, self.DelegateOnCreateElement)
	EventDispatcher.AddEventListener(EventID.MazeElementDispose, self.DelegateOnDisposeElement)
	EventDispatcher.AddEventListener(EventID.MazeCloseManualUI, self.DelegateOnCloseManualUI)
end

function m:RemoveEventListeners()
	self.BigMapController:RemoveEventListeners()
	EventDispatcher.RemoveEventListener(EventID.MazeNodeCreate, self.DelegateOnCreateNode)
	EventDispatcher.RemoveEventListener(EventID.MazeNodeDispose, self.DelegateOnDisposeNode)
	EventDispatcher.RemoveEventListener(EventID.MazePathCreate, self.DelegateOnCreatePath)
	EventDispatcher.RemoveEventListener(EventID.MazePathDispose, self.DelegateOnDisposePath)
	EventDispatcher.RemoveEventListener(EventID.MazeCameraMove, self.DelegateOnMazeCameraMove)
	EventDispatcher.RemoveEventListener(EventID.MazeElementCreate, self.DelegateOnCreateElement)
	EventDispatcher.RemoveEventListener(EventID.MazeElementDispose, self.DelegateOnDisposeElement)
	EventDispatcher.RemoveEventListener(EventID.MazeCloseManualUI, self.DelegateOnCloseManualUI)
end

function m:OnCreateNode(areaNodeData)
	if MazeDataModule.MapUILimitType == Constant.Maze.MapUILimitTypeArea and areaNodeData.AreaIx ~= MazeModule.MazeScene.Hero.NodeData.AreaIx then
		return
	end

	self:AddNode(areaNodeData)
end

function m:OnDisposeNode(areaNodeData)
	if MazeDataModule.MapUILimitType == Constant.Maze.MapUILimitTypeArea and areaNodeData.AreaIx ~= MazeModule.MazeScene.Hero.NodeData.AreaIx then
		return
	end

	self:RemoveNode(areaNodeData.NodeId)
end

function m:OnShow()
	self:Clear()

	for i = 1, #MazeModule.MapUIModule.NodeDataList do
		local areaNodeData = MazeModule.MapUIModule.NodeDataList[i]

		self:AddNode(areaNodeData)
	end

	for i = 1, #MazeModule.MapUIModule.PathDataList do
		local pathData = MazeModule.MapUIModule.PathDataList[i]

		self:AddPath(pathData.position, pathData.rotation, pathData.length, pathData.startNodeData, pathData.endNodeData)
	end

	for i = 1, #MazeModule.MapUIModule.ElementDataList do
		local elementData = MazeModule.MapUIModule.ElementDataList[i]

		self:AddElement(elementData.elementPOD, elementData.nodeData)
	end

	local trans = self.Map.transform
	local size = trans.sizeDelta

	size.x = MazeDataModule.AllNodeMaxX * Constant.Maze.SceneSizeToUI
	size.y = MazeDataModule.AllNodeMaxY * Constant.Maze.SceneSizeToUI
	trans.sizeDelta = size

	self:AdjustMapPosByCamera(MazeModule.MazeScene.MainCamera.transform.position)
end

function m:AddNode(areaNodeData)
	local nodePrefab = self.UIController:GetPreloadedAsset(UIGlobalApi.GetUIPrefab("/_MazeMainUI/SmallMap/Node"))
	local node = MazeMapUINode.New(UnityEngine.Object.Instantiate(nodePrefab))

	node:SetData(areaNodeData, MazeDataModule.AllNodeMaxY * Constant.Maze.SceneSizeToUI)
	node.View.transform:SetParent(self.Map.transform:Find("Node"), false)
	table.insert(self.NodeViews, node)
end

function m:RemoveNode(nodeId)
	for i = 1, #self.NodeViews do
		local node = self.NodeViews[i]

		if node.NodeData.NodeId == nodeId then
			table.remove(self.NodeViews, i)

			local view = node.View

			node:Dispose()
			UnityEngine.Object.Destroy(view)

			break
		end
	end
end

function m:OnCreatePath(position, rotation, length, startNodeData, endNodeData)
	if MazeDataModule.MapUILimitType == Constant.Maze.MapUILimitTypeArea and (startNodeData.AreaIx ~= MazeModule.MazeScene.Hero.NodeData.AreaIx or endNodeData.AreaIx ~= MazeModule.MazeScene.Hero.NodeData.AreaIx) then
		return
	end

	self:AddPath(position, rotation, length, startNodeData, endNodeData)
end

function m:OnDisposePath(startNodeData, endNodeData)
	if MazeDataModule.MapUILimitType == Constant.Maze.MapUILimitTypeArea and (startNodeData.AreaIx ~= MazeModule.MazeScene.Hero.NodeData.AreaIx or endNodeData.AreaIx ~= MazeModule.MazeScene.Hero.NodeData.AreaIx) then
		return
	end

	self:RemovePath(startNodeData, endNodeData)
end

function m:AddPath(position, rotation, length, startNodeData, endNodeData)
	local path = MazeMapUIPath.New(UnityEngine.Object.Instantiate(self.UIController:GetPreloadedAsset(UIGlobalApi.GetUIPrefab("/_MazeMainUI/SmallMap/Path"))))

	path:SetData(position, rotation, length, MazeDataModule.AllNodeMaxY * Constant.Maze.SceneSizeToUI, startNodeData, endNodeData)
	path.View.transform:SetParent(self.Map.transform:Find("Path"), false)
	table.insert(self.PathViews, path)
end

function m:RemovePath(startNodeData, endNodeData)
	for i = 1, #self.PathViews do
		local path = self.PathViews[i]

		if path.StartNodeData.NodeId == startNodeData.NodeId and path.EndNodeData.NodeId == endNodeData.NodeId then
			table.remove(self.PathViews, i)

			local view = path.View

			path:Dispose()
			UnityEngine.Object.Destroy(view)

			break
		end
	end
end

function m:OnCreateElement(elementPOD, areaNodeData)
	if MazeDataModule.MapUILimitType == Constant.Maze.MapUILimitTypeArea and areaNodeData.AreaIx ~= MazeModule.MazeScene.Hero.NodeData.AreaIx then
		return
	end

	self:AddElement(elementPOD, areaNodeData)
end

function m:OnDisposeElement(elementPOD)
	if MazeDataModule.MapUILimitType == Constant.Maze.MapUILimitTypeArea then
		local areaNodeData = MazeDataModule.GetNodeDataById(elementPOD.NodeId)

		if areaNodeData.AreaIx ~= MazeModule.MazeScene.Hero.NodeData.AreaIx then
			return
		end
	end

	self:RemoveElement(elementPOD.ID)
end

function m:AddElement(elementPOD, nodeData)
	local element = MazeMapUIElement.New(self.UIController)

	element:SetData(elementPOD, self.Map.transform:Find("Element"), MazeDataModule.AllNodeMaxY * Constant.Maze.SceneSizeToUI, nodeData)
	table.insert(self.ElementViews, element)
end

function m:RemoveElement(id)
	for i = 1, #self.ElementViews do
		local element = self.ElementViews[i]

		if element.ElementPOD.ID == id then
			table.remove(self.ElementViews, i)

			local view = element.View

			element:Dispose()

			if view ~= nil then
				UnityEngine.Object.Destroy(view)
			end

			break
		end
	end
end

function m:Clear(isDestroy)
	for i = 1, #self.NodeViews do
		local node = self.NodeViews[i]
		local view = node.View

		node:Dispose()

		if not isDestroy then
			UnityEngine.Object.Destroy(view)
		end
	end

	self.NodeViews = {}

	for i = 1, #self.PathViews do
		local path = self.PathViews[i]
		local view = path.View

		path:Dispose()

		if not isDestroy then
			UnityEngine.Object.Destroy(view)
		end
	end

	self.PathViews = {}

	for i = 1, #self.ElementViews do
		local element = self.ElementViews[i]
		local view = element.View

		element:Dispose()

		if not isDestroy and view ~= nil then
			UnityEngine.Object.Destroy(view)
		end
	end

	self.ElementViews = {}
end

function m:OnMazeCameraMove(cameraPos, isNotMoveOrSet)
	if not self.BigMapMode and not isNotMoveOrSet then
		self:AdjustMapPosByCamera(cameraPos)
	end
end

function m:AdjustMapPosByCamera(cameraPos)
	self.Map.transform.anchoredPosition = Vector2(-cameraPos.x * Constant.Maze.SceneSizeToUI, (MazeDataModule.AllNodeMaxY - cameraPos.y) * Constant.Maze.SceneSizeToUI)
end

function m:ShowBigMap()
	self.BigMapMode = true

	self.BigMapController:Show(self.Map)
end

function m:OnBigMapClose()
	self.BigMapMode = false

	self:AdjustMapPosByCamera(MazeModule.MazeScene.MainCamera.transform.position)
end

function m:OnCloseManualUI()
	if self.BigMapMode then
		self.BigMapController:Close()
	end
end

function m:Dispose()
	self:Clear(true)
	self:RemoveEventListeners()
	self.BigMapController:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
