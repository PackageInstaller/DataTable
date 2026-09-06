local EquipPopTitleCell2 = class("EquipPopTitleCell2", Dialog)
EquipPopTitleCell2.AssetBundleName = "ui/layouts.equip"
EquipPopTitleCell2.AssetName = "EquipPopTitleCell2"

function EquipPopTitleCell2:Ctor(...)
  EquipPopTitleCell2.super.Ctor(self, ...)
end

function EquipPopTitleCell2:OnCreate()
end

function EquipPopTitleCell2:OnDestroy()
end

function EquipPopTitleCell2:RefreshCell(data)
end

return EquipPopTitleCell2
