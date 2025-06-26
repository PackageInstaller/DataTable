-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/courtcabin/recommendthemeframecell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GridFrame = require("framework.ui.frame.grid.gridframe")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CDormFurnitureType = (BeanManager.GetTableByName)("courtyard.cdormfurnituretype")
local ColumnNums = 6
local RecommendThemeFrameCell = class("RecommendThemeFrameCell", Dialog)
RecommendThemeFrameCell.AssetBundleName = "ui/layouts.yard"
RecommendThemeFrameCell.AssetName = "HouseThemeRecommendCell"
RecommendThemeFrameCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RecommendThemeFrameCell
  ((RecommendThemeFrameCell.super).Ctor)(self, ...)
end

RecommendThemeFrameCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : GridFrame, ColumnNums
  self._title = self:GetChild("Title")
  self._image = self:GetChild("Image")
  self._panel = self:GetChild("ItemFrame")
  self._frame = (GridFrame.Create)(self._panel, self, true, ColumnNums, false)
  self._width = (self._panel):GetRectSize()
end

RecommendThemeFrameCell.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

RecommendThemeFrameCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CDormFurnitureType, _ENV, CImagePathTable
  local recorder = CDormFurnitureType:GetRecorder(data.type)
  ;
  (self._title):SetText((TextManager.GetText)(recorder.nameTextID))
  if not CImagePathTable:GetRecorder(recorder.image) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._image):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._frame):ReloadAllCell()
  local totalLength = (self._frame):GetTotalLength()
  ;
  (self._panel):SetSize(0, self._width, 0, totalLength)
  ;
  (self._frame):ReloadAllCell()
end

RecommendThemeFrameCell.NumberOfCell = function(self, frame)
  -- function num : 0_4
  return #(self._cellData).furnitureList
end

RecommendThemeFrameCell.CellAtIndex = function(self, frame, index)
  -- function num : 0_5
  return "courtcabin.themefurniturecell"
end

RecommendThemeFrameCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  return ((self._cellData).furnitureList)[index]
end

return RecommendThemeFrameCell

