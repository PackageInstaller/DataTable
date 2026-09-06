local EquipListTitleCell2 = class("EquipListTitleCell2", Dialog)
EquipListTitleCell2.AssetBundleName = "ui/layouts.equip"
EquipListTitleCell2.AssetName = "EquipListTitleCell2"

function EquipListTitleCell2:Ctor(...)
  EquipListTitleCell2.super.Ctor(self, ...)
end

function EquipListTitleCell2:OnCreate()
end

function EquipListTitleCell2:OnDestroy()
end

function EquipListTitleCell2:RefreshCell(data)
end

return EquipListTitleCell2
