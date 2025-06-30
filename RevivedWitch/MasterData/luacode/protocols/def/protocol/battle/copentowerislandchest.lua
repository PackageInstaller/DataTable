-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/copentowerislandchest.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local COpenTowerIslandChest = dataclass("COpenTowerIslandChest", require("framework.net.protocol"))
COpenTowerIslandChest.ProtocolType = 1985
COpenTowerIslandChest.MaxSize = 65535
COpenTowerIslandChest.islandID = 0
COpenTowerIslandChest.choice = 0
COpenTowerIslandChest.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : COpenTowerIslandChest
  ((COpenTowerIslandChest.super).Ctor)(self, client)
end

COpenTowerIslandChest.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.islandID) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.choice) then
    return false
  end
  return true
end

COpenTowerIslandChest.Unmarshal = function(self, buffer)
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

return COpenTowerIslandChest

