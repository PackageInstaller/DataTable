-- chunkname: @IQIGame\\UI\\EndlessMazeMainUI.lua

local EndlessMazeMainUI = {
	CurrentScoreUpperLimit = 0,
	ScaleTweenList = {},
	RewardCells = {},
	LastBoxCidNumMap = {}
}

EndlessMazeMainUI = Base:Extend("EndlessMazeMainUI", "IQIGame.Onigao.UI.EndlessMazeMainUI", EndlessMazeMainUI)

local MazeMainUICommonModuleController = require("IQIGame.UI.Maze.MazeMainUICommonModuleController")
local EndlessMazeRewardBoxCell = require("IQIGame.UI.Maze.EndlessMazeRewardBoxCell")
local EndlessMazeNextRewardTip = require("IQIGame.UI.Maze.EndlessMazeNextRewardTip")
local EndlessMazeRewardBoxTip = require("IQIGame.UI.Maze.EndlessMazeRewardBoxTip")
local EndlessMazeRuneItemCell = require("IQIGame.UI.Maze.EndlessMazeRuneItemCell")
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local EndlessMazeRuneCell = require("IQIGame.UI.EndlessMazeRune.EndlessMazeRuneCell")

function EndlessMazeMainUI:OnInit()
	function self.DelegateOnUpdateExploreScore(addValue)
		self:OnUpdateExploreScore(addValue)
	end

	function self.DelegateOnClickEngravingBtn()
		self:OnClickEngravingBtn()
	end

	function self.DelegateOnClickScoreInfoBtn()
		self:OnClickScoreInfoBtn()
	end

	function self.DelegateOnMazeFlyRuneOrItem(dataList)
		self:OnMazeFlyRuneOrItem(dataList)
	end

	function self.DelegateOnAbyssDifficultyChanged()
		self:OnAbyssDifficultyChanged()
	end

	self.CommonModule = MazeMainUICommonModuleController.New(self.CommonModule, self.UIController, self.Top, self.BtnGroup, self.Bottom, function()
		return self:GetCustomData()
	end)

	self.CommonModule:OnInit()

	self.CurrencyCell = MazeCurrencyCell.New(self.CurrencyModule, 4)
	self.RewardCellPool = UIObjectPool.New(5, function()
		local cell = EndlessMazeRewardBoxCell.New(UnityEngine.Object.Instantiate(self.RewardCellPrefab), function(cfgMazeEndlessBoxData, position)
			self:OnClickRewardBox(cfgMazeEndlessBoxData, position)
		end)

		return cell
	end, function(cell)
		local v = cell.View

		cell:Dispose()
		UnityEngine.Object.Destroy(v)
	end)
	self.NextRewardTipController = EndlessMazeNextRewardTip.New(self.NextRewardTip)

	self.NextRewardTipController:Hide()

	self.RewardBoxTipController = EndlessMazeRewardBoxTip.New(self.RewardBoxTip)

	self.RewardBoxTipController:Hide()

	local runeItemPrefab = self.UIController:GetPreloadedAsset(UIGlobalApi.GetRuneItemSlotUIPath())

	self.RuneItems = {}

	for i = 1, 3 do
		local go = UnityEngine.Object.Instantiate(runeItemPrefab)

		go.transform:SetParent(self.RuneItemGrid.transform, false)
		table.insert(self.RuneItems, EndlessMazeRuneItemCell.New(go, function()
			self:ShowRuneItemTip()
		end))
	end

	self.FlyRunePool = UIObjectPool.New(3, function()
		return EndlessMazeRuneCell.New(UnityEngine.Object.Instantiate(self.UIController:GetPreloadedAsset(UIGlobalApi.GetRuneSlotUIPath())), false)
	end, function(cell)
		local v = cell.View

		cell:Dispose()
		UnityEngine.Object.Destroy(v)
	end)
	self.FlyRuneItemPool = UIObjectPool.New(3, function()
		return EndlessMazeRuneItemCell.New(UnityEngine.Object.Instantiate(runeItemPrefab), nil, false)
	end, function(cell)
		local v = cell.View

		cell:Dispose()
		UnityEngine.Object.Destroy(v)
	end)

	UGUIUtil.SetText(self.ScoreLabelText, EndlessMazeMainUIApi:GetString("ScoreLabelText"))
	UGUIUtil.SetTextInChildren(self.EngravingBtn, EndlessMazeMainUIApi:GetString("EngravingBtnText"))
