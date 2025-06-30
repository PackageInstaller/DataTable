-- chunkname: @IQIGame\\UI\\BattleMonsterInfo\\BattleMonsterInfoWeakCell.lua

local m = {
	WeakType = 0
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function m:SetData(weakType)
	self.WeakType = weakType

	self.View:SetActive(weakType ~= nil)

	if weakType ~= nil then
		AssetUtil.LoadImage(self, BattleUIApi:GetString("EnergyShieldImage", weakType), self.View:GetComponentInChildren(typeof(UnityEngine.UI.Image)))
	end
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
