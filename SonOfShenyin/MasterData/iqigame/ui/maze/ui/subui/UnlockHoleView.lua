-- chunkname: @IQIGame\\UI\\Maze\\UI\\SubUI\\UnlockHoleView.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickConfirmBtn()
		self:OnClickConfirmBtn()
	end

	self.consumeGoldCell = CommonConsumeGold.New(self.Com_ConsumeGold)

	self:AddListeners()
end

function m:AddListeners()
	self.confirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickConfirmBtn)
end

function m:RemoveListeners()
	self.confirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickConfirmBtn)
end

function m:SetData(...)
	local arg = {
		...
	}

	self.SeatId = arg[1]
	self.holeCfg = MazeModule.GetHoleCfgByHoleID(self.SeatId)

	self.consumeGoldCell:InitIconImg(self.holeCfg.Cost[1])
	self.consumeGoldCell:SetData(self.holeCfg.Cost[2])
end

function m:OnClickConfirmBtn()
	MazeModule.UnlockSeat(self.SeatId)
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	self:RemoveListeners()
	self.consumeGoldCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
