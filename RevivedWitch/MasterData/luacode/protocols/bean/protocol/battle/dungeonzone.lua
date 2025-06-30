-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/bean/protocol/battle/dungeonzone.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local DungeonZone = dataclass("DungeonZone")
DungeonZone.isReceived = 0
DungeonZone.autoExplore = 0
DungeonZone.openedBoxes = 0
DungeonZone.totalBoxes = 0
DungeonZone.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.checkPoint = ((require("protocols.bean.protocol.battle.dungeonpoint")).Create)()
  self.smallPoint = {}
end

DungeonZone.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt16)(buffer, self.isReceived) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt16)(buffer, self.autoExplore) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.openedBoxes) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.totalBoxes) then
    return false
  end
  if not (self.checkPoint):Marshal(buffer) then
    return false
  end
  local length = (table.slen)(self.smallPoint)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.smallPoint)[i]):Marshal(buffer) then
      return false
    end
  end
  return true
end

DungeonZone.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt16)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt16)(buffer)
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
  if not (self.checkPoint):Unmarshal(buffer) then
    return false
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC60: Confused about usage of register: R8 in 'UnsetPending'

    (self.smallPoint)[i] = ((require("protocols.bean.protocol.battle.dungeonpoint")).Create)()
    if not ((self.smallPoint)[i]):Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return DungeonZone

