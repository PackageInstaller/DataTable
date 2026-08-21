-- chunkname: @IQIGame\\UI\\MazeSelectLevelUI.lua

local MazeSelectLevelUI = Base:Extend("MazeSelectLevelUI", "IQIGame.Onigao.UI.MazeSelectLevelUI", {
	ChapterCid = 0,
	Cells = {},
	RewardBoxCells = {},
	TestChapterButtons = {}
})
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local MazeInstanceCell = require("IQIGame.UI.Maze.MazeInstanceCell")
local TaskUIData = require("IQIGame.Module.Task.TaskUIData")
local MazeSelectLevelRewardBoxCell = require("IQIGame.UI.MazeSelectLevel.MazeSelectLevelRewardBoxCell")
local ChapterViewportController = require("IQIGame.UI.MazeSelectLevel.ChapterViewportController")
local MazeSelectLevelPaidView = require("IQIGame.UI.MazeSelectLevel.MazeSelectLevelPaidView")

function MazeSelectLevelUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnTaskUpdate()
		self:OnTaskUpdate()
	end

	function self.DelegateOnTaskCommitted(cids, rewards)
		self:OnTaskCommitted(cids, rewards)
	end

	function self.DelegateOnClickMazeCell(cell)
		self:OnClickMazeCell(cell)
	end

	function self.DelegateOnClickChapterTipBtn()
		self:OnClickChapterTipBtn()
	end

	function self.DelegateOnUpdateMaze()
		local cfgChapterData, cfgMazeInstanceData, unfinishedMazeCid = PlayerModule.GetNormalMazeExploreProgressData()

		self.ChapterCid = cfgChapterData.Id

		self:UpdateView(self.ChapterCid)
		self.ChapterViewportController:Refresh(self.ChapterCid)
	end

	self.EnergyCell = EnergyCell.New(self.EnergyCom.transform:GetChild(0).gameObject)
	self.CurrencyControllers = {}

	self:AddCurrencyCell(Constant.ItemID.MONEY)
	self:AddCurrencyCell(Constant.ItemID.TREASURE)

	self.RewardBoxPool = UIObjectPool.New(5, function()
		local cell = MazeSelectLevelRewardBoxCell.New(UnityEngine.Object.Instantiate(self.RewardBoxCellPrefab))

		return cell
	end, function(cell)
		local view = cell.goView

		cell:OnDestroy()
		UnityEngine.Object.Destroy(view)
	end)
	self.InstanceCellPool = UIObjectPool.New(5, function()
		return MazeInstanceCell.New(UnityEngine.Object.Instantiate(self.CellPrefab), self.UIController:GetComponent("Canvas"), self.DelegateOnClickMazeCell)
	end, function(cell)
		local view = cell.View

		cell:Dispose()
		UnityEngine.Object.Destroy(view)
	end)
	self.MapNodeScrollRect = self.MapNode:GetComponent("ScrollRect")
	self.MapNodeTrans = self.MapNode.transform:GetChild(0)
	self.ChapterViewportController = ChapterViewportController.New(self.ChapterViewport, function(chapterCid)
		self:UpdateView(chapterCid)
	end)

	for i = 0, self.TestChapterNode.transform.childCount - 1 do
		local btnGo = self.TestChapterNode.transform:GetChild(i).gameObject
		local prefix = "Chapter_"
		local startIndex = string.find(btnGo.name, prefix)

		if startIndex == 1 then
			local chapterCid = tonumber(string.sub(btnGo.name, startIndex + #prefix))

			self.TestChapterButtons[chapterCid] = btnGo
			self["DelegateOnClickTestChapterBtn" .. chapterCid] = function()
				self:UpdateView(chapterCid)
			end
		end
	end

	UGUIUtil.SetText(self.ExploreTargetRewardLabel, MazeSelectLevelUIApi:GetString("ExploreTargetRewardLabel"))

	self.mazeSelectLevelPaidView = MazeSelectLevelPaidView.New(self.PaidNode)
end

function MazeSelectLevelUI:GetPreloadAssetPaths()
	local paths = {
		AssetPath.Get(GlobalKey.UIPrefabPath, "Common/MoneyGrid_Mould")
	}

	return paths
end

function MazeSelectLevelUI:GetOpenPreloadAssetPaths(userData)
	local cfgChapterData = CfgChapterTable[userData.chapterCid]

	return {
		UIGlobalApi.GetUIPrefab(cfgChapterData.BackgroundRes),
		UIGlobalApi.GetUIPrefab(cfgChapterData.ChapterMapRes)
	}
end

function MazeSelectLevelUI:OnOpen(userData)
	self:UpdateView(userData.chapterCid)
	self.ChapterViewportController:Refresh(userData.chapterCid)
end

function MazeSelectLevelUI:OnClose(userData)
	for i = 1, #self.Cells do
		local cell = self.Cells[i]

		cell:StopEffects()
	end
end

function MazeSelectLevelUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.ChapterTipBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickChapterTipBtn)

	for chapterCid, btnGo in pairs(self.TestChapterButtons) do
		btnGo:GetComponent("Button").onClick:AddListener(self["DelegateOnClickTestChapterBtn" .. chapterCid])
	end

	EventDispatcher.AddEventListener(EventID.TaskUpdate, self.DelegateOnTaskUpdate)
	EventDispatcher.AddEventListener(EventID.TaskCommitResponse, self.DelegateOnTaskCommitted)
	EventDispatcher.AddEventListener(EventID.UpdateMaze, self.DelegateOnUpdateMaze)
end

function MazeSelectLevelUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.ChapterTipBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickChapterTipBtn)

	for chapterCid, btnGo in pairs(self.TestChapterButtons) do
		btnGo:GetComponent("Button").onClick:RemoveListener(self["DelegateOnClickTestChapterBtn" .. chapterCid])
	end

	EventDispatcher.RemoveEventListener(EventID.TaskUpdate, self.DelegateOnTaskUpdate)
	EventDispatcher.RemoveEventListener(EventID.TaskCommitResponse, self.DelegateOnTaskCommitted)
	EventDispatcher.RemoveEventListener(EventID.UpdateMaze, self.DelegateOnUpdateMaze)
