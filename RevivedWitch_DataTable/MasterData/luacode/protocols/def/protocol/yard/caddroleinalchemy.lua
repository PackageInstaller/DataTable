-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/yard/caddroleinalchemy.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CAddRoleInAlchemy = dataclass("CAddRoleInAlchemy", require("framework.net.protocol"))
CAddRoleInAlchemy.ProtocolType = 2352
CAddRoleInAlchemy.MaxSize = 65535
CAddRoleInAlchemy.roleId = 0
CAddRoleInAlchemy.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CAddRoleInAlchemy
  ((CAddRoleInAlchemy.super).Ctor)(self, client)
end

CAddRoleInAlchemy.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.roleId) then
    return false
  end
  return true
end

CAddRoleInAlchemy.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CAddRoleInAlchemy

