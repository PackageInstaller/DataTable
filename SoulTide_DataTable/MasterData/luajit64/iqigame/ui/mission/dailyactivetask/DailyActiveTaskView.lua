-- chunkname: @IQIGame\\UI\\Mission\\DailyActiveTask\\DailyActiveTaskView.lua

local DailyActiveTaskView = {
	taskCellPool = {},
	activeCellPool = {}
}
local DailyActiveTaskCell = require("IQIGame.UI.Mission.DailyActiveTask.DailyActiveTaskCell")
local DailyActiveTaskActiveCell = require("IQIGame.UI.Mission.DailyActiveTask.DailyActiveTaskActiveCell")

function DailyActiveTaskView.New(view)
	local obj = Clone(DailyActiveTaskView)

	obj:Init(view)

	return obj
end

function DailyActiveTaskView:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.tfActiveProgress = self.goActiveProgress:GetComponent("Text")
	self.btnEasyGet = self.goBtnEasyGet:GetComponent("Button")

	function self.onClickBtnEasyGetDelegate()
		self:OnClickBtnEasyGet()
	end

	function self.onPlayerInfoChangeDelegate()
		self:OnPlayerInfoChange()
	end

	self.activeCellList = self.goActiveCellList:GetComponent("ScrollAreaList")

	function self.activeCellList.onRenderCell(cell)
		self:OnRenderActiveCell(cell)
	end

	function self.activeCellList.onSelectedCell(cell)
		self:OnSelectedActiveCell(cell)
	end

	self.taskCellList = self.goTaskCellList:GetComponent("ScrollAreaList")

	function self.taskCellList.onRenderCell(cell)
		self:OnRenderTaskCell(cell)
	end

	self.goBtnEasyGet.transform:Find("Text"):GetComponent("Text").text = MissionUIApi:GetString("goEasyGetTxt")
	self.goSignNoReward.transform:Find("Title/Text_01"):GetComponent("Text").text = MissionUIApi:GetString("activeViewNoRewardTxt", false)
	self.goSignNoReward.transform:Find("Title/Text_02"):GetComponent("Text").text = MissionUIApi:GetString("activeViewNoRewardEngTxt", false)
	self.goSignExpBonus.transform:Find("Sort/Text_01"):GetComponent("Text").text = MissionUIApi:GetString("goExpBonusDesc1")
	self.goSignExpBonus.transform:Find("Sort/Text_02"):GetComponent("Text").text = MissionUIApi:GetString("goExpBonusDesc2", CfgDiscreteDataTable[6520063].Data[1] - 100)
end

function DailyActiveTaskView:Open()
	self.View:SetActive(true)
	self:RefreshDatum()
	self:RefreshMisc()
	self:RefreshActiveCellList()
	self:RefreshTaskCellList()
	self:AddListener()
end

function DailyActiveTaskView:Close()
	self:OnHide()
	self.View:SetActive(false)
end

function DailyActiveTaskView:OnHide()
	self:RemoveListener()

	for i, v in pairs(self.taskCellPool) do
		v:OnHide()
	end

	for i, v in pairs(self.activeCellPool) do
		v:OnHide()
	end
end

function DailyActiveTaskView:OnDestroy()
	for i, v in pairs(self.taskCellPool) do
		v:OnDestroy()
	end

	for i, v in pairs(self.activeCellPool) do
		v:OnDestroy()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function DailyActiveTaskView:AddListener()
	self:RemoveListener()
	self.btnEasyGet.onClick:AddListener(self.onClickBtnEasyGetDelegate)
	EventDispatcher.AddEventListener(EventID.PlayerInfoChanged, self.onPlayerInfoChangeDelegate)
end

function DailyActiveTaskView:RemoveListener()
	self.btnEasyGet.onClick:RemoveListener(self.onClickBtnEasyGetDelegate)
	EventDispatcher.RemoveEventListener(EventID.PlayerInfoChanged, self.onPlayerInfoChangeDelegate)
end

function DailyActiveTaskView:OnClickBtnEasyGet()
	local cids = self:GetTaskCidsCanGetReward()

	if #cids > 0 then
		TaskModule.SendCommitTaskMsgBatch(cids)
	else
		NoticeModule.ShowNotice(21040136)
	end
end