end

function MazeSelectLevelUI:OnPause()
	return
end

function MazeSelectLevelUI:OnResume()
	return
end

function MazeSelectLevelUI:OnCover()
	return
end

function MazeSelectLevelUI:OnReveal()
	return
end

function MazeSelectLevelUI:OnRefocus(userData)
	return
end

function MazeSelectLevelUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MazeSelectLevelUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MazeSelectLevelUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MazeSelectLevelUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MazeSelectLevelUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.EnergyCell:Dispose()

	for i = 1, #self.CurrencyControllers do
		self.CurrencyControllers[i]:Dispose()
	end

	self:ClearInstanceCells(true)
	self.InstanceCellPool:Dispose()
	self:ClearRewardBoxes(true)
	self.RewardBoxPool:Dispose()
	self.mazeSelectLevelPaidView:Dispose()

	self.mazeSelectLevelPaidView = nil
end

function MazeSelectLevelUI:OnClickCloseBtn()
	UIModule.Close(Constant.UIControllerName.MazeSelectLevelUI)
end

function MazeSelectLevelUI:UpdateView(chapterCid)
	self.ChapterCid = chapterCid

	local cfgChapterData = CfgChapterTable[chapterCid]

	self.ChapterNameText:GetComponent("Text").text = MazeSelectLevelUIApi:GetString("ChapterNameText", cfgChapterData.Alias, cfgChapterData.Name)

	self.BlockView:SetActive(false)

	if self.LastBgPath ~= cfgChapterData.BackgroundRes then
		if self.Background.transform.childCount == 1 then
			local oldBg = self.Background.transform:GetChild(0)
			local oldBgGo = oldBg.gameObject

			UnityEngine.Object.Destroy(oldBgGo)
		end

		local bgPrefab = self.UIController:GetPreloadedAsset(UIGlobalApi.GetUIPrefab(cfgChapterData.BackgroundRes))

		if bgPrefab ~= nil then
			local bgGo = UnityEngine.Object.Instantiate(bgPrefab)

			bgGo.transform:SetParent(self.Background.transform, false)
		else
			self.BlockView:SetActive(true)
			AssetUtil.LoadAsset(self, UIGlobalApi.GetUIPrefab(cfgChapterData.BackgroundRes), self.OnLoadSuccess, nil, {
				parent = self.Background.transform
			})
		end

		self.LastBgPath = cfgChapterData.BackgroundRes
	end

	self:ClearInstanceCells()

	if self.LastMapPath ~= cfgChapterData.ChapterMapRes then
		if self.Map ~= nil then
			UnityEngine.Object.Destroy(self.Map)
		end

		self.Map = nil

		local mapPrefab = self.UIController:GetPreloadedAsset(UIGlobalApi.GetUIPrefab(cfgChapterData.ChapterMapRes))

		if mapPrefab ~= nil then
			local mapGo = UnityEngine.Object.Instantiate(mapPrefab)

			mapGo.transform:SetParent(self.MapNodeTrans, false)
			self:OnMapLoaded(mapGo)
		else
			self.BlockView:SetActive(true)
			AssetUtil.LoadAsset(self, UIGlobalApi.GetUIPrefab(cfgChapterData.ChapterMapRes), self.OnLoadSuccess, nil, {
				isMap = true,
				parent = self.MapNodeTrans
			})
		end

		self.LastMapPath = cfgChapterData.ChapterMapRes
	else
		self:OnMapLoaded(self.Map)
	end

	for cid, btnGo in pairs(self.TestChapterButtons) do
		local cfgData = CfgChapterTable[cid]
		local isUnlock = ConditionModule.Check(cfgData.LockCondition)

		btnGo:SetActive(isUnlock)
	end

	self.mazeSelectLevelPaidView:UpdateView(self.ChapterCid)
