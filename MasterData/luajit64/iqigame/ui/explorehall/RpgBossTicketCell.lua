-- chunkname: @IQIGame\\UI\\ExploreHall\\RpgBossTicketCell.lua

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

	function self.DelegateBtnTip()
		self:OnBtnTip()
	end

	self:AddListeners()
end

function m:AddListeners()
	EventDispatcher.AddEventListener(EventID.RpgMazeUpdateTicket, self.DelegateOnUpdateTicket)
	EventDispatcher.AddEventListener(EventID.UpdateDailyDupEvent, self.DelegateOnUpdateDailyDupEvent)
	self.TipBtn:GetComponent("Button").onClick:AddListener(self.DelegateBtnTip)
end

function m:RemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.RpgMazeUpdateTicket, self.DelegateOnUpdateTicket)
	EventDispatcher.RemoveEventListener(EventID.UpdateDailyDupEvent, self.DelegateOnUpdateDailyDupEvent)
	self.TipBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnTip)
end

function m:Refresh()
	if not RpgMazeModule.IsShow() then
		return
	end

	UGUIUtil.SetText(self.ValueText, RpgMazeModule.DailyDupPOD.rpgMazePOD.tickets)
	AssetUtil.LoadImage(self, MazeBossChallengeEntryUIApi:GetString("RpgBossCurrencyIcon", RpgMazeModule.DailyDupPOD.common.openCount), self.Icon:GetComponent("Image"))
end

function m:OnUpdateTicket()
	self:Refresh()
end

function m:OnUpdateDailyDupEvent()
	self:Refresh()
end

function m:OnBtnTip()
	UIModule.Open(Constant.UIControllerName.TextFollowingTipUI, Constant.UILayer.UI, {
		title = MazeBossChallengeEntryUIApi:GetString("RpgBossTicketTitle", RpgMazeModule.DailyDupPOD.common.openCount),
		content = MazeBossChallengeEntryUIApi:GetString("RpgBossTicketDes", RpgMazeModule.DailyDupPOD.common.openCount),
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
