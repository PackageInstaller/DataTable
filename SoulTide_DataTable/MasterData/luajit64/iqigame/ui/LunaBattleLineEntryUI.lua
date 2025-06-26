-- chunkname: @IQIGame\\UI\\LunaBattleLineEntryUI.lua

local LunaBattleLineEntryUI = {
	RewardBoxCells = {},
	UnfinishedTags = {}
}

LunaBattleLineEntryUI = Base:Extend("LunaBattleLineEntryUI", "IQIGame.Onigao.UI.LunaBattleLineEntryUI", LunaBattleLineEntryUI)

require("IQIGame.UIExternalApi.LunaBattleLineEntryUIApi")

local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local MazeSelectLevelRewardBoxCell = require("IQIGame.UI.MazeSelectLevel.MazeSelectLevelRewardBoxCell")
local LunaBattleLineEntryZoneCell = require("IQIGame.UI.LunaBattleLine.Entry.LunaBattleLineEntryZoneCell")
local LunaBattleEntryUnfinishedTagItem = require("IQIGame.UI.LunaBattleLine.Entry.LunaBattleEntryUnfinishedTagItem")

function LunaBattleLineEntryUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnTaskUpdate()
		self:OnTaskUpdate()
	end

	function self.DelegateOnTaskCommitted(cids, rewards)
		self:OnTaskCommitted(cids, rewards)
	end

	function self.DelegateOnClickTipBtn()
		self:OnClickTipBtn()
	end

	function self.DelegateOnClickShopBtn()
		self:OnClickShopBtn()
	end

	function self.DelegateOnClickTaskBtn()
		self:OnClickTaskBtn()
	end

	self.EnergyCell = EnergyCell.New(self.EnergyCom.transform:GetChild(0).gameObject)
	self.CurrencyControllers = {}

	self:AddCurrencyCell(203)

	self.RewardBoxPool = UIObjectPool.New(5, function()
		local cell = MazeSelectLevelRewardBoxCell.New(UnityEngine.Object.Instantiate(self.RewardBoxCellPrefab))

		return cell
	end, function(cell)
		local view = cell.goView

		cell:OnDestroy()
		UnityEngine.Object.Destroy(view)
	end)
	self.ZoneIdCellMap = {}

	for i, cfgLunaBattleLineZoneData in pairsCfg(CfgLunaBattleLineZoneTable) do
		local levelTrans = self.Map.transform:Find("Chapter_" .. cfgLunaBattleLineZoneData.Id)
		local cellGo = UnityEngine.Object.Instantiate(self.CellPrefab)

		cellGo.name = self.CellPrefab.name

		cellGo.transform:SetParent(levelTrans:Find("Point"), false)

		cellGo.transform.localPosition = Vector3.zero

		local cell = LunaBattleLineEntryZoneCell.New(cellGo, cfgLunaBattleLineZoneData.Id)

		self.ZoneIdCellMap[cfgLunaBattleLineZoneData.Id] = cell
	end

	self.Map:SetActive(false)
	self.Map:SetActive(true)

	for i = 1, 3 do
		local item = LunaBattleEntryUnfinishedTagItem.New(UnityEngine.Object.Instantiate(self.UnfinishedTagPrefab))

		item.View.transform:SetParent(self.UnfinishedTagGrid.transform, false)
		table.insert(self.UnfinishedTags, item)
	end

	UGUIUtil.SetText(self.TitleText, LunaBattleLineEntryUIApi:GetString("TitleText"))
	UGUIUtil.SetTextInChildren(self.TipBtn, LunaBattleLineEntryUIApi:GetString("TipBtnText"))
	UGUIUtil.SetTextInChildren(self.ShopBtn, LunaBattleLineEntryUIApi:GetString("ShopBtnText"))
	UGUIUtil.SetTextInChildren(self.TaskBtn, LunaBattleLineEntryUIApi:GetString("TaskBtnText"))
end

function LunaBattleLineEntryUI:GetPreloadAssetPaths()
	local paths = {
		AssetPath.Get(GlobalKey.UIPrefabPath, "Common/MoneyGrid_Mould")
	}

	return paths
end

function LunaBattleLineEntryUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function LunaBattleLineEntryUI:IsManualShowOnOpen(userData)
	return false
end

