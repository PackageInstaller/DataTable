-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/login/sroleremove.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SRoleRemove = dataclass("SRoleRemove", require("framework.net.protocol"))
SRoleRemove.ProtocolType = 1013
SRoleRemove.MaxSize = 65535
SRoleRemove.roleId = 0
SRoleRemove.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SRoleRemove
  ((SRoleRemove.super).Ctor)(self, client)
end

SRoleRemove.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.roleId) then
    return false
  end
  return true
end

SRoleRemove.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SRoleRemove

