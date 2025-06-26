-- chunkname: @IQIGame\\UI\\Activity\\LimitedTurn\\LimitedTurnView.lua

local m = {
	playingIndex = 1,
	StartRotate = false,
	limitedTurnTableCellPool = {},
	limitedShowTab = {},
	taskCellPool = {}
}
local LimitedTurnTableCell = require("IQIGame.UI.Activity.LimitedTurn.LimitedTurnTableCell")
local LimitedTurnTaskItemCell = require("IQIGame.UI.Activity.LimitedTurn.LimitedTurnTaskItemCell")

function m.New(view, root, operateEventID)
	local obj = Clone(m)

	obj:Init(view, root, operateEventID)

	return obj
end

function m:Init(view, root, operateEventID)
	self.View = view
	self.root = root
	self.operateEventID = operateEventID

	LuaCodeInterface.BindOutlet(self.View, self)
	UGUIUtil.SetText(self.TextDes, ActivityUIApi:GetString("LimitedTextDes"))
	UGUIUtil.SetText(self.BtnProbabilityTitle, ActivityUIApi:GetString("LimitedBtnProbabilityTitle"))
	UGUIUtil.SetText(self.BtnLotteryRecordTitle, ActivityUIApi:GetString("LimitedBtnLotteryRecordTitle"))
	UGUIUtil.SetText(self.BtnBuyTitle2, ActivityUIApi:GetString("LimitedBtnBuyTitle2"))
	UGUIUtil.SetText(self.BtnBatchBuyTitle2, ActivityUIApi:GetString("LimitedBtnBatchBuyTitle2"))
	UGUIUtil.SetTextInChildren(self.BtnDetails, ActivityUIApi:GetString("LimitedBtnDetails"))
	UGUIUtil.SetText(self.TextTitle, ActivityUIApi:GetString("LimitedTextTitle"))

	function self.delegateBtnProbability()
		self:OnBtnProbability()
	end

	function self.delegateBtnLotteryRecord()
		self:OnBtnLotteryRecord()
	end

	function self.delegateBtnBuy()
		self:OnBtnBuy()
	end

	function self.delegateBtnBatchBuy()
		self:OnBtnBatchBuy()
	end

	function self.delegateBtnDetails()
		self:OnBtnDetails()
	end

	function self.delegateUpdateOperations()
		self:OnUpdateOperations()
	end

	function self.onTaskUpdateDelegate(id)
		self:OnUpdateTask(id)
	end

	function self.delegateUpdateItem()
		self:OnUpdateItem()
	end

	self.limitedShowTab = ActiveLimitedTurnModule.GetCfgData(self.operateEventID)
	self.limitedTurnTableCellPool = {}

	for i = 1, 18 do
		if i <= #self.limitedShowTab then
			self["Item" .. i]:SetActive(true)

			local cell = LimitedTurnTableCell.New(self["Item" .. i], i)

			self.limitedTurnTableCellPool[i] = cell
		else
			self["Item" .. i]:SetActive(false)
		end
	end

	self.scrollAreaList = self.TaskScrollArea:GetComponent("ScrollAreaList")

	function self.scrollAreaList.onRenderCell(cell)
		self:OnRenderTaskCell(cell)
	end

	self.turnTimer = Timer.New(function()
		self:UpdateTimer()
	end, 0.025, -1)

	self.turnTimer:Start()
end

function m:AddListener()
	self.BtnProbability:GetComponent("Button").onClick:AddListener(self.delegateBtnProbability)
	self.BtnLotteryRecord:GetComponent("Button").onClick:AddListener(self.delegateBtnLotteryRecord)
	self.goBtnBuy:GetComponent("Button").onClick:AddListener(self.delegateBtnBuy)
	self.goBtnBatchBuy:GetComponent("Button").onClick:AddListener(self.delegateBtnBatchBuy)
	self.BtnDetails:GetComponent("Button").onClick:AddListener(self.delegateBtnDetails)
	EventDispatcher.AddEventListener(EventID.UpdateOperationsEvent, self.delegateUpdateOperations)
	EventDispatcher.AddEventListener(EventID.TaskUpdate, self.onTaskUpdateDelegate)
	EventDispatcher.AddEventListener(EventID.UpdateItem, self.delegateUpdateItem)
end

