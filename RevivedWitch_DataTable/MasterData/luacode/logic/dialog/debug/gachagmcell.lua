-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/debug/gachagmcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GachaGMCell = class("GachaGMCell", Dialog)
GachaGMCell.AssetBundleName = "ui/layouts.gm"
GachaGMCell.AssetName = "GachaGMCell"
GachaGMCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GachaGMCell
  ((GachaGMCell.super).Ctor)(self, ...)
end

GachaGMCell.OnCreate = function(self)
  -- function num : 0_1
  self._title = self:GetChild("Txt1")
  self._rateNum = self:GetChild("Num1")
end

GachaGMCell.OnDestroy = function(self)
  -- function num : 0_2
end

GachaGMCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  (self._title):SetText(data.title)
  ;
  (self._rateNum):SetText(tostring(data.num) .. "\t\t" .. tostring(data.rate) .. "%")
end

return GachaGMCell

