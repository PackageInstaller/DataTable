-- chunkname: @IQIGame\\UI\\MonsterAcademyCalendarUI.lua

local MonsterAcademyCalendarUI = {
	weekCellPool = {},
	dayCells = {},
	detailCells = {}
}

MonsterAcademyCalendarUI = Base:Extend("MonsterAcademyCalendarUI", "IQIGame.Onigao.UI.MonsterAcademyCalendarUI", MonsterAcademyCalendarUI)

require("IQIGame.UIExternalApi.MonsterAcademyCalendarUIApi")

local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local MonsterAcademyDayCell = require("IQIGame.UI.ExploreHall.MonsterAcademy.MonsterAcademyDayCell")
local MonsterAcademyDetailCell = require("IQIGame.UI.ExploreHall.MonsterAcademy.MonsterAcademyDetailCell")

function MonsterAcademyCalendarUI:OnInit()
	UGUIUtil.SetText(self.TextTripRecord, MonsterAcademyCalendarUIApi:GetString("TextTripRecord"))
	UGUIUtil.SetText(self.TextTip1, MonsterAcademyCalendarUIApi:GetString("TextTip1"))
	UGUIUtil.SetText(self.TextTip2, MonsterAcademyCalendarUIApi:GetString("TextTip2"))

	function self.DelegateOnWeekCellValueChanged(isOn)
		self:OnWeekCellValueChanged(isOn)
	end

	function self.DelegateOnClickBtnClose()
		self:OnClickBtnClose()
	end

	function self.delegateUpdateBaseEvent()
		self:OnUpdateBaseEvent()
	end

	function self.delegateUpdateScheduleEvent()
		self:OnUpdateScheduleEvent()
	end

	self.goWeekCell:SetActive(false)

	for i = 1, 5 do
		local weekCellObj = UnityEngine.Object.Instantiate(self.goWeekCell)

		weekCellObj:SetActive(true)
		weekCellObj.transform:SetParent(self.goWeekCell.transform.parent, false)

		weekCellObj:GetComponent("ToggleHelperComponent").text = MonsterAcademyCalendarUIApi:GetString("WeekTxt", i)
		weekCellObj:GetComponent("Toggle").isOn = i > 3
		self.weekCellPool[i] = weekCellObj
	end

	self.dayCellPool = UIObjectPool.New(6, function()
		return MonsterAcademyDayCell.New(UnityEngine.Object.Instantiate(self.DayModule), self)
	end, function(cell)
		cell:Dispose()
	end)
	self.detailCellPool = UIObjectPool.New(10, function()
		return MonsterAcademyDetailCell.New(UnityEngine.Object.Instantiate(self.DetailModule))
	end, function(cell)
		cell:Dispose()
	end)
end

function MonsterAcademyCalendarUI:GetPreloadAssetPaths()
	return nil
end

function MonsterAcademyCalendarUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MonsterAcademyCalendarUI:IsManualShowOnOpen(userData)
	return false
end

function MonsterAcademyCalendarUI:GetBGM(userData)
	return nil
end

function MonsterAcademyCalendarUI:OnOpen(userData)
	self:UpdateView()
end

function MonsterAcademyCalendarUI:OnClose(userData)
	return
end

function MonsterAcademyCalendarUI:OnAddListeners()
	self.goWeekCell:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateOnWeekCellValueChanged)
	self.goBtnClose2:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnClose)
	self.goBtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnClose)
	EventDispatcher.AddEventListener(EventID.MonsterAcademyUpdateBaseEvent, self.delegateUpdateBaseEvent)
	EventDispatcher.AddEventListener(EventID.MonsterAcademyUpdateScheduleEvent, self.delegateUpdateScheduleEvent)
end

function MonsterAcademyCalendarUI:OnRemoveListeners()
	self.goWeekCell:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateOnWeekCellValueChanged)
	self.goBtnClose2:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnClose)
	self.goBtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnClose)
	EventDispatcher.RemoveEventListener(EventID.MonsterAcademyUpdateBaseEvent, self.delegateUpdateBaseEvent)
	EventDispatcher.RemoveEventListener(EventID.MonsterAcademyUpdateScheduleEvent, self.delegateUpdateScheduleEvent)
end

function MonsterAcademyCalendarUI:OnPause()
	return
end

function MonsterAcademyCalendarUI:OnResume()
	return
end

function MonsterAcademyCalendarUI:OnCover()
	return
end

function MonsterAcademyCalendarUI:OnReveal()
	return
end

function MonsterAcademyCalendarUI:OnRefocus(userData)
	return
