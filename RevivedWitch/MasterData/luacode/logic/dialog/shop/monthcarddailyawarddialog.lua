-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/shop/monthcarddailyawarddialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local Item = require("logic.manager.experimental.types.item")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local MonthCardDailyAwardDialog = class("MonthCardDailyAwardDialog", Dialog)
MonthCardDailyAwardDialog.AssetBundleName = "ui/layouts.baseshop"
MonthCardDailyAwardDialog.AssetName = "MonthCardItemAccount"
MonthCardDailyAwardDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MonthCardDailyAwardDialog
  ((MonthCardDailyAwardDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

MonthCardDailyAwardDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : GridFrame
  self._cellArea = self:GetChild("CellPanel/CellPanel")
  self._cellFrame = (GridFrame.Create)(self._cellArea, self, true, 5)
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

MonthCardDailyAwardDialog.OnDestroy = function(self)
  -- function num : 0_2
  (self._cellFrame):Destroy()
end

MonthCardDailyAwardDialog.SetData = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  self._itemList = {}
  for k,v in pairs(data) do
    (table.insert)(self._itemList, {itemid = k, itemnum = v})
  end
  ;
  (self._cellFrame):ReloadAllCell()
end

MonthCardDailyAwardDialog.NumberOfCell = function(self, frame)
  -- function num : 0_4
  return #self._itemList
end

MonthCardDailyAwardDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_5
  return "shop.monthcarddailyawardcell"
end

MonthCardDailyAwardDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  return (self._itemList)[index]
end

MonthCardDailyAwardDialog.OnBackBtnClicked = function(self)
  -- function num : 0_7
  if (self:GetRootWindow()):IsActive() then
    self:Destroy()
  end
end

return MonthCardDailyAwardDialog

