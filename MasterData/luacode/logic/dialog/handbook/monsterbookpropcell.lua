local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local MonsterBookPropertyCell = class("MonsterBookPropertyCell", Dialog)
MonsterBookPropertyCell.AssetBundleName = "ui/layouts.tujian"
MonsterBookPropertyCell.AssetName = "MonsterBookPropCell"

function MonsterBookPropertyCell:Ctor(...)
  MonsterBookPropertyCell.super.Ctor(self, ...)
end

function MonsterBookPropertyCell:OnCreate()
  self._icon = self:GetChild("Prop/Image")
  self._progress = self:GetChild("Prop/Progress")
end

function MonsterBookPropertyCell:OnDestroy()
end

function MonsterBookPropertyCell:RefreshCell(data)
  local imageRecord = CImagePathTable:GetRecorder(data.icon)
  self._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._progress:SetFillAmount(data.num)
end

return MonsterBookPropertyCell
