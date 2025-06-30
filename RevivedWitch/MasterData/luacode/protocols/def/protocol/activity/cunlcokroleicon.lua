-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/cunlcokroleicon.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CUnlcokRoleIcon = dataclass("CUnlcokRoleIcon", require("framework.net.protocol"))
CUnlcokRoleIcon.ProtocolType = 2594
CUnlcokRoleIcon.MaxSize = 65535
CUnlcokRoleIcon.roleId = 0
CUnlcokRoleIcon.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CUnlcokRoleIcon
  ((CUnlcokRoleIcon.super).Ctor)(self, client)
end

CUnlcokRoleIcon.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.roleId) then
    return false
  end
  return true
end

CUnlcokRoleIcon.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CUnlcokRoleIcon

