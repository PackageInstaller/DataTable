-- chunkname: @IQIGame\\UI\\Battle\\BattleEnergyShieldBarDot.lua

local m = {
	ElementType = 0,
	MatchEffectPlayId = 0
}

function m.New(view, elementType, battleUI)
	local obj = Clone(m)

	obj:Init(view, elementType, battleUI)

	return obj
end

function m:Init(view, elementType, battleUI)
	self.View = view
	self.ElementType = elementType
	self.BattleUI = battleUI

	LuaCodeInterface.BindOutlet(self.View, self)
	self.Icon:SetActive(false)
	AssetUtil.LoadImage(self, BattleUIApi:GetString("EnergyShieldImage", elementType), self.Icon:GetComponent("Image"), self.OnSuccess, nil, self.Icon)
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

function m:PlayEffect(elementTypes, isSelectingAndSelectable, layer, sortingOrder)
	local isWeak = table.indexOf(elementTypes, self.ElementType) ~= -1

	self.NotMatchView:SetActive(isSelectingAndSelectable and not isWeak)

	if isSelectingAndSelectable and isWeak then
		if self.MatchEffectPlayId == 0 then
			self.MatchEffectPlayId = BattleModule.CSBattleModule.PlayMountPointEffect(BattleUIApi:GetString("EnergyShieldMatchEffect", self.ElementType), 50000, 0, self.View, 0, 0, layer, 0, sortingOrder)
		end
	else
		self:StopEffect()
	end
end

function m:StopEffect()
	if self.MatchEffectPlayId ~= 0 then
		GameEntry.Effect:StopEffect(self.MatchEffectPlayId)

		self.MatchEffectPlayId = 0
	end
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListeners()
	self:StopEffect()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.BattleUI = nil
end

return m
