-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/sneed2renewshatteredzones.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SNeed2RenewShatteredZones = dataclass("SNeed2RenewShatteredZones", require("framework.net.protocol"))
SNeed2RenewShatteredZones.ProtocolType = 2412
SNeed2RenewShatteredZones.MaxSize = 65535
SNeed2RenewShatteredZones.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SNeed2RenewShatteredZones
  ((SNeed2RenewShatteredZones.super).Ctor)(self, client)
end

SNeed2RenewShatteredZones.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

SNeed2RenewShatteredZones.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return SNeed2RenewShatteredZones

