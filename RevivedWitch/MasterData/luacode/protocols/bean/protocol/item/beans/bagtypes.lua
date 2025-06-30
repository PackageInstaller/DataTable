-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/bean/protocol/item/beans/bagtypes.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local BagTypes = dataclass("BagTypes")
BagTypes.BAG = 1
BagTypes.EQUIPBAG = 4
BagTypes.VALUABLEBAG = 5
BagTypes.FURNITURE_BAG = 6
BagTypes.Ctor = function(self)
  -- function num : 0_0
end

BagTypes.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

BagTypes.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return BagTypes

