-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/cusebackinvitecode.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CUseBackInviteCode = dataclass("CUseBackInviteCode", require("framework.net.protocol"))
CUseBackInviteCode.ProtocolType = 2551
CUseBackInviteCode.MaxSize = 65535
CUseBackInviteCode.invitationCode = ""
CUseBackInviteCode.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CUseBackInviteCode
  ((CUseBackInviteCode.super).Ctor)(self, client)
end

CUseBackInviteCode.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, self.invitationCode) then
    return false
  end
  return true
end

CUseBackInviteCode.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadProtocolString)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CUseBackInviteCode

