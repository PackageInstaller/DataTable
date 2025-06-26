-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/login/crolelock.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CRoleLock = dataclass("CRoleLock", require("framework.net.protocol"))
CRoleLock.ProtocolType = 1014
CRoleLock.MaxSize = 65535
CRoleLock.roleId = 0
CRoleLock.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CRoleLock
  ((CRoleLock.super).Ctor)(self, client)
end

CRoleLock.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.roleId) then
    return false
  end
  return true
end

CRoleLock.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CRoleLock

