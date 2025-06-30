-- chunkname: @IQIGame\\UI\\Activity\\GroupBuy\\ActiveGroupBuyView.lua

local m = {
	groupBuyRenderPool = {},
	returnRewardCellPool = {},
	returnRewardCells = {}
}
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local ActiveGroupBuyRenderCell = require("IQIGame.UI.Activity.GroupBuy.ActiveGroupBuyRenderCell")
local ReturnRewardCell = require("IQIGame.UI.Activity.GroupBuy.ReturnRewardCell")

function m.New(view, root, groupBuyID)
	local obj = Clone(m)

	obj:Init(view, root, groupBuyID)

	return obj
end

function m:Init(view, root, groupBuyID)
	self.View = view
	self.root = root
	self.groupBuyID = groupBuyID

	LuaCodeInterface.BindOutlet(self.View, self)
	self.ReturnMould:SetActive(false)
	UGUIUtil.SetText(self.TextReturn, ActivityUIApi:GetString("TextReturn"))

	self.scrollList = self.ScrollArea:GetComponent("ScrollAreaList")

	function self.scrollList.onRenderCell(cell)
		self:OnRenderGridCell(cell)
	end

	self.returnRewardCellPool = UIObjectPool.New(2, function()
		return ReturnRewardCell.New(UnityEngine.Object.Instantiate(self.ReturnMould))
	end, function(cell)
		cell:Dispose()
	end)

	function self.delegateBtnTip()
		self:OnBtnTip()
	end

	function self.delegateUpdateOperations()
		self:UpDateView()
	end

	self.timer = Timer.New(function()
		self:ShowCD()
	end, 1, -1)
end

function m.GetPreloadAssetPaths()
	return
end

function m:Update(elapseSeconds, realElapseSeconds)
	return
end

function m:AddListener()
	self.BtnTips:GetComponent("Button").onClick:AddListener(self.delegateBtnTip)
	EventDispatcher.AddEventListener(EventID.UpdateOperationsEvent, self.delegateUpdateOperations)
end

function m:RemoveListener()
	self.BtnTips:GetComponent("Button").onClick:RemoveListener(self.delegateBtnTip)
	EventDispatcher.RemoveEventListener(EventID.UpdateOperationsEvent, self.delegateUpdateOperations)
end

function m:UpDateView()
	if not ActiveOperationEventModule.CheckIsOpen(self.groupBuyID) then
		return false
	end

	self.eventPOD = ActiveOperationEventModule.GetActiveOperationData(self.groupBuyID)

	if self.eventPOD then
		self.cfgGroupBuyGlobal = CfgGroupBuyGlobalTable[self.eventPOD.dataCfgId]

		self.scrollList:Refresh(#self.cfgGroupBuyGlobal.Items)

		for i, v in pairs(self.returnRewardCells) do
			v.View.transform:SetParent(self.root.UIController.transform, false)
			v.View:SetActive(false)
			self.returnRewardCellPool:Release(v)
		end

		self.returnRewardCells = {}

		local isShow = false
		local tab = ActiveGroupBuyModule.GetTotalRebate(self.groupBuyID)

		for k, v in pairs(tab) do
			if v > 0 then
				local cell = self.returnRewardCellPool:Obtain()

				cell.View:SetActive(true)
				cell.View.transform:SetParent(self.ReturnBox.transform, false)
				cell:SetData(k, v)
				table.insert(self.returnRewardCells, cell)

				isShow = true
			end
		end

		self.timer:Stop()

		if self.eventPOD.status == Constant.Activity_Operation_Sate.STATUS_STARTED or self.eventPOD.status == Constant.Activity_Operation_Sate.STATUS_END then
			self:ShowCD()
			self.timer:Start()
		else
			UGUIUtil.SetText(self.TextTimeTitle, ActivityUIApi:GetString("TextTimeTitle", getCustomDateTimeText(self.eventPOD.startTime, "MonthToMinuteFormat"), getCustomDateTimeText(self.eventPOD.endTime, "MonthToMinuteFormat")))
		end

		self.ImgBG:SetActive(isShow)
		self.TextReturn:SetActive(isShow)
		self.ReturnBox:SetActive(isShow)
	end
end

function m:ShowCD()
	if self.eventPOD then
		if PlayerModule.GetServerTime() > self.eventPOD.endTime and PlayerModule.GetServerTime() < self.eventPOD.closeTime then
			local cd = self.eventPOD.closeTime - PlayerModule.GetServerTime()

			if cd >= 0 then
				UGUIUtil.SetText(self.TextTimeTitle, ActivityUIApi:GetString("TextTimeClose", GetFormatTime(cd)))
			end
		else
			UGUIUtil.SetText(self.TextTimeTitle, ActivityUIApi:GetString("TextTimeTitle", getCustomDateTimeText(self.eventPOD.startTime, "MonthToMinuteFormat"), getCustomDateTimeText(self.eventPOD.endTime, "MonthToMinuteFormat")))
		end
	end
end

function m:OnRenderGridCell(cell)
	local data = self.cfgGroupBuyGlobal.Items[cell.index + 1]

	if data == nil then
		cell.gameObject:SetActive(false)

		return
	end

	cell.gameObject:SetActive(true)

	local instanceID = cell.gameObject:GetInstanceID()
	local renderCell = self.groupBuyRenderPool[instanceID]

	if renderCell == nil then
		renderCell = ActiveGroupBuyRenderCell.New(cell.gameObject, self.root)
		self.groupBuyRenderPool[instanceID] = renderCell
	end

	renderCell:SetData(data, self.groupBuyID)
end

function m:OnBtnTip()
	UIModule.Open(Constant.UIControllerName.DailyActivityTipsUI, Constant.UILayer.UI, self.cfgGroupBuyGlobal.Desc)
end

function m:Open()
	self:AddListener()
	ActiveGroupBuyModule.GetGroupPurchaseCommonData(self.groupBuyID)
	self.View:SetActive(true)
	self:UpDateView()
end

function m:Close()
	self.View:SetActive(false)
	self:OnHide()
end

function m:OnHide()
	if self.timer then
		self.timer:Stop()
	end

	self:RemoveListener()
end

function m:OnDestroy()
	self.timer = nil

	for i, v in pairs(self.groupBuyRenderPool) do
		v:Dispose()
	end

	for i, v in pairs(self.returnRewardCells) do
		self.returnRewardCellPool:Release(v)
	end

	self.returnRewardCells = {}

	self.returnRewardCellPool:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