end

function EndlessMazeMainUI:GetPreloadAssetPaths()
	local paths = {}
	local boxImagePaths = EndlessMazeMainUIApi:GetString("ScoreInfoBoxImagePaths")

	for i = 1, #boxImagePaths do
		table.insert(paths, boxImagePaths[i])
	end

	table.insert(paths, UIGlobalApi.GetRuneSlotUIPath())
	table.insert(paths, UIGlobalApi.GetRuneItemSlotUIPath())

	local commonModulePaths = MazeMainUICommonModuleController.GetPreloadAssetPaths()

	if commonModulePaths ~= nil then
		for i = 1, #commonModulePaths do
			table.insert(paths, commonModulePaths[i])
		end
	end

	return paths
end

function EndlessMazeMainUI:GetOpenPreloadAssetPaths(userData)
	return MazeMainUICommonModuleController.GetOpenPreloadAssetPaths(userData)
end

function EndlessMazeMainUI:OnOpen(userData)
	self.CommonModule:OnOpen(userData)
	self:UpdateView()
end

function EndlessMazeMainUI:OnClose(userData)
	self.CommonModule:OnClose(userData)
	ModuleTimerUtil.Stop(Constant.UIControllerName.EndlessMazeMainUI)
end

function EndlessMazeMainUI:OnAddListeners()
	self.CommonModule:OnAddListeners()
	self.EngravingBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickEngravingBtn)
	self.ScoreInfoBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickScoreInfoBtn)
	EventDispatcher.AddEventListener(EventID.MazeUpdateExploreScore, self.DelegateOnUpdateExploreScore)
	EventDispatcher.AddEventListener(EventID.MazeFlyRuneOrItem, self.DelegateOnMazeFlyRuneOrItem)
	EventDispatcher.AddEventListener(EventID.AbyssDifficultyChanged, self.DelegateOnAbyssDifficultyChanged)
end

function EndlessMazeMainUI:OnRemoveListeners()
	self.CommonModule:OnRemoveListeners()
	self.EngravingBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickEngravingBtn)
	self.ScoreInfoBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickScoreInfoBtn)
	EventDispatcher.RemoveEventListener(EventID.MazeUpdateExploreScore, self.DelegateOnUpdateExploreScore)
	EventDispatcher.RemoveEventListener(EventID.MazeFlyRuneOrItem, self.DelegateOnMazeFlyRuneOrItem)
	EventDispatcher.RemoveEventListener(EventID.AbyssDifficultyChanged, self.DelegateOnAbyssDifficultyChanged)
end

function EndlessMazeMainUI:OnPause()
	self.CommonModule:OnPause()
end

function EndlessMazeMainUI:OnResume()
	self.CommonModule:OnResume()
end

function EndlessMazeMainUI:OnCover()
	self.CommonModule:OnCover()
end

function EndlessMazeMainUI:OnReveal()
	self.CommonModule:OnReveal()
end

function EndlessMazeMainUI:OnRefocus(userData)
	self.CommonModule:OnRefocus(userData)
end

function EndlessMazeMainUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self.CommonModule:OnUpdate(elapseSeconds, realElapseSeconds)
end

function EndlessMazeMainUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	self.CommonModule:OnDepthChanged(uiGroupDepth, depthInUIGroup)
end

function EndlessMazeMainUI:OnLoadSucceed(assetName, asset, duration, userData)
	self.CommonModule:OnLoadSucceed(assetName, asset, duration, userData)
end

function EndlessMazeMainUI:OnLoadFailed(assetName, status, errorMessage, userData)
	self.CommonModule:OnLoadFailed(assetName, status, errorMessage, userData)
end

function EndlessMazeMainUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.CommonModule:OnDestroy()
	self.CurrencyCell:Dispose()
	self.NextRewardTipController:Dispose()
	self.RewardBoxTipController:Dispose()
	self:ClearRewardCells(true)
	self.RewardCellPool:Dispose()

	for i = 1, #self.RuneItems do
		local cell = self.RuneItems[i]

		cell:Dispose()
	end

	local copy = {}

	for i = 1, #self.ScaleTweenList do
		copy[i] = self.ScaleTweenList[i]
	end

	for i = 1, #copy do
		local tween = copy[i]

		tween:Stop(TweenStopBehavior.Complete)
	end

	self.FlyRunePool:Dispose()
	self.FlyRuneItemPool:Dispose()
