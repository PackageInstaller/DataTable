local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SOpenDoubleElevenActivity = dataclass("SOpenDoubleElevenActivity", require("framework.net.protocol"))
SOpenDoubleElevenActivity.ProtocolType = 2522
SOpenDoubleElevenActivity.MaxSize = 65535
SOpenDoubleElevenActivity.poolId = 0

function SOpenDoubleElevenActivity:Ctor(client)
  SOpenDoubleElevenActivity.super.Ctor(self, client)
  self.openCards = {}
end

function SOpenDoubleElevenActivity:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.poolId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.openCards)) then
    return false
  end
  for key, value in pairs(self.openCards) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not value:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SOpenDoubleElevenActivity:Unmarshal(buffer)
  local ret = true
  ret, self.poolId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
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
    value = require("protocols.bean.protocol.activity.unlockitem").Create()
    if not value:Unmarshal(buffer) then
      return false
    end
    self.openCards[key] = value
  end
  return ret
end

return SOpenDoubleElevenActivity
