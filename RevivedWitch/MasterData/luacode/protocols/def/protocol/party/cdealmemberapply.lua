-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/party/cdealmemberapply.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CDealMemberApply = dataclass("CDealMemberApply", require("framework.net.protocol"))
CDealMemberApply.ProtocolType = 5012
CDealMemberApply.MaxSize = 65535
CDealMemberApply.partyId = 0
CDealMemberApply.userId = 0
CDealMemberApply.operate = 0
CDealMemberApply.REFUSE = 0
CDealMemberApply.ACCEPT = 1
CDealMemberApply.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CDealMemberApply
  ((CDealMemberApply.super).Ctor)(self, client)
end

CDealMemberApply.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.partyId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.userId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.operate) then
    return false
  end
  return true
end

CDealMemberApply.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CDealMemberApply

