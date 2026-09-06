local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SWeekActiveAward = dataclass("SWeekActiveAward", require("framework.net.protocol"))
SWeekActiveAward.ProtocolType = 1627
SWeekActiveAward.MaxSize = 65535
SWeekActiveAward.value = 0

function SWeekActiveAward:Ctor(client)
  SWeekActiveAward.super.Ctor(self, client)
  self.awards = {}
end

function SWeekActiveAward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.value) then
    return false
  end
  local length = table.slen(self.awards)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.awards[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SWeekActiveAward:Unmarshal(buffer)
  local ret = true
  ret, self.value = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.awards[i] = require("protocols.bean.protocol.item.beans.iteminfo").Create()
    if not self.awards[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SWeekActiveAward
