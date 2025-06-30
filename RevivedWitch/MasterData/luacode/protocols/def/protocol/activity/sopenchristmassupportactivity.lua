-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/sopenchristmassupportactivity.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SOpenChristmasSupportActivity = dataclass("SOpenChristmasSupportActivity", require("framework.net.protocol"))
SOpenChristmasSupportActivity.ProtocolType = 2563
SOpenChristmasSupportActivity.MaxSize = 65535
SOpenChristmasSupportActivity.state = 0
SOpenChristmasSupportActivity.score = 0
SOpenChristmasSupportActivity.activityLeftTime = 0
SOpenChristmasSupportActivity.supportLeftTime = 0
SOpenChristmasSupportActivity.canSupport = 0
SOpenChristmasSupportActivity.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SOpenChristmasSupportActivity
  ((SOpenChristmasSupportActivity.super).Ctor)(self, client)
  self.rewardIds = {}
end

SOpenChristmasSupportActivity.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.state) then
    return false
  end
  local length = (table.slen)(self.rewardIds)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, (self.rewardIds)[i]) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.score) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.activityLeftTime) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.supportLeftTime) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.canSupport) then
    return false
  end
  return true
end

SOpenChristmasSupportActivity.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
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
    -- DECOMPILER ERROR at PC26: Confused about usage of register: R8 in 'UnsetPending'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
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
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SOpenChristmasSupportActivity

