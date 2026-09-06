local EquipListTitleCell1 = class("EquipListTitleCell1", Dialog)
EquipListTitleCell1.AssetBundleName = "ui/layouts.equip"
EquipListTitleCell1.AssetName = "EquipListTitleCell1"

function EquipListTitleCell1:Ctor(...)
  EquipListTitleCell1.super.Ctor(self, ...)
end

function EquipListTitleCell1:OnCreate()
  self._title = self:GetChild("Title")
end

function EquipListTitleCell1:OnDestroy()
end

function EquipListTitleCell1:RefreshCell(data)
  if data.titleID then
    self._title:SetText(TextManager.GetText(data.titleID))
  end
end

return EquipListTitleCell1