function LunaBattleLineEntryUI:GetBGM(userData)
	return 413
end

function LunaBattleLineEntryUI:OnOpen(userData)
	self:UpdateView()
end

function LunaBattleLineEntryUI:OnClose(userData)
	return
end

function LunaBattleLineEntryUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.TipBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickTipBtn)
	self.ShopBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickShopBtn)
	self.TaskBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickTaskBtn)
	EventDispatcher.AddEventListener(EventID.TaskUpdate, self.DelegateOnTaskUpdate)
	EventDispatcher.AddEventListener(EventID.TaskCommitResponse, self.DelegateOnTaskCommitted)
end

function LunaBattleLineEntryUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.TipBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickTipBtn)
	self.ShopBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickShopBtn)
	self.TaskBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickTaskBtn)
	EventDispatcher.RemoveEventListener(EventID.TaskUpdate, self.DelegateOnTaskUpdate)
	EventDispatcher.RemoveEventListener(EventID.TaskCommitResponse, self.DelegateOnTaskCommitted)
end

function LunaBattleLineEntryUI:OnPause()
	return
end

function LunaBattleLineEntryUI:OnResume()
	return
end

function LunaBattleLineEntryUI:OnCover()
	return
end

function LunaBattleLineEntryUI:OnReveal()
	return
end

function LunaBattleLineEntryUI:OnRefocus(userData)
	return
end

function LunaBattleLineEntryUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function LunaBattleLineEntryUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function LunaBattleLineEntryUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function LunaBattleLineEntryUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function LunaBattleLineEntryUI:OnDestroy()
	self.EnergyCell:Dispose()

	for i = 1, #self.CurrencyControllers do
		self.CurrencyControllers[i]:Dispose()
	end

	self:ClearRewardBoxes(true)
	self.RewardBoxPool:Dispose()

	for zoneId, cell in pairs(self.ZoneIdCellMap) do
		cell:Dispose()
	end

	for i = 1, #self.UnfinishedTags do
		local item = self.UnfinishedTags[i]

		item:Dispose()
	end
end

function LunaBattleLineEntryUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function LunaBattleLineEntryUI:UpdateView()
	local dailyDupPOD = LunaBattleLineModule.DailyDupPOD

	for zoneId, cell in pairs(self.ZoneIdCellMap) do
		local sealNum = dailyDupPOD.common.centerLunaBattleLineDataPOD.zoneSealPercentage[zoneId]

		if sealNum == nil then
			sealNum = 0
		end

		local zonePOD = dailyDupPOD.lunaBattleLineDataPOD.zones[zoneId]

		cell:SetData(sealNum, zonePOD)
	end

	self:UpdateTasks()

	local cfgDailyDupData = CfgDailyDupTable[LunaBattleLineModule.DailyDupPOD.common.cid]
	local currentServerTime = PlayerModule.GetServerTime()
	local accessEndTime = LunaBattleLineModule.DailyDupPOD.common.openDate + cfgDailyDupData.AccessibleTime
	local activityEndTime = LunaBattleLineModule.DailyDupPOD.common.openDate + cfgDailyDupData.Duration

	UGUIUtil.SetText(self.TimeText, LunaBattleLineEntryUIApi:GetString("TimeText", currentServerTime, accessEndTime, activityEndTime))
	self:UpdateUnfinishedMazeTags()
end

function LunaBattleLineEntryUI:UpdateUnfinishedMazeTags()
	local dailyDupPOD = LunaBattleLineModule.DailyDupPOD
	local unfinishedMazeTypeDataMap = {}

	for zoneId, zonePOD in pairs(dailyDupPOD.lunaBattleLineDataPOD.zones) do
		local cfgLunaBattleLineZoneData = CfgLunaBattleLineZoneTable[zoneId]
		local mazeCid, chapterType = self:GetUnfinishedMaze(cfgLunaBattleLineZoneData.StationingLevel)

		if mazeCid ~= 0 then
			unfinishedMazeTypeDataMap[1] = {
				zoneId = zoneId,
				mazeCid = mazeCid,
				chapterType = chapterType
			}
		end

		mazeCid, chapterType = self:GetUnfinishedMaze(cfgLunaBattleLineZoneData.SealedLevel)

		if mazeCid ~= 0 then
			unfinishedMazeTypeDataMap[2] = {
				zoneId = zoneId,
				mazeCid = mazeCid,
				chapterType = chapterType
			}
		end

		mazeCid, chapterType = self:GetUnfinishedMaze(cfgLunaBattleLineZoneData.TrainingLevel)

		if mazeCid ~= 0 then
			unfinishedMazeTypeDataMap[3] = {
				zoneId = zoneId,
				mazeCid = mazeCid,
				chapterType = chapterType
			}
		end
	end

	for i = 1, #self.UnfinishedTags do
		local item = self.UnfinishedTags[i]

		item:SetData(unfinishedMazeTypeDataMap[i])
	end
