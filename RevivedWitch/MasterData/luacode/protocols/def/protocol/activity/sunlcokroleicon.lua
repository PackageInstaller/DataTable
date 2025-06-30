-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/sunlcokroleicon.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SUnlcokRoleIcon = dataclass("SUnlcokRoleIcon", require("framework.net.protocol"))
SUnlcokRoleIcon.ProtocolType = 2595
SUnlcokRoleIcon.MaxSize = 65535
SUnlcokRoleIcon.roleId = 0
SUnlcokRoleIcon.roleNum = 0
SUnlcokRoleIcon.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SUnlcokRoleIcon
  ((SUnlcokRoleIcon.super).Ctor)(self, client)
end

SUnlcokRoleIcon.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.roleId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.roleNum) then
    return false
  end
  return true
end

SUnlcokRoleIcon.Unmarshal = function(self, buffer)
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
  return ret
end

return SUnlcokRoleIcon

