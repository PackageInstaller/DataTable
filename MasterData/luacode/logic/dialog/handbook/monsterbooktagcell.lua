local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local MonsterBookTagCell = class("MonsterBookTagCell", Dialog)
MonsterBookTagCell.AssetBundleName = "ui/layouts.tujian"
MonsterBookTagCell.AssetName = "MonsterBookKeyCell"

function MonsterBookTagCell:Ctor(...)
  MonsterBookTagCell.super.Ctor(self, ...)
end

function MonsterBookTagCell:OnCreate()
  self._tag = self:GetChild("Txt")
end

function MonsterBookTagCell:OnDestroy()
end

function MonsterBookTagCell:RefreshCell(data)
  self._tag:SetText(TextManager.GetText(data))
end

return MonsterBookTagCell
