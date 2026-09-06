local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SRefreshScore = dataclass("SRefreshScore", require("framework.net.protocol"))
SRefreshScore.ProtocolType = 2537
SRefreshScore.MaxSize = 65535

function SRefreshScore:Ctor(client)
  SRefreshScore.super.Ctor(self, client)
  self.scoreRewards = {}
end

function SRefreshScore:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.scoreRewards)) then
    return false
  end
  for key, value in pairs(self.scoreRewards) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not value:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SRefreshScore:Unmarshal(buffer)
  local ret = true
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
    value = require("protocols.bean.protocol.activity.scorereward").Create()
    if not value:Unmarshal(buffer) then
      return false
    end
    self.scoreRewards[key] = value
  end
  return ret
end

return SRefreshScore
