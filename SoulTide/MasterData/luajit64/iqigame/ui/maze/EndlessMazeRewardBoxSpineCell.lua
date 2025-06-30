-- chunkname: @IQIGame\\UI\\Maze\\EndlessMazeRewardBoxSpineCell.lua

local m = {
	ClosedEffectId = 0,
	STATE_OPENING = 1,
	STATE_OPENED = 2,
	EFFECT_OPENED = 3,
	OpenedEffectId = 0,
	Num = 0,
	EFFECT_OPENING = 2,
	State = 0,
	OpeningEffectId = 0,
	EFFECT_CLOSED = 1,
	STATE_CLOSED = 0
}

function m.New(view, onClickCallback)
	local obj = Clone(m)

	obj:Init(view, onClickCallback)

	return obj
end

function m:Init(view, onClickCallback)
	self.View = view
	self.OnClickCallback = onClickCallback

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClick()
		self:OnClick()
	end

	function self.DelegateOnEffectShow(sender, args)
		self:OnEffectShow(sender, args)
	end

	self:AddEventListeners()
end

function m:AddEventListeners()
	self.View:GetComponent("Button").onClick:AddListener(self.DelegateOnClick)
	GameEntry.LuaEvent:Subscribe(EffectShowEventArgs.EventId, self.DelegateOnEffectShow)
end

function m:RemoveEventListeners()
	self.View:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClick)
	GameEntry.LuaEvent:Unsubscribe(EffectShowEventArgs.EventId, self.DelegateOnEffectShow)
end

function m:SetData(type, num, items)
	self.State = m.STATE_CLOSED
	self.Num = num

	self.View:SetActive(num ~= 0)

	if num == 0 then
		return
	end

	local boxEffects = EndlessMazeSettlementUIApi:GetString("BoxEffects")

	self.Effects = boxEffects[type]
	self.Items = items
	self.ClosedEffectId = GameEntry.Effect:PlayUIMountPointEffect(self.Effects[m.EFFECT_CLOSED], 50000, 0, self.SpineNode, 0)

	UGUIUtil.SetText(self.NumText, EndlessMazeSettlementUIApi:GetString("BoxNumText", num))
end

function m:Clear()
	if self.ClosedEffectId ~= 0 then
		GameEntry.Effect:StopEffect(self.ClosedEffectId)

		self.ClosedEffectId = 0
	elseif self.OpeningEffectId ~= 0 then
		GameEntry.Effect:StopEffect(self.OpeningEffectId)

		self.OpeningEffectId = 0
	elseif self.OpenedEffectId ~= 0 then
		GameEntry.Effect:StopEffect(self.OpenedEffectId)

		self.OpenedEffectId = 0
	end
end

function m:OnClick()
	if self.OnClickCallback ~= nil then
		self.OnClickCallback(self)
	end
end

function m:OpenBox()
	if self.Num == 0 then
		return
	end

	self.State = m.STATE_OPENING
	self.OpeningEffectId = GameEntry.Effect:PlayUIMountPointEffect(self.Effects[m.EFFECT_OPENING], 50000, 0, self.SpineNode, 0)

	if self.OpenBoxDelayTimer ~= nil then
		self.OpenBoxDelayTimer:Stop()
	end

	self.OpenBoxDelayTimer = Timer.New(function()
		self.OpenBoxDelayTimer = nil
		self.OpenedEffectId = GameEntry.Effect:PlayUIMountPointEffect(self.Effects[m.EFFECT_OPENED], 50000, 0, self.SpineNode, 0)
		self.State = m.STATE_OPENED
	end, 0.5)

	self.OpenBoxDelayTimer:Start()
end

function m:OnEffectShow(sender, args)
	if args.EffectPlayID == self.OpeningEffectId then
		GameEntry.Effect:StopEffect(self.ClosedEffectId)

		self.ClosedEffectId = 0
	elseif args.EffectPlayID == self.OpenedEffectId then
		GameEntry.Effect:StopEffect(self.OpeningEffectId)

		self.OpeningEffectId = 0
	end
end

function m:Dispose()
	if self.OpenBoxDelayTimer ~= nil then
		self.OpenBoxDelayTimer:Stop()
	end

	self:RemoveEventListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
