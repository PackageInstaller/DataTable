-- chunkname: @IQIGame\\UI\\ScrollMazeMainUI.lua

local ScrollMazeMainUI = {
	CurrentScoreUpperLimit = 0,
	ScaleTweenList = {}
}

ScrollMazeMainUI = Base:Extend("ScrollMazeMainUI", "IQIGame.Onigao.UI.ScrollMazeMainUI", ScrollMazeMainUI)

require("IQIGame.UIExternalApi.ScrollMazeMainUIApi")

local MazeMainUICommonModuleController = require("IQIGame.UI.Maze.MazeMainUICommonModuleController")
local EndlessMazeRuneItemCell = require("IQIGame.UI.Maze.EndlessMazeRuneItemCell")
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local EndlessMazeRuneCell = require("IQIGame.UI.EndlessMazeRune.EndlessMazeRuneCell")

function ScrollMazeMainUI:OnInit()
	function self.DelegateOnMazeScrollReady()
		self:OnMazeScrollReady()
	end

	function self.DelegateOnUpdateExploreScore(addValue)
		self:OnUpdateExploreScore(addValue)
	end

	function self.DelegateOnMazeFlyRuneOrItem(dataList)
		self:OnMazeFlyRuneOrItem(dataList)
	end

	function self.DelegateOnAbyssDifficultyChanged()
		self:OnAbyssDifficultyChanged()
	end

	function self.DelegateOnClickNextStepBtn()
		self:OnClickNextStepBtn()
	end

	function self.DelegateOnMazeHeroCorrectPosition()
		self:OnMazeHeroCorrectPosition()
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

	UGUIUtil.SetText(self.ScoreLabelText, ScrollMazeMainUIApi:GetString("ScoreLabelText"))
	UGUIUtil.SetTextInChildren(self.EngravingBtn, ScrollMazeMainUIApi:GetString("EngravingBtnText"))
end

function ScrollMazeMainUI:GetPreloadAssetPaths()
	local paths = {}
	local boxImagePaths = ScrollMazeMainUIApi:GetString("ScoreInfoBoxImagePaths")

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

function ScrollMazeMainUI:GetOpenPreloadAssetPaths(userData)
	return MazeMainUICommonModuleController.GetOpenPreloadAssetPaths(userData)
end

function ScrollMazeMainUI:OnOpen(userData)
	self.NextStepBtn:SetActive(false)
	self.CommonModule:OnOpen(userData)
	self:UpdateView()
end

function ScrollMazeMainUI:OnClose(userData)
	self.CommonModule:OnClose(userData)
	ModuleTimerUtil.Stop(Constant.UIControllerName.ScrollMazeMainUI)
end

function ScrollMazeMainUI:OnAddListeners()
	self.CommonModule:OnAddListeners()
	self.EngravingBtn:GetComponent("Button").onClick:AddListener(self.OnClickEngravingBtn)
	self.NextStepBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickNextStepBtn)
	EventDispatcher.AddEventListener(EventID.MazeScrollReady, self.DelegateOnMazeScrollReady)
	EventDispatcher.AddEventListener(EventID.MazeUpdateExploreScore, self.DelegateOnUpdateExploreScore)
	EventDispatcher.AddEventListener(EventID.MazeFlyRuneOrItem, self.DelegateOnMazeFlyRuneOrItem)
	EventDispatcher.AddEventListener(EventID.AbyssDifficultyChanged, self.DelegateOnAbyssDifficultyChanged)
	EventDispatcher.AddEventListener(EventID.MazeHeroCorrectPosition, self.DelegateOnMazeHeroCorrectPosition)
end

function ScrollMazeMainUI:OnRemoveListeners()
	self.CommonModule:OnRemoveListeners()
	self.EngravingBtn:GetComponent("Button").onClick:RemoveListener(self.OnClickEngravingBtn)
	self.NextStepBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickNextStepBtn)
	EventDispatcher.RemoveEventListener(EventID.MazeScrollReady, self.DelegateOnMazeScrollReady)
	EventDispatcher.RemoveEventListener(EventID.MazeUpdateExploreScore, self.DelegateOnUpdateExploreScore)
	EventDispatcher.RemoveEventListener(EventID.MazeFlyRuneOrItem, self.DelegateOnMazeFlyRuneOrItem)
	EventDispatcher.RemoveEventListener(EventID.AbyssDifficultyChanged, self.DelegateOnAbyssDifficultyChanged)
	EventDispatcher.RemoveEventListener(EventID.MazeHeroCorrectPosition, self.DelegateOnMazeHeroCorrectPosition)
end

function ScrollMazeMainUI:OnPause()
	self.CommonModule:OnPause()
end

function ScrollMazeMainUI:OnResume()
	self.CommonModule:OnResume()
end

function ScrollMazeMainUI:OnCover()
	self.CommonModule:OnCover()
end

function ScrollMazeMainUI:OnReveal()
	self.CommonModule:OnReveal()
end

function ScrollMazeMainUI:OnRefocus(userData)
	self.CommonModule:OnRefocus(userData)
end

function ScrollMazeMainUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self.CommonModule:OnUpdate(elapseSeconds, realElapseSeconds)
end

function ScrollMazeMainUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	self.CommonModule:OnDepthChanged(uiGroupDepth, depthInUIGroup)
end

function ScrollMazeMainUI:OnLoadSucceed(assetName, asset, duration, userData)
	self.CommonModule:OnLoadSucceed(assetName, asset, duration, userData)
end

