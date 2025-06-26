-- chunkname: @IQIGame\\UI\\Maze\\MazeBigMapController.lua

local m = {}

function m.New(view, smallMapRoot, closeCallback)
	local obj = Clone(m)

	obj:Init(view, smallMapRoot, closeCallback)

	return obj
end

function m:Init(view, smallMapRoot, closeCallback)
	self.View = view
	self.SmallMapRoot = smallMapRoot
	self.CloseCallback = closeCallback

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	UGUIUtil.SetText(self.TitleText, MazeMainUIApi:GetString("BigMapTitleText"))
end

function m:AddEventListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function m:RemoveEventListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function m:Show(mapGo)
	self.View:SetActive(true)

	self.View:GetComponent("Canvas").sortingOrder = Constant.Unity.SortingOrderMaxValue
	self.MapGo = mapGo

	self.MapGo.transform:SetParent(self.MapRoot.transform, false)

	self.MapGo.transform.anchoredPosition = Vector2(-self.MapGo.transform.sizeDelta.x * 0.5, self.MapGo.transform.sizeDelta.y * 0.5)

	local nodeMinX, nodeMaxX, nodeMinY, nodeMaxY

	if MazeDataModule.StreamingLoadType == Constant.Maze.StreamingTypeNone then
		nodeMinX = MazeDataModule.AllNodeMinX
		nodeMaxX = MazeDataModule.AllNodeMaxX
		nodeMinY = MazeDataModule.AllNodeMinY
		nodeMaxY = MazeDataModule.AllNodeMaxY
	else
		nodeMinX = MazeModule.MazeScene.VisibleNodeMinX
		nodeMaxX = MazeModule.MazeScene.VisibleNodeMaxX
		nodeMinY = MazeModule.MazeScene.VisibleNodeMinY
		nodeMaxY = MazeModule.MazeScene.VisibleNodeMaxY
	end

	local mapWidth = (nodeMaxX - nodeMinX) * Constant.Maze.SceneSizeToUI
	local mapHeight = (nodeMaxY - nodeMinY) * Constant.Maze.SceneSizeToUI
	local marginX = MazeSceneApi:GetString("NodeLeftMarginX") * Constant.Maze.SceneSizeToUI
	local marginY = MazeSceneApi:GetString("NodeBottomMarginY") * Constant.Maze.SceneSizeToUI
	local scrollContentSizeDelta = self.ScrollArea.transform.sizeDelta

	scrollContentSizeDelta.x = math.max(self.View.transform.rect.w, (mapWidth + marginX * 2) * self.MapRoot.transform.localScale.x)
	scrollContentSizeDelta.y = math.max(self.View.transform.rect.h, (mapHeight + marginY * 2) * self.MapRoot.transform.localScale.y)
	self.ScrollArea.transform.sizeDelta = scrollContentSizeDelta

	local scaledMapWidth = MazeDataModule.AllNodeMaxX * Constant.Maze.SceneSizeToUI * self.MapRoot.transform.localScale.x
	local scaledMapHeight = MazeDataModule.AllNodeMaxY * Constant.Maze.SceneSizeToUI * self.MapRoot.transform.localScale.y
	local offsetMapSize = Vector2((scaledMapWidth - scrollContentSizeDelta.x) * 0.5, (scaledMapHeight - scrollContentSizeDelta.y) * 0.5)
	local offsetLoadedNodeX = nodeMinX * Constant.Maze.SceneSizeToUI * self.MapRoot.transform.localScale.x
	local offsetLoadedNodeY = nodeMinY * Constant.Maze.SceneSizeToUI * self.MapRoot.transform.localScale.y

	offsetMapSize = offsetMapSize - Vector2(offsetLoadedNodeX, offsetLoadedNodeY)

	local edgeOffsetX = marginX * 0.5
	local edgeOffsetY = marginY * 0.5

	offsetMapSize = offsetMapSize + Vector2(edgeOffsetX, edgeOffsetY)
	self.MapRoot.transform.anchoredPosition = offsetMapSize

	local heroNode = MazeDataModule.GetNodeDataById(MazeModule.MazeScene.Hero.NodeData.NodeId)
	local heroNodePos = Vector2(heroNode.x, heroNode.y)
	local heroNodeUIPosX = (heroNodePos.x - MazeModule.MazeScene.VisibleNodeMinX) * Constant.Maze.SceneSizeToUI * self.MapRoot.transform.localScale.x + edgeOffsetX
	local heroNodeUIPosY = (heroNodePos.y - MazeModule.MazeScene.VisibleNodeMinY) * Constant.Maze.SceneSizeToUI * self.MapRoot.transform.localScale.y + edgeOffsetY
	local offsetContentX = self.View.transform.rect.w * 0.5 - heroNodeUIPosX
	local offsetContentY = self.View.transform.rect.h * 0.5 - heroNodeUIPosY + (self.ScrollArea.transform.sizeDelta.y - self.View.transform.rect.h)

	self.ScrollArea.transform.anchoredPosition = Vector2(offsetContentX, offsetContentY)
end

function m:OnClickCloseBtn()
	self:Close()
end

function m:Close()
	self.MapGo.transform:SetParent(self.SmallMapRoot.transform, false)
	self.View:SetActive(false)
	self.CloseCallback()
end

function m:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.SmallMapRoot = nil
end

return m
