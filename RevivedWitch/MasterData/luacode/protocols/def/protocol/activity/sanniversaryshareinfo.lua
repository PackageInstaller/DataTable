-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/sanniversaryshareinfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SAnniversaryShareInfo = dataclass("SAnniversaryShareInfo", require("framework.net.protocol"))
SAnniversaryShareInfo.ProtocolType = 2693
SAnniversaryShareInfo.MaxSize = 65535
SAnniversaryShareInfo.leftTime = 0
SAnniversaryShareInfo.shareLeftTime = 0
SAnniversaryShareInfo.picture = 0
SAnniversaryShareInfo.totalShare = 0
SAnniversaryShareInfo.dailyShareAward = 0
SAnniversaryShareInfo.LOCKED = 0
SAnniversaryShareInfo.UNLOCKED = 1
SAnniversaryShareInfo.FETCHED = 2
SAnniversaryShareInfo.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SAnniversaryShareInfo
  ((SAnniversaryShareInfo.super).Ctor)(self, client)
  self.totShareAward = {}
end

SAnniversaryShareInfo.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.leftTime) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.shareLeftTime) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.picture) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.totalShare) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.totShareAward)) then
    return false
  end
  for key,value in pairs(self.totShareAward) do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC50) then
      return false
    end
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC50) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.dailyShareAward) then
    return false
  end
  return true
end

SAnniversaryShareInfo.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
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
    -- DECOMPILER ERROR at PC61: Overwrote pending register: R5 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC67: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (self.totShareAward)[key] = value
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SAnniversaryShareInfo

