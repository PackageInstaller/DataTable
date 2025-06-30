-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/activity/dm_spiritdiscount.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DM_SpiritDiscount = class("DM_SpiritDiscount")
DM_SpiritDiscount.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._data = ((NekoData.Data).activities).spiritdiscount
end

DM_SpiritDiscount.Clear = function(self)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  ((NekoData.Data).activities).spiritdiscount = {}
end

DM_SpiritDiscount.OnSReduceCostActInfo = function(self, protocol)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._data).discount = protocol.discount
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).range = (string.split)(protocol.floorList, ",")
  for k,v in pairs((self._data).range) do
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R7 in 'UnsetPending'

    ((self._data).range)[k] = tonumber(v)
  end
end

return DM_SpiritDiscount

