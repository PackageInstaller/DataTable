-- chunkname: @IQIGame\\UI\\Activity\\PaidChallenge\\PaidChallengeView.lua

local PaidChallengeView = {
	taskCellPool = {},
	rewardCellPool = {}
}
local PaidChallengeTaskCell = require("IQIGame.UI.Activity.PaidChallenge.PaidChallengeTaskCell")
local PaidChallengeRewardCell = require("IQIGame.UI.Activity.PaidChallenge.PaidChallengeRewardCell")
local TaskUIData = require("IQIGame.Module.Task.TaskUIData")

function PaidChallengeView.New(view, eventID)
	local obj = Clone(PaidChallengeView)

	obj:Init(view, eventID)

	return obj
end

function PaidChallengeView:Init(view, eventID)
	self.View = view
	self.eventID = eventID

	LuaCodeInterface.BindOutlet(self.View, self)

	self.btnDetail = self.goBtnDetail:GetComponent("Button")
	self.btnBuy = self.goBtnBuy:GetComponent("Button")

	function self.onClickBtnBuyDelegate()
		self:OnClickBtnBuy()
	end

	function self.onClickBtnDetailDelegate()
		self:OnClickBtnDetail()
	end

	function self.onUpdateOperationsEventDelegate()
		self:OnUpdateOperationsEvent()
	end

	self.taskCellList = self.goTaskList:GetComponent("ScrollAreaList")

	function self.taskCellList.onRenderCell(cell)
		self:OnRenderTaskCell(cell)
	end

	self.rewardCellList = self.goRewardList:GetComponent("ScrollAreaList")

	function self.rewardCellList.onRenderCell(cell)
		self:OnRenderRewardCell(cell)
	end

	self.goPaidDesc:GetComponent("Text").text = ActivityUIApi:GetString("paidViewDesc_1")
	self.goPaidDesc2:GetComponent("Text").text = ActivityUIApi:GetString("paidViewDesc_2")
	self.goPaidDesc3:GetComponent("Text").text = ActivityUIApi:GetString("paidViewDesc_3")
	self.goBtnDetail.transform:Find("Text_01"):GetComponent("Text").text = ActivityUIApi:GetString("paidViewBtnDetailTxt")
end

function PaidChallengeView:Open()
	self.View:SetActive(true)
	self:OnAddListener()
	self:RefreshMisc()
	self:RefreshList()
end

function PaidChallengeView:Close()
	self.View:SetActive(false)
	self:OnHide()
end

function PaidChallengeView:OnHide()
	self:OnRemoveListener()

	for i, v in pairs(self.taskCellPool) do
		v:OnHide()
	end

	for i, v in pairs(self.rewardCellPool) do
		v:OnHide()
	end
end

function PaidChallengeView:OnDestroy()
	for i, v in pairs(self.taskCellPool) do
		v:OnDestroy()
	end

	for i, v in pairs(self.rewardCellPool) do
		v:OnDestroy()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function PaidChallengeView:OnAddListener()
	self:OnRemoveListener()
	self.btnDetail.onClick:AddListener(self.onClickBtnDetailDelegate)
	self.btnBuy.onClick:AddListener(self.onClickBtnBuyDelegate)
	EventDispatcher.AddEventListener(EventID.UpdateOperationsEvent, self.onUpdateOperationsEventDelegate)
end

function PaidChallengeView:OnRemoveListener()
	self.btnDetail.onClick:RemoveListener(self.onClickBtnDetailDelegate)
	self.btnBuy.onClick:RemoveListener(self.onClickBtnBuyDelegate)
	EventDispatcher.RemoveEventListener(EventID.UpdateOperationsEvent, self.onUpdateOperationsEventDelegate)
end

function PaidChallengeView:OnClickBtnDetail()
	local operationEventDataPOD = ActiveOperationEventModule.GetEventDataPOD(self.eventID)

	UIModule.Open(Constant.UIControllerName.DailyActivityTipsUI, Constant.UILayer.UI, CfgPaidChallengeGlobalTable[operationEventDataPOD.dataCfgId].Desc)
end

function PaidChallengeView:OnClickBtnBuy()
	local eventPOD = ActiveOperationEventModule.GetActiveOperationData(self.eventID)
	local cfgPaidChallengeGlobalData = CfgPaidChallengeGlobalTable[eventPOD.dataCfgId]
	local cfgMallData = CfgMallTable[cfgPaidChallengeGlobalData.PayMoney]

	MallModule.ReqPay(cfgMallData.PayMoney)
end

