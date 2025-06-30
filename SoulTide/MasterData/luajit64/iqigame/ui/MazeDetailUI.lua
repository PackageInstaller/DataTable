-- chunkname: @IQIGame\\UI\\MazeDetailUI.lua

local MazeDetailUI = Base:Extend("MazeDetailUI", "IQIGame.Onigao.UI.MazeDetailUI", {
	MazeCid = 0,
	MonsterElementCells = {}
})
local FormationPanelController = require("IQIGame.UI.FormationUI.FormationPanelController")
local MazeRewardCell = require("IQIGame.UI.MazeDetail.MazeRewardCell")
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local MonsterElementCell = require("IQIGame.UI.MazeDetail.MonsterElementCell")

function MazeDetailUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnClickConfirmBtn()
		self:OnClickConfirmBtn()
	end

	function self.DelegateOnClickSweepBtn()
		self:OnClickSweepBtn()
	end

	function self.DelegateOnClickQuickChallengeBtn()
		self:OnClickQuickChallengeBtn()
	end

	function self.DelegateOnPlayerNumAttrsChange(itemCid, value)
		self:OnPlayerNumAttrsChange(itemCid, value)
	end

	self.EnergyCell = EnergyCell.New(self.EnergyCom.transform:GetChild(0).gameObject)
	self.CurrencyControllers = {}

	self:AddCurrencyCell(Constant.ItemID.MONEY)
	self:AddCurrencyCell(Constant.ItemID.TREASURE)

	self.FormationPanelController = FormationPanelController.New(self.FormationNode, function()
		self:OnUpdateFormation()
	end)
	self.MonsterElementPool = UIObjectPool.New(5, function()
		local cell = MonsterElementCell.New(UnityEngine.Object.Instantiate(self.MonsterElementPrefab))

		return cell
	end, function(cell)
		local v = cell.View

		cell:Dispose()
		UnityEngine.Object.Destroy(v)
	end)
	self.RewardCells = {}

	for i = 1, 5 do
		local itemCell = MazeRewardCell.New(UnityEngine.Object.Instantiate(self.RewardPrefab))

		itemCell.View.transform:SetParent(self.RewardGrid.transform, false)
		table.insert(self.RewardCells, itemCell)
	end

	UGUIUtil.SetText(self.TitleText, MazeDetailUIApi:GetString("TitleText"))
	UGUIUtil.SetText(self.RewardLabelText, MazeDetailUIApi:GetString("RewardLabelText"))
	UGUIUtil.SetTextInChildren(self.ConfirmBtn, MazeDetailUIApi:GetString("ConfirmBtnText"))
	UGUIUtil.SetText(self.MonsterPanelLabel, MazeDetailUIApi:GetString("MonsterPanelLabel"))
	UGUIUtil.SetText(self.ExploreLabel, MazeDetailUIApi:GetString("ExploreLabel"))
	UGUIUtil.SetText(self.SweepNoticeText, MazeDetailUIApi:GetString("SweepNoticeText"))
	UGUIUtil.SetText(self.CheckPointText, MazeDetailUIApi:GetString("CheckPointText"))
	UGUIUtil.SetTextInChildren(self.FirstEnergyView, MazeDetailUIApi:GetString("FirstEnergyText"))
	UGUIUtil.SetText(self.CannotSweepBtnText1, MazeDetailUIApi:GetString("CannotSweepBtnText1"))
	UGUIUtil.SetText(self.CannotSweepBtnText2, MazeDetailUIApi:GetString("CannotSweepBtnText2"))
	UGUIUtil.SetTextInChildren(self.SweepBtn, MazeDetailUIApi:GetString("SweepBtnText"))
end

function MazeDetailUI:GetPreloadAssetPaths()
	local paths = {}

	table.insert(paths, AssetPath.Get(GlobalKey.UIPrefabPath, "Common/MoneyGrid_Mould"))

	return paths
end

function MazeDetailUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MazeDetailUI:OnOpen(userData)
	self:UpdateView(userData.mazeCid)
end

function MazeDetailUI:OnClose(userData)
	return
end

function MazeDetailUI:OnAddListeners()
	self.FormationPanelController:AddEventListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickConfirmBtn)
	self.SweepBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickSweepBtn)
	self.QuickChallengeBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickQuickChallengeBtn)
	EventDispatcher.AddEventListener(EventID.PlayerNumAttrsChange, self.DelegateOnPlayerNumAttrsChange)
end

function MazeDetailUI:OnRemoveListeners()
	self.FormationPanelController:RemoveEventListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickConfirmBtn)
	self.SweepBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickSweepBtn)
	self.QuickChallengeBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickQuickChallengeBtn)
	EventDispatcher.RemoveEventListener(EventID.PlayerNumAttrsChange, self.DelegateOnPlayerNumAttrsChange)
end

function MazeDetailUI:OnPause()
	return
end

function MazeDetailUI:OnResume()
	return
end

