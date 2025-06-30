-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/activity/bm_spiritdiscount.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BM_SpiritDiscount = class("BM_SpiritDiscount")
BM_SpiritDiscount.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._data = ((NekoData.Data).activities).spiritdiscount
end

BM_SpiritDiscount.Clear = function(self)
  -- function num : 0_1
end

BM_SpiritDiscount.GetDiscount = function(self)
  -- function num : 0_2
  return (self._data).discount
end

BM_SpiritDiscount.GetRange = function(self)
  -- function num : 0_3
  return (self._data).range
end

return BM_SpiritDiscount

