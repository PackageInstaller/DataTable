-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/cresetpositiontrap.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CResetPositionTrap = dataclass("CResetPositionTrap", require("framework.net.protocol"))
CResetPositionTrap.ProtocolType = 4101
CResetPositionTrap.MaxSize = 65535
CResetPositionTrap.trapGroupId = 0
CResetPositionTrap.status = 0
CResetPositionTrap.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CResetPositionTrap
  ((CResetPositionTrap.super).Ctor)(self, client)
end

CResetPositionTrap.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.trapGroupId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.status) then
    return false
  end
  return true
end

CResetPositionTrap.Unmarshal = function(self, buffer)
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

return CResetPositionTrap

