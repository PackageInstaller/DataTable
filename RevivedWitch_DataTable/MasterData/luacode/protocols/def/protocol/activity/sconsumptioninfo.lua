-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/sconsumptioninfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SConsumptionInfo = dataclass("SConsumptionInfo", require("framework.net.protocol"))
SConsumptionInfo.ProtocolType = 2732
SConsumptionInfo.MaxSize = 65535
SConsumptionInfo.activityId = 0
SConsumptionInfo.consumption = 0
SConsumptionInfo.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SConsumptionInfo
  ((SConsumptionInfo.super).Ctor)(self, client)
  self.awardStatus = {}
end

SConsumptionInfo.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.activityId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.consumption) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.awardStatus)) then
    return false
  end
  for key,value in pairs(self.awardStatus) do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC34) then
      return false
    end
    if not value:Marshal(R9_PC34) then
      return false
    end
  end
  return true
end

SConsumptionInfo.Unmarshal = function(self, buffer)
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
    -- DECOMPILER ERROR at PC47: Overwrote pending register: R5 in 'AssignReg'

    if not value:Unmarshal(buffer) then
      return false
    end
    -- DECOMPILER ERROR at PC56: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (self.awardStatus)[key] = value
  end
  return ret
end

return SConsumptionInfo

