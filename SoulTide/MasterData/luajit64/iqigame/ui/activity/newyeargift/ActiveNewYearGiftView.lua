-- chunkname: @IQIGame\\UI\\Activity\\NewYearGift\\ActiveNewYearGiftView.lua

local m = {
	newYearGiftTab = {},
	newYearGiftCellPool = {}
}
local NewYearGiftCell = require("IQIGame.UI.Activity.NewYearGift.NewYearGiftCell")

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

	self.scrollList = self.ScrollArea:GetComponent("ScrollAreaList")

	function self.scrollList.onRenderCell(cell)
		self:OnRenderCell(cell)
	end

	function self.delegateUpdateOperations()
		self:OnUpdateOperations()
	end
end

function m.GetPreloadAssetPaths()
	return
end

function m:Update(elapseSeconds, realElapseSeconds)
	return
end

function m:AddListener()
	EventDispatcher.AddEventListener(EventID.UpdateOperationsEvent, self.delegateUpdateOperations)
end

function m:RemoveListener()
	EventDispatcher.RemoveEventListener(EventID.UpdateOperationsEvent, self.delegateUpdateOperations)
end

function m:OnUpdateOperations()
	self:UpDateView()
end

function m:OnRenderCell(cell)
	local data = self.newYearGiftTab[cell.index + 1]
	local insID = cell.gameObject:GetInstanceID()
	local giftCell = self.newYearGiftCellPool[insID]

	if giftCell == nil then
		giftCell = NewYearGiftCell.New(cell.gameObject, self.root)
		self.newYearGiftCellPool[insID] = giftCell
	end

	giftCell:SetData(data, self.operateEventID)
end

function m:UpDateView()
	if ActiveOperationEventModule.CheckIsOpen(self.operateEventID) then
		self.eventPOD = ActiveOperationEventModule.GetActiveOperationData(self.operateEventID)

		if self.eventPOD then
			local cfgNewYearGiftGlobal = CfgTreasureHuntGlobalTable[self.eventPOD.dataCfgId]

			UGUIUtil.SetText(self.TextDes, cfgNewYearGiftGlobal.Desc)
			UGUIUtil.SetText(self.TextOpenTime, ActivityUIApi:GetString("NewYearTextOpenTime", getCustomDateTimeText(self.eventPOD.startTime, "MonthToMinuteFormat"), getCustomDateTimeText(self.eventPOD.endTime, "MonthToMinuteFormat")))

			self.newYearGiftTab = {}

			for i, v in pairsCfg(CfgTreasureHuntGiftListTable) do
				if v.Team == cfgNewYearGiftGlobal.Id then
					table.insert(self.newYearGiftTab, v)
				end
			end

			table.sort(self.newYearGiftTab, function(a, b)
				return a.Id < b.Id
			end)
			self.scrollList:Refresh(#self.newYearGiftTab)
		end
	end
end

function m:Open()
	self:AddListener()
	self.View:SetActive(true)
	self:UpDateView()
end

function m:Close()
	self.View:SetActive(false)
	self:OnHide()
end

function m:OnHide()
	self:RemoveListener()
end

function m:OnDestroy()
	for i, v in pairs(self.newYearGiftCellPool) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