function ScrollMazeMainUI:OnLoadFailed(assetName, status, errorMessage, userData)
	self.CommonModule:OnLoadFailed(assetName, status, errorMessage, userData)
end

function ScrollMazeMainUI:OnDestroy()
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

function ScrollMazeMainUI:UpdateView()
	self.CfgMazeInstanceData = CfgMazeInstanceTable[MazeDataModule.MazeInstanceID]

	local cfgChapterData = CfgChapterTable[self.CfgMazeInstanceData.ChapterId]

	UGUIUtil.SetText(self.MazeNameText, ScrollMazeMainUIApi:GetString("MazeNameText", cfgChapterData.Order, self.CfgMazeInstanceData.Order, self.CfgMazeInstanceData.Name))
	self:UpdateScore()
	self.CurrencyCell:UpdateNum()
	self:UpdateRuneItems()
	self:UpdateDangerLevel()
end

function ScrollMazeMainUI:UpdateDangerLevel()
	self.DangerLabelBg:SetActive(false)
	AssetUtil.LoadImage(self, ScrollMazeMainUIApi:GetString("DangerLabelBg", MazeDataModule.PlayerInfo.MonsterGrade, MazeDataModule.PlayerInfo.AbyssPowerId), self.DangerLabelBg:GetComponent("Image"), self.OnLoadImageSuccess, nil, self.DangerLabelBg)
	UGUIUtil.SetText(self.DangerLabel, ScrollMazeMainUIApi:GetString("DangerLabel", MazeDataModule.PlayerInfo.MonsterGrade, MazeDataModule.PlayerInfo.AbyssPowerId))
	UGUIUtil.SetText(self.DangerText, ScrollMazeMainUIApi:GetString("DangerText", MazeDataModule.PlayerInfo.MonsterGrade, MazeDataModule.PlayerInfo.AbyssPowerId, MazeDataModule.ChapterType))

	self.DangerOutline:GetComponent("OutlineRenderCfgUGUI").color = hexStringToColor(ScrollMazeMainUIApi:GetString("DangerOutlineColor", MazeDataModule.PlayerInfo.MonsterGrade, MazeDataModule.PlayerInfo.AbyssPowerId))
end

function ScrollMazeMainUI:UpdateRuneItems()
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

function ScrollMazeMainUI:GetCustomData()
	local cfgMazeInstanceData = CfgMazeInstanceTable[MazeDataModule.MazeInstanceID]

	return {
		startTitle = ScrollMazeMainUIApi:GetString("StartTitleText"),
		startTip = ScrollMazeMainUIApi:GetString("StartTipText", cfgMazeInstanceData.ConditionsDesc)
	}
end

function ScrollMazeMainUI:UpdateScore(addValue)
	UGUIUtil.SetText(self.ScoreText, ScrollMazeMainUIApi:GetString("ScoreText", MazeDataModule.PlayerInfo.ExploreScore))
end

function ScrollMazeMainUI:OnUpdateExploreScore(addValue)
	self:UpdateScore(addValue)
end

function ScrollMazeMainUI.OnClickEngravingBtn()
	UIModule.Open(Constant.UIControllerName.EndlessMazeRuneMainUI, Constant.UILayer.UI)
end

function ScrollMazeMainUI:ShowRuneItemTip()
	UIModule.Open(Constant.UIControllerName.EndlessMazeRuneLockUI, Constant.UILayer.UI)
end

function ScrollMazeMainUI:OnMazeFlyRuneOrItem(dataList)
	for i = 1, #dataList do
		self:FlyRuneOrItem(dataList[i])
	end
end

function ScrollMazeMainUI:FlyRuneOrItem(data)
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
		GameEntry.Effect:PlayNormalEffect(ScrollMazeMainUIApi:GetString("StartRuneEffectCid", quality), position, 0, 0, LayerMask.NameToLayer("UI"), 0, sortingOrder, 0.02666666666666667)
	end

	local timer = ModuleTimerUtil.NewTimer(Constant.UIControllerName.ScrollMazeMainUI, function()
		playStartEffect(startPos)
	end, 0.13)

	timer:Start()

	timer = ModuleTimerUtil.NewTimer(Constant.UIControllerName.ScrollMazeMainUI, function()
		GameEntry.Effect:FlyEffect(ScrollMazeMainUIApi:GetString("FlyRuneEffectCid", quality), startPos, endPos, 0.5, LayerMask.NameToLayer("UI"), sortingOrder, 0, 0, 0.02666666666666667, function(go)
			playStartEffect(endPos)

			if targetRuneItemCell ~= nil then
				targetRuneItemCell:SetActive(true)
			end
		end, true)
	end, 0.23)

	timer:Start()
end

function ScrollMazeMainUI:OnAbyssDifficultyChanged()
	self:UpdateScore()
	self:UpdateDangerLevel()
end

function ScrollMazeMainUI:OnLoadImageSuccess(assetName, asset, duration, userData)
	userData:SetActive(true)
end

function ScrollMazeMainUI:OnMazeScrollReady()
	self.NextStepBtn:SetActive(MazeModule.MazeScene:HasNextNode())
end

function ScrollMazeMainUI:OnClickNextStepBtn()
	self.NextStepBtn:SetActive(false)
	MazeModule.MoveToNextNode()
end

function ScrollMazeMainUI:OnMazeHeroCorrectPosition()
	self.NextStepBtn:SetActive(MazeModule.MazeScene:HasNextNode())
end

return ScrollMazeMainUI
