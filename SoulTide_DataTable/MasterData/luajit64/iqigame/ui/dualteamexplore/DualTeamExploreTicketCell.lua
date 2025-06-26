-- chunkname: @IQIGame\\UI\\DualTeamExplore\\DualTeamExploreTicketCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnUpdateTicket()
		self:OnUpdateTicket()
	end

	function self.DelegateOnUpdateDailyDupEvent()
		self:OnUpdateDailyDupEvent()
	end

	function self.DelegateOnClickTipBtn()
		self:OnClickTipBtn()
	end

	function self.DelegateOnUpdateTicketEvent()
		self:OnUpdateDualTeamExploreEvent()
	end

	self:AddListeners()
end

function m:AddListeners()
	self.TipBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickTipBtn)
	EventDispatcher.AddEventListener(EventID.RpgMazeUpdateTicket, self.DelegateOnUpdateTicket)
	EventDispatcher.AddEventListener(EventID.UpdateDailyDupEvent, self.DelegateOnUpdateDailyDupEvent)
	EventDispatcher.AddEventListener(EventID.DualTeamExploreUpdateTicket, self.DelegateOnUpdateTicketEvent)
end

function m:RemoveListeners()
	self.TipBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickTipBtn)
	EventDispatcher.RemoveEventListener(EventID.RpgMazeUpdateTicket, self.DelegateOnUpdateTicket)
	EventDispatcher.RemoveEventListener(EventID.UpdateDailyDupEvent, self.DelegateOnUpdateDailyDupEvent)
	EventDispatcher.RemoveEventListener(EventID.DualTeamExploreUpdateTicket, self.DelegateOnUpdateTicketEvent)
end

function m:Refresh()
	if not DualTeamExploreModule.IsShow() then
		return
	end

	AssetUtil.LoadImage(self, DualTeamExploreUICommonApi:GetString("TicketIcon", DualTeamExploreModule.DailyDupPOD.common.openCount), self.Icon:GetComponent("Image"))
	UGUIUtil.SetText(self.ValueText, DualTeamExploreModule.DailyDupPOD.dualTeamExplorePOD.tickets)
end

function m:OnUpdateTicket()
	self:Refresh()
end

function m:OnUpdateDailyDupEvent()
	self:Refresh()
end

function m:OnUpdateDualTeamExploreEvent()
	self:Refresh()
end

function m:OnClickTipBtn()
	UIModule.Open(Constant.UIControllerName.TextFollowingTipUI, Constant.UILayer.UI, {
		title = DualTeamExploreUICommonApi:GetString("TicketTitle", DualTeamExploreModule.DailyDupPOD.common.openCount),
		content = DualTeamExploreUICommonApi:GetString("TicketDesc", DualTeamExploreModule.DailyDupPOD.common.openCount),
		refTrans = self.View.transform
	})
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
