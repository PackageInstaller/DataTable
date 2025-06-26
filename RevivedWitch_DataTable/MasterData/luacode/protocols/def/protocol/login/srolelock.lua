-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/login/srolelock.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SRoleLock = dataclass("SRoleLock", require("framework.net.protocol"))
SRoleLock.ProtocolType = 1015
SRoleLock.MaxSize = 65535
SRoleLock.roleId = 0
SRoleLock.lock = 0
SRoleLock.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SRoleLock
  ((SRoleLock.super).Ctor)(self, client)
end

SRoleLock.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.roleId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt16)(buffer, self.lock) then
    return false
  end
  return true
end

SRoleLock.Unmarshal = function(self, buffer)
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
  return ret
end

return SRoleLock

