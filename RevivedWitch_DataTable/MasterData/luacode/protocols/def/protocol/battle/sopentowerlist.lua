-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/sopentowerlist.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SOpenTowerList = dataclass("SOpenTowerList", require("framework.net.protocol"))
SOpenTowerList.ProtocolType = 1978
SOpenTowerList.MaxSize = 65535
SOpenTowerList.chanceLeft = 0
SOpenTowerList.totalChance = 0
SOpenTowerList.challenging = 0
SOpenTowerList.challengingFloor = 0
SOpenTowerList.resetTimeLeft = 0
SOpenTowerList.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SOpenTowerList
  ((SOpenTowerList.super).Ctor)(self, client)
  self.towerUnlock = {}
end

SOpenTowerList.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.towerUnlock)) then
    return false
  end
  for key,value in pairs(self.towerUnlock) do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC18) then
      return false
    end
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC18) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.chanceLeft) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.totalChance) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.challenging) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.challengingFloor) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.resetTimeLeft) then
    return false
  end
  return true
end

SOpenTowerList.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
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
    -- DECOMPILER ERROR at PC29: Overwrote pending register: R5 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC35: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (self.towerUnlock)[key] = value
  end
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
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SOpenTowerList

