local EquipBagJobCell = class("EquipBagJobCell", Dialog)
EquipBagJobCell.AssetBundleName = "ui/layouts.equip"
EquipBagJobCell.AssetName = "EquipListJobCell"

function EquipBagJobCell:Ctor(...)
  EquipBagJobCell.super.Ctor(self, ...)
end

function EquipBagJobCell:OnCreate()
  self._jobName = self:GetChild("JobName")
end

function EquipBagJobCell:OnDestroy()
end

function EquipBagJobCell:RefreshCell(str)
  self._jobName:SetText(str)
end

return EquipBagJobCell
