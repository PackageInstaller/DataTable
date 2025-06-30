-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/item/sequipenchantreset.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SEquipEnchantReset = dataclass("SEquipEnchantReset", require("framework.net.protocol"))
SEquipEnchantReset.ProtocolType = 1252
SEquipEnchantReset.MaxSize = 65535
SEquipEnchantReset.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SEquipEnchantReset
  ((SEquipEnchantReset.super).Ctor)(self, client)
end

SEquipEnchantReset.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

SEquipEnchantReset.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return SEquipEnchantReset

