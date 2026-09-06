local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local STotalSignAward = dataclass("STotalSignAward", require("framework.net.protocol"))
STotalSignAward.ProtocolType = 1073
STotalSignAward.MaxSize = 65535
STotalSignAward.day = 0
STotalSignAward.success = 0

function STotalSignAward:Ctor(client)
  STotalSignAward.super.Ctor(self, client)
  self.awards = {}
end

function STotalSignAward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.day) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.success) then
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

function STotalSignAward:Unmarshal(buffer)
  local ret = true
  ret, self.day = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.success = ProtocolBufferStaticFunctions.ReadInt32(buffer)
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

return STotalSignAward
