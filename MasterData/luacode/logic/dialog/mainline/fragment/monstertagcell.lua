local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local MonsterTagCell = class("MonsterTagCell", Dialog)
MonsterTagCell.AssetBundleName = "ui/layouts.fragment"
MonsterTagCell.AssetName = "LevelInfoKeyCell"

function MonsterTagCell:Ctor(...)
  MonsterTagCell.super.Ctor(self, ...)
end

function MonsterTagCell:OnCreate()
  self._tag = self:GetChild("Txt")
end

function MonsterTagCell:OnDestroy()
end

function MonsterTagCell:RefreshCell(data)
  self._tag:SetText(TextManager.GetText(data))
end

return MonsterTagCell
