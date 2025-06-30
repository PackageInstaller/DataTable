-- chunkname: @IQIGame\\UI\\Activity\\PureExhibition\\ActivityPureExhibitionView.lua

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

function m:UpDateView()
	if ActiveOperationEventModule.CheckIsOpen(self.operateEventID) then
		self.eventPOD = ActiveOperationEventModule.GetActiveOperationData(self.operateEventID)

		if self.eventPOD then
			local cfgGlobal = CfgPureExhibitionActivitiesGlobalTable[self.eventPOD.dataCfgId]

			UGUIUtil.SetText(self.goTitle1, cfgGlobal.Name)
			UGUIUtil.SetText(self.goDesc1, ActivityUIApi:GetString("PureExhibitionOpenTime", getCustomDateTimeText(self.eventPOD.startTime, "MonthToMinuteFormat"), getCustomDateTimeText(self.eventPOD.endTime, "MonthToMinuteFormat")))
			UGUIUtil.SetText(self.goDesc2, cfgGlobal.Desc)
			UGUIUtil.SetText(self.goNpc1, cfgGlobal.World1)
			UGUIUtil.SetText(self.goNpc2, cfgGlobal.World2)
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
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
