-- chunkname: @IQIGame\\UI\\MagicTower\\MagicTowerMonsterInfoCell.lua

local LabelValueTextItem = require("IQIGame.UI.Common.LabelValueTextItem")
local m = {
	EntityId = 0
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.HpItem = LabelValueTextItem.New(self.HpView)
	self.AtkItem = LabelValueTextItem.New(self.AtkView)
	self.DefItem = LabelValueTextItem.New(self.DefView)
end

function m:SetData(cfgMagicTowerMonsterData)
	self:HideEntity()

	if cfgMagicTowerMonsterData == nil then
		return
	end

	self.HpItem:SetData(MagicTowerMainUIApi:GetString("HpLabel"), cfgMagicTowerMonsterData.HP)
	self.AtkItem:SetData(MagicTowerMainUIApi:GetString("AtkLabel"), cfgMagicTowerMonsterData.Atk)
	self.DefItem:SetData(MagicTowerMainUIApi:GetString("DefLabel"), cfgMagicTowerMonsterData.Def)

	self.EntityId = GameEntry.Entity:GenerateEntityID()

	GameEntry.Entity:ShowUIElement(self.EntityId, cfgMagicTowerMonsterData.EntityId, 0, self.SpineRoot.transform, Vector3.zero)
end

function m:HideEntity()
	if self.EntityId ~= 0 then
		GameEntry.Entity:HideEntity(self.EntityId)

		self.EntityId = 0
	end
end

function m:Dispose()
	self:HideEntity()
	self.HpItem:Dispose()
	self.AtkItem:Dispose()
	self.DefItem:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
