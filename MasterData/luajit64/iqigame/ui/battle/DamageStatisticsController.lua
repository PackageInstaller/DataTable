-- chunkname: @IQIGame\\UI\\Battle\\DamageStatisticsController.lua

local m = {
	TotalDamageValue = 0,
	IsPlaying = false
}
local RollingNumber = require("IQIGame.UI.Common.RollingNumber")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(view, self)

	self.AddValueQueue = Queue.New()

	local numImages = {}

	for i = 1, self.TotalDamage.transform.childCount do
		numImages[i] = self.TotalDamage.transform:Find("Num_" .. i).gameObject
	end

	self.TotalDamageController = RollingNumber.New(numImages, true, true)
	self.UITweeners = self.TurnDamageView:GetComponents(typeof(UITweener))

	self.TurnDamageView:SetActive(false)
	UGUIUtil.SetText(self.TotalDamageLabelText, BattleUIApi:GetString("TotalDamageLabelText"))
end

function m:AddDamage(value)
	if value == 0 then
		return
	end

	self.AddValueQueue:Enqueue(value)
	self:PlayNextAddDamageAnimation()
end

function m:PlayNextAddDamageAnimation()
	if self.AddValueQueue.Size == 0 then
		return
	end

	if self.IsPlaying then
		return
	end

	self.IsPlaying = true

	local value = self.AddValueQueue:Dequeue()

	for i = 0, self.UITweeners.Length - 1 do
		local uiTweener = self.UITweeners[i]

		uiTweener:ResetToBeginning()

		uiTweener.enabled = true
	end

	self.TurnDamage:GetComponent("Text").text = "+" .. value

	self.TurnDamageView:SetActive(true)

	self.Timer = Timer.New(function()
		self.TotalDamageValue = self.TotalDamageValue + value

		self.TotalDamageController:RollTo(self.TotalDamageValue)

		self.Timer = nil
		self.IsPlaying = false

		self:PlayNextAddDamageAnimation()
	end, 0.5)

	self.Timer:Start()
end

function m:Update(elapseSeconds, realElapseSeconds)
	self.TotalDamageController:Update(elapseSeconds, realElapseSeconds)
end

function m:Clear()
	self.TotalDamageValue = 0

	if self.Timer ~= nil then
		self.Timer:Stop()

		self.Timer = nil
	end

	self.TotalDamageController:SetNumber(0)
end

function m:Dispose()
	self:Clear()
	self.TotalDamageController:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
