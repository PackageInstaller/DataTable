local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local EntryDetailCell = class("EntryDetailCell", Dialog)
EntryDetailCell.AssetBundleName = "ui/layouts.activitystar"
EntryDetailCell.AssetName = "ActivityStarBossBuffCell"

function EntryDetailCell:Ctor(...)
  EntryDetailCell.super.Ctor(self, ...)
end

function EntryDetailCell:OnCreate()
  self._title = self:GetChild("Title")
  self._detail = self:GetChild("Detail")
  self._img = self:GetChild("Img")
  self._rootWindowAnchorY, self._rootWindowOffsetY = self._rootWindow:GetHeight()
  self._detailWidth, self._detailHeight = self._detail:GetRectSize()
  self._detailAnchorMinX, self._detailAnchorMinY, self._detailAnchorMaxX, self._detailAnchorMaxY, self._detailOffsetMinX, self._detailOffsetMinY, self._detailOffsetMaxX, self._detailOffsetMaxY = self._detail:GetAnchorAndOffset()
end

function EntryDetailCell:OnDestroy()
end

function EntryDetailCell:RefreshCell(data)
  self._title:SetText(TextManager.GetText(data.nameId))
  self._detail:SetText(TextManager.GetText(data.effectId))
  local image = CImagePathTable:GetRecorder(data.img)
  self._img:SetSprite(image.assetBundle, image.assetName)
  local _, textHeight = self._detail:GetPreferredSize()
  if textHeight > self._detailHeight then
    local delta = textHeight - self._detailHeight
    self._detail:SetAnchorAndOffset(self._detailAnchorMinX, self._detailAnchorMinY, self._detailAnchorMaxX, self._detailAnchorMaxY, self._detailOffsetMinX, self._detailOffsetMinY - delta, self._detailOffsetMaxX, self._detailOffsetMaxY)
    self._rootWindow:SetHeight(self._rootWindowAnchorY, self._rootWindowOffsetY + delta)
  else
    self._detail:SetAnchorAndOffset(self._detailAnchorMinX, self._detailAnchorMinY, self._detailAnchorMaxX, self._detailAnchorMaxY, self._detailOffsetMinX, self._detailOffsetMinY, self._detailOffsetMaxX, self._detailOffsetMaxY)
    self._rootWindow:SetHeight(self._rootWindowAnchorY, self._rootWindowOffsetY)
  end
end

return EntryDetailCell
