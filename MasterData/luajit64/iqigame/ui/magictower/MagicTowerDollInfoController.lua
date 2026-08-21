-- chunkname: @IQIGame\\UI\\MagicTower\\MagicTowerDollInfoController.lua

local IconValueTextItem = require("IQIGame.UI.Common.IconValueTextItem")
local LabelValueTextItem = require("IQIGame.UI.Common.LabelValueTextItem")
local m = {
	EntityId = 0,
	KeyItems = {}
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnMagicTowerUpdateRoleData()
		self:OnMagicTowerUpdateRoleData()
	end

	self.HpItem = LabelValueTextItem.New(self.HpView)
	self.AtkItem = LabelValueTextItem.New(self.AtkView)
	self.DefItem = LabelValueTextItem.New(self.DefView)
	self.WeaponItem = IconValueTextItem.New(self.WeaponView)
	self.ArmorItem = IconValueTextItem.New(self.ArmorView)

	for i = 1, 3 do
		self.KeyItems[i] = IconValueTextItem.New(self["KeyView" .. i])
	end

	self:AddListeners()
end

function m:AddListeners()
	EventDispatcher.AddEventListener(EventID.MagicTowerUpdateRoleData, self.DelegateOnMagicTowerUpdateRoleData)
end

function m:RemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.MagicTowerUpdateRoleData, self.DelegateOnMagicTowerUpdateRoleData)
end

function m:OnOpen(userData)
	self:Refresh()
end

function m:Refresh()
	local hp, atk, def = self:GetAttrs()

	self.HpItem:SetData(MagicTowerMainUIApi:GetString("HpLabel"), hp)
	self.AtkItem:SetData(MagicTowerMainUIApi:GetString("AtkLabel"), atk)
	self.DefItem:SetData(MagicTowerMainUIApi:GetString("DefLabel"), def)

	local weaponCfgData, armorCfgData = self:GetWeaponArmor()

	self.WeaponItem:SetData(self:GetEquipIcon(weaponCfgData), self:GetEquipName(weaponCfgData, 1))
	self.ArmorItem:SetData(self:GetEquipIcon(armorCfgData), self:GetEquipName(armorCfgData, 2))

	for i = 1, #self.KeyItems do
		local keyItem = self.KeyItems[i]
		local cfgItemData = CfgItemTable[MagicTowerModule.GetKeyItemId(i)]

		keyItem:SetData(UIGlobalApi.GetIconPath(cfgItemData.Icon), MagicTowerModule.MapData.mapPOD.role["key" .. i])
	end

	self:HideEntity()

	self.EntityId = GameEntry.Entity:GenerateEntityID()

	GameEntry.Entity:ShowUIElement(self.EntityId, 840000, 0, self.SpineRoot.transform, Vector3.zero)
end

function m:GetAttrs()
	local role = MagicTowerModule.MapData.mapPOD.role
	local hp = role.hp
	local atk = role.atk
	local def = role.def

	for i = 1, #role.equipments do
		local equipCid = role.equipments[i]
		local cfgMagicTowerEquipData = CfgMagicTowerEquipTable[equipCid]

		atk = atk + cfgMagicTowerEquipData.Atk
		def = def + cfgMagicTowerEquipData.Def
	end

	return hp, atk, def
end

function m:GetWeaponArmor()
	local role = MagicTowerModule.MapData.mapPOD.role
	local weaponCfgData, armorCfgData

	for i = 1, #role.equipments do
		local equipCid = role.equipments[i]
		local cfgMagicTowerEquipData = CfgMagicTowerEquipTable[equipCid]

		if cfgMagicTowerEquipData.EquipType == 1 then
			weaponCfgData = cfgMagicTowerEquipData
		elseif cfgMagicTowerEquipData.EquipType == 2 then
			armorCfgData = cfgMagicTowerEquipData
		end
	end

	return weaponCfgData, armorCfgData
end

function m:GetEquipIcon(equipCfgData)
	if equipCfgData == nil then
		return MagicTowerMainUIApi:GetString("DefaultItemIcon")
	end

	local cfgItemData = CfgItemTable[equipCfgData.ItemID]

	return UIGlobalApi.GetIconPath(cfgItemData.Icon)
end

function m:GetEquipName(equipCfgData, equipType)
	local cfgItemData

	if equipCfgData ~= nil then
		cfgItemData = CfgItemTable[equipCfgData.ItemID]
	end

	return MagicTowerMainUIApi:GetString("EquipName", cfgItemData ~= nil and cfgItemData.Name or nil, equipType)
end

function m:OnMagicTowerUpdateRoleData()
	self:Refresh()
end

function m:HideEntity()
	if self.EntityId ~= 0 then
		GameEntry.Entity:HideEntity(self.EntityId)

		self.EntityId = 0
	end
end

function m:Dispose()
	self:RemoveListeners()
	self:HideEntity()
	self.HpItem:Dispose()
	self.AtkItem:Dispose()
	self.DefItem:Dispose()
	self.WeaponItem:Dispose()
	self.ArmorItem:Dispose()

	for i = 1, #self.KeyItems do
		local keyItem = self.KeyItems[i]

		keyItem:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