function DailyActiveTaskView:OnUpdateTask()
	self:RefreshDatum()
	self:RefreshMisc()
	self.activeCellList:RenderCellsDynamic(#self.boxTaskDatum)

	if self.curScore < self.maxScore then
		self.taskCellList:RenderCellsDynamic(#self.taskDatum)
	else
		self.taskCellList:Refresh(0)
	end
end

function DailyActiveTaskView:OnRenderActiveCell(cell)
	local luaIndex = cell.index + 1
	local insID = cell.gameObject:GetInstanceID()
	local taskData = self.boxTaskDatum[luaIndex]
	local taskCell = self.activeCellPool[insID]

	if taskCell == nil then
		taskCell = DailyActiveTaskActiveCell.New(cell.gameObject)
		self.activeCellPool[insID] = taskCell
	end

	taskCell:Refresh(taskData, luaIndex)
end

function DailyActiveTaskView:OnSelectedActiveCell(cell)
	local insID = cell.gameObject:GetInstanceID()
	local taskCell = self.activeCellPool[insID]

	taskCell:OnSelected()
end

function DailyActiveTaskView:OnRenderTaskCell(cell)
	local luaIndex = cell.index + 1
	local insID = cell.gameObject:GetInstanceID()
	local taskData = self.taskDatum[luaIndex]
	local taskCell = self.taskCellPool[insID]

	if taskCell == nil then
		taskCell = DailyActiveTaskCell.New(cell.gameObject)
		self.taskCellPool[insID] = taskCell
	end

	taskCell:Refresh(taskData)
end

function DailyActiveTaskView:OnPlayerInfoChange()
	self:RefreshSignExpBonusVisible()
end

function DailyActiveTaskView:RefreshDatum()
	self.taskDatum = MissionModule.GetSpecialTaskDatum(TaskModule.TaskType.ACTIVE_TASK, 1)
	self.boxTaskDatum = MissionModule.GetSpecialTaskDatum(TaskModule.TaskType.ACTIVE_TASK, 2)

	table.sort(self.boxTaskDatum, function(a, b)
		return a.cid < b.cid
	end)

	self.maxScore = 0

	for i, v in pairs(self.boxTaskDatum) do
		if self.maxScore < v.TargetNum then
			self.maxScore = v.TargetNum
		end
	end

	self.curScore = 0

	for i, v in pairs(self.taskDatum) do
		if v.TaskStatus == TaskModule.TaskStatus.FINISH_TASK then
			local cfgData = CfgMainQuestTable[v.cid]

			for m, n in ipairs(cfgData.Reward) do
				if m % 2 ~= 0 and n == 102 then
					self.curScore = self.curScore + cfgData.Reward[m + 1]
				end
			end
		end
	end
end

function DailyActiveTaskView:RefreshMisc()
	self.tfActiveProgress.text = MissionUIApi:GetString("activeViewProgress", self.curScore, self.maxScore)

	self.goSignNoReward:SetActive(self.curScore >= self.maxScore)
	self:RefreshGray()
	self:RefreshSignExpBonusVisible()
end

function DailyActiveTaskView:RefreshActiveCellList()
	self.activeCellList:Refresh(#self.boxTaskDatum)
end

function DailyActiveTaskView:RefreshTaskCellList()
	local taskCount = 0

	if self.curScore < self.maxScore then
		taskCount = #self.taskDatum
	end

	self.taskCellList:Refresh(taskCount)
end

function DailyActiveTaskView:RefreshGray()
	local grayComp = self.goBtnEasyGet:GetComponent("GrayComponent")
	local cids = self:GetTaskCidsCanGetReward()

	grayComp:SetGray(#cids == 0)
end

function DailyActiveTaskView:RefreshSignExpBonusVisible()
	local result = PlayerModule.PlayerInfo.baseInfo.pLv < CfgDiscreteDataTable[6520062].Data[1]

	self.goSignExpBonus:SetActive(result)
end

function DailyActiveTaskView:GetTaskCidsCanGetReward()
	local cids = {}

	for i, v in pairs(self.taskDatum) do
		if v.TaskStatus == TaskModule.TaskStatus.CURRENT_TASK and v.CurrentNum >= v.TargetNum then
			cids[#cids + 1] = v.cid
		end
	end

	local existBoxReward = false

	for i, v in pairs(self.boxTaskDatum) do
		if v.TaskStatus == TaskModule.TaskStatus.CURRENT_TASK and v.CurrentNum >= v.TargetNum then
			cids[#cids + 1] = v.cid
			existBoxReward = true
		end
	end

	if existBoxReward == false and self.curScore >= self.maxScore then
		cids = {}
	end

	return cids
end

return DailyActiveTaskView
