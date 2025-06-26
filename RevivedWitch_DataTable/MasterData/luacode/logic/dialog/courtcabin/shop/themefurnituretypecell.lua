-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/courtcabin/shop/themefurnituretypecell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local CDormFurnitureType = (BeanManager.GetTableByName)("courtyard.cdormfurnituretype")
local ThemeFurnitureTypeCell = class("ThemeFurnitureTypeCell", Dialog)
ThemeFurnitureTypeCell.AssetBundleName = "ui/layouts.yard"
ThemeFurnitureTypeCell.AssetName = "FurnitureThemeBuyFrame"
ThemeFurnitureTypeCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ThemeFurnitureTypeCell
  ((ThemeFurnitureTypeCell.super).Ctor)(self, ...)
end

ThemeFurnitureTypeCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame
  self._typeTxt = self:GetChild("TitleBack/Txt")
  self._panel = self:GetChild("Frame")
  self._anchorX = (self._rootWindow):GetSize()
  self._panel_anchorX = (self._panel):GetSize()
  self._panel_pos_anchorY = (self._panel):GetYPosition()
  self._frame = (TableFrame.Create)(self._panel, self, R4_PC11, false, true)
end

ThemeFurnitureTypeCell.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

ThemeFurnitureTypeCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, CDormFurnitureType
  if data.type == (self._delegate)._haveFurnitureType then
    (self._typeTxt):SetText((TextManager.GetText)(700834))
  else
    local recorder = CDormFurnitureType:GetRecorder(data.type)
    ;
    (self._typeTxt):SetText((TextManager.GetText)(recorder.nameTextID))
  end
  do
    ;
    (self._frame):ReloadAllCell()
    local len = (self._frame):GetTotalLength()
    ;
    (self._panel):SetSize(self._anchorX, self._offsetX, self._anchorY, len)
    ;
    (self._panel):SetYPosition(self._panel_pos_anchorY, self._panel_pos_offsetY - (len - self._panel_offsetY) / 2)
    ;
    (self._rootWindow):SetSize(self._anchorX, self._offsetX, self._anchorY, self._offsetY + (len - self._panel_offsetY))
    ;
    (self._frame):ReloadAllCell()
    ;
    (self._frame):MoveToTop()
  end
end

ThemeFurnitureTypeCell.NumberOfCell = function(self, frame)
  -- function num : 0_4
  return #(self._cellData).data
end

ThemeFurnitureTypeCell.CellAtIndex = function(self, frame, index)
  -- function num : 0_5
  return "courtcabin.shop.themefurniturecell"
end

ThemeFurnitureTypeCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  return ((self._cellData).data)[index]
end

return ThemeFurnitureTypeCell

