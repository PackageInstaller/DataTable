-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/suseinvitationcode.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SUseInvitationCode = dataclass("SUseInvitationCode", require("framework.net.protocol"))
SUseInvitationCode.ProtocolType = 2457
SUseInvitationCode.MaxSize = 65535
SUseInvitationCode.result = 0
SUseInvitationCode.invitationCode = ""
SUseInvitationCode.fail = 0
SUseInvitationCode.success = 1
SUseInvitationCode.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SUseInvitationCode
  ((SUseInvitationCode.super).Ctor)(self, client)
end

SUseInvitationCode.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.result) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, self.invitationCode) then
    return false
  end
  return true
end

SUseInvitationCode.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadProtocolString)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SUseInvitationCode

