-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/sshowarenaresult.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SShowArenaResult = dataclass("SShowArenaResult", require("framework.net.protocol"))
SShowArenaResult.ProtocolType = 4117
SShowArenaResult.MaxSize = 65535
SShowArenaResult.victory = 0
SShowArenaResult.arenaId = 0
SShowArenaResult.camp = 0
SShowArenaResult.totalNum = 0
SShowArenaResult.victoryNum = 0
SShowArenaResult.pithy = 0
SShowArenaResult.totalPithy = 0
SShowArenaResult.open = 0
SShowArenaResult.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SShowArenaResult
  ((SShowArenaResult.super).Ctor)(self, client)
  self.campsResult = {}
  self.reward = {}
end

SShowArenaResult.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.victory) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.arenaId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.camp) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.campsResult)) then
    return false
  end
  for key,value in pairs(self.campsResult) do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC42) then
      return false
    end
    if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, R9_PC42) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.totalNum) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.victoryNum) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.pithy) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.totalPithy) then
    return false
  end
  local length = (table.slen)(self.reward)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC108: Overwrote pending register: R9 in 'AssignReg'

    if not ((self.reward)[i]):Marshal(R9_PC42) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.open) then
    return false
  end
  return true
end

SShowArenaResult.Unmarshal = function(self, buffer)
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

    ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC59: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (self.campsResult)[key] = value
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
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
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC112: Confused about usage of register: R11 in 'UnsetPending'

    (self.reward)[i] = ((require("protocols.bean.protocol.item.beans.iteminfo")).Create)()
    if not ((self.reward)[i]):Unmarshal(buffer) then
      return false
    end
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SShowArenaResult

