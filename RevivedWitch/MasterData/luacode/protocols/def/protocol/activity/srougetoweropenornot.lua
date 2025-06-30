-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/srougetoweropenornot.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SRougeTowerOpenorNot = dataclass("SRougeTowerOpenorNot", require("framework.net.protocol"))
SRougeTowerOpenorNot.ProtocolType = 2478
SRougeTowerOpenorNot.MaxSize = 65535
SRougeTowerOpenorNot.openornot = 0
SRougeTowerOpenorNot.leftTime = 0
SRougeTowerOpenorNot.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SRougeTowerOpenorNot
  ((SRougeTowerOpenorNot.super).Ctor)(self, client)
end

SRougeTowerOpenorNot.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.openornot) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.leftTime) then
    return false
  end
  return true
end

SRougeTowerOpenorNot.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SRougeTowerOpenorNot

