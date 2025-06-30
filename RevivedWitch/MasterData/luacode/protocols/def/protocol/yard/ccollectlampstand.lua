-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/yard/ccollectlampstand.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CCollectLampStand = dataclass("CCollectLampStand", require("framework.net.protocol"))
CCollectLampStand.ProtocolType = 2335
CCollectLampStand.MaxSize = 65535
CCollectLampStand.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CCollectLampStand
  ((CCollectLampStand.super).Ctor)(self, client)
end

CCollectLampStand.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CCollectLampStand.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CCollectLampStand

