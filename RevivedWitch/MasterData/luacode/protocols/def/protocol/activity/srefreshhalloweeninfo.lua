-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/srefreshhalloweeninfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SRefreshHalloweenInfo = dataclass("SRefreshHalloweenInfo", require("framework.net.protocol"))
SRefreshHalloweenInfo.ProtocolType = 2515
SRefreshHalloweenInfo.MaxSize = 65535
SRefreshHalloweenInfo.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SRefreshHalloweenInfo
  ((SRefreshHalloweenInfo.super).Ctor)(self, client)
  self.pumpkinReward = {}
  self.pumpkinPieReward = {}
end

SRefreshHalloweenInfo.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.pumpkinReward)) then
    return false
  end
  for key,value in pairs(self.pumpkinReward) do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC18) then
      return false
    end
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC18) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.pumpkinPieReward)) then
    return false
  end
  for key,value in pairs(self.pumpkinPieReward) do
    -- DECOMPILER ERROR at PC50: Overwrote pending register: R9 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC18) then
      return false
    end
    -- DECOMPILER ERROR at PC58: Overwrote pending register: R9 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC18) then
      return false
    end
  end
  return true
end

SRefreshHalloweenInfo.Unmarshal = function(self, buffer)
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
    (self.pumpkinReward)[key] = value
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
    -- DECOMPILER ERROR at PC65: Overwrote pending register: R8 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC71: Confused about usage of register: R13 in 'UnsetPending'

    ;
    (self.pumpkinPieReward)[key] = value
  end
  return ret
end

return SRefreshHalloweenInfo