end

function MazeSelectLevelUI:OnMapLoaded(map)
	self.Map = map

	local chapterMazes = {}

	for i, cfgMazeInstanceData in pairsCfg(CfgMazeInstanceTable) do
		if cfgMazeInstanceData.ChapterId == self.ChapterCid then
			local areaMazes = chapterMazes[cfgMazeInstanceData.MazeArea]

			if areaMazes == nil then
				areaMazes = {}
				chapterMazes[cfgMazeInstanceData.MazeArea] = areaMazes
			end

			table.insert(areaMazes, cfgMazeInstanceData)
		end
	end

	local areaUnlockMap = {}
	local minOrderLockCfg, isUnlock

	for areaId, areaMazes in pairs(chapterMazes) do
		if areaId ~= 0 then
			local minOrderCfg

			for i = 1, #areaMazes do
				local cfgMazeInstanceData = areaMazes[i]

				if minOrderCfg == nil or areaId ~= 0 and cfgMazeInstanceData.Order < minOrderCfg.Order then
					minOrderCfg = cfgMazeInstanceData
				end

				isUnlock = (cfgMazeInstanceData.QuickChallengeLockCondition ~= 0 and {
					ConditionModule.Check(cfgMazeInstanceData.QuickChallengeLockCondition)
				} or {
					ConditionModule.Check(cfgMazeInstanceData.LockCondition)
				})[1]

				if areaId ~= 0 and (not isUnlock or PlayerModule.PlayerInfo.baseInfo.pLv < cfgMazeInstanceData.LockLevel) and (minOrderLockCfg == nil or cfgMazeInstanceData.Order < minOrderLockCfg.Order) then
					minOrderLockCfg = cfgMazeInstanceData
				end
			end

			areaUnlockMap[areaId] = (minOrderCfg.QuickChallengeLockCondition ~= 0 and {
				ConditionModule.Check(minOrderCfg.QuickChallengeLockCondition)
			} or {
				ConditionModule.Check(minOrderCfg.LockCondition)
			})[1]
		else
			areaUnlockMap[areaId] = false

			for i = 1, #areaMazes do
				local cfgMazeInstanceData = areaMazes[i]

				if table.indexOf(PlayerModule.PlayerInfo.openExtraMazes, cfgMazeInstanceData.Id) ~= -1 then
					areaUnlockMap[areaId] = true

					break
				end
			end
		end
	end

	self.MapNodeScrollRect.content = self.Map.transform

	for areaId, unlock in pairs(areaUnlockMap) do
		local lockTrans = self.Map.transform:Find("AreaLock"):Find("Lock_" .. areaId)

		if lockTrans ~= nil then
			lockTrans.gameObject:SetActive(not unlock)
		end
	end

	local cfgChapterData = CfgChapterTable[self.ChapterCid]
	local mapRootTrans = self.Map.transform:Find("Map")
	local maxOrder = 0
	local maxOrderMazeCell

	for areaId, areaMazes in pairs(chapterMazes) do
		for i = 1, #areaMazes do
			local cfgMazeInstanceData = areaMazes[i]
			local cell = self.InstanceCellPool:Obtain()

			cell.View:SetActive(true)

			local mazeTrans = mapRootTrans:Find("Chapter_" .. cfgMazeInstanceData.Id)

			if mazeTrans ~= nil then
				local bg = mazeTrans.gameObject

				cell:SetData(bg, cfgMazeInstanceData, areaUnlockMap[areaId], cfgChapterData.Order, minOrderLockCfg)
				cell:Highlight(false)
				cell:SetUnlockConditionViewVisible(false)
				table.insert(self.Cells, cell)

				if cell.IsQuickUnlock and cell.IsLevelEnough and maxOrder < cfgMazeInstanceData.Order then
					maxOrderMazeCell = cell
					maxOrder = cfgMazeInstanceData.Order
				end
			else
				logError("MazeInstance id在地图上未找到。id：" .. cfgMazeInstanceData.Id)
			end
		end
	end

	if maxOrderMazeCell ~= nil then
		self:SelectMazeCell(maxOrderMazeCell)
		maxOrderMazeCell:SetIsNewestMaze()
	end

	local minOrderUnlockCell

	for i = 1, #self.Cells do
		local cell = self.Cells[i]

		if not cell.IsQuickUnlock and (minOrderUnlockCell == nil or cell.CfgMazeInstanceData.Order < minOrderUnlockCell.CfgMazeInstanceData.Order) then
			minOrderUnlockCell = cell
		end
	end

	if minOrderUnlockCell ~= nil then
		minOrderUnlockCell:SetUnlockConditionViewVisible(true)
	end

	self:UpdateRewardView(self.ChapterCid)

	local sortComponents = self.Background:GetComponentsInChildren(typeof(IQIGame.Onigao.Game.SortedComponentOrder), true)

	for i = 0, sortComponents.Length - 1 do
		sortComponents[i].UIRootCanvas = self.UIController:GetComponent("Canvas")
	end

	sortComponents = self.Map:GetComponentsInChildren(typeof(IQIGame.Onigao.Game.SortedComponentOrder), true)

	for i = 0, sortComponents.Length - 1 do
		sortComponents[i].UIRootCanvas = self.UIController:GetComponent("Canvas")
	end

	self.UIController:ChangeBGM(cfgChapterData.BGM)
