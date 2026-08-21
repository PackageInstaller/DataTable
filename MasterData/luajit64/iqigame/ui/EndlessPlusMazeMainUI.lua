-- chunkname: @IQIGame\\UI\\EndlessPlusMazeMainUI.lua

require("IQIGame.UIExternalApi.EndlessPlusMazeMainUIApi")

local MazeMainUICommonModuleController = require("IQIGame.UI.Maze.MazeMainUICommonModuleController")
local EndlessMazeRuneItemCell = require("IQIGame.UI.Maze.EndlessMazeRuneItemCell")
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local EndlessMazeRuneCell = require("IQIGame.UI.EndlessMazeRune.EndlessMazeRuneCell")
local EndlessPlusMazeMainUI = {
	CurrentScoreUpperLimit = 0,
	ScaleTweenList = {},
	RewardCells = {},
	LastBoxCidNumMap = {}
}

EndlessPlusMazeMainUI = Base:Extend("EndlessPlusMazeMainUI", "IQIGame.Onigao.UI.EndlessPlusMazeMainUI", EndlessPlusMazeMainUI)

function EndlessPlusMazeMainUI:OnInit()
	function self.DelegateOnClickEngravingBtn()
		self:OnClickEngravingBtn()
	end

	function self.DelegateOnMazeFlyRuneOrItem(dataList)
		self:OnMazeFlyRuneOrItem(dataList)
	end

	function self.DelegateOnClickRuneOverviewBtn()
		self:OnClickRuneOverviewBtn()
	end

	function self.DelegateOnUpdateExploreScore()
		self:OnUpdateExploreScore()
	end

	self.CommonModule = MazeMainUICommonModuleController.New(self.CommonModule, self.UIController, self.Top, self.BtnGroup, self.Bottom, function()
		return self:GetCustomData()
	end)

	self.CommonModule:OnInit()

	self.CurrencyCell = MazeCurrencyCell.New(self.CurrencyModule, 4)

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

	UGUIUtil.SetText(self.LayerLabel, EndlessPlusMazeMainUIApi:GetString("LayerLabel"))
	UGUIUtil.SetTextInChildren(self.EngravingBtn, EndlessPlusMazeMainUIApi:GetString("EngravingBtnText"))
end

function EndlessPlusMazeMainUI:GetPreloadAssetPaths()
	local paths = {}

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

function EndlessPlusMazeMainUI:GetOpenPreloadAssetPaths(userData)
	return MazeMainUICommonModuleController.GetOpenPreloadAssetPaths(userData)
end

function EndlessPlusMazeMainUI:IsManualShowOnOpen(userData)
	return false
end

function EndlessPlusMazeMainUI:GetBGM(userData)
	return nil
end

function EndlessPlusMazeMainUI:OnOpen(userData)
	self.CommonModule:OnOpen(userData)
	self:UpdateView()
end

function EndlessPlusMazeMainUI:OnClose(userData)
	self.CommonModule:OnClose(userData)
	ModuleTimerUtil.Stop(Constant.UIControllerName.EndlessMazeMainUI)
end

function EndlessPlusMazeMainUI:OnAddListeners()
	self.CommonModule:OnAddListeners()
	self.EngravingBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickEngravingBtn)
	self.RuneOverviewBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickRuneOverviewBtn)
	EventDispatcher.AddEventListener(EventID.MazeFlyRuneOrItem, self.DelegateOnMazeFlyRuneOrItem)
	EventDispatcher.AddEventListener(EventID.MazeUpdateExploreScore, self.DelegateOnUpdateExploreScore)
end

function EndlessPlusMazeMainUI:OnRemoveListeners()
	self.CommonModule:OnRemoveListeners()
	self.EngravingBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickEngravingBtn)
	self.RuneOverviewBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickRuneOverviewBtn)
	EventDispatcher.RemoveEventListener(EventID.MazeFlyRuneOrItem, self.DelegateOnMazeFlyRuneOrItem)
	EventDispatcher.RemoveEventListener(EventID.MazeUpdateExploreScore, self.DelegateOnUpdateExploreScore)
end

function EndlessPlusMazeMainUI:OnPause()
	self.CommonModule:OnPause()
end

function EndlessPlusMazeMainUI:OnResume()
	self.CommonModule:OnResume()
end

function EndlessPlusMazeMainUI:OnCover()
	self.CommonModule:OnCover()
end

