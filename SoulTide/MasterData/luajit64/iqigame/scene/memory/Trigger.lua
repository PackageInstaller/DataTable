-- chunkname: @IQIGame\\Scene\\Memory\\Trigger.lua

local Trigger = {
	type2ExecuteDic = {},
	ExecuteType = {
		Transfer = 3,
		Effect = 2,
		TextTip = 1
	},
	TriggerType = {
		EnterArea = 1,
		ClickElement = 2
	}
}
local TransferExecute = require("IQIGame.Scene.Memory.Execute.TransferExecute")
local TipExecute = require("IQIGame.Scene.Memory.Execute.TipExecute")
local EffectExecute = require("IQIGame.Scene.Memory.Execute.EffectExecute")

function Trigger.New(View, element)
	local obj = Clone(Trigger)

	obj:Init(View, element)

	return obj
end

function Trigger:Init(View, element)
	self.View = View
	self.element = element

	LuaCodeInterface.BindOutlet(self.View, self)

	self.collider = self.TriggerArea:GetComponent(typeof(UnityEngine.Collider2D))

	function self.onClickAreaDelegate()
		self:OnClickArea()
	end

	self:OnAddListener()
end

function Trigger:Refresh(cfgEventData)
	self.cfgEventData = cfgEventData
	self.inArea = false
	self.inDistance = false
end

function Trigger:OnDestroy()
	self:OnRemoveListener()

	for i, v in pairs(self.type2ExecuteDic) do
		v:OnDestroy()
	end

	self.type2ExecuteDic = nil

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.element = nil
end

function Trigger:OnAddListener()
	EventTriggerListener.Get(self.TriggerClick).onClick = self.onClickAreaDelegate
end

function Trigger:OnRemoveListener()
	EventTriggerListener.Get(self.TriggerClick).onClick = nil
end

function Trigger:OnClickArea()
	if self.inDistance and self.cfgEventData.TriggerType == self.TriggerType.ClickElement then
		self:TryTrigger()
	end
end

function Trigger:OnEnterArea()
	if self.inArea then
		return
	end

	self.inArea = true

	if self.cfgEventData.TriggerType == self.TriggerType.EnterArea then
		self:TryTrigger()
	end
end

function Trigger:OnExitArea()
	if not self.inArea then
		return
	end

	self.inArea = false
end

function Trigger:OnInDistance(isIn)
	self.inDistance = isIn
end

function Trigger:TryTrigger()
	local canTrigger = true

	for i, v in pairs(self.cfgEventData.FrontEvent) do
		-- block empty
	end

	local type = self.cfgEventData.Type

	if canTrigger then
		local execute = self.type2ExecuteDic[type]

		if execute == nil then
			if type == self.ExecuteType.TextTip then
				execute = TipExecute.New(self.element)
			elseif type == self.ExecuteType.Transfer then
				execute = TransferExecute.New()
			elseif type == self.ExecuteType.Effect then
				execute = EffectExecute.New(self.element)
			end

			self.type2ExecuteDic[type] = execute
		end

		execute:Execute(self.cfgEventData.Parameter)
	end
end

return Trigger
