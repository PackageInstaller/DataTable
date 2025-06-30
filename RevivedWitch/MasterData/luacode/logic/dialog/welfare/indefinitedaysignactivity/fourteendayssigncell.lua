-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/welfare/indefinitedaysignactivity/fourteendayssigncell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local IndefiniteDaysSignCellHelper = require("logic.dialog.welfare.indefinitedaysignactivity.indefinitedayssigncellhelper")
local FourteenDaysSignCell = class("FourteenDaysSignCell", Dialog)
FourteenDaysSignCell.AssetBundleName = "ui/layouts.welfare"
FourteenDaysSignCell.AssetName = "WelfareMain14DayCell"
FourteenDaysSignCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : FourteenDaysSignCell
  ((FourteenDaysSignCell.super).Ctor)(self, ...)
end

FourteenDaysSignCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : IndefiniteDaysSignCellHelper
  self._rootElement = self:GetRootWindow()
  self._indefiniteDaysSignCellHelper = (IndefiniteDaysSignCellHelper.Create)(self._rootElement)
  self._imageput = self:GetChild("Imageput")
end

FourteenDaysSignCell.OnDestroy = function(self)
  -- function num : 0_2
  if self._indefiniteDaysSignCellHelper then
    (self._indefiniteDaysSignCellHelper):OnDestroy()
  end
end

FourteenDaysSignCell.RefreshCell = function(self, data)
  -- function num : 0_3
  self._data = data
  if self._indefiniteDaysSignCellHelper then
    (self._indefiniteDaysSignCellHelper):RefreshCell(self._delegate, data)
  end
end

FourteenDaysSignCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_4
  if self._indefiniteDaysSignCellHelper then
    (self._indefiniteDaysSignCellHelper):OnEvent(eventName, arg)
  end
end

return FourteenDaysSignCell

