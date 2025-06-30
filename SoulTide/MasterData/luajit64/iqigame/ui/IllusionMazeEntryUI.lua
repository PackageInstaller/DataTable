-- chunkname: @IQIGame\\UI\\IllusionMazeEntryUI.lua

local IllusionMazeEntryUI = Base:Extend("IllusionMazeEntryUI", "IQIGame.Onigao.UI.IllusionMazeEntryUI", {
	IllusionLv2DiffCells = {},
	RewardCells = {}
})
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local IllusionMazeLv2DiffCell = require("IQIGame.UI.ExploreHall.IllusionMazeLv2DiffCell")
local MazeRewardCell = require("IQIGame.UI.MazeDetail.MazeRewardCell")

function IllusionMazeEntryUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnClickCollectionBtn()
		self:OnClickCollectionBtn()
	end

	function self.DelegateOnClickChallengeBtn()
		self:OnClickChallengeBtn()
	end

	function self.DelegateOnClickRestoreBtn()
		self:OnClickRestoreBtn()
	end

	function self.DelegateOnPlayerNumAttrsChange()
		self:OnPlayerNumAttrsChange()
	end

	function self.DelegateOnClickDiffDetailBtn()
		self:OnClickDiffDetailBtn()
	end

	function self.DelegateOnClickSweepBtn()
		self:OnClickSweepBtn()
	end

	self.moneyCellBuilder = MoneyCellsBuilder.New(self.CurrencyCom)

	self.moneyCellBuilder:RefreshView({
		Constant.ItemID.SPIRIT_AMBER
	})

	self.EnergyCell = EnergyCell.New(self.EnergyCom.transform:GetChild(0).gameObject)
	self.IllusionLv2DiffCellPool = UIObjectPool.New(5, function()
		return IllusionMazeLv2DiffCell.New(UnityEngine.Object.Instantiate(self.Lv2DiffCellPrefab))
	end, function(cell)
		local v = cell.View

		cell:Dispose()
		UnityEngine.Object.Destroy(v)
	end)

	local scrollAreaList = self.RewardCellGrid:GetComponent("ScrollAreaList")

	function scrollAreaList.onRenderCell(cell)
		self:OnRenderRewardCell(cell)
	end

	UGUIUtil.SetText(self.TitleText, IllusionMazeEntryUIApi:GetString("TitleText"))
	UGUIUtil.SetText(self.TipText, IllusionMazeEntryUIApi:GetString("TipText"))
	UGUIUtil.SetText(self.Lv1DiffLabel, IllusionMazeEntryUIApi:GetString("Lv1DiffLabel"))
	UGUIUtil.SetText(self.RewardLabel, IllusionMazeEntryUIApi:GetString("RewardLabel"))
	UGUIUtil.SetTextInChildren(self.ChallengeBtn, IllusionMazeEntryUIApi:GetString("ChallengeBtnText"))
	UGUIUtil.SetTextInChildren(self.RestoreBtn, IllusionMazeEntryUIApi:GetString("RestoreBtnText"))
	UGUIUtil.SetTextInChildren(self.CollectionBtn, IllusionMazeEntryUIApi:GetString("CollectionBtnText"))
end

function IllusionMazeEntryUI:GetPreloadAssetPaths()
	return nil
end

function IllusionMazeEntryUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function IllusionMazeEntryUI:IsManualShowOnOpen(userData)
	return false
end

function IllusionMazeEntryUI:GetBGM(userData)
	return nil
end

function IllusionMazeEntryUI:OnOpen(userData)
	self:UpdateView(userData)
end

function IllusionMazeEntryUI:OnClose(userData)
	return
end

function IllusionMazeEntryUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.CollectionBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCollectionBtn)
	self.ChallengeBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickChallengeBtn)
	self.RestoreBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickRestoreBtn)
	self.DiffDetailBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickDiffDetailBtn)
	self.SweepBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickSweepBtn)
	EventDispatcher.AddEventListener(EventID.PlayerNumAttrsChange, self.DelegateOnPlayerNumAttrsChange)
