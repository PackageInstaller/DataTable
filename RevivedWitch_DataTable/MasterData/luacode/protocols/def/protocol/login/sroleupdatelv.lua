-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/login/sroleupdatelv.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SRoleUpdateLv = dataclass("SRoleUpdateLv", require("framework.net.protocol"))
SRoleUpdateLv.ProtocolType = 1016
SRoleUpdateLv.MaxSize = 65535
SRoleUpdateLv.roleId = 0
SRoleUpdateLv.level = 0
SRoleUpdateLv.exp = 0
SRoleUpdateLv.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SRoleUpdateLv
  ((SRoleUpdateLv.super).Ctor)(self, client)
end

SRoleUpdateLv.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.roleId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt16)(buffer, self.level) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.exp) then
    return false
  end
  return true
end

SRoleUpdateLv.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt16)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SRoleUpdateLv

