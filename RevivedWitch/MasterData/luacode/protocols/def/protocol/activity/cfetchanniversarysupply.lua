-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/cfetchanniversarysupply.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CFetchAnniversarySupply = dataclass("CFetchAnniversarySupply", require("framework.net.protocol"))
CFetchAnniversarySupply.ProtocolType = 2681
CFetchAnniversarySupply.MaxSize = 65535
CFetchAnniversarySupply.supply = 0
CFetchAnniversarySupply.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CFetchAnniversarySupply
  ((CFetchAnniversarySupply.super).Ctor)(self, client)
end

CFetchAnniversarySupply.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.supply) then
    return false
  end
  return true
end

CFetchAnniversarySupply.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CFetchAnniversarySupply

