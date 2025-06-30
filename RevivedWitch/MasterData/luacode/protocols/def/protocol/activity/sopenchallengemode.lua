-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/sopenchallengemode.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SOpenChallengeMode = dataclass("SOpenChallengeMode", require("framework.net.protocol"))
SOpenChallengeMode.ProtocolType = 2716
SOpenChallengeMode.MaxSize = 65535
SOpenChallengeMode.totalScore = 0
SOpenChallengeMode.curScore = 0
SOpenChallengeMode.passTime = 0
SOpenChallengeMode.rank = 0
SOpenChallengeMode.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SOpenChallengeMode
  ((SOpenChallengeMode.super).Ctor)(self, client)
end

SOpenChallengeMode.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.totalScore) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.curScore) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.passTime) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.rank) then
    return false
  end
  return true
end

SOpenChallengeMode.Unmarshal = function(self, buffer)
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

return SOpenChallengeMode