end

function EndlessMazeMainUI:UpdateView()
	self.CfgMazeInstanceData = CfgMazeInstanceTable[MazeDataModule.MazeInstanceID]

	local cfgChapterData = CfgChapterTable[self.CfgMazeInstanceData.ChapterId]

	UGUIUtil.SetText(self.MazeNameText, EndlessMazeMainUIApi:GetString("MazeNameText", cfgChapterData.Order, self.CfgMazeInstanceData.Order, self.CfgMazeInstanceData.Name))
	self:UpdateScore()
	self.CurrencyCell:UpdateNum()
	self:UpdateRuneItems()
	self:UpdateDangerLevel()
end

function EndlessMazeMainUI:UpdateDangerLevel()
	self.DangerLabelBg:SetActive(false)
	AssetUtil.LoadImage(self, EndlessMazeMainUIApi:GetString("DangerLabelBg", MazeDataModule.PlayerInfo.MonsterGrade, MazeDataModule.PlayerInfo.AbyssPowerId), self.DangerLabelBg:GetComponent("Image"), self.OnLoadImageSuccess, nil, self.DangerLabelBg)
	UGUIUtil.SetText(self.DangerLabel, EndlessMazeMainUIApi:GetString("DangerLabel", MazeDataModule.PlayerInfo.MonsterGrade, MazeDataModule.PlayerInfo.AbyssPowerId))
	UGUIUtil.SetText(self.DangerText, EndlessMazeMainUIApi:GetString("DangerText", MazeDataModule.PlayerInfo.MonsterGrade, MazeDataModule.PlayerInfo.AbyssPowerId))

	self.DangerOutline:GetComponent("OutlineRenderCfgUGUI").color = hexStringToColor(EndlessMazeMainUIApi:GetString("DangerOutlineColor", MazeDataModule.PlayerInfo.MonsterGrade, MazeDataModule.PlayerInfo.AbyssPowerId))
end

function EndlessMazeMainUI:UpdateRuneItems()
	local runeItemDataList = {}
	local items = MazeDataModule.GetAllItems(0)

	for i = 1, #items do
		local itemData = items[i]
		local cfgItemData = itemData:GetCfg()

		if cfgItemData.Type == Constant.ItemType.Item and cfgItemData.SubType == Constant.ItemSubType.ItemUnlockRune then
			table.insert(runeItemDataList, itemData)
		end
	end

	for i = 1, #self.RuneItems do
		local cell = self.RuneItems[i]

		cell:SetData(runeItemDataList[i])
	end
end

function EndlessMazeMainUI:GetCustomData()
	local cfgMazeInstanceData = CfgMazeInstanceTable[MazeDataModule.MazeInstanceID]

	return {
		startTitle = EndlessMazeMainUIApi:GetString("StartTitleText"),
		startTip = EndlessMazeMainUIApi:GetString("StartTipText", cfgMazeInstanceData.ConditionsDesc)
	}
end

