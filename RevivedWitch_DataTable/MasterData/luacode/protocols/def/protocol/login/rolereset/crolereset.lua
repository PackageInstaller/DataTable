-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/login/rolereset/crolereset.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CRoleReset = dataclass("CRoleReset", require("framework.net.protocol"))
CRoleReset.ProtocolType = 1087
CRoleReset.MaxSize = 65535
CRoleReset.roleId = 0
CRoleReset.isPreview = 0
CRoleReset.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CRoleReset
  ((CRoleReset.super).Ctor)(self, client)
end

CRoleReset.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.roleId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.isPreview) then
    return false
  end
  return true
end

CRoleReset.Unmarshal = function(self, buffer)
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

return CRoleReset

