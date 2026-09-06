local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local EntryCell = class("EntryCell", Dialog)
EntryCell.AssetBundleName = "ui/layouts.activitystar"
EntryCell.AssetName = "ActivityStarMainBuffCell"

function EntryCell:Ctor(...)
  EntryCell.super.Ctor(self, ...)
end

function EntryCell:OnCreate()
  self._txt = self:GetChild("Txt")
  self._img = self:GetChild("Img")
end

function EntryCell:OnDestroy()
end

function EntryCell:RefreshCell(data)
  self._txt:SetText(TextManager.GetText(data.nameId))
  local image = CImagePathTable:GetRecorder(data.img)
  self._img:SetSprite(image.assetBundle, image.assetName)
end

return EntryCell