end

function MazeSelectLevelUI:OnLoadSuccess(assetName, asset, duration, userData)
	local assetObj = UnityEngine.Object.Instantiate(asset)

	assetObj.transform:SetParent(userData.parent, false)

	if userData.isMap then
		self:OnMapLoaded(assetObj)
	end

	if self.Background.transform.childCount > 0 and self.Map ~= nil then
		self.BlockView:SetActive(false)
	end
end

function MazeSelectLevelUI:ClearInstanceCells(isDestroy)
	for i = 1, #self.Cells do
		local cell = self.Cells[i]

		cell:Clear(isDestroy)
		self.InstanceCellPool:Release(cell)
	end

	self.Cells = {}
	self.SelectedCell = nil
end

function MazeSelectLevelUI:AddCurrencyCell(currencyCid)
	local currencyModule = UnityEngine.Object.Instantiate(self.UIController:GetPreloadedAsset(AssetPath.Get(GlobalKey.UIPrefabPath, "Common/MoneyGrid_Mould")))

	currencyModule.transform:SetParent(self.CurrencyCom.transform, false)
	table.insert(self.CurrencyControllers, CurrencyCell.New(currencyModule, currencyCid))
end

function MazeSelectLevelUI:UpdateRewardView(chapterCid)
	self:ClearRewardBoxes()

	local taskDataList = self:GetTaskData(chapterCid)
	local maxFinishedNum = 0
	local maxTargetNum = 0
	local dataList = {}

	for i = 1, #taskDataList do
		local data = taskDataList[i]

		maxFinishedNum = math.max(maxFinishedNum, data.CurrentNum)
		maxTargetNum = math.max(maxTargetNum, data.TargetNum)

		local cell = self.RewardBoxPool:Obtain()

		cell.goView:SetActive(true)
		cell.goView.transform:SetParent(self.RewardBoxContainer.transform, false)

		dataList[i] = data

		table.insert(self.RewardBoxCells, cell)
	end

	for i = 1, #self.RewardBoxCells do
		local cell = self.RewardBoxCells[i]
		local data = dataList[i]
		local anchoredPosition = cell.goView.transform.anchoredPosition

		anchoredPosition.x = data.TargetNum / maxTargetNum * self.RewardBoxContainer.transform.sizeDelta.x
		cell.goView.transform.anchoredPosition = anchoredPosition

		cell:RefreshView(data, maxTargetNum, i)
	end

	UGUIUtil.SetText(self.CompleteLevelNumText, MazeSelectLevelUIApi:GetString("CompleteLevelNumText", maxFinishedNum, maxTargetNum))

	self.RewardProgressBar:GetComponent("Image").fillAmount = maxFinishedNum / maxTargetNum
