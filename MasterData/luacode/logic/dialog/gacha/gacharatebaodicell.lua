local GachaRateBaoDiCell = class("GachaRateBaoDiCell", Dialog)
GachaRateBaoDiCell.AssetBundleName = "ui/layouts.gacha"
GachaRateBaoDiCell.AssetName = "GachaRateBaoDi"

function GachaRateBaoDiCell:Ctor(...)
  GachaRateBaoDiCell.super.Ctor(self, ...)
end

function GachaRateBaoDiCell:OnCreate()
  self._title = self:GetChild("Title")
  self._txt = self:GetChild("Text")
  self._rootWindow_anchorY, self._rootWindow_offsetY = self:GetRootWindow():GetHeight()
  self._sizeDelta_width, self._sizeDelta_height = self._txt:GetRectSize()
  self._txt_anchorMinX, self._txt_anchorMinY, self._txt_anchorMaxX, self._txt_anchorMaxY, self._txt_offsetMinX, self._txt_offsetMinY, self._txt_offsetMaxX, self._txt_offsetMaxY = self._txt:GetAnchorAndOffset()
end

function GachaRateBaoDiCell:OnDestroy()
end

function GachaRateBaoDiCell:RefreshCell(data)
  self._title:SetText(TextManager.GetText(data.title))
  self._txt:SetText(data.describe)
  local _, textHeight = self._txt:GetPreferredSize()
  local delta = textHeight - self._sizeDelta_height
  self._txt:SetAnchorAndOffset(self._txt_anchorMinX, self._txt_anchorMinY, self._txt_anchorMaxX, self._txt_anchorMaxY, self._txt_offsetMinX, self._txt_offsetMinY - delta, self._txt_offsetMaxX, self._txt_offsetMaxY)
  self:GetRootWindow():SetHeight(self._rootWindow_anchorY, self._rootWindow_offsetY + delta)
end

return GachaRateBaoDiCell
