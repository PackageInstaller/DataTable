-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/cgetprogressreward.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CGetProgressReward = dataclass("CGetProgressReward", require("framework.net.protocol"))
CGetProgressReward.ProtocolType = 2497
CGetProgressReward.MaxSize = 65535
CGetProgressReward.activityId = 0
CGetProgressReward.boxId = 0
CGetProgressReward.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CGetProgressReward
  ((CGetProgressReward.super).Ctor)(self, client)
end

CGetProgressReward.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.activityId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.boxId) then
    return false
  end
  return true
end

CGetProgressReward.Unmarshal = function(self, buffer)
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
  return ret
end

return CGetProgressReward

