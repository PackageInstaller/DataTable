local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local MonsterPropertyCell = class("MonsterPropertyCell", Dialog)
MonsterPropertyCell.AssetBundleName = "ui/layouts.fragment"
MonsterPropertyCell.AssetName = "LevelInfoPropCell"

function MonsterPropertyCell:Ctor(...)
  MonsterPropertyCell.super.Ctor(self, ...)
end

function MonsterPropertyCell:OnCreate()
  self._icon = self:GetChild("Prop/Image")
  self._progress = self:GetChild("Prop/Progress")
end

function MonsterPropertyCell:OnDestroy()
end

function MonsterPropertyCell:RefreshCell(data)
  local imageRecord = CImagePathTable:GetRecorder(data.icon)
  self._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._progress:SetFillAmount(data.num)
end

return MonsterPropertyCell