end

function IllusionMazeEntryUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.CollectionBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCollectionBtn)
	self.ChallengeBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickChallengeBtn)
	self.RestoreBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickRestoreBtn)
	self.DiffDetailBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickDiffDetailBtn)
	self.SweepBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickSweepBtn)
	EventDispatcher.RemoveEventListener(EventID.PlayerNumAttrsChange, self.DelegateOnPlayerNumAttrsChange)
end

function IllusionMazeEntryUI:OnPause()
	return
end

function IllusionMazeEntryUI:OnResume()
	return
end

function IllusionMazeEntryUI:OnCover()
	return
end

function IllusionMazeEntryUI:OnReveal()
	return
end

function IllusionMazeEntryUI:OnRefocus(userData)
	return
end

function IllusionMazeEntryUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function IllusionMazeEntryUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function IllusionMazeEntryUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function IllusionMazeEntryUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function IllusionMazeEntryUI:OnDestroy()
	self.moneyCellBuilder:Dispose()
	self.EnergyCell:Dispose()
	self:ClearIllusionLv2DiffCell(true)
	self.IllusionLv2DiffCellPool:Dispose()

	for gameObject, rewardCell in pairs(self.RewardCells) do
		rewardCell:Dispose()
	end

	self.RewardCells = nil
end

function IllusionMazeEntryUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function IllusionMazeEntryUI:OnClickCollectionBtn()
	TownLibraryModule.OpenLibrary(function()
		UIModule.Open(Constant.UIControllerName.IllusionMazeElementCollectionUI, Constant.UILayer.UI)
	end)
end

function IllusionMazeEntryUI:OnClickChallengeBtn()
	local unfinishedMazeCid = PlayerModule.GetUnfinishedMazeCid(Constant.Maze.ChapterTypeIllusion)

	if unfinishedMazeCid ~= nil then
		return
	end

	local leftCount = DailyDupModule.GetLeftCount(self.DailyDupPOD)

	if leftCount <= 0 then
		NoticeModule.ShowNotice(21040092)

		return
	end

	local cfgMazeInstanceData = CfgMazeInstanceTable[Constant.MazeId.IllusionMaze]

	if WarehouseModule.GetItemNumByCfgID(Constant.ItemID.ENERGY) < cfgMazeInstanceData.Cost then
		NoticeModule.ShowNotice(21045026)

		return
	end

	MazeModule.SendEnterIllusionMaze(Constant.MazeId.IllusionMaze, SoulModule.curSoulData.soulCid)
end

function IllusionMazeEntryUI:OnClickRestoreBtn()
	local unfinishedMazeCid = PlayerModule.GetUnfinishedMazeCid(Constant.Maze.ChapterTypeIllusion)

	if unfinishedMazeCid == nil then
		return
	end

	MazeModule.SendRestore(unfinishedMazeCid)
end

function IllusionMazeEntryUI:UpdateView(dailyDupPOD)
	self.DailyDupPOD = dailyDupPOD

	self:Refresh()
end