function m:RemoveListener()
	self.BtnProbability:GetComponent("Button").onClick:RemoveListener(self.delegateBtnProbability)
	self.BtnLotteryRecord:GetComponent("Button").onClick:RemoveListener(self.delegateBtnLotteryRecord)
	self.goBtnBuy:GetComponent("Button").onClick:RemoveListener(self.delegateBtnBuy)
	self.goBtnBatchBuy:GetComponent("Button").onClick:RemoveListener(self.delegateBtnBatchBuy)
	self.BtnDetails:GetComponent("Button").onClick:RemoveListener(self.delegateBtnDetails)
	EventDispatcher.RemoveEventListener(EventID.UpdateOperationsEvent, self.delegateUpdateOperations)
	EventDispatcher.RemoveEventListener(EventID.TaskUpdate, self.onTaskUpdateDelegate)
	EventDispatcher.RemoveEventListener(EventID.UpdateItem, self.delegateUpdateItem)
end

function m:OnUpdateOperations()
	self:UpDateView()
end

function m:OnUpdateItem()
	self:UpDateView()
end

function m:UpDateView()
	self.BtnBuyRedTag:SetActive(false)
	self.BtnBatchBuyRedTag:SetActive(false)

	if not ActiveOperationEventModule.CheckIsOpen(self.operateEventID) then
		return false
	end

	self.eventPOD = ActiveOperationEventModule.GetActiveOperationData(self.operateEventID)

	if self.eventPOD then
		self.cfgLimitedTurntableGlobal = CfgLimitedTurntableGlobalTable[self.eventPOD.dataCfgId]

		local startYear = getYearText(self.eventPOD.startTime)
		local endYear = getYearText(self.eventPOD.endTime)
		local startMoth = getMonthText(self.eventPOD.startTime)
		local endMoth = getMonthText(self.eventPOD.endTime)
		local startDay = getOnlyDateText(self.eventPOD.startTime)
		local endDay = getOnlyDateText(self.eventPOD.endTime)
		local startHM = getHourMinuteText(self.eventPOD.startTime)
		local endHM = getHourMinuteText(self.eventPOD.endTime)

		UGUIUtil.SetText(self.TextTimeStart, ActivityUIApi:GetString("LimitedTextTimeStart", startYear, startMoth, startDay, startHM))
		UGUIUtil.SetText(self.TextTimeEnd, ActivityUIApi:GetString("LimitedTextTimeEnd", endYear, endMoth, endDay, endHM))

		local itemName = CfgItemTable[self.cfgLimitedTurntableGlobal.CostItem].Name
		local num = self.cfgLimitedTurntableGlobal.CostNum

		UGUIUtil.SetText(self.BtnBuyTitle1, ActivityUIApi:GetString("LimitedBtnBuyTitle1", itemName, num))
		UGUIUtil.SetText(self.BtnBatchBuyTitle1, ActivityUIApi:GetString("LimitedBtnBatchBuyTitle1", itemName, num * 10))

		local have, needOnce = ActiveLimitedTurnModule.GetCostItemNum(self.operateEventID)

		self.BtnBuyRedTag:SetActive(needOnce <= have)
		self.BtnBatchBuyRedTag:SetActive(have >= needOnce * 10)

		local operationEventDataPOD = ActiveOperationEventModule.GetEventDataPOD(self.operateEventID)
		local value = self.cfgLimitedTurntableGlobal.MaxTimes

		if operationEventDataPOD.limitTurnTableDataPOD then
			value = self.cfgLimitedTurntableGlobal.MaxTimes - operationEventDataPOD.limitTurnTableDataPOD.insureTimes
		end

		value = value - 1
		value = value < 0 and 0 or value

		UGUIUtil.SetText(self.TestDes, ActivityUIApi:GetString("LimitedTestDes", value))
		self.TestDes:SetActive(ActiveLimitedTurnModule.HaveLimitedReward(self.operateEventID))

		for i = 1, #self.limitedTurnTableCellPool do
			local cfgData = self.limitedShowTab[i]
			local cell = self.limitedTurnTableCellPool[i]
			local getNum = 0

			if operationEventDataPOD.limitTurnTableDataPOD then
				getNum = operationEventDataPOD.limitTurnTableDataPOD.getAwards[cfgData.Id]
			end

			if getNum == nil then
				getNum = 0
			end

			cell:SetData(cfgData, getNum)
		end
	end
end

function m:OnUpdateTask()
	self:RefreshTask()
end

