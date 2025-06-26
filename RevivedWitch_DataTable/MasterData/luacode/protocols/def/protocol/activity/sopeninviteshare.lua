-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/sopeninviteshare.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SOpenInviteShare = dataclass("SOpenInviteShare", require("framework.net.protocol"))
SOpenInviteShare.ProtocolType = 2466
SOpenInviteShare.MaxSize = 65535
SOpenInviteShare.invitationCode = ""
SOpenInviteShare.weekshare = 0
SOpenInviteShare.inviteeNum = 0
SOpenInviteShare.limitNum = 0
SOpenInviteShare.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SOpenInviteShare
  ((SOpenInviteShare.super).Ctor)(self, client)
end

SOpenInviteShare.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, self.invitationCode) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.weekshare) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.inviteeNum) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.limitNum) then
    return false
  end
  return true
end

SOpenInviteShare.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadProtocolString)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
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

return SOpenInviteShare

