-- chunkname: @IQIGame\\UI\\AmusementParkGameBlocksUI.lua

local AmusementParkGameBlocksUI = {
	mapTileCells = {},
	blockCellPools = {},
	blockCells = {}
}

AmusementParkGameBlocksUI = Base:Extend("AmusementParkGameBlocksUI", "IQIGame.Onigao.UI.AmusementParkGameBlocksUI", AmusementParkGameBlocksUI)

require("IQIGame.UIExternalApi.AmusementParkGameBlocksUIApi")

local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local AmusementParkPuzzleGameMapTileCell = require("IQIGame.UI.ExploreHall.AmusementPark.AmusementParkPuzzleGame.AmusementParkPuzzleGameMapTileCell")
local AmusementParkPuzzleGameBlockCell = require("IQIGame.UI.ExploreHall.AmusementPark.AmusementParkPuzzleGame.AmusementParkPuzzleGameBlockCell")

function AmusementParkGameBlocksUI:OnInit()
	UGUIUtil.SetTextInChildren(self.ConfirmBtn, AmusementParkGameBlocksUIApi:GetString("Title"))

	function self.DelegateOnClickConfirmBtn()
		self:OnClickConfirmBtn()
	end

	function self.DelegateBtnStartGame()
		self:OnBtnStartGame()
	end

	function self.DelegateBtnRank()
		self:OnBtnRank()
	end

	function self.DelegateUpdatePuzzleGameRank()
		self:OnUpdatePuzzleGameRank()
	end

	function self.DelegateBtnReset()
		self:OnBtnReset()
	end

	self.TileModel:SetActive(false)

	self.mapTileCellPool = UIObjectPool.New(100, function()
		local tileCell = AmusementParkPuzzleGameMapTileCell.New(UnityEngine.Object.Instantiate(self.TileModel))

		return tileCell
	end, function(cell)
		cell:Dispose()
	end)
	self.blockCellPools = {}

	for i = 0, self.Blocks.transform.childCount - 1 do
		local obj = self.Blocks.transform:GetChild(i).gameObject

		self.blockCellPools[tonumber(obj.name)] = UIObjectPool.New(5, function()
			local blockCell = AmusementParkPuzzleGameBlockCell.New(UnityEngine.Object.Instantiate(obj))

			function blockCell.onDrag(cell)
				self:OnDrag(cell)
			end

			function blockCell.endDrag(cell)
				self:OnEndDrag(cell)
			end

			return blockCell
		end, function(cell)
			cell:Dispose()
		end)
		self.blockCells[tonumber(obj.name)] = {}
	end
end

function AmusementParkGameBlocksUI:GetPreloadAssetPaths()
	return nil
end

function AmusementParkGameBlocksUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function AmusementParkGameBlocksUI:IsManualShowOnOpen(userData)
	return false
end

function AmusementParkGameBlocksUI:GetBGM(userData)
	return nil
end

function AmusementParkGameBlocksUI:OnOpen(userData)
	AmusementParkModule.SetAmusementParkSceneActive(false)
	AmusementParkPuzzleGameModule.GetPuzzleGameRanking()
	self:StartNewGame()
	self:UpdateView()
end

function AmusementParkGameBlocksUI:OnClose(userData)
	AmusementParkModule.SetAmusementParkSceneActive(true)
end

function AmusementParkGameBlocksUI:OnAddListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickConfirmBtn)
	self.BtnStartGame:GetComponent("Button").onClick:AddListener(self.DelegateBtnStartGame)
	self.BtnRank:GetComponent("Button").onClick:AddListener(self.DelegateBtnRank)
	self.BtnReset:GetComponent("Button").onClick:AddListener(self.DelegateBtnReset)
	EventDispatcher.AddEventListener(EventID.APUpdatePuzzleGameRankEvent, self.DelegateUpdatePuzzleGameRank)
end

function AmusementParkGameBlocksUI:OnRemoveListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickConfirmBtn)
	self.BtnStartGame:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnStartGame)
	self.BtnRank:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnRank)
	self.BtnReset:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnReset)
	EventDispatcher.RemoveEventListener(EventID.APUpdatePuzzleGameRankEvent, self.DelegateUpdatePuzzleGameRank)
end

function AmusementParkGameBlocksUI:OnPause()
	return
end

function AmusementParkGameBlocksUI:OnResume()
	return
end

function AmusementParkGameBlocksUI:OnCover()
	return
end

function AmusementParkGameBlocksUI:OnReveal()
	return
end

function AmusementParkGameBlocksUI:OnRefocus(userData)
	return
end

function AmusementParkGameBlocksUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function AmusementParkGameBlocksUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function AmusementParkGameBlocksUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function AmusementParkGameBlocksUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function AmusementParkGameBlocksUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.mapTileCells) do
		self.mapTileCellPool:Release(v)
	end

	self.mapTileCells = {}

	self.mapTileCellPool:Dispose()

	for i, cells in pairs(self.blockCells) do
		for j, k in pairs(cells) do
			self.blockCellPools[i]:Release(k)
		end

		self.blockCells[i] = {}

		self.blockCellPools[i]:Dispose()
	end
end

function AmusementParkGameBlocksUI:OnClickConfirmBtn()
	UIModule.CloseSelf(self)
end

function AmusementParkGameBlocksUI:UpdateView()
	self:RefreshScore()
	self:OnUpdatePuzzleGameRank()

	if AmusementParkPuzzleGameModule.apPuzzleGameData then
		self:CreateMap()
		self:CreateBlocks()
	end

	self:RefreshBtnState()
end

function AmusementParkGameBlocksUI:RefreshScore()
	local lv = AmusementParkPuzzleGameModule.maxLv

	if AmusementParkPuzzleGameModule.apPuzzleGameData then
		lv = AmusementParkPuzzleGameModule.apPuzzleGameData.cfgPuzzleGameControlData.Level

		UGUIUtil.SetText(self.TextCurrentScore, AmusementParkPuzzleGameModule.apPuzzleGameData.score)
	else
		UGUIUtil.SetText(self.TextCurrentScore, 0)
	end

	UGUIUtil.SetText(self.TextCurrentLv, AmusementParkGameBlocksUIApi:GetString("TextCurrentLv", lv))
end

function AmusementParkGameBlocksUI:CreateMap()
	for i, v in pairs(self.mapTileCells) do
		self.mapTileCellPool:Release(v)
		v.View:SetActive(false)
		v.View.transform:SetParent(self.UIController.transform, false)
	end

	self.mapTileCells = {}

	local tileMaps = AmusementParkPuzzleGameModule.apPuzzleGameData.tileMaps

	for i = 1, #tileMaps do
		local mapData = tileMaps[i]
		local mapTile = self.mapTileCellPool:Obtain()

		mapTile.View:SetActive(true)
		mapTile.View.transform:SetParent(self.MapNode.transform, false)
		mapTile:SetData(mapData)

		self.mapTileCells[mapData.index] = mapTile
	end
end

function AmusementParkGameBlocksUI:OnUpdatePuzzleGameRank()
	local rank = AmusementParkPuzzleGameModule.myRanking or 0

	self.RankTag:SetActive(false)

	if AmusementParkPuzzleGameModule.rankType == 2 then
		rank = 999

		self.RankTag:SetActive(true)
	elseif rank > 999 then
		rank = 999

		self.RankTag:SetActive(true)
	end

	UGUIUtil.SetText(self.TextRank, AmusementParkGameBlocksUIApi:GetString("TextRank", rank))
	UGUIUtil.SetText(self.TextMaxLv, AmusementParkGameBlocksUIApi:GetString("TextMaxLv", AmusementParkPuzzleGameModule.maxLv or 0))
	UGUIUtil.SetText(self.TextMaxScore, AmusementParkPuzzleGameModule.maxScore or 0)
end

function AmusementParkGameBlocksUI:CreateBlocks()
	for i, cells in pairs(self.blockCells) do
		for j, v in pairs(cells) do
			self.blockCellPools[i]:Release(v)
			v.View:SetActive(false)
			v.View.transform:SetParent(self.UIController.transform, false)
		end

		self.blockCells[i] = {}
	end

	local randomBlock = AmusementParkPuzzleGameModule.apPuzzleGameData.randomBlock

	for i = 1, #randomBlock do
		local parent = self["Pos" .. i].transform

		if parent == nil then
			parent = self.Left.transform
		end

		local id = randomBlock[i]
		local blockCell = self.blockCellPools[id]:Obtain()

		blockCell.View.transform:SetParent(parent, false)
		blockCell.View:SetActive(true)
		blockCell:SetData(id)
		table.insert(self.blockCells[id], blockCell)
	end
end

function AmusementParkGameBlocksUI:RefreshBtnState()
	local isShow = AmusementParkPuzzleGameModule.apPuzzleGameData ~= nil

	self.BtnReset:SetActive(isShow)
	self.BtnStartGame:SetActive(not isShow)
end

function AmusementParkGameBlocksUI:OnBtnReset()
	self:StartNewGame()
end

function AmusementParkGameBlocksUI:OnBtnStartGame()
	self:StartNewGame()
end

function AmusementParkGameBlocksUI:StartNewGame()
	AmusementParkPuzzleGameModule.CreateNewGame()
	AmusementParkPuzzleGameModule.apPuzzleGameData:RefreshRandomBlock()
	self:CreateMap()
	self:CreateBlocks()
	self:RefreshBtnState()