end

function MonsterAcademyCalendarUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MonsterAcademyCalendarUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MonsterAcademyCalendarUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MonsterAcademyCalendarUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MonsterAcademyCalendarUI:OnDestroy()
	for i, v in pairs(self.dayCells) do
		self.dayCellPool:Release(v)
	end

	self.dayCells = {}

	self.dayCellPool:Dispose()

	for i, v in pairs(self.detailCells) do
		self.detailCellPool:Release(v)
	end

	self.detailCells = {}

	self.detailCellPool:Dispose()
end

function MonsterAcademyCalendarUI:OnWeekCellValueChanged(isOn)
	return
end

function MonsterAcademyCalendarUI:UpdateView()
	self.currentCfgDay = MonsterAcademyModule.GetGameTime()

	UGUIUtil.SetText(self.goLeftTitle1, MonsterAcademyCalendarUIApi:GetString("LeftTitle1", self.currentCfgDay.Year, self.currentCfgDay.Month, self.currentCfgDay.Day))
	UGUIUtil.SetText(self.goLeftTitle2, MonsterAcademyCalendarUIApi:GetString("LeftTitle2", self.currentCfgDay.Week > 3))
	UGUIUtil.SetText(self.goLeftTitle3, MonsterAcademyCalendarUIApi:GetString("LeftTitle3", self.currentCfgDay.Week))
	UGUIUtil.SetText(self.goLeftTitle4, MonsterAcademyCalendarUIApi:GetString("LeftTitle4", MonsterAcademyModule.SaveDataDetailPOD.basePOD.dayOfPhase))
	UGUIUtil.SetText(self.goDetailTitle, MonsterAcademyCalendarUIApi:GetString("DetailTitle"))

	for i, v in pairs(self.detailCells) do
		v.View.transform:SetParent(self.UIController.transform, false)
		v.View:SetActive(false)
		self.detailCellPool:Release(v)
	end

	self.detailCells = {}

	local scheduleList = MonsterAcademyModule.GetMonsterAcademyTripRecord(self.currentCfgDay.Month)

	for i = 1, #scheduleList do
		local detailCell = self.detailCellPool:Obtain()

		detailCell.View:SetActive(true)
		detailCell.View.transform:SetParent(self.DetailContent.transform, false)

		local schedulePOD = scheduleList[i]
		local scheduleCfgTime = MonsterAcademyModule.GetCfgGalGameDataByDayNum(schedulePOD.day)
		local timeStr = MonsterAcademyCalendarUIApi:GetString("LeftTitle1", scheduleCfgTime.Year, scheduleCfgTime.Month, scheduleCfgTime.Day)
		local girlNam = CfgGalgameMonsterGirlListTable[schedulePOD.girlId].Name
		local areaStr = CfgGalgameMonsterAreaTable[schedulePOD.areaId].Name
		local functionName = CfgGalgameMonsterSchoolFunctionTable[schedulePOD.functionId].ButtonWord

		detailCell:SetData(timeStr, schedulePOD.dayOfPhase, girlNam, functionName, areaStr, schedulePOD.status)
		table.insert(self.detailCells, detailCell)
	end

	for i, v in pairs(self.dayCells) do
		v.View.transform:SetParent(self.UIController.transform, false)
		v.View:SetActive(false)
		self.dayCellPool:Release(v)
	end

	self.dayCells = {}

	local days = MonsterAcademyModule.GetMonsterAcademyDays(self.currentCfgDay.Year, self.currentCfgDay.Month)

	for i = 1, #days do
		local cfgDay = days[i]
		local dayCell = self.dayCellPool:Obtain()

		dayCell.View:SetActive(true)
		dayCell.View.transform:SetParent(self.DayContent.transform, false)

		local schedulePODTab = self:GetScheduleData(cfgDay.DayNum, scheduleList)

		dayCell:SetData(cfgDay, schedulePODTab)
		dayCell:SetSelect(cfgDay.Day == self.currentCfgDay.Day)
		table.insert(self.dayCells, dayCell)
	end
end

function MonsterAcademyCalendarUI:GetScheduleData(dayNum, scheduleList)
	local tab = {}

	for i, v in pairs(scheduleList) do
		if v.day == dayNum then
			table.insert(tab, v)
		end
	end

	return tab
end

function MonsterAcademyCalendarUI:OnUpdateBaseEvent()
	self:UpdateView()
end

function MonsterAcademyCalendarUI:OnUpdateScheduleEvent()
	self:UpdateView()
end

function MonsterAcademyCalendarUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

return MonsterAcademyCalendarUI
