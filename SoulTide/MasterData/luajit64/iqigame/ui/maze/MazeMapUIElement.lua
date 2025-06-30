-- chunkname: @IQIGame\\UI\\Maze\\MazeMapUIElement.lua

local m = {
	ParentHeight = 0,
	IsHero = false
}

function m.New(uiController)
	local obj = Clone(m)

	obj:Init(uiController)

	return obj
end

function m:Init(uiController)
	self.UIController = uiController

	function self.DelegateOnElementUpdate(elementPOD, oldNodeId)
		self:OnElementUpdate(elementPOD, oldNodeId)
	end

	function self.DelegateOnNodeUpdate(nodeData, isNewActive)
		self:OnNodeUpdate(nodeData, isNewActive)
	end

	function self.DelegateOnHeroMove(position)
		self:OnHeroMove(position)
	end

	function self.DelegateOnHeroCorrectPosition(position)
		self:OnHeroCorrectPosition(position)
	end

	function self.DelegateOnVisibleChanged(nodeId, isVisible)
		self:OnVisibleChanged(nodeId, isVisible)
	end

	self:AddEventListeners()
end

function m:AddEventListeners()
	EventDispatcher.AddEventListener(EventID.MazeUpdateElement, self.DelegateOnElementUpdate)
	EventDispatcher.AddEventListener(EventID.MazeUpdateNodeData, self.DelegateOnNodeUpdate)
	EventDispatcher.AddEventListener(EventID.MazeElementVisibleChanged, self.DelegateOnVisibleChanged)
end

function m:RemoveEventListeners()
	EventDispatcher.RemoveEventListener(EventID.MazeUpdateElement, self.DelegateOnElementUpdate)
	EventDispatcher.RemoveEventListener(EventID.MazeUpdateNodeData, self.DelegateOnNodeUpdate)
	EventDispatcher.RemoveEventListener(EventID.MazeElementVisibleChanged, self.DelegateOnVisibleChanged)

	if self.IsHero then
		EventDispatcher.RemoveEventListener(EventID.MazeHeroMove, self.DelegateOnHeroMove)
		EventDispatcher.RemoveEventListener(EventID.MazeHeroCorrectPosition, self.DelegateOnHeroCorrectPosition)
	end
end

function m:SetData(elementPOD, parentGo, parentHeight, nodeData)
	self.ElementPOD = elementPOD
	self.NodeData = nodeData
	self.IsHero = self.ElementPOD.ID == MazeDataModule.LeaderElementPOD.ID

	if self.IsHero then
		EventDispatcher.AddEventListener(EventID.MazeHeroMove, self.DelegateOnHeroMove)
		EventDispatcher.AddEventListener(EventID.MazeHeroCorrectPosition, self.DelegateOnHeroCorrectPosition)
	end

	self.ParentGo = parentGo
	self.ParentHeight = parentHeight

	self:UpdateView(elementPOD, self.IsHero and true or self.NodeData.IsActive)
end

function m:UpdateView(elementPOD, isNodeActive)
	local cfgElementAllData = CfgElementAllTable[elementPOD.CID]
	local elementAssetPath = MazeMainUIApi:GetString("MapElementPath", cfgElementAllData.ElementType, self.IsHero)

	if self.LastElementAssetPath ~= elementAssetPath then
		if self.View ~= nil then
			UnityEngine.Object.Destroy(self.View)

			self.View = nil
		end

		if elementAssetPath ~= nil then
			self.View = UnityEngine.Object.Instantiate(self.UIController:GetPreloadedAsset(elementAssetPath))

			self.View.transform:SetParent(self.ParentGo, false)

			local trans = self.View.transform
			local position = trans.anchoredPosition

			position.x = self.NodeData.x * Constant.Maze.SceneSizeToUI
			position.y = self.NodeData.y * Constant.Maze.SceneSizeToUI - self.ParentHeight
			trans.anchoredPosition = position
		end

		self.LastElementAssetPath = elementAssetPath
	end

	if self.View ~= nil then
		self.View:SetActive(isNodeActive and MazeDataModule.IsShowOnLayer(self.NodeData))
	end
end

function m:OnElementUpdate(elementPOD, oldNodeId)
	if not self.IsHero and self.ElementPOD.ID == elementPOD.ID and self.NodeData.NodeId == oldNodeId then
		self:UpdateView(elementPOD, self.NodeData.IsActive)
	end
end

function m:OnNodeUpdate(nodeData, isNewActive)
	if not self.IsHero and self.ElementPOD.NodeId == nodeData.NodeId then
		self:UpdateView(self.ElementPOD, nodeData.IsActive)
	end
end

function m:OnHeroMove(position)
	self:SetPosition(position)
end

function m:OnHeroCorrectPosition()
	self:SetPosition(MazeModule.MazeScene.Hero.gameObject.transform.position)
end

function m:SetPosition(position)
	local trans = self.View.transform

	position.x = position.x * Constant.Maze.SceneSizeToUI
	position.y = position.y * Constant.Maze.SceneSizeToUI - self.ParentHeight
	trans.anchoredPosition = position
end

function m:OnVisibleChanged(nodeId, isVisible)
	if self.View == nil then
		return
	end

	if self.NodeData.NodeId == nodeId then
		self.View:SetActive(isVisible)
	end
end

function m:Dispose()
	self:RemoveEventListeners()

	self.View = nil
	self.UIController = nil
end

return m
