-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/starmirage/entrydetailcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local EntryDetailCell = class("EntryDetailCell", Dialog)
EntryDetailCell.AssetBundleName = "ui/layouts.activitystar"
EntryDetailCell.AssetName = "ActivityStarBossBuffCell"
EntryDetailCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : EntryDetailCell
  ((EntryDetailCell.super).Ctor)(self, ...)
end

EntryDetailCell.OnCreate = function(self)
  -- function num : 0_1
  self._title = self:GetChild("Title")
  self._detail = self:GetChild("Detail")
  self._img = self:GetChild("Img")
  self._rootWindowAnchorY = (self._rootWindow):GetHeight()
  self._detailWidth = (self._detail):GetRectSize()
  self._detailAnchorMinX = (self._detail):GetAnchorAndOffset()
end

EntryDetailCell.OnDestroy = function(self)
  -- function num : 0_2
end

EntryDetailCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, CImagePathTable
  (self._title):SetText((TextManager.GetText)(data.nameId))
  ;
  (self._detail):SetText((TextManager.GetText)(data.effectId))
  local image = CImagePathTable:GetRecorder(data.img)
  ;
  (self._img):SetSprite(image.assetBundle, image.assetName)
  local _, textHeight = (self._detail):GetPreferredSize()
  if self._detailHeight < textHeight then
    local delta = textHeight - self._detailHeight
    ;
    (self._detail):SetAnchorAndOffset(self._detailAnchorMinX, self._detailAnchorMinY, self._detailAnchorMaxX, self._detailAnchorMaxY, self._detailOffsetMinX, self._detailOffsetMinY - delta, self._detailOffsetMaxX, self._detailOffsetMaxY)
    ;
    (self._rootWindow):SetHeight(self._rootWindowAnchorY, self._rootWindowOffsetY + delta)
  else
    do
      ;
      (self._detail):SetAnchorAndOffset(self._detailAnchorMinX, self._detailAnchorMinY, self._detailAnchorMaxX, self._detailAnchorMaxY, self._detailOffsetMinX, self._detailOffsetMinY, self._detailOffsetMaxX, self._detailOffsetMaxY)
      ;
      (self._rootWindow):SetHeight(self._rootWindowAnchorY, self._rootWindowOffsetY)
    end
  end
end

return EntryDetailCell

