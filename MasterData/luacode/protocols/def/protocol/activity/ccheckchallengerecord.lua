local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CCheckChallengeRecord = dataclass("CCheckChallengeRecord", require("framework.net.protocol"))
CCheckChallengeRecord.ProtocolType = 2481
CCheckChallengeRecord.MaxSize = 65535
CCheckChallengeRecord.battleType = 0
CCheckChallengeRecord.battleId = 0

function CCheckChallengeRecord:Ctor(client)
  CCheckChallengeRecord.super.Ctor(self, client)
end

function CCheckChallengeRecord:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.battleType) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.battleId) then
    return false
  end
  return true
end

function CCheckChallengeRecord:Unmarshal(buffer)
  local ret = true
  ret, self.battleType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.battleId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CCheckChallengeRecord
