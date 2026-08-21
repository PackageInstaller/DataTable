-- chunkname: @IQIGame\\Scene\\HorizontalRPG\\Element\\HorizontalRPGMovePlatform.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnEnterTrigger()
		self:OnEnterTrigger()
	end

	function self.DelegateOnExitTrigger()
		self:OnExitTrigger()
	end

	self.TriggerCollider2D = self.Trigger:GetComponent(typeof(UnityEngine.Collider2D))

	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:RefreshWeather(isDay)
	self.Day:SetActive(isDay)
	self.Night:SetActive(not isDay)
end

function m:Dispose()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
