-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/cuseinvitationcode.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CUseInvitationCode = dataclass("CUseInvitationCode", require("framework.net.protocol"))
CUseInvitationCode.ProtocolType = 2456
CUseInvitationCode.MaxSize = 65535
CUseInvitationCode.invitationCode = ""
CUseInvitationCode.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CUseInvitationCode
  ((CUseInvitationCode.super).Ctor)(self, client)
end

CUseInvitationCode.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, self.invitationCode) then
    return false
  end
  return true
end

CUseInvitationCode.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadProtocolString)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CUseInvitationCode