end

function AmusementParkGameBlocksUI:OnBtnRank()
	UIModule.Open(Constant.UIControllerName.AmusementParkGameBlocksRankUI, Constant.UILayer.UI)
end

function AmusementParkGameBlocksUI:OnDrag(cell)
	local tab = self:GetBlockOccupiedAreas(cell)

	for i, v in pairs(self.mapTileCells) do
		local isShow = table.indexOf(tab, v.tileData.index) ~= -1

		v:ShowPassNode(isShow)
	end
end

function AmusementParkGameBlocksUI:OnEndDrag(cell)
	for i, mapTile in pairs(self.mapTileCells) do
		mapTile:ShowPassNode(false)
	end

	local tab = self:GetBlockOccupiedAreas(cell)
	local emptyTileNum = 0

	for i, v in ipairs(tab) do
		if self.mapTileCells[v].tileData.blockId == 0 then
			emptyTileNum = emptyTileNum + 1
		end
	end

	if emptyTileNum == cell.blockNum then
		for i, v in ipairs(tab) do
			self.mapTileCells[v].tileData.blockId = cell.cid

			self.mapTileCells[v]:UpdateView()
			cell:PutDownMap()
		end

		AmusementParkPuzzleGameModule.apPuzzleGameData:RemoveBlock(cell.cid)
		self:CheckBlocksNum()
		self:CheckEliminate()
	else
		cell:OnFailure()
	end
end

function AmusementParkGameBlocksUI:CheckEliminate()
	local totalNum, lines, columns = AmusementParkPuzzleGameModule.apPuzzleGameData:Eliminate()

	for i, v in ipairs(lines) do
		for col = 1, AmusementParkPuzzleGameModule.apPuzzleGameData.maxColumn do
			local pos = (v - 1) * AmusementParkPuzzleGameModule.apPuzzleGameData.maxColumn + col

			self.mapTileCells[pos]:PlayEffect()

			self.mapTileCells[pos].tileData.blockId = 0

			self.mapTileCells[pos]:UpdateView()
		end
	end

	for i, col in ipairs(columns) do
		for line = 1, AmusementParkPuzzleGameModule.apPuzzleGameData.maxLine do
			local pos = (line - 1) * AmusementParkPuzzleGameModule.apPuzzleGameData.maxLine + col

			self.mapTileCells[pos]:PlayEffect()

			self.mapTileCells[pos].tileData.blockId = 0

			self.mapTileCells[pos]:UpdateView()
		end
	end

	local isPlaySound = totalNum > 0

	if isPlaySound then
		GameEntry.Sound:PlaySound(10802, Constant.SoundGroup.ENVIRONMENT)
	end

	local addScore = AmusementParkPuzzleGameModule.GetAddScore(totalNum)

	AmusementParkPuzzleGameModule.apPuzzleGameData:AddScore(addScore)
	AmusementParkPuzzleGameModule.Stacking()
	self:RefreshScore()
end

function AmusementParkGameBlocksUI:GetRemainingBlocks()
	local blockTab = {}

	for i, blocks in pairs(self.blockCells) do
		for j, blockCell in pairs(blocks) do
			if not blockCell.isPutDown then
				table.insert(blockTab, blockCell)
			end
		end
	end

	return blockTab
end

function AmusementParkGameBlocksUI:CheckBlocksNum()
	local blocks = self:GetRemainingBlocks()

	if #blocks == 0 then
		AmusementParkPuzzleGameModule.apPuzzleGameData:RefreshRandomBlock()
		self:CreateBlocks()
	end
end

function AmusementParkGameBlocksUI:CheckPutDownBlock(cell)
	local tab = {}

	for i, collider in pairs(cell.collider2DList) do
		for j, mapTile in pairs(self.mapTileCells) do
			local res = self:CheckBoundsIntersects(collider, mapTile.collider2D)

			if res then
				table.insert(tab, mapTile.tileData.index)
			end

			mapTile:ShowPassNode(false)
		end
	end

	for i, v in pairs(tab) do
		self.mapTileCells[v]:ShowPassNode(true)
	end
end

function AmusementParkGameBlocksUI:GetBlockOccupiedAreas(cell)
	local tab = {}

	for i, collider in pairs(cell.collider2DList) do
		for j, mapTile in pairs(self.mapTileCells) do
			local res = self:CheckBoundsIntersects(collider, mapTile.collider2D)

			if res then
				table.insert(tab, mapTile.tileData.index)
			end
		end
	end

	return tab
end

function AmusementParkGameBlocksUI:CheckBoundsIntersects(collider2D1, collider2D2)
	return collider2D1.bounds:Intersects(collider2D2.bounds)
end

return AmusementParkGameBlocksUI
