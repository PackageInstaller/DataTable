-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/welfare/indefinitedaysignactivity/fourteendayssigncell2.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local IndefiniteDaysSignCellHelper = require("logic.dialog.welfare.indefinitedaysignactivity.indefinitedayssigncellhelper")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local FourteenDaysSignCell2 = class("FourteenDaysSignCell2", Dialog)
FourteenDaysSignCell2.AssetBundleName = "ui/layouts.welfare"
FourteenDaysSignCell2.AssetName = "WelfareMain14DaySkinCell"
FourteenDaysSignCell2.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : FourteenDaysSignCell2
  ((FourteenDaysSignCell2.super).Ctor)(self, ...)
end

FourteenDaysSignCell2.OnCreate = function(self)
  -- function num : 0_1 , upvalues : IndefiniteDaysSignCellHelper
  self._rootElement = self:GetRootWindow()
  self._indefiniteDaysSignCellHelper = (IndefiniteDaysSignCellHelper.Create)(self._rootElement)
  self._imageput = self:GetChild("Imageput")
end

FourteenDaysSignCell2.OnDestroy = function(self)
  -- function num : 0_2
  if self._indefiniteDaysSignCellHelper then
    (self._indefiniteDaysSignCellHelper):OnDestroy()
  end
end

FourteenDaysSignCell2.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, CImagePathTable
  self._data = data
  if self._indefiniteDaysSignCellHelper then
    (self._indefiniteDaysSignCellHelper):RefreshCell(self._delegate, data)
  end
  local iconKind = tonumber(((self._data).extraCfg)[2])
  local imageRecord = CImagePathTable:GetRecorder(iconKind)
  ;
  ((self._indefiniteDaysSignCellHelper)._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  ((self._indefiniteDaysSignCellHelper)._icongrey):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
end

FourteenDaysSignCell2.OnEvent = function(self, eventName, arg)
  -- function num : 0_4
  if self._indefiniteDaysSignCellHelper then
    (self._indefiniteDaysSignCellHelper):OnEvent(eventName, arg)
  end
end

return FourteenDaysSignCell2

