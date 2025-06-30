-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/ssevendaypopgift.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SSevenDayPopGIft = dataclass("SSevenDayPopGIft", require("framework.net.protocol"))
SSevenDayPopGIft.ProtocolType = 2743
SSevenDayPopGIft.MaxSize = 65535
SSevenDayPopGIft.pop = 0
SSevenDayPopGIft.hasBought = 0
SSevenDayPopGIft.leftTime = 0
SSevenDayPopGIft.goodId = 0
SSevenDayPopGIft.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SSevenDayPopGIft
  ((SSevenDayPopGIft.super).Ctor)(self, client)
  self.rewards = {}
end

SSevenDayPopGIft.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.pop) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.hasBought) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.rewards)) then
    return false
  end
  for key,value in pairs(self.rewards) do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC34) then
      return false
    end
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC34) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.leftTime) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.goodId) then
    return false
  end
  return true
end

SSevenDayPopGIft.Unmarshal = function(self, buffer)
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
    -- DECOMPILER ERROR at PC45: Overwrote pending register: R5 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC51: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (self.rewards)[key] = value
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SSevenDayPopGIft

