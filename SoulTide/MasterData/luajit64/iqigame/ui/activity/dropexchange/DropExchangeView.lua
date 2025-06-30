-- chunkname: @IQIGame\\UI\\Activity\\DropExchange\\DropExchangeView.lua

local m = {}

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

	self.ItemCell = ItemCell.New(self.Item)

	UGUIUtil.SetText(self.goTitle1, ActivityUIApi:GetString("DropExchangeTitle1"))
	UGUIUtil.SetText(self.TextLabel, ActivityUIApi:GetString("DropExchangeTextLabel"))
	UGUIUtil.SetText(self.TextTip, ActivityUIApi:GetString("DropExchangeTextTip"))
	UGUIUtil.SetText(self.BtnShopLabel, ActivityUIApi:GetString("DropExchangeBtnShopLabel"))
	UGUIUtil.SetText(self.goDesc1, ActivityUIApi:GetString("DropExchangeDesc1"))

	function self.delegateUpdateOperations()
		self:OnUpdateOperations()
	end

	function self.delegateBtnShop()
		self:OnBtnShop()
	end
end

function m.GetPreloadAssetPaths()
	return
end

function m:Update(elapseSeconds, realElapseSeconds)
	return
end

function m:AddListener()
	self.BtnShop:GetComponent("Button").onClick:AddListener(self.delegateBtnShop)
	EventDispatcher.AddEventListener(EventID.UpdateOperationsEvent, self.delegateUpdateOperations)
end

function m:RemoveListener()
	self.BtnShop:GetComponent("Button").onClick:RemoveListener(self.delegateBtnShop)
	EventDispatcher.RemoveEventListener(EventID.UpdateOperationsEvent, self.delegateUpdateOperations)
end

function m:OnUpdateOperations()
	self:UpDateView()
end

function m:UpDateView()
	self.TextTip:SetActive(false)

	if ActiveOperationEventModule.CheckIsOpen(self.operateEventID) then
		self.eventPOD = ActiveOperationEventModule.GetActiveOperationData(self.operateEventID)

		if self.eventPOD then
			local cfgGlobal = CfgDropExchangeActivitiesGlobalTable[self.eventPOD.dataCfgId]

			UGUIUtil.SetText(self.goDesc2, cfgGlobal.Desc)

			local startMoth = getMonthText(self.eventPOD.startTime)
			local endMoth = getMonthText(self.eventPOD.endTime)
			local startDay = getOnlyDateText(self.eventPOD.startTime)
			local endDay = getOnlyDateText(self.eventPOD.endTime)
			local startHM = getHourMinuteText(self.eventPOD.startTime)
			local endHM = getHourMinuteText(self.eventPOD.endTime)

			UGUIUtil.SetText(self.TextDay, ActivityUIApi:GetString("DropExchangeTextDay", startMoth, startDay, endMoth, endDay))
			UGUIUtil.SetText(self.TextHours1, startHM)
			UGUIUtil.SetText(self.TextHours2, endHM)
			UGUIUtil.SetText(self.TextCloseTime, ActivityUIApi:GetString("DropExchangeTextCloseTime", getCustomDateTimeText(self.eventPOD.closeTime, "MonthToMinuteFormat")))

			local getNum = ActiveDropExchangeModule.GetDropExchangedCount(self.operateEventID)
			local itemID = cfgGlobal.GetItem[1]
			local maxNum = cfgGlobal.DayLimit

			self.ItemCell:SetItemByCID(itemID, getNum)
			self.TextTip:SetActive(maxNum <= getNum)
			UGUIUtil.SetText(self.TextGetValue, ActivityUIApi:GetString("DropExchangeTextGetValue", getNum, maxNum))
		end
	end
end

function m:OnBtnShop()
	MallModule.OpenActivityMall(Constant.Mall_EntranceType.DropExchange)
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
	self.ItemCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
