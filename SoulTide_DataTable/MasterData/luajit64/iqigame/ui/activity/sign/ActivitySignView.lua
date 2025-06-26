-- chunkname: @IQIGame\\UI\\Activity\\Sign\\ActivitySignView.lua

local ActivitySignView = {
	cellPool = {}
}
local SignCell = require("IQIGame.UI.Activity.Sign.SignCell")

function ActivitySignView.New(view, eventID)
	local obj = Clone(ActivitySignView)

	obj:Init(view, eventID)

	return obj
end

function ActivitySignView:Init(view, eventID)
	self.View = view
	self.eventID = eventID

	LuaCodeInterface.BindOutlet(self.View, self)

	self.btnDetail = self.goBtnDetail:GetComponent("Button")

	function self.onClickBtnDetailDelegate()
		self:OnClickBtnDetail()
	end

	self.goBtnDetail.transform:Find("Text_01"):GetComponent("Text").text = ActivityUIApi:GetString("signViewBtnDetailTxt")
end

function ActivitySignView:Open()
	self.View:SetActive(true)
	self:OnAddListener()
	self:RefreshCells()
	self:RefreshMisc()
end

function ActivitySignView:Close()
	self:OnHide()
	self.View:SetActive(false)
end

function ActivitySignView:OnHide()
	for i, v in pairs(self.cellPool) do
		v:OnHide()
	end

	self:OnRemoveListener()
end

function ActivitySignView:OnDestroy()
	for i, v in pairs(self.cellPool) do
		v:OnDestroy()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function ActivitySignView:OnAddListener()
	self:OnRemoveListener()
	self.btnDetail.onClick:AddListener(self.onClickBtnDetailDelegate)
end

function ActivitySignView:OnRemoveListener()
	self.btnDetail.onClick:RemoveListener(self.onClickBtnDetailDelegate)
end

function ActivitySignView:OnTaskUpdate(taskID)
	self:RefreshCells(taskID)
end

function ActivitySignView:OnClickBtnDetail()
	local operationEventDataPOD = ActiveOperationEventModule.GetEventDataPOD(self.eventID)

	UIModule.Open(Constant.UIControllerName.DailyActivityTipsUI, Constant.UILayer.UI, CfgEventSignInGlobalTable[operationEventDataPOD.dataCfgId].Desc)
end

function ActivitySignView:RefreshMisc()
	self.eventPOD = ActiveOperationEventModule.GetActiveOperationData(self.eventID)

	UGUIUtil.SetText(self.goTime, ActivityUIApi:GetString("signViewTime", getCustomDateTimeText(self.eventPOD.endTime, "MonthToMinuteFormat")))
end

function ActivitySignView:RefreshCells(taskID)
	local taskDatum = ActivitySignModule.GetTaskDatum()
	local parentPos

	for i, v in ipairs(taskDatum) do
		local cell = self.cellPool[i]

		if cell == nil then
			if i == 1 then
				cell = SignCell.New(self.goCell)
				self.cellPool[i] = cell
			else
				local go = UnityEngine.Object.Instantiate(self.goCell)

				cell = SignCell.New(go)
				self.cellPool[i] = cell
			end

			if self["nodePos" .. i] then
				parentPos = self["nodePos" .. i].transform
			else
				parentPos = self.goCell.transform.parent
			end

			cell:SetParent(parentPos)
		end

		cell:Refresh(i, v)

		if taskID == v.cid and v.TaskStatus == TaskModule.TaskStatus.FINISH_TASK then
			cell:PlayGetRewardEffect()
		end
	end
end

return ActivitySignView
