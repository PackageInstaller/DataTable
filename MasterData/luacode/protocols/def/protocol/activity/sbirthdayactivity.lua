-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/sbirthdayactivity.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SBirthdayActivity = dataclass("SBirthdayActivity", require("framework.net.protocol"))
SBirthdayActivity.ProtocolType = 2542
SBirthdayActivity.MaxSize = 65535
SBirthdayActivity.state = 0
SBirthdayActivity.startDay = 0
SBirthdayActivity.endDay = 0
SBirthdayActivity.share = 0
SBirthdayActivity.wish = 0
SBirthdayActivity.maxMissionId = 0
SBirthdayActivity.extraItemLeftTime = 0
SBirthdayActivity.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SBirthdayActivity
  ((SBirthdayActivity.super).Ctor)(self, client)
  self.rewardRecord = {}
end

SBirthdayActivity.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.state) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.startDay) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.endDay) then
    return false
  end
  local length = (table.slen)(self.rewardRecord)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, (self.rewardRecord)[i]) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.share) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.wish) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.maxMissionId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.extraItemLeftTime) then
    return false
  end
  return true
end

SBirthdayActivity.Unmarshal = function(self, buffer)
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

return SBirthdayActivity

