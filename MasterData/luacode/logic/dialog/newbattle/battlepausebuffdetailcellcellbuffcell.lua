-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/newbattle/battlepausebuffdetailcellcellbuffcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CCBuffConfig = (BeanManager.GetTableByName)("buff.ccbuffconfig")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local BattlePauseBuffDetailCellCellBuffCell = class("BattlePauseBuffDetailCellCellBuffCell", Dialog)
BattlePauseBuffDetailCellCellBuffCell.AssetBundleName = "ui/layouts.battlenew"
BattlePauseBuffDetailCellCellBuffCell.AssetName = "BattlePauseCellBuffCell"
BattlePauseBuffDetailCellCellBuffCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BattlePauseBuffDetailCellCellBuffCell
  ((BattlePauseBuffDetailCellCellBuffCell.super).Ctor)(self, ...)
end

BattlePauseBuffDetailCellCellBuffCell.OnCreate = function(self)
  -- function num : 0_1
  self._buffImg = self:GetChild("Buff")
  self._describe = self:GetChild("Text")
  self._width = (self._describe):GetRectSize()
  local _ = 0
  self._talk_size_x = (self:GetRootWindow()):GetSize()
  self._cellWidth = (self:GetRootWindow()):GetRectSize()
end

BattlePauseBuffDetailCellCellBuffCell.OnDestroy = function(self)
  -- function num : 0_2
end

BattlePauseBuffDetailCellCellBuffCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CCBuffConfig, CImagePathTable, _ENV
  local recorder = CCBuffConfig:GetRecorder(data)
  if recorder then
    local imageRecord = CImagePathTable:GetRecorder(recorder.iconId)
    if imageRecord then
      (self._buffImg):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    else
      ;
      (self._buffImg):SetSprite("", "")
    end
    ;
    (self._describe):SetText((TextManager.GetText)(recorder.buffTextID))
    local textWidth, _ = (self._describe):GetPreferredSize()
    if self._width < textWidth then
      local delta = textWidth - self._width
      ;
      (self:GetRootWindow()):SetSize(self._talk_size_x, self._talk_size_offset_x + delta, self._talk_size_y, self._talk_size_offset_y)
    else
      do
        ;
        (self:GetRootWindow()):SetSize(self._talk_size_x, self._talk_size_offset_x, self._talk_size_y, self._talk_size_offset_y)
      end
    end
  end
end

BattlePauseBuffDetailCellCellBuffCell.GetCellActualWidth = function(self, text)
  -- function num : 0_4
  (self._describe):SetText(text)
  local textWidth, _ = (self._describe):GetPreferredSize()
  local delta = 0
  if self._width < textWidth then
    delta = textWidth - self._width
  end
  return self._cellWidth + (delta)
end

return BattlePauseBuffDetailCellCellBuffCell

