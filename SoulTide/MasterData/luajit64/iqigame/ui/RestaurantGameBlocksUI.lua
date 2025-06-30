-- chunkname: @IQIGame\\UI\\RestaurantGameBlocksUI.lua

local RestaurantGameBlocksUI = {
	mapTileCells = {},
	blockCellPools = {},
	blockCells = {}
}

RestaurantGameBlocksUI = Base:Extend("RestaurantGameBlocksUI", "IQIGame.Onigao.UI.RestaurantGameBlocksUI", RestaurantGameBlocksUI)

require("IQIGame.UIExternalApi.RestaurantGameBlocksUIApi")

local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local PuzzleGameMapTileCell = require("IQIGame.UI.ExploreHall.RestaurantOperation.PuzzleGame.PuzzleGameMapTileCell")
local PuzzleGameBlockCell = require("IQIGame.UI.ExploreHall.RestaurantOperation.PuzzleGame.PuzzleGameBlockCell")

function RestaurantGameBlocksUI:OnInit()
	UGUIUtil.SetTextInChildren(self.ConfirmBtn, RestaurantGameBlocksUIApi:GetString("Title"))

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
		local tileCell = PuzzleGameMapTileCell.New(UnityEngine.Object.Instantiate(self.TileModel))

		return tileCell
	end, function(cell)
		cell:Dispose()
	end)
	self.blockCellPools = {}

	for i = 0, self.Blocks.transform.childCount - 1 do
		local obj = self.Blocks.transform:GetChild(i).gameObject

		self.blockCellPools[tonumber(obj.name)] = UIObjectPool.New(5, function()
			local blockCell = PuzzleGameBlockCell.New(UnityEngine.Object.Instantiate(obj))

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

function RestaurantGameBlocksUI:GetPreloadAssetPaths()
	return nil
end

function RestaurantGameBlocksUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function RestaurantGameBlocksUI:IsManualShowOnOpen(userData)
	return false
end

function RestaurantGameBlocksUI:GetBGM(userData)
	return nil
end

function RestaurantGameBlocksUI:OnOpen(userData)
	RestaurantOperationModule.SetRestaurantSceneActive(false)
	ROPuzzleGameModule.GetPuzzleGameRanking()
	self:UpdateView()
end

function RestaurantGameBlocksUI:OnClose(userData)
	RestaurantOperationModule.SetRestaurantSceneActive(true)
end

function RestaurantGameBlocksUI:OnAddListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickConfirmBtn)
	self.BtnStartGame:GetComponent("Button").onClick:AddListener(self.DelegateBtnStartGame)
	self.BtnRank:GetComponent("Button").onClick:AddListener(self.DelegateBtnRank)
	self.BtnReset:GetComponent("Button").onClick:AddListener(self.DelegateBtnReset)
	EventDispatcher.AddEventListener(EventID.ROUpdatePuzzleGameRankEvent, self.DelegateUpdatePuzzleGameRank)
end

function RestaurantGameBlocksUI:OnRemoveListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickConfirmBtn)
	self.BtnStartGame:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnStartGame)
	self.BtnRank:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnRank)
	self.BtnReset:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnReset)
	EventDispatcher.RemoveEventListener(EventID.ROUpdatePuzzleGameRankEvent, self.DelegateUpdatePuzzleGameRank)
end

function RestaurantGameBlocksUI:OnPause()
	return
end

function RestaurantGameBlocksUI:OnResume()
	return
end

function RestaurantGameBlocksUI:OnCover()
	return
end

function RestaurantGameBlocksUI:OnReveal()
	return
end

function RestaurantGameBlocksUI:OnRefocus(userData)
	return
end

function RestaurantGameBlocksUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function RestaurantGameBlocksUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function RestaurantGameBlocksUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function RestaurantGameBlocksUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function RestaurantGameBlocksUI:OnDestroy()
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

function RestaurantGameBlocksUI:OnClickConfirmBtn()
	UIModule.CloseSelf(self)
end

function RestaurantGameBlocksUI:UpdateView()
	self:RefreshScore()
	self:OnUpdatePuzzleGameRank()

	if ROPuzzleGameModule.roPuzzleGameData then
		self:CreateMap()
		self:CreateBlocks()
	end

	self:RefreshBtnState()
end

function RestaurantGameBlocksUI:RefreshScore()
	if ROPuzzleGameModule.roPuzzleGameData then
		UGUIUtil.SetText(self.TextCurrentScore, ROPuzzleGameModule.roPuzzleGameData.score)
	else
		UGUIUtil.SetText(self.TextCurrentScore, 0)
	end
end

function RestaurantGameBlocksUI:CreateMap()
	for i, v in pairs(self.mapTileCells) do
		self.mapTileCellPool:Release(v)
		v.View:SetActive(false)
		v.View.transform:SetParent(self.UIController.transform, false)
	end

	self.mapTileCells = {}

	local tileMaps = ROPuzzleGameModule.roPuzzleGameData.tileMaps

	for i = 1, #tileMaps do
		local mapData = tileMaps[i]
		local mapTile = self.mapTileCellPool:Obtain()

		mapTile.View:SetActive(true)
		mapTile.View.transform:SetParent(self.MapNode.transform, false)
		mapTile:SetData(mapData)

		self.mapTileCells[mapData.index] = mapTile
	end