function MazeDetailUI:OnCover()
	return
end

function MazeDetailUI:OnReveal()
	return
end

function MazeDetailUI:OnRefocus(userData)
	return
end

function MazeDetailUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MazeDetailUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MazeDetailUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MazeDetailUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MazeDetailUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.EnergyCell:Dispose()

	for i = 1, #self.CurrencyControllers do
		self.CurrencyControllers[i]:Dispose()
	end

	self:ClearMonsterElementCells(true)
	self.MonsterElementPool:Dispose()

	for i = 1, #self.RewardCells do
		local itemCell = self.RewardCells[i]

		itemCell:Dispose()
	end

	self.RewardCells = nil

	self.FormationPanelController:Dispose()
end

function MazeDetailUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function MazeDetailUI:OnClickConfirmBtn()
	if not self.IsUnlock then
		local cfgConditionData = CfgConditionTable[self.cfgMazeInstanceData.LockCondition]

		NoticeModule.ShowNoticeNoCallback(21045025, cfgConditionData.Name)

		return
	end

	local validate, noticeCid, formationPOD = self:CheckValidation()

	if validate then
		if noticeCid ~= 0 then
			NoticeModule.ShowNotice(noticeCid, function()
				self:EnterMaze(formationPOD.id)
			end)
		else
			self:EnterMaze(formationPOD.id)
		end
	end
end

function MazeDetailUI:EnterMaze(formationId)
	local cfgMazeInstanceData = CfgMazeInstanceTable[self.MazeCid]
	local cfgChapterData = CfgChapterTable[cfgMazeInstanceData.ChapterId]

	if cfgChapterData.Type == Constant.Maze.ChapterTypeNormal then
		MazeModule.SendEnterWorldMazeMsg(self.MazeCid, formationId)
	else
		logError("迷宫类型错误：" .. cfgChapterData.Type)
	end
end

function MazeDetailUI:CheckValidation(isSweep)
	local formationPOD

	if not isSweep then
		local valid, formationPOD2 = self.FormationPanelController:CheckValidation()

		if not valid then
			return false, 0, nil
		end

		formationPOD = formationPOD2
	end

	if not isSweep then
		local cfgMazeInstanceData = CfgMazeInstanceTable[self.MazeCid]

		if #cfgMazeInstanceData.EnterRestrictedSoul > 0 then
			local formationSouls = {}

			if formationPOD then
				for prefabId, prefabIndex in pairs(formationPOD.formation) do
					local soulPrefabData = SoulPrefabModule.GetPrefab(prefabId)

					if soulPrefabData.soulCid ~= nil then
						table.insert(formationSouls, soulPrefabData.soulCid)
					end
				end
			end

			local canEnter = #formationSouls == #cfgMazeInstanceData.EnterRestrictedSoul
			local soulNames = ""

			for i, v in pairs(cfgMazeInstanceData.EnterRestrictedSoul) do
				canEnter = canEnter and table.indexOf(formationSouls, v) ~= -1
				soulNames = soulNames .. " " .. CfgSoulTable[v].Name
			end

			if not canEnter then
				NoticeModule.ShowNoticeNoCallback(21042051, soulNames)

				return false, 0, nil
			end
		end
	end

	local valid, noticeCid = MazeModule.CheckCanEnterMaze(self.MazeCid, formationPOD, isSweep)

	return valid, noticeCid, formationPOD
end

