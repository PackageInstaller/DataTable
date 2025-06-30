-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/bean/protocol/activity/shatteredzone.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local ShatteredZone = dataclass("ShatteredZone")
ShatteredZone.zoneIndex = 0
ShatteredZone.thisWeekState = 0
ShatteredZone.Ctor = function(self)
  -- function num : 0_0
  self.normalRewards = {}
  self.firstPassRewards = {}
  self.LineupsRecords = {}
end

ShatteredZone.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.zoneIndex) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.normalRewards)) then
    return false
  end
  for key,value in pairs(self.normalRewards) do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC26) then
      return false
    end
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC26) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.firstPassRewards)) then
    return false
  end
  for key,value in pairs(self.firstPassRewards) do
    -- DECOMPILER ERROR at PC58: Overwrote pending register: R9 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC26) then
      return false
    end
    -- DECOMPILER ERROR at PC66: Overwrote pending register: R9 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC26) then
      return false
    end
  end
  local length = (table.slen)(self.LineupsRecords)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC93: Overwrote pending register: R9 in 'AssignReg'

    if not ((self.LineupsRecords)[i]):Marshal(R9_PC26) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.thisWeekState) then
    return false
  end
  return true
end

ShatteredZone.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
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
    -- DECOMPILER ERROR at PC37: Overwrote pending register: R5 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC43: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (self.normalRewards)[key] = value
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
    -- DECOMPILER ERROR at PC73: Overwrote pending register: R8 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC79: Confused about usage of register: R13 in 'UnsetPending'

    ;
    (self.firstPassRewards)[key] = value
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC100: Confused about usage of register: R14 in 'UnsetPending'

    (self.LineupsRecords)[i] = ((require("protocols.bean.protocol.activity.lineuprecord")).Create)()
    if not ((self.LineupsRecords)[i]):Unmarshal(buffer) then
      return false
    end
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return ShatteredZone

