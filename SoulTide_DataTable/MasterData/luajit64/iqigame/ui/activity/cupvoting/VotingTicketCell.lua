-- chunkname: @IQIGame\\UI\\Activity\\CupVoting\\VotingTicketCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	UGUIUtil.SetText(self.TipText, ActivityUIApi:GetString("CupVotingTipText"))

	function self.DelegateUpdateOperationsEvent()
		self:OnUpdateOperationsEvent()
	end

	function self.DelegateOnClickTipBtn()
		self:OnTipBtn()
	end

	self:AddListener()
end

function m:AddListener()
	self.TipBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickTipBtn)
	EventDispatcher.AddEventListener(EventID.UpdateOperationsEvent, self.DelegateUpdateOperationsEvent)
end

function m:RemoveListener()
	self.TipBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickTipBtn)
	EventDispatcher.RemoveEventListener(EventID.UpdateOperationsEvent, self.DelegateUpdateOperationsEvent)
end

function m:OnUpdateOperationsEvent()
	self:RefreshNum()
end

function m:RefreshData(operateEventID)
	self.operateEventID = operateEventID
	self.cfgData = ActiveCupVotingModule.GetCfgGlobalData(self.operateEventID)

	local path = UIGlobalApi.GetIconPath(self.cfgData.Icon)

	AssetUtil.LoadImage(self, path, self.Icon:GetComponent("Image"))
	self:RefreshNum()
end

function m:RefreshNum()
	UGUIUtil.SetText(self.ValueText, ActiveCupVotingModule.GetCupVotingTickets(self.operateEventID))
end

function m:OnTipBtn()
	if self.cfgData == nil then
		return
	end

	UIModule.Open(Constant.UIControllerName.TextFollowingTipUI, Constant.UILayer.UI, {
		title = self.cfgData.TicketName,
		content = self.cfgData.TicketDes,
		refTrans = self.View.transform
	})
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