function PaidChallengeView:OnUpdateOperationsEvent()
	self:RefreshMisc()
	self:RefreshList()
end

function PaidChallengeView:OnTaskUpdate()
	self:RefreshMisc()
	self:RefreshList()
end

function PaidChallengeView:OnItemUpdate()
	self:RefreshMisc()
	self:RefreshList()
end

function PaidChallengeView:RefreshMisc()
	local eventPOD = ActiveOperationEventModule.GetActiveOperationData(self.eventID)
	local cfgPaidChallengeGlobalData = CfgPaidChallengeGlobalTable[eventPOD.dataCfgId]

	UGUIUtil.SetText(self.goName, ActivityUIApi:GetString("paidViewActivityName", cfgPaidChallengeGlobalData.Name))
	UGUIUtil.SetText(self.goTime, ActivityUIApi:GetString("paidViewTime", getCustomDateTimeText(eventPOD.endTime, "MonthToMinuteFormat")))

	local cfgMallData = CfgMallTable[cfgPaidChallengeGlobalData.PayMoney]
	local cfgPayData = CfgPayTable[cfgMallData.PayMoney]

	UGUIUtil.SetText(self.goBtnBuy.transform:Find("Text_01").gameObject, ActivityUIApi:GetString("paidViewBuyTxt", cfgPayData.Amount))
	self.goBuyBlock:SetActive(not PaidChallengeModule.isPaid)
end

function PaidChallengeView:RefreshList()
	local taskDatum = PaidChallengeModule.GetTaskDatum(TaskModule.TaskType.PAID_CHALLENGE_TASK, 1)
	local taskDatumExt = PaidChallengeModule.GetTaskDatum(TaskModule.TaskType.PAID_CHALLENGE_TASK, 2)
	local eventPOD = ActiveOperationEventModule.GetActiveOperationData(self.eventID)
	local cfgPaidChallengeGlobalData = CfgPaidChallengeGlobalTable[eventPOD.dataCfgId]

	self.taskCellListDay2DataDic = {}
	self.rewardCellListDay2DataDic = {}

	for i, v in ipairs(cfgPaidChallengeGlobalData.Quest) do
		if i % 2 ~= 0 then
			local cid = v
			local day = cfgPaidChallengeGlobalData.Quest[i + 1] + 1
			local isMainTask = false

			for m, n in pairs(taskDatum) do
				if n.cid == cid then
					self.taskCellListDay2DataDic[day] = n
					isMainTask = true

					break
				end
			end

			local isExtTask = false

			if not isMainTask then
				for j, k in pairs(taskDatumExt) do
					if k.cid == cid then
						self.rewardCellListDay2DataDic[day] = k
						isExtTask = true

						break
					end
				end
			end

			if not isMainTask and not isExtTask then
				local cfgTaskData = CfgMainQuestTable[cid]
				local cfgTargetData = CfgTargetTable[cfgTaskData.TargetId]

				if cfgTaskData.TypeParam[1] == 2 then
					self.rewardCellListDay2DataDic[day] = TaskUIData.New(cid, 0, cfgTargetData.TargetNum, TaskModule.TaskStatus.CURRENT_TASK)
				elseif cfgTaskData.TypeParam[1] == 1 then
					self.taskCellListDay2DataDic[day] = TaskUIData.New(cid, 0, cfgTargetData.TargetNum, 0)
				end
			end
		end
	end

	local days = 0

	for i, v in pairs(self.taskCellListDay2DataDic) do
		days = days + 1
	end

	self.taskCellList:Refresh(days)
	self.rewardCellList:Refresh(days)
end

function PaidChallengeView:OnRenderTaskCell(cell)
	local luaIndex = cell.index + 1
	local taskData = self.taskCellListDay2DataDic[luaIndex]
	local grid = self.taskCellPool[luaIndex]

	if grid == nil then
		grid = PaidChallengeTaskCell.New(cell.gameObject)
		self.taskCellPool[luaIndex] = grid
	end

	grid:Refresh(luaIndex, taskData)
end

function PaidChallengeView:OnRenderRewardCell(cell)
	local luaIndex = cell.index + 1
	local taskData = self.taskCellListDay2DataDic[luaIndex]
	local taskDataExt = self.rewardCellListDay2DataDic[luaIndex]
	local grid = self.rewardCellPool[luaIndex]

	if grid == nil then
		grid = PaidChallengeRewardCell.New(cell.gameObject)
		self.rewardCellPool[luaIndex] = grid
	end

	grid:Refresh(luaIndex, taskData, taskDataExt)
end

return PaidChallengeView
