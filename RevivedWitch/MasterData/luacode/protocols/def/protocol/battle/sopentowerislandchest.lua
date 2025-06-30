-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/sopentowerislandchest.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SOpenTowerIslandChest = dataclass("SOpenTowerIslandChest", require("framework.net.protocol"))
SOpenTowerIslandChest.ProtocolType = 1986
SOpenTowerIslandChest.MaxSize = 65535
SOpenTowerIslandChest.islandID = 0
SOpenTowerIslandChest.resultType = 0
SOpenTowerIslandChest.effect = 0
SOpenTowerIslandChest.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SOpenTowerIslandChest
  ((SOpenTowerIslandChest.super).Ctor)(self, client)
  self.items = {}
end

SOpenTowerIslandChest.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.islandID) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.resultType) then
    return false
  end
  local length = (table.slen)(self.items)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.items)[i]):Marshal(buffer) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.effect) then
    return false
  end
  return true
end

SOpenTowerIslandChest.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC36: Confused about usage of register: R8 in 'UnsetPending'

    (self.items)[i] = ((require("protocols.bean.protocol.item.beans.iteminfo")).Create)()
    if not ((self.items)[i]):Unmarshal(buffer) then
      return false
    end
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SOpenTowerIslandChest

