-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/yard/ccollectlightspot.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CCollectLightSpot = dataclass("CCollectLightSpot", require("framework.net.protocol"))
CCollectLightSpot.ProtocolType = 2344
CCollectLightSpot.MaxSize = 65535
CCollectLightSpot.key = 0
CCollectLightSpot.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CCollectLightSpot
  ((CCollectLightSpot.super).Ctor)(self, client)
end

CCollectLightSpot.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.key) then
    return false
  end
  return true
end

CCollectLightSpot.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CCollectLightSpot