function EndlessMazeMainUI:UpdateScore(addValue)
	self.ScoreView:SetActive(MazeDataModule.PlayerInfo.AbyssDifficulty > 0)

	if MazeDataModule.PlayerInfo.AbyssDifficulty == 0 then
		return
	end

	local isUpdate = addValue ~= nil
	local score = MazeDataModule.PlayerInfo.ExploreScore
	local oldScoreUpperLimit

	if isUpdate then
		oldScoreUpperLimit = self.CurrentScoreUpperLimit
	end

	self.CurrentScoreUpperLimit = 0

	local endlessScores = self.CfgMazeInstanceData.EndlessScore[MazeDataModule.PlayerInfo.AbyssDifficulty]
	local endlessRewards = self.CfgMazeInstanceData.EndlessReward[MazeDataModule.PlayerInfo.AbyssDifficulty]
	local targetBoxCid = 0
	local lastBoxCid = 0
	local scoreLength = #endlessScores

	for i = 1, scoreLength do
		if score < endlessScores[i] or i == scoreLength then
			self.CurrentScoreUpperLimit = endlessScores[i]
			targetBoxCid = endlessRewards[i]

			break
		else
			lastBoxCid = endlessRewards[i]
		end
	end

	UGUIUtil.SetText(self.ScoreText, EndlessMazeMainUIApi:GetString("ScoreText", score, self.CurrentScoreUpperLimit))

	self.ScoreProgressImg:GetComponent("Image").fillAmount = score / self.CurrentScoreUpperLimit

	self.NextRewardTipController:SetData(score, self.CurrentScoreUpperLimit)

	local nextBoxCfgData = CfgMazeEndlessBoxTable[targetBoxCid]
	local boxImagePaths = EndlessMazeMainUIApi:GetString("ScoreInfoBoxImagePaths")

	self.NextRewardIcon:GetComponent("Image").sprite = LuaCodeInterface.ToSprite(self.UIController:GetPreloadedAsset(boxImagePaths[nextBoxCfgData.Type]))

	if isUpdate and oldScoreUpperLimit ~= self.CurrentScoreUpperLimit then
		local lastBoxCfgData = CfgMazeEndlessBoxTable[lastBoxCid]

		GameEntry.Effect:PlayUIMountPointEffect(EndlessMazeMainUIApi:GetString("ScoreBoxEffect", lastBoxCfgData.Type), 50000, 0, self.NextRewardIcon, Constant.Unity.SortingOrderMaxValue - 1)
	end

	self:ClearRewardCells()

	local rewardCidNumMap = {}

	for i = 1, #endlessScores do
		if endlessScores[i] <= MazeDataModule.PlayerInfo.ExploreScore then
			local boxCid = endlessRewards[i]
			local num = rewardCidNumMap[boxCid]

			if num == nil then
				num = 0
			end

			num = num + 1
			rewardCidNumMap[boxCid] = num
		end
	end

	local changedBoxCidList = {}

	for cid, num in pairs(rewardCidNumMap) do
		local oldNum = self.LastBoxCidNumMap[cid]

		if oldNum == nil or num ~= oldNum then
			table.insert(changedBoxCidList, cid)
		end
	end

	self.LastBoxCidNumMap = rewardCidNumMap

	local rewardList = {}

	for cid, num in pairs(rewardCidNumMap) do
		local cfgMazeEndlessBoxData = CfgMazeEndlessBoxTable[cid]

		table.insert(rewardList, {
			cfgData = cfgMazeEndlessBoxData,
			num = num
		})
	end

	table.sort(rewardList, function(data1, data2)
		local cfgData1 = data1.cfgData
		local cfgData2 = data2.cfgData

		if cfgData1.Type == cfgData2.Type then
			return cfgData1.Id < cfgData2.Id
		end

		return cfgData1.Type < cfgData2.Type
	end)

	for i = 1, #rewardList do
		local cell = self.RewardCellPool:Obtain()

		cell.View:SetActive(true)
		cell.View.transform:SetParent(self.RewardGrid.transform, false)

		local data = rewardList[i]

		cell:SetData(self, data.cfgData, data.num, addValue ~= nil and table.indexOf(changedBoxCidList, data.cfgData.Id) ~= -1)

		self.RewardCells[i] = cell
	end
end

function EndlessMazeMainUI:ClearRewardCells(isDestroy)
	for i = 1, #self.RewardCells do
		local cell = self.RewardCells[i]

		cell.View:SetActive(false)

		if not isDestroy then
			cell.View.transform:SetParent(self.UIController.transform, false)
		end

		self.RewardCellPool:Release(cell)
	end

	self.RewardCells = {}
end

function EndlessMazeMainUI:OnUpdateExploreScore(addValue)
	self:UpdateScore(addValue)
end

function EndlessMazeMainUI:OnClickEngravingBtn()
	UIModule.Open(Constant.UIControllerName.EndlessMazeRuneMainUI, Constant.UILayer.UI)
end

function EndlessMazeMainUI:OnClickRewardBox(cfgMazeEndlessBoxData, position)
	self.RewardBoxTipController:Show(cfgMazeEndlessBoxData, position)
end

function EndlessMazeMainUI:OnClickScoreInfoBtn()
	self.NextRewardTipController:Show()
end

