local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SOpenChallengeMode = dataclass("SOpenChallengeMode", require("framework.net.protocol"))
SOpenChallengeMode.ProtocolType = 2716
SOpenChallengeMode.MaxSize = 65535
SOpenChallengeMode.totalScore = 0
SOpenChallengeMode.curScore = 0
SOpenChallengeMode.passTime = 0
SOpenChallengeMode.rank = 0

function SOpenChallengeMode:Ctor(client)
  SOpenChallengeMode.super.Ctor(self, client)
end

function SOpenChallengeMode:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.totalScore) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.curScore) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.passTime) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.rank) then
    return false
  end
  return true
end

function SOpenChallengeMode:Unmarshal(buffer)
  local ret = true
  ret, self.totalScore = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.curScore = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.passTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.rank = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SOpenChallengeMode