function IllusionMazeEntryUI:Refresh()
	local cfgDailyDupData = CfgDailyDupTable[self.DailyDupPOD.common.cid]

	UGUIUtil.SetText(self.MazeNameText, cfgDailyDupData.Name)

	local unfinishedMazeCid = PlayerModule.GetUnfinishedMazeCid(Constant.Maze.ChapterTypeIllusion)

	self.ChallengeBtn:SetActive(unfinishedMazeCid == nil)
	self.RestoreBtn:SetActive(unfinishedMazeCid ~= nil)

	local cfgMazeInstanceData = CfgMazeInstanceTable[Constant.MazeId.IllusionMaze]

	UGUIUtil.SetText(self.EnergyCostText, IllusionMazeEntryUIApi:GetString("EnergyCostText", cfgMazeInstanceData.Cost, WarehouseModule.GetItemNumByCfgID(Constant.ItemID.ENERGY)))

	local cfgChapterDataOfLatestUnlockMaze, latestUnlockMazeData, maxChapterOrder = PlayerModule.GetLatestNormalMazeData()
	local lv1Diff, lv2Diff, maxLv2Diff = IllusionMazeEntryUIApi:GetString("IllusionDifficulty", cfgChapterDataOfLatestUnlockMaze.Order, maxChapterOrder)

	UGUIUtil.SetText(self.Lv1DiffText, lv1Diff)
	self:ClearIllusionLv2DiffCell()

	for i = 1, maxLv2Diff do
		local diffCell = self.IllusionLv2DiffCellPool:Obtain()

		diffCell.View:SetActive(true)
		diffCell.View.transform:SetParent(self.Lv2DiffGrid.transform, false)
		diffCell:SetData(i <= lv2Diff)
		table.insert(self.IllusionLv2DiffCells, diffCell)
	end

	self.RewardDataList = MazeModule.GetRewardShowData(cfgMazeInstanceData)

	local scrollAreaList = self.RewardCellGrid:GetComponent("ScrollAreaList")

	scrollAreaList:Refresh(#self.RewardDataList)

	local isSweepAvailable = UnlockFunctionModule.IsUnlock(Constant.UnlockType.MAZE_SWEEP)
	local passItemNum = WarehouseModule.GetItemNumByCfgID(1201061)

	self.SweepBtn:SetActive(isSweepAvailable and passItemNum > 0)
end

function IllusionMazeEntryUI:ClearIllusionLv2DiffCell(isDestroy)
	for i = 1, #self.IllusionLv2DiffCells do
		local cell = self.IllusionLv2DiffCells[i]

		cell.View:SetActive(false)

		if not isDestroy then
			cell.View.transform:SetParent(self.UIController.transform, false)
		end

		self.IllusionLv2DiffCellPool:Release(cell)
	end

	self.IllusionLv2DiffCells = {}
end

function IllusionMazeEntryUI:OnPlayerNumAttrsChange()
	self:Refresh()
end

function IllusionMazeEntryUI:OnClickDiffDetailBtn()
	UIModule.Open(Constant.UIControllerName.TextFollowingTipUI, Constant.UILayer.UI, {
		title = IllusionMazeEntryUIApi:GetString("DifficultyTipTitle"),
		content = IllusionMazeEntryUIApi:GetString("DifficultyTipContent"),
		refTrans = self.DiffDetailBtn.transform,
		refAlign = UGUISide.Top,
		tipAlign = UGUISide.BottomLeft
	})
end

function IllusionMazeEntryUI:OnRenderRewardCell(cell)
	local rewardCell = self.RewardCells[cell.gameObject]

	if rewardCell == nil then
		rewardCell = MazeRewardCell.New(cell.gameObject)
		self.RewardCells[cell.gameObject] = rewardCell
	end

	local itemInfo = self.RewardDataList[cell.index + 1]
	local itemCid = 0
	local itemNum = 0
	local isFirstPassReward = false
	local isUncertain = false

	if itemInfo ~= nil then
		itemCid = itemInfo.cid
		itemNum = itemInfo.number
		isFirstPassReward = itemInfo.isFirstPassReward
		isUncertain = itemInfo.isUncertain
	end

	rewardCell:SetData(itemCid, itemNum, isFirstPassReward, isUncertain)
end

function IllusionMazeEntryUI:OnClickSweepBtn()
	if NoticeModule.IsCustomIgnore(Constant.CustomIgnoreType.IllusionMazeSweep) then
		MazeModule.SweepIllusionMaze(Constant.MazeId.IllusionMaze, 1)
	else
		UIModule.Open(Constant.UIControllerName.IllusionMazeSweepUI, Constant.UILayer.UI)
	end
end

return IllusionMazeEntryUI
