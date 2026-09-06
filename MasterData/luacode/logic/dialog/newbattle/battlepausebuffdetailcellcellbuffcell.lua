local CCBuffConfig = BeanManager.GetTableByName("buff.ccbuffconfig")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local BattlePauseBuffDetailCellCellBuffCell = class("BattlePauseBuffDetailCellCellBuffCell", Dialog)
BattlePauseBuffDetailCellCellBuffCell.AssetBundleName = "ui/layouts.battlenew"
BattlePauseBuffDetailCellCellBuffCell.AssetName = "BattlePauseCellBuffCell"

function BattlePauseBuffDetailCellCellBuffCell:Ctor(...)
  BattlePauseBuffDetailCellCellBuffCell.super.Ctor(self, ...)
end

function BattlePauseBuffDetailCellCellBuffCell:OnCreate()
  self._buffImg = self:GetChild("Buff")
  self._describe = self:GetChild("Text")
  self._width, self._height = self._describe:GetRectSize()
  local _ = 0
  self._talk_size_x, self._talk_size_offset_x, self._talk_size_y, self._talk_size_offset_y = self:GetRootWindow():GetSize()
  self._cellWidth, self._cellHeight = self:GetRootWindow():GetRectSize()
end

function BattlePauseBuffDetailCellCellBuffCell:OnDestroy()
end

function BattlePauseBuffDetailCellCellBuffCell:RefreshCell(data)
  local recorder = CCBuffConfig:GetRecorder(data)
  if recorder then
    local imageRecord = CImagePathTable:GetRecorder(recorder.iconId)
    if imageRecord then
      self._buffImg:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    else
      self._buffImg:SetSprite("", "")
    end
    self._describe:SetText(TextManager.GetText(recorder.buffTextID))
    local textWidth, _ = self._describe:GetPreferredSize()
    if textWidth > self._width then
      local delta = textWidth - self._width
      self:GetRootWindow():SetSize(self._talk_size_x, self._talk_size_offset_x + delta, self._talk_size_y, self._talk_size_offset_y)
    else
      self:GetRootWindow():SetSize(self._talk_size_x, self._talk_size_offset_x, self._talk_size_y, self._talk_size_offset_y)
    end
  end
end

function BattlePauseBuffDetailCellCellBuffCell:GetCellActualWidth(text)
  self._describe:SetText(text)
  local textWidth, _ = self._describe:GetPreferredSize()
  local delta = 0
  if textWidth > self._width then
    delta = textWidth - self._width
  end
  return self._cellWidth + delta
end

return BattlePauseBuffDetailCellCellBuffCell