function EndlessPlusMazeMainUI:OnReveal()
	self.CommonModule:OnReveal()
end

function EndlessPlusMazeMainUI:OnRefocus(userData)
	self.CommonModule:OnRefocus(userData)
end

function EndlessPlusMazeMainUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self.CommonModule:OnUpdate(elapseSeconds, realElapseSeconds)
end

function EndlessPlusMazeMainUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	self.CommonModule:OnDepthChanged(uiGroupDepth, depthInUIGroup)
end

function EndlessPlusMazeMainUI:OnLoadSucceed(assetName, asset, duration, userData)
	self.CommonModule:OnLoadSucceed(assetName, asset, duration, userData)
end

function EndlessPlusMazeMainUI:OnLoadFailed(assetName, status, errorMessage, userData)
	self.CommonModule:OnLoadFailed(assetName, status, errorMessage, userData)
end

function EndlessPlusMazeMainUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.CommonModule:OnDestroy()
	self.CurrencyCell:Dispose()

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

function EndlessPlusMazeMainUI:UpdateView()
	self.CfgMazeInstanceData = CfgMazeInstanceTable[MazeDataModule.MazeInstanceID]

	local cfgChapterData = CfgChapterTable[self.CfgMazeInstanceData.ChapterId]

	UGUIUtil.SetText(self.MazeNameText, EndlessPlusMazeMainUIApi:GetString("MazeNameText", cfgChapterData.Order, self.CfgMazeInstanceData.Order, self.CfgMazeInstanceData.Name))
	self.CurrencyCell:UpdateNum()
	self:UpdateRuneItems()
	self:UpdateLayer()
end

function EndlessPlusMazeMainUI:UpdateLayer()
	UGUIUtil.SetText(self.LayerText, tostring(MazeDataModule.PlayerInfo.ExploreScore))
end

function EndlessPlusMazeMainUI:UpdateRuneItems()
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

function EndlessPlusMazeMainUI:GetCustomData()
	local cfgMazeInstanceData = CfgMazeInstanceTable[MazeDataModule.MazeInstanceID]

	return {
		startTitle = EndlessPlusMazeMainUIApi:GetString("StartTitleText"),
		startTip = EndlessPlusMazeMainUIApi:GetString("StartTipText", cfgMazeInstanceData.ConditionsDesc)
	}
end

function EndlessPlusMazeMainUI:OnClickEngravingBtn()
	UIModule.Open(Constant.UIControllerName.EndlessMazeRuneMainUI, Constant.UILayer.UI)
end

function EndlessPlusMazeMainUI:ShowRuneItemTip()
	UIModule.Open(Constant.UIControllerName.EndlessMazeRuneLockUI, Constant.UILayer.UI)
end

function EndlessPlusMazeMainUI:OnMazeFlyRuneOrItem(dataList)
	for i = 1, #dataList do
		self:FlyRuneOrItem(dataList[i])
	end
end

function EndlessPlusMazeMainUI:FlyRuneOrItem(data)
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
		GameEntry.Effect:PlayNormalEffect(EndlessPlusMazeMainUIApi:GetString("StartRuneEffectCid", quality), position, 0, 0, LayerMask.NameToLayer("UI"), 0, sortingOrder, 0.02666666666666667)
	end

	local timer = ModuleTimerUtil.NewTimer(Constant.UIControllerName.EndlessMazeMainUI, function()
		playStartEffect(startPos)
	end, 0.13)

	timer:Start()

	timer = ModuleTimerUtil.NewTimer(Constant.UIControllerName.EndlessMazeMainUI, function()
		GameEntry.Effect:FlyEffect(EndlessPlusMazeMainUIApi:GetString("FlyRuneEffectCid", quality), startPos, endPos, 0.5, LayerMask.NameToLayer("UI"), sortingOrder, 0, 0, 0.02666666666666667, function(go)
			playStartEffect(endPos)

			if targetRuneItemCell ~= nil then
				targetRuneItemCell:SetActive(true)
			end
		end, true)
	end, 0.23)

	timer:Start()
end

function EndlessPlusMazeMainUI:OnClickRuneOverviewBtn()
	UIModule.Open(Constant.UIControllerName.EndlessPlusSelectRuneUI, Constant.UILayer.UI, {
		viewMode = true
	})
end

function EndlessPlusMazeMainUI:OnUpdateExploreScore()
	self:UpdateLayer()
end

return EndlessPlusMazeMainUI