function m:RefreshTask()
	self.TaskDataList = self:GetTaskData()

	self.scrollAreaList:Refresh(#self.TaskDataList)
end

function m:OnRenderTaskCell(cell)
	local luaIndex = cell.index + 1
	local insID = cell.gameObject:GetInstanceID()
	local taskData = self.TaskDataList[luaIndex]
	local taskCell = self.taskCellPool[insID]

	if taskCell == nil then
		taskCell = LimitedTurnTaskItemCell.New(cell.gameObject)
		self.taskCellPool[insID] = taskCell
	end

	taskCell:Refresh(taskData, luaIndex)
end

function m:GetTaskData()
	local taskDataList = ActiveLimitedTurnModule.GetTaskDataList()

	table.sort(taskDataList, function(data1, data2)
		local finish1 = data1.TaskStatus == TaskModule.TaskStatus.FINISH_TASK and 1 or 0
		local finish2 = data2.TaskStatus == TaskModule.TaskStatus.FINISH_TASK and 1 or 0

		if finish1 == finish2 then
			local targetOK1 = data1.CurrentNum >= data1.TargetNum and 1 or 0
			local targetOK2 = data2.CurrentNum >= data2.TargetNum and 1 or 0

			if targetOK1 == targetOK2 then
				return data1.cid < data2.cid
			end

			return targetOK2 < targetOK1
		end

		return finish1 < finish2
	end)

	return taskDataList
end

function m:UpdateTimer()
	if self.StartRotate then
		for i = 1, #self.limitedTurnTableCellPool do
			self.limitedTurnTableCellPool[i]:SetSelect(i == self.playingIndex)
		end

		local nowTime = PlayerModule.GetServerTime()

		if nowTime - self.startTime > 3 and self.playingIndex == self.endIndex then
			self:TurnTableComplete()
		else
			self.playingIndex = self.playingIndex + 1

			if self.playingIndex > #self.limitedTurnTableCellPool then
				self.playingIndex = 1
			end
		end
	end
end

function m:OnBtnProbability()
	UIModule.Open(Constant.UIControllerName.LimitedTurnRewardListUI, Constant.UILayer.UI, self.operateEventID)
end

function m:OnBtnLotteryRecord()
	ActiveLimitedTurnModule.GetHistory(self.operateEventID, function(history)
		UIModule.Open(Constant.UIControllerName.LimitedTurnHistoryListUI, Constant.UILayer.UI, history)
	end)
end

function m:OnBtnBuy()
	if self.StartRotate then
		return
	end

	local haveNum, needNum = ActiveLimitedTurnModule.GetCostItemNum(self.operateEventID)

	if haveNum < needNum then
		NoticeModule.ShowNotice(21052002)

		return
	end

	self:DefaultSelect()
	ActiveLimitedTurnModule.Draw(self.operateEventID, 0, function(awardsId, list)
		self:StartPlayTurnTable(awardsId, list)
	end)
end

function m:StartPlayTurnTable(awardsId, list)
	self.showItems = list
	self.endIndex = nil

	local endItemID = awardsId[#awardsId]

	for i = 1, #self.limitedTurnTableCellPool do
		local cell = self.limitedTurnTableCellPool[i]

		if cell.cfgData.Id == endItemID then
			self.endIndex = i

			break
		end
	end

	self.StartRotate = true
	self.startTime = PlayerModule.GetServerTime()
end

function m:TurnTableComplete()
	self.StartRotate = false

	self:ShowReward()
end

function m:ShowReward()
	if self.showItems and #self.showItems > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, self.showItems)

		self.showItems = nil
	end

	self:UpDateView()
end

function m:OnBtnBatchBuy()
	if self.StartRotate then
		return
	end

	local haveNum, needNum = ActiveLimitedTurnModule.GetCostItemNum(self.operateEventID)

	if haveNum < needNum * 10 then
		NoticeModule.ShowNotice(21052002)

		return
	end

	self:DefaultSelect()
	ActiveLimitedTurnModule.Draw(self.operateEventID, 1, function(awardsId, list)
		self:StartPlayTurnTable(awardsId, list)
	end)
end

function m:OnBtnDetails()
	if self.cfgLimitedTurntableGlobal then
		UIModule.Open(Constant.UIControllerName.DailyActivityTipsUI, Constant.UILayer.UI, self.cfgLimitedTurntableGlobal.Desc)
	end
end

function m:DefaultSelect()
	for i, v in pairs(self.limitedTurnTableCellPool) do
		v:SetSelect(false)
	end
end

function m:Open()
	self:AddListener()
	self.View:SetActive(true)
	self:DefaultSelect()
	self:UpDateView()
	self:RefreshTask()
end

function m:Close()
	self.View:SetActive(false)
	self:OnHide()
end

function m:OnHide()
	self:RemoveListener()

	for i, v in pairs(self.taskCellPool) do
		v:OnHide()
	end

	self:TurnTableComplete()
end

function m:OnDestroy()
	self.turnTimer:Stop()

	self.turnTimer = nil

	for i, v in pairs(self.limitedTurnTableCellPool) do
		v:Dispose()
	end

	for i, v in pairs(self.taskCellPool) do
		v:OnDestroy()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