end

function RestaurantGameBlocksUI:OnUpdatePuzzleGameRank()
	local rank = ROPuzzleGameModule.myRanking or 0

	UGUIUtil.SetText(self.TextRank, RestaurantGameBlocksUIApi:GetString("TextRank", rank))
	self.RankTag:SetActive(rank > ROPuzzleGameModule.puzzleGameRankMaxNum)
	UGUIUtil.SetText(self.TextMaxScore, ROPuzzleGameModule.maxScore)
end

function RestaurantGameBlocksUI:CreateBlocks()
	for i, cells in pairs(self.blockCells) do
		for j, v in pairs(cells) do
			self.blockCellPools[i]:Release(v)
			v.View:SetActive(false)
			v.View.transform:SetParent(self.UIController.transform, false)
		end

		self.blockCells[i] = {}
	end

	local randomBlock = ROPuzzleGameModule.roPuzzleGameData.randomBlock

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

function RestaurantGameBlocksUI:RefreshBtnState()
	local isShow = ROPuzzleGameModule.roPuzzleGameData ~= nil

	self.BtnReset:SetActive(isShow)
	self.BtnStartGame:SetActive(not isShow)
end

function RestaurantGameBlocksUI:OnBtnReset()
	self:StartNewGame()
end

function RestaurantGameBlocksUI:OnBtnStartGame()
	self:StartNewGame()
end

function RestaurantGameBlocksUI:StartNewGame()
	ROPuzzleGameModule.CreateNewGame()
	ROPuzzleGameModule.roPuzzleGameData:RefreshRandomBlock()
	self:CreateMap()
	self:CreateBlocks()
	self:RefreshBtnState()
end

function RestaurantGameBlocksUI:OnBtnRank()
	UIModule.Open(Constant.UIControllerName.RestaurantGameBlocksRankUI, Constant.UILayer.UI)
end

function RestaurantGameBlocksUI:OnDrag(cell)
	local tab = self:GetBlockOccupiedAreas(cell)

	for i, v in pairs(self.mapTileCells) do
		local isShow = table.indexOf(tab, v.tileData.index) ~= -1

		v:ShowPassNode(isShow)
	end
end

function RestaurantGameBlocksUI:OnEndDrag(cell)
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

		ROPuzzleGameModule.roPuzzleGameData:RemoveBlock(cell.cid)
		self:CheckBlocksNum()
		self:CheckEliminate()
	else
		cell:OnFailure()
	end

	self:CheckEndGame()
end

function RestaurantGameBlocksUI:CheckEndGame()
	return
end

function RestaurantGameBlocksUI:CheckEliminate()
	local totalNum, lines, columns = ROPuzzleGameModule.roPuzzleGameData:Eliminate()

	for i, v in ipairs(lines) do
		for col = 1, ROPuzzleGameModule.roPuzzleGameData.maxColumn do
			local pos = (v - 1) * ROPuzzleGameModule.roPuzzleGameData.maxColumn + col

			self.mapTileCells[pos]:PlayEffect()

			self.mapTileCells[pos].tileData.blockId = 0

			self.mapTileCells[pos]:UpdateView()
		end
	end

	for i, col in ipairs(columns) do
		for line = 1, ROPuzzleGameModule.roPuzzleGameData.maxLine do
			local pos = (line - 1) * ROPuzzleGameModule.roPuzzleGameData.maxLine + col

			self.mapTileCells[pos]:PlayEffect()

			self.mapTileCells[pos].tileData.blockId = 0

			self.mapTileCells[pos]:UpdateView()
		end
	end

	local isPlaySound = totalNum > 0

	if isPlaySound then
		GameEntry.Sound:PlaySound(10802, Constant.SoundGroup.ENVIRONMENT)
	end

	local addScore = ROPuzzleGameModule.GetAddScore(totalNum)

	ROPuzzleGameModule.roPuzzleGameData:AddScore(addScore)
	ROPuzzleGameModule.Puzzle()
	self:RefreshScore()
end

function RestaurantGameBlocksUI:GetRemainingBlocks()
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

function RestaurantGameBlocksUI:CheckBlocksNum()
	local blocks = self:GetRemainingBlocks()

	if #blocks == 0 then
		ROPuzzleGameModule.roPuzzleGameData:RefreshRandomBlock()
		self:CreateBlocks()
	end
end

function RestaurantGameBlocksUI:CheckPutDownBlock(cell)
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

function RestaurantGameBlocksUI:GetBlockOccupiedAreas(cell)
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

function RestaurantGameBlocksUI:CheckBoundsIntersects(collider2D1, collider2D2)
	return collider2D1.bounds:Intersects(collider2D2.bounds)
end

return RestaurantGameBlocksUI