function EndlessMazeMainUI:ShowRuneItemTip()
	UIModule.Open(Constant.UIControllerName.EndlessMazeRuneLockUI, Constant.UILayer.UI)
end

function EndlessMazeMainUI:OnMazeFlyRuneOrItem(dataList)
	for i = 1, #dataList do
		self:FlyRuneOrItem(dataList[i])
	end
end

function EndlessMazeMainUI:FlyRuneOrItem(data)
	if data.runeCid == nil and data.itemCid == nil then
		return
	end

	local startPos = data.startPos

	if startPos == nil then
		startPos = self.FlyEffectRoot.transform:Find("DefaultPos").position
	end

	local targetCell
	local quality = 1
	local endPos = self.EngravingBtn.transform.position + Vector3(-1.2, 1.44, 0)
	local targetRuneItemCell

	if data.runeCid ~= nil then
		local cell = self.FlyRunePool:Obtain()

		cell:SetDataByCID(data.runeCid)
		cell.View:SetActive(true)
		cell.View.transform:SetParent(self.FlyEffectRoot.transform, false)

		cell.View.transform.position = startPos
		targetCell = cell
		quality = cell.CfgRuneData.Quality
	elseif data.itemCid ~= nil then
		local cell = self.FlyRuneItemPool:Obtain()
		local cfgItemData = CfgItemTable[data.itemCid]

		cell:SetDataByCfgData(cfgItemData)
		cell.View:SetActive(true)
		cell.View.transform:SetParent(self.FlyEffectRoot.transform, false)

		cell.View.transform.position = startPos
		targetCell = cell
		quality = cfgItemData.Quality

		self:UpdateRuneItems()

		for i = 1, #self.RuneItems do
			local runeItemCell = self.RuneItems[i]

			if runeItemCell.ItemData ~= nil and runeItemCell.ItemData.id == data.itemInstanceId then
				targetRuneItemCell = runeItemCell

				targetRuneItemCell:SetActive(false)
			end
		end

		if targetRuneItemCell == nil then
			for i = #self.RuneItems, 1, -1 do
				local runeItemCell = self.RuneItems[i]

				if runeItemCell.IsActive then
					targetRuneItemCell = runeItemCell

					break
				end
			end
		end

		endPos = targetRuneItemCell.View.transform.position
	end

	local tween

	tween = LuaCodeInterface.TweenScale(targetCell:GetRoot(), 0.16, Vector3.one, Vector3.zero, function(go)
		targetCell.View:SetActive(false)

		targetCell.View.transform.localScale = Vector3.one

		local pool

		if data.runeCid ~= nil then
			pool = self.FlyRunePool
		elseif data.itemCid ~= nil then
			pool = self.FlyRuneItemPool
		end

		pool:Release(targetCell)
		table.remove(self.ScaleTweenList, table.indexOf(self.ScaleTweenList, tween))
	end)

	table.insert(self.ScaleTweenList, tween)

	local sortingOrder = 4000

	local function playStartEffect(position)
		GameEntry.Effect:PlayNormalEffect(EndlessMazeMainUIApi:GetString("StartRuneEffectCid", quality), position, 0, 0, LayerMask.NameToLayer("UI"), 0, sortingOrder, 0.02666666666666667)
	end

	local timer = ModuleTimerUtil.NewTimer(Constant.UIControllerName.EndlessMazeMainUI, function()
		playStartEffect(startPos)
	end, 0.13)

	timer:Start()

	timer = ModuleTimerUtil.NewTimer(Constant.UIControllerName.EndlessMazeMainUI, function()
		GameEntry.Effect:FlyEffect(EndlessMazeMainUIApi:GetString("FlyRuneEffectCid", quality), startPos, endPos, 0.5, LayerMask.NameToLayer("UI"), sortingOrder, 0, 0, 0.02666666666666667, function(go)
			playStartEffect(endPos)

			if targetRuneItemCell ~= nil then
				targetRuneItemCell:SetActive(true)
			end
		end, true)
	end, 0.23)

	timer:Start()
end

function EndlessMazeMainUI:OnAbyssDifficultyChanged()
	self:UpdateScore()
	self:UpdateDangerLevel()
end

function EndlessMazeMainUI:OnLoadImageSuccess(assetName, asset, duration, userData)
	userData:SetActive(true)
end

return EndlessMazeMainUI
