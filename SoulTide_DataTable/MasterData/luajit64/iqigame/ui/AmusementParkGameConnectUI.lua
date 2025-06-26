-- chunkname: @IQIGame\\UI\\AmusementParkGameConnectUI.lua

local AmusementParkGameConnectUI = {
	OneConnectBlockCells = {}
}

AmusementParkGameConnectUI = Base:Extend("AmusementParkGameConnectUI", "IQIGame.Onigao.UI.AmusementParkGameConnectUI", AmusementParkGameConnectUI)

local AmusementParkOneConnectBlockData = require("IQIGame.Module.CommonActivity.AmusementPark.AmusementParkOneConnectGame.AmusementParkOneConnectBlockData")
local AmusementParkOneConnectBlockCell = require("IQIGame.UI.ExploreHall.AmusementPark.AmusementParkOneConnectGame.AmusementParkOneConnectBlockCell")

function AmusementParkGameConnectUI:OnInit()
	self.UICanvas = self.UIController:GetComponent(typeof(UnityEngine.Canvas))

	function self.DelegateOnClickBtnClose()
		self:OnClickBtnClose()
	end

	function self.DelegateOnClickBtnRest()
		self:OnClickBtnRest()
	end

	function self.DelegateOnClickBtnChooseLevel()
		self:OnClickBtnChooseLevel()
	end

	function self.DelegateUpdateOneConnectGame()
		self:OnUpdateOneConnectGame()
	end

	function self.DelegateOnGameEnd()
		self:OnGameEnd()
	end
end

function AmusementParkGameConnectUI:GetPreloadAssetPaths()
	return nil
end

function AmusementParkGameConnectUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function AmusementParkGameConnectUI:IsManualShowOnOpen(userData)
	return false
end

function AmusementParkGameConnectUI:GetBGM(userData)
	return nil
end

function AmusementParkGameConnectUI:OnOpen(userData)
	AmusementParkModule.SetAmusementParkSceneActive(false)
	self:CreateGameMap()
	self:UpdateView()
end

function AmusementParkGameConnectUI:OnClose(userData)
	AmusementParkModule.SetAmusementParkSceneActive(true)
end

function AmusementParkGameConnectUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnClose)
	self.BtnRest:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnRest)
	self.BtnChooseLevel:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnChooseLevel)
	self.ResultView:GetComponent("Button").onClick:AddListener(self.DelegateOnGameEnd)
	EventDispatcher.AddEventListener(EventID.APUpdateOneConnectGameEvent, self.DelegateUpdateOneConnectGame)
end

function AmusementParkGameConnectUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnClose)
	self.BtnRest:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnRest)
	self.BtnChooseLevel:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnChooseLevel)
	self.ResultView:GetComponent("Button").onClick:RemoveListener(self.DelegateOnGameEnd)
	EventDispatcher.RemoveEventListener(EventID.APUpdateOneConnectGameEvent, self.DelegateUpdateOneConnectGame)
end

function AmusementParkGameConnectUI:OnPause()
	return
end

function AmusementParkGameConnectUI:OnResume()
	return
end

function AmusementParkGameConnectUI:OnCover()
	return
end

function AmusementParkGameConnectUI:OnReveal()
	return
end

function AmusementParkGameConnectUI:OnRefocus(userData)
	return
end

function AmusementParkGameConnectUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function AmusementParkGameConnectUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function AmusementParkGameConnectUI:OnLoadSucceed(assetName, asset, duration, userData)
	local type = userData.type

	if type == "LoadMap" then
		self:CleanBlocks()
		AmusementParkOneConnectGameModule.oneConnectGameData.LevelData:RestLevelBlock()

		local mapObj = UnityEngine.Object.Instantiate(asset)

		mapObj.transform:SetParent(self.RootLevel.transform, false)

		for i = 0, mapObj.transform.childCount - 1 do
			local node = mapObj.transform:GetChild(i)
			local posTab = string.split(node.gameObject.name, "_")
			local blockObj = UnityEngine.Object.Instantiate(self.BlockMould)

			blockObj:SetActive(true)
			blockObj.transform:SetParent(node, false)

			local blockData = AmusementParkOneConnectBlockData.New(i + 1, posTab[1], posTab[2])
			local blockCell = AmusementParkOneConnectBlockCell.New(blockObj)

			function blockCell.OnBeginDragCallBack(cell)
				self:StartDrag(cell)
			end

			function blockCell.OnDragCallBack(cell)
				self:OnDrag(cell)
			end

			blockCell:SetData(blockData)
			table.insert(self.OneConnectBlockCells, blockCell)
			AmusementParkOneConnectGameModule.oneConnectGameData.LevelData:Create(blockData)
		end
	end