function MazeDetailUI:UpdateView(mazeCid)
	self.MazeCid = mazeCid
	self.cfgMazeInstanceData = CfgMazeInstanceTable[self.MazeCid]
	self.cfgChapterData = CfgChapterTable[self.cfgMazeInstanceData.ChapterId]

	UGUIUtil.SetText(self.MazeOrderText, MazeDetailUIApi:GetString("MazeOrderText", self.cfgChapterData.Order, self.cfgMazeInstanceData.Order))
	UGUIUtil.SetText(self.MazeNameText, self.cfgMazeInstanceData.Name)
	UGUIUtil.SetText(self.MazeDescText, self.cfgMazeInstanceData.Desc)

	local cfgRecommendPowerData = CfgRecommendPowerTable[self.cfgMazeInstanceData.RecommendPowerId]

	UGUIUtil.SetText(self.RecommendPowerText, MazeDetailUIApi:GetString("RecommendPowerText", cfgRecommendPowerData.RecommendPower))

	self.isQuickFinished = table.indexOf(PlayerModule.PlayerInfo.quickChallenge, self.cfgMazeInstanceData.Id) ~= -1

	self:UpdateCost()
	self:ClearMonsterElementCells(false)

	local elements = MazeModule.GetWeakShowData(self.cfgMazeInstanceData)

	for i = 1, #elements do
		local cell = self.MonsterElementPool:Obtain()

		cell.View:SetActive(true)
		cell.View.transform:SetParent(self.MonsterElementGrid.transform, false)
		cell:SetData(elements[i], self.cfgMazeInstanceData.MainWeakType)
		table.insert(self.MonsterElementCells, cell)
	end

	local rewards = MazeModule.GetRewardShowData(self.cfgMazeInstanceData)

	for i = 1, #self.RewardCells do
		local itemCell = self.RewardCells[i]
		local itemInfo = rewards[i]
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

		itemCell:SetData(itemCid, itemNum, isFirstPassReward, isUncertain)
	end

	local mazeInfoPOD = PlayerModule.PlayerInfo.mazeInfoPOD[self.MazeCid]
	local score = 0

	if mazeInfoPOD ~= nil then
		score = mazeInfoPOD.score
	end

	UGUIUtil.SetText(self.ExploreText, MazeDetailUIApi:GetString("ExploreText", score))

	self.ExploreBar:GetComponent("Image").fillAmount = score / 100

	self.ExploreMaxImg:SetActive(score >= 100)
	self.FormationPanelController:UpdateView()
	self.MonsterPanel:SetActive(#self.cfgMazeInstanceData.MonsterHead ~= 0)

	local isSweepAvailable = UnlockFunctionModule.IsUnlock(Constant.UnlockType.MAZE_SWEEP)

	self.IsUnlock = ConditionModule.Check(self.cfgMazeInstanceData.LockCondition)

	self.CannotSweepBtn:SetActive(isSweepAvailable and not self.isQuickFinished)
	self.SweepBtn:SetActive(isSweepAvailable and self.isQuickFinished)
	self.QuickChallengeBtn:SetActive(not self.isQuickFinished and self.cfgMazeInstanceData.QuickChallengeOpen)
	self.SweepNoticeText:SetActive(MazeDetailUIApi:GetString("ShowSweepNotice", self.cfgChapterData.Order, self.cfgMazeInstanceData.Order))
end

function MazeDetailUI:ClearMonsterElementCells(isDestroy)
	for i = 1, #self.MonsterElementCells do
		local cell = self.MonsterElementCells[i]

		cell.View:SetActive(false)

		if not isDestroy then
			cell.View.transform:SetParent(self.UIController.transform, false)
		end

		self.MonsterElementPool:Release(cell)
	end

	self.MonsterElementCells = {}
end

function MazeDetailUI:UpdateCost()
	local mazeInfoPOD = PlayerModule.PlayerInfo.mazeInfoPOD[self.MazeCid]
	local cfgMazeInstanceData = CfgMazeInstanceTable[self.MazeCid]
	local cfgItemData = CfgItemTable[Constant.ItemID.ENERGY]

	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(cfgItemData.Icon), self.CostItemIcon:GetComponent("Image"), nil, nil, nil, true)

	local isFirst = mazeInfoPOD == nil

	if self.isQuickFinished then
		isFirst = false
	end

	self.FirstEnergyView:SetActive(isFirst and cfgMazeInstanceData.FirstCost < cfgMazeInstanceData.Cost)

	local cost = cfgMazeInstanceData.Cost

	if isFirst then
		cost = cfgMazeInstanceData.FirstCost
	end

	UGUIUtil.SetText(self.CostItemNumText, MazeDetailUIApi:GetString("CostItemNumText", cost, cost > WarehouseModule.GetItemNumByCfgID(Constant.ItemID.ENERGY)))
end

function MazeDetailUI:OnUpdateFormation()
	local cfgMazeInstanceData = CfgMazeInstanceTable[self.MazeCid]
	local cfgRecommendPowerData = CfgRecommendPowerTable[cfgMazeInstanceData.RecommendPowerId]

	UGUIUtil.SetText(self.FormationPowerText, MazeDetailUIApi:GetString("FormationPowerText", self.FormationPanelController:GetPower(), cfgRecommendPowerData.RecommendPower))
end

function MazeDetailUI:AddCurrencyCell(currencyCid)
	local currencyModule = UnityEngine.Object.Instantiate(self.UIController:GetPreloadedAsset(AssetPath.Get(GlobalKey.UIPrefabPath, "Common/MoneyGrid_Mould")))

	currencyModule.transform:SetParent(self.CurrencyCom.transform, false)
	table.insert(self.CurrencyControllers, CurrencyCell.New(currencyModule, currencyCid))
end

function MazeDetailUI:OnClickSweepBtn()
	local validate, noticeCid, formationPOD = self:CheckValidation(true)

	if validate then
		UIModule.Open(Constant.UIControllerName.MazeSweepDetailConfirmUI, Constant.UILayer.UI, {
			mazeCid = self.MazeCid
		})
	end
end

function MazeDetailUI:OnClickQuickChallengeBtn()
	UIModule.Open(Constant.UIControllerName.MazeBossUI, Constant.UILayer.UI, {
		mazeCid = self.MazeCid
	})
end

function MazeDetailUI:OnPlayerNumAttrsChange(itemCid, value)
	if itemCid == Constant.ItemID.ENERGY then
		self:UpdateCost()
	end
end

return MazeDetailUI
