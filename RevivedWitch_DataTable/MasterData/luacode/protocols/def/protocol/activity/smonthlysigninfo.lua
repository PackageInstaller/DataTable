-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/smonthlysigninfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SMonthlySignInfo = dataclass("SMonthlySignInfo", require("framework.net.protocol"))
SMonthlySignInfo.ProtocolType = 2677
SMonthlySignInfo.MaxSize = 65535
SMonthlySignInfo.month = 0
SMonthlySignInfo.days = 0
SMonthlySignInfo.complementNum = 0
SMonthlySignInfo.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SMonthlySignInfo
  ((SMonthlySignInfo.super).Ctor)(self, client)
  self.receivedAward = {}
  self.monthDay = {}
end

SMonthlySignInfo.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.month) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.days) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.complementNum) then
    return false
  end
  local length = (table.slen)(self.receivedAward)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, (self.receivedAward)[i]) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.monthDay)) then
    return false
  end
  for key,value in pairs(self.monthDay) do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R10_PC68) then
      return false
    end
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R10_PC68) then
      return false
    end
  end
  return true
end

SMonthlySignInfo.Unmarshal = function(self, buffer)
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
    -- DECOMPILER ERROR at PC42: Confused about usage of register: R8 in 'UnsetPending'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
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
    -- DECOMPILER ERROR at PC76: Overwrote pending register: R6 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC82: Confused about usage of register: R11 in 'UnsetPending'

    ;
    (self.monthDay)[key] = value
  end
  return ret
end

return SMonthlySignInfo

