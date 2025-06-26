-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/cupgradefoolsdayrole.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CUpgradeFoolsDayRole = dataclass("CUpgradeFoolsDayRole", require("framework.net.protocol"))
CUpgradeFoolsDayRole.ProtocolType = 2630
CUpgradeFoolsDayRole.MaxSize = 65535
CUpgradeFoolsDayRole.Id = 0
CUpgradeFoolsDayRole.upgradeType = 0
CUpgradeFoolsDayRole.LEVEL = 1
CUpgradeFoolsDayRole.WEAPON = 2
CUpgradeFoolsDayRole.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CUpgradeFoolsDayRole
  ((CUpgradeFoolsDayRole.super).Ctor)(self, client)
end

CUpgradeFoolsDayRole.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.Id) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.upgradeType) then
    return false
  end
  return true
end

CUpgradeFoolsDayRole.Unmarshal = function(self, buffer)
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

return CUpgradeFoolsDayRole

