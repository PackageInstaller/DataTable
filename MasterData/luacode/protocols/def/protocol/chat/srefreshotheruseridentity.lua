-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/chat/srefreshotheruseridentity.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SRefreshOtherUserIdentity = dataclass("SRefreshOtherUserIdentity", require("framework.net.protocol"))
SRefreshOtherUserIdentity.ProtocolType = 1128
SRefreshOtherUserIdentity.MaxSize = 65535
SRefreshOtherUserIdentity.userId = 0
SRefreshOtherUserIdentity.identity = 0
SRefreshOtherUserIdentity.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SRefreshOtherUserIdentity
  ((SRefreshOtherUserIdentity.super).Ctor)(self, client)
end

SRefreshOtherUserIdentity.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.userId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.identity) then
    return false
  end
  return true
end

SRefreshOtherUserIdentity.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
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

return SRefreshOtherUserIdentity

