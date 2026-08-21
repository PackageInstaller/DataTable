-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/bag/itemtipsuniqueequipattrpanelcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local ItemTipsUniqueEquipAttrPanelCell = class("ItemTipsUniqueEquipAttrPanelCell", Dialog)
ItemTipsUniqueEquipAttrPanelCell.AssetBundleName = "ui/layouts.bag"
ItemTipsUniqueEquipAttrPanelCell.AssetName = "ItemTipsNewEquipAttribute"
ItemTipsUniqueEquipAttrPanelCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ItemTipsUniqueEquipAttrPanelCell
  ((ItemTipsUniqueEquipAttrPanelCell.super).Ctor)(self, ...)
end

ItemTipsUniqueEquipAttrPanelCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame
  self._cellPanel = self:GetChild("Equiptips")
  self._frame = (TableFrame.Create)(self._cellPanel, self, true, false, true)
end

ItemTipsUniqueEquipAttrPanelCell.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

ItemTipsUniqueEquipAttrPanelCell.RefreshCell = function(self, data)
  -- function num : 0_3
  (self._frame):ReloadAllCell()
  ;
  (self._frame):MoveToTop()
end

ItemTipsUniqueEquipAttrPanelCell.NumberOfCell = function(self, frame)
  -- function num : 0_4
  return #(self._cellData).value
end

ItemTipsUniqueEquipAttrPanelCell.CellAtIndex = function(self, frame, index)
  -- function num : 0_5
  return "bag.itemtipsuniqueequipattrcell"
end

ItemTipsUniqueEquipAttrPanelCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  return ((self._cellData).value)[index]
end

return ItemTipsUniqueEquipAttrPanelCell

