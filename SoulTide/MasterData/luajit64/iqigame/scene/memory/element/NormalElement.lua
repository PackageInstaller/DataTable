-- chunkname: @IQIGame\\Scene\\Memory\\Element\\NormalElement.lua

local NormalElement = {}
local Trigger = require("IQIGame.Scene.Memory.Trigger")

function NormalElement.New(view, scene)
	local obj = Clone(NormalElement)

	obj:Init(view, scene)

	return obj
end

function NormalElement:Init(view, scene)
	self.View = view
	self.scene = scene

	LuaCodeInterface.BindOutlet(self.View, self)

	if self.goTip ~= nil then
		self.goTip.transform.parent.gameObject:SetActive(false)
	end

	self.collider = self.View:GetComponent(typeof(UnityEngine.Collider2D))
	self.trigger = Trigger.New(self.goTrigger, self)
end

function NormalElement:Refresh(cfgEventData)
	self.cfgEventData = cfgEventData

	self.trigger:Refresh(self.cfgEventData)
end

function NormalElement:OnDestroy()
	if self.trigger ~= nil then
		self.trigger:OnDestroy()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.scene = nil
end

return NormalElement