end

function MazeSelectLevelUI:ClearRewardBoxes(isDestroy)
	for i = 1, #self.RewardBoxCells do
		local cell = self.RewardBoxCells[i]

		if not isDestroy then
			cell.goView.transform:SetParent(self.UIController.transform, false)
		end

		cell.goView:SetActive(false)
		self.RewardBoxPool:Release(cell)
	end

	self.RewardBoxCells = {}
end

function MazeSelectLevelUI:GetTaskData(childType)
	local ret = {}
	local processing = TaskModule.GetTaskProcessing(TaskModule.TaskType.EXPLORE_POINT_TASK, {
		childType
	})
	local finished = TaskModule.GetTaskFinished(TaskModule.TaskType.EXPLORE_POINT_TASK, {
		childType
	})

	for i = 1, #processing do
		local taskData = processing[i]
		local uiTaskData = TaskUIData.New(taskData.cid, taskData.finNum, taskData.tgtNum, TaskModule.TaskStatus.CURRENT_TASK, taskData.createTime)

		table.insert(ret, uiTaskData)
	end

	for i = 1, #finished do
		local taskCid = finished[i]
		local cfgTaskData = CfgMainQuestTable[taskCid]
		local cfgTargetData = CfgTargetTable[cfgTaskData.TargetId]
		local uiTaskData = TaskUIData.New(taskCid, cfgTargetData.TargetNum, cfgTargetData.TargetNum, TaskModule.TaskStatus.FINISH_TASK)

		table.insert(ret, uiTaskData)
	end

	table.sort(ret, function(data1, data2)
		return data1.TargetNum < data2.TargetNum
	end)

	return ret
end

function MazeSelectLevelUI:OnTaskUpdate()
	self:UpdateRewardView(self.ChapterCid)
	self.ChapterViewportController:UpdateRedPoint()
end

function MazeSelectLevelUI:OnTaskCommitted(cids, rewards)
	if #rewards > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, rewards)
	end
end

function MazeSelectLevelUI:OnClickMazeCell(cell)
	self:SelectMazeCell(cell)
end

function MazeSelectLevelUI:SelectMazeCell(cell)
	if self.SelectedCell ~= nil then
		self.SelectedCell:Highlight(false)
	end

	self.SelectedCell = cell

	self.SelectedCell:Highlight(true)
	self.SelectedCell.Background.transform:SetAsLastSibling()
end

function MazeSelectLevelUI:OnClickChapterTipBtn()
	UIModule.Open(Constant.UIControllerName.MazeChapterTipUI, Constant.UILayer.UI, {
		chapterCid = self.ChapterCid
	})
end

return MazeSelectLevelUI