end

function LunaBattleLineEntryUI:GetUnfinishedMaze(mazeCid)
	local cfgMazeInstanceData = CfgMazeInstanceTable[mazeCid]
	local cfgChapterData = CfgChapterTable[cfgMazeInstanceData.ChapterId]
	local unfinishedMazeCid = PlayerModule.GetUnfinishedMazeCid(cfgChapterData.Type)

	if unfinishedMazeCid ~= nil then
		return unfinishedMazeCid, cfgChapterData.Type
	end

	return 0, 0
end

function LunaBattleLineEntryUI:AddCurrencyCell(currencyCid)
	local currencyModule = UnityEngine.Object.Instantiate(self.UIController:GetPreloadedAsset(AssetPath.Get(GlobalKey.UIPrefabPath, "Common/MoneyGrid_Mould")))

	currencyModule.transform:SetParent(self.CurrencyCom.transform, false)
	table.insert(self.CurrencyControllers, CurrencyCell.New(currencyModule, currencyCid))
end

function LunaBattleLineEntryUI:UpdateTasks()
	self:UpdateDailyTaskRewardBoxes()

	local taskDataList1 = LunaBattleLineModule.GetTaskDataList(2)
	local hasReward1 = self:CheckTaskReward(taskDataList1)
	local taskDataList2 = LunaBattleLineModule.GetTaskDataList(3)
	local hasReward2 = self:CheckTaskReward(taskDataList2)

	self.TaskBtnRedPoint:SetActive(hasReward1 or hasReward2)
end

function LunaBattleLineEntryUI:CheckTaskReward(taskDataList)
	for i = 1, #taskDataList do
		local taskUIData = taskDataList[i]

		if taskUIData.TaskStatus == TaskModule.TaskStatus.CURRENT_TASK and taskUIData.CurrentNum >= taskUIData.TargetNum then
			return true
		end
	end

	return false
end

function LunaBattleLineEntryUI:UpdateDailyTaskRewardBoxes()
	self:ClearRewardBoxes()

	local taskDataList = self:GetDailyTaskData(1)
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

	UGUIUtil.SetText(self.RewardProgressText, LunaBattleLineEntryUIApi:GetString("RewardProgressText", maxFinishedNum, maxTargetNum))

	self.RewardProgressBar:GetComponent("Image").fillAmount = maxFinishedNum / maxTargetNum
end

function LunaBattleLineEntryUI:ClearRewardBoxes(isDestroy)
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

function LunaBattleLineEntryUI:GetDailyTaskData(childType)
	local taskDataList = LunaBattleLineModule.GetTaskDataList(childType)

	table.sort(taskDataList, function(data1, data2)
		return data1.TargetNum < data2.TargetNum
	end)

	return taskDataList
end

function LunaBattleLineEntryUI:OnTaskUpdate()
	self:UpdateTasks()
end

function LunaBattleLineEntryUI:OnTaskCommitted(cids, rewards)
	if #rewards > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, rewards)
	end
end

function LunaBattleLineEntryUI:OnClickTipBtn()
	UIModule.Open(Constant.UIControllerName.LunaBattleLineTipsUI, Constant.UILayer.UI)
end

function LunaBattleLineEntryUI:OnClickShopBtn()
	MallModule.OpenActivityMall(Constant.Mall_EntranceType.LU_NA_BATTLE, LunaBattleLineModule.GetMallCidList())
end

function LunaBattleLineEntryUI:OnClickTaskBtn()
	UIModule.Open(Constant.UIControllerName.LunaBattleLineMissionUI, Constant.UILayer.UI)
end

return LunaBattleLineEntryUI
