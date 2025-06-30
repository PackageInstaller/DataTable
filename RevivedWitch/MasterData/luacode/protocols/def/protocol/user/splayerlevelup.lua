-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/user/splayerlevelup.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SPlayerLevelUp = dataclass("SPlayerLevelUp", require("framework.net.protocol"))
SPlayerLevelUp.ProtocolType = 2266
SPlayerLevelUp.MaxSize = 65535
SPlayerLevelUp.level = 0
SPlayerLevelUp.strengthLimit = 0
SPlayerLevelUp.roleMaxLv = 0
SPlayerLevelUp.strengthGet = 0
SPlayerLevelUp.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SPlayerLevelUp
  ((SPlayerLevelUp.super).Ctor)(self, client)
end

SPlayerLevelUp.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.level) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.strengthLimit) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.roleMaxLv) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.strengthGet) then
    return false
  end
  return true
end

SPlayerLevelUp.Unmarshal = function(self, buffer)
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

return SPlayerLevelUp

