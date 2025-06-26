-- chunkname: @IQIGame\\UI\\BattleWeakShieldTips\\BattleWeakShieldTipItem.lua

local m = {}

function m.New(view, elementType)
	local obj = Clone(m)

	obj:Init(view, elementType)

	return obj
end

function m:Init(view, elementType)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	self.Icon:SetActive(false)
	AssetUtil.LoadImage(self, BattleUIApi:GetString("EnergyShieldImage", elementType), self.Icon:GetComponent("Image"), self.OnSuccess, nil, self.Icon)
	UGUIUtil.SetText(self.DescText, BattleUIApi:GetString("EnergyShieldDescText", elementType))
	self:AddListeners()
end

function m:OnSuccess(assetName, asset, duration, userData)
	userData:SetActive(true)
end

function m:AddListeners()
	return
end

function m:RemoveListeners()
	return
end

function m:SetEnabled(value)
	self.View:SetActive(value)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
