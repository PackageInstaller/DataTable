-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/copendoubleelevencard.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local COpenDoubleElevenCard = dataclass("COpenDoubleElevenCard", require("framework.net.protocol"))
COpenDoubleElevenCard.ProtocolType = 2523
COpenDoubleElevenCard.MaxSize = 65535
COpenDoubleElevenCard.poolId = 0
COpenDoubleElevenCard.position = 0
COpenDoubleElevenCard.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : COpenDoubleElevenCard
  ((COpenDoubleElevenCard.super).Ctor)(self, client)
end

COpenDoubleElevenCard.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.poolId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.position) then
    return false
  end
  return true
end

COpenDoubleElevenCard.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return COpenDoubleElevenCard

