local EquipPopTitleCell1 = class("EquipPopTitleCell1", Dialog)
EquipPopTitleCell1.AssetBundleName = "ui/layouts.equip"
EquipPopTitleCell1.AssetName = "EquipPopTitleCell1"

function EquipPopTitleCell1:Ctor(...)
  EquipPopTitleCell1.super.Ctor(self, ...)
end

function EquipPopTitleCell1:OnCreate()
  self._title = self:GetChild("Title")
end

function EquipPopTitleCell1:OnDestroy()
end

function EquipPopTitleCell1:RefreshCell(data)
  if data.titleID then
    self._title:SetText(TextManager.GetText(data.titleID))
  end
end

return EquipPopTitleCell1
