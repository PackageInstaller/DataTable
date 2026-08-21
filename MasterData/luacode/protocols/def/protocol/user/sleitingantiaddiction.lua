-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/user/sleitingantiaddiction.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SLeiTingAntiAddiction = dataclass("SLeiTingAntiAddiction", require("framework.net.protocol"))
SLeiTingAntiAddiction.ProtocolType = 2265
SLeiTingAntiAddiction.MaxSize = 65535
SLeiTingAntiAddiction.lefttime = 0
SLeiTingAntiAddiction.totaltime = 0
SLeiTingAntiAddiction.isGuest = 0
SLeiTingAntiAddiction.auth = 0
SLeiTingAntiAddiction.AUTH_UNDER_AGE = 0
SLeiTingAntiAddiction.AUTH_ADULT = 1
SLeiTingAntiAddiction.AUTH_UNIDENTIFIED = 2
SLeiTingAntiAddiction.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SLeiTingAntiAddiction
  ((SLeiTingAntiAddiction.super).Ctor)(self, client)
end

SLeiTingAntiAddiction.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.lefttime) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.totaltime) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteByte)(buffer, self.isGuest) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteByte)(buffer, self.auth) then
    return false
  end
  return true
end

SLeiTingAntiAddiction.Unmarshal = function(self, buffer)
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
  ret = (ProtocolBufferStaticFunctions.ReadByte)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadByte)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SLeiTingAntiAddiction

