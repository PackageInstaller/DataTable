-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/susebackinvitecode.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SUseBackInviteCode = dataclass("SUseBackInviteCode", require("framework.net.protocol"))
SUseBackInviteCode.ProtocolType = 2552
SUseBackInviteCode.MaxSize = 65535
SUseBackInviteCode.result = 0
SUseBackInviteCode.fail = 0
SUseBackInviteCode.success = 1
SUseBackInviteCode.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SUseBackInviteCode
  ((SUseBackInviteCode.super).Ctor)(self, client)
end

SUseBackInviteCode.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.result) then
    return false
  end
  return true
end

SUseBackInviteCode.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SUseBackInviteCode

