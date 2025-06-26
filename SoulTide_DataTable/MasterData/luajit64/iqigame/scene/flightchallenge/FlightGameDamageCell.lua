-- chunkname: @IQIGame\\Scene\\FlightChallenge\\FlightGameDamageCell.lua

local m = {
	active = false
}

function m.New(view, type)
	local obj = Clone(m)

	obj:Init(view, type)

	return obj
end

function m:Init(view, type)
	self.View = view
	self.type = type

	LuaCodeInterface.BindOutlet(self.View, self)

	self.Animator = self.DamagePrefab:GetComponentInChildren(typeof(UnityEngine.Animator))

	self:AddListener()
	self:Reset()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:Reset()
	self.active = false

	UGUIUtil.SetText(self.DamageTxt, "")
	self.View:SetActive(false)
end

function m:SetData(num)
	self.active = true

	self.View:SetActive(true)
	UGUIUtil.SetText(self.DamageTxt, num)
end

function m:IsFinished()
	return self.Animator:IsInTransition(0)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.Animator = nil
	self.View = nil
end

return m
