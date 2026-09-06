local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SCheckChallengeRecord = dataclass("SCheckChallengeRecord", require("framework.net.protocol"))
SCheckChallengeRecord.ProtocolType = 2482
SCheckChallengeRecord.MaxSize = 65535
SCheckChallengeRecord.battleType = 0
SCheckChallengeRecord.HIGHEST = 0
SCheckChallengeRecord.LATEST = 1

function SCheckChallengeRecord:Ctor(client)
  SCheckChallengeRecord.super.Ctor(self, client)
  self.record = {}
end

function SCheckChallengeRecord:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.battleType) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.record)) then
    return false
  end
  for key, value in pairs(self.record) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not value:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SCheckChallengeRecord:Unmarshal(buffer)
  local ret = true
  ret, self.battleType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length, key, value = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    key, value = nil, nil
    ret, key = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
    value = require("protocols.bean.protocol.activity.challengerecord").Create()
    if not value:Unmarshal(buffer) then
      return false
    end
    self.record[key] = value
  end
  return ret
end

return SCheckChallengeRecord
