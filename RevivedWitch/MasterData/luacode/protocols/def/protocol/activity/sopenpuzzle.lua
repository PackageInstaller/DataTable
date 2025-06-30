-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/sopenpuzzle.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SOpenPuzzle = dataclass("SOpenPuzzle", require("framework.net.protocol"))
SOpenPuzzle.ProtocolType = 2494
SOpenPuzzle.MaxSize = 65535
SOpenPuzzle.actId = 0
SOpenPuzzle.deadLine = 0
SOpenPuzzle.leftTime = 0
SOpenPuzzle.puzzleNum = 0
SOpenPuzzle.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SOpenPuzzle
  ((SOpenPuzzle.super).Ctor)(self, client)
  self.puzzleInfo = {}
  self.progressReward = {}
end

SOpenPuzzle.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.actId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.deadLine) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.leftTime) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.puzzleInfo)) then
    return false
  end
  for key,value in pairs(self.puzzleInfo) do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC42) then
      return false
    end
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC42) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.puzzleNum) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.progressReward)) then
    return false
  end
  for key,value in pairs(self.progressReward) do
    -- DECOMPILER ERROR at PC82: Overwrote pending register: R9 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC42) then
      return false
    end
    -- DECOMPILER ERROR at PC90: Overwrote pending register: R9 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC42) then
      return false
    end
  end
  return true
end

SOpenPuzzle.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
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
    -- DECOMPILER ERROR at PC53: Overwrote pending register: R5 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC59: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (self.puzzleInfo)[key] = value
  end
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
    -- DECOMPILER ERROR at PC97: Overwrote pending register: R8 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC103: Confused about usage of register: R13 in 'UnsetPending'

    ;
    (self.progressReward)[key] = value
  end
  return ret
end

return SOpenPuzzle

