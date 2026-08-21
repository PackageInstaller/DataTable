-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/user/sroleconverttoavatar.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SRoleConvertToAvatar = dataclass("SRoleConvertToAvatar", require("framework.net.protocol"))
SRoleConvertToAvatar.ProtocolType = 2264
SRoleConvertToAvatar.MaxSize = 65535
SRoleConvertToAvatar.avatarId = 0
SRoleConvertToAvatar.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SRoleConvertToAvatar
  ((SRoleConvertToAvatar.super).Ctor)(self, client)
end

SRoleConvertToAvatar.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.avatarId) then
    return false
  end
  return true
end

SRoleConvertToAvatar.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SRoleConvertToAvatar