end

function AmusementParkGameConnectUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function AmusementParkGameConnectUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self:CleanBlocks()

	if self.oneConnectGameMapView then
		self.oneConnectGameMapView:Dispose()
	end

	self.oneConnectGameMapView = nil
end

function AmusementParkGameConnectUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function AmusementParkGameConnectUI:RefreshMap()
	for i, v in pairs(self.OneConnectBlockCells) do
		v:UpdateView()
	end

	local result = AmusementParkOneConnectGameModule.oneConnectGameData:CheckComplete()

	if result then
		AmusementParkOneConnectGameModule.OneStroke(AmusementParkOneConnectGameModule.oneConnectGameData.LevelData.cid)
		self.ResultView:SetActive(true)
		GameEntry.Sound:PlaySound(10905, Constant.SoundGroup.UI)
	end
end

function AmusementParkGameConnectUI:StartDrag(cell)
	local blockData = cell.BlockData
	local result = AmusementParkOneConnectGameModule.oneConnectGameData:CheckIsConnect(blockData)

	if result then
		AmusementParkOneConnectGameModule.oneConnectGameData:AddBlockData(blockData)
		self:RefreshMap()
		GameEntry.Sound:PlaySound(10904, Constant.SoundGroup.UI)
	end
end

function AmusementParkGameConnectUI:OnDrag(cell)
	local top, blockData = self:GetBlockOccupiedAreas(cell)

	if top then
		local result = AmusementParkOneConnectGameModule.oneConnectGameData:CheckIsConnect(blockData)

		if result then
			AmusementParkOneConnectGameModule.oneConnectGameData:AddBlockData(blockData)
			self:RefreshMap()
			GameEntry.Sound:PlaySound(10904, Constant.SoundGroup.UI)
		end
	end
end

function AmusementParkGameConnectUI:CheckBoundsIntersects(collider2D1, collider2D2)
	return collider2D1.bounds:Intersects(collider2D2.bounds)
end

function AmusementParkGameConnectUI:GetBlockOccupiedAreas(cell)
	local res = false

	for i, v in pairs(self.OneConnectBlockCells) do
		if v.BlockData.Index ~= cell.BlockData.Index then
			res = self:CheckBoundsIntersects(cell.DrgCollider, v.BlockCollider)

			if res then
				return true, v.BlockData
			end
		end
	end

	return false, nil
end

function AmusementParkGameConnectUI:OnUpdateOneConnectGame()
	self:ResetGame()
end

function AmusementParkGameConnectUI:ResetGame()
	self.ResultView:SetActive(false)
	AmusementParkOneConnectGameModule.oneConnectGameData:RestGame()
	self:CreateGameMap()
	self:UpdateView()
end

function AmusementParkGameConnectUI:UpdateView()
	UGUIUtil.SetText(self.TextLevel, AmusementParkOneConnectGameModule.oneConnectGameData.LevelData:GetCfgData().Level)
end

function AmusementParkGameConnectUI:CreateGameMap()
	local levelMap = AmusementParkOneConnectGameModule.oneConnectGameData.LevelData:GetCfgData().GamePrefab
	local path = UIGlobalApi.UIPath .. levelMap

	AssetUtil.LoadAsset(self, path, self.OnLoadSucceed, nil, {
		type = "LoadMap"
	})
end

function AmusementParkGameConnectUI:CleanBlocks()
	for i, v in pairs(self.OneConnectBlockCells) do
		v:Dispose()
	end

	self.OneConnectBlockCells = {}
end

function AmusementParkGameConnectUI:OnClickBtnRest()
	self:ResetGame()
end

function AmusementParkGameConnectUI:OnGameEnd()
	self.ResultView:SetActive(false)
	AmusementParkOneConnectGameModule.CreateNewGame()
	self:CreateGameMap()
	self:UpdateView()
end

function AmusementParkGameConnectUI:OnClickBtnChooseLevel()
	UIModule.Open(Constant.UIControllerName.AmusementParkGameSelectLevelUI, Constant.UILayer.UI)
end

return AmusementParkGameConnectUI
