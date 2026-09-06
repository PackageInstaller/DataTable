local GridFrame = require("framework.ui.frame.grid.gridframe")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CDormFurnitureType = BeanManager.GetTableByName("courtyard.cdormfurnituretype")
local ColumnNums = 6
local RecommendThemeFrameCell = class("RecommendThemeFrameCell", Dialog)
RecommendThemeFrameCell.AssetBundleName = "ui/layouts.yard"
RecommendThemeFrameCell.AssetName = "HouseThemeRecommendCell"

function RecommendThemeFrameCell:Ctor(...)
  RecommendThemeFrameCell.super.Ctor(self, ...)
end

function RecommendThemeFrameCell:OnCreate()
  self._title = self:GetChild("Title")
  self._image = self:GetChild("Image")
  self._panel = self:GetChild("ItemFrame")
  self._frame = GridFrame.Create(self._panel, self, true, ColumnNums, false)
  self._width, self._height = self._panel:GetRectSize()
end

function RecommendThemeFrameCell:OnDestroy()
  self._frame:Destroy()
end

function RecommendThemeFrameCell:RefreshCell(data)
  local recorder = CDormFurnitureType:GetRecorder(data.type)
  self._title:SetText(TextManager.GetText(recorder.nameTextID))
  local imageRecord = CImagePathTable:GetRecorder(recorder.image) or DataCommon.DefaultImageAsset
  self._image:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._frame:ReloadAllCell()
  local totalLength = self._frame:GetTotalLength()
  self._panel:SetSize(0, self._width, 0, totalLength)
  self._frame:ReloadAllCell()
end

function RecommendThemeFrameCell:NumberOfCell(frame)
  return #self._cellData.furnitureList
end

function RecommendThemeFrameCell:CellAtIndex(frame, index)
  return "courtcabin.themefurniturecell"
end

function RecommendThemeFrameCell:DataAtIndex(frame, index)
  return self._cellData.furnitureList[index]
end

return RecommendThemeFrameCell
