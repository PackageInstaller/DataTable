-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/cmagiclauncher.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CMagicLauncher = dataclass("CMagicLauncher", require("framework.net.protocol"))
CMagicLauncher.ProtocolType = 1971
CMagicLauncher.MaxSize = 65535
CMagicLauncher.instanceId = 0
CMagicLauncher.launcherId = 0
CMagicLauncher.targetId = 0
CMagicLauncher.power = 0
CMagicLauncher.direction = 0
CMagicLauncher.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CMagicLauncher
  ((CMagicLauncher.super).Ctor)(self, client)
end

CMagicLauncher.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.instanceId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.launcherId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.targetId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteProtocolFloat)(buffer, self.power) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteProtocolFloat)(buffer, self.direction) then
    return false
  end
  return true
end

CMagicLauncher.Unmarshal = function(self, buffer)
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
  ret = (ProtocolBufferStaticFunctions.ReadFloat)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadFloat)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CMagicLauncher

