-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/bean/protocol/battle/dungeonworld.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local DungeonWorld = dataclass("DungeonWorld")
DungeonWorld.curZone = 0
DungeonWorld.clearZones = 0
DungeonWorld.totalZones = 0
DungeonWorld.isReceived = 0
DungeonWorld.Ctor = function(self)
  -- function num : 0_0
  self.zone = {}
end

DungeonWorld.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.curZone) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.clearZones) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.totalZones) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt16)(buffer, self.isReceived) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.zone)) then
    return false
  end
  for key,value in pairs(self.zone) do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC50) then
      return false
    end
    if not value:Marshal(R9_PC50) then
      return false
    end
  end
  return true
end

DungeonWorld.Unmarshal = function(self, buffer)
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
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt16)(buffer)
  if not ret then
    return ret
  end
  local length, key, value = 0, nil, nil
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    key = nil
    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC63: Overwrote pending register: R5 in 'AssignReg'

    if not value:Unmarshal(buffer) then
      return false
    end
    -- DECOMPILER ERROR at PC72: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (self.zone)[key] = value
  end
  return ret
end

return DungeonWorld

