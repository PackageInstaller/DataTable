local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local TotalSign = dataclass("TotalSign")
TotalSign.needReceive = 0
TotalSign.totalDay = 0
TotalSign.cumulativeDay = 0

function TotalSign:Ctor()
  self.awards = {}
end

function TotalSign:Marshal(buffer)
  local length = table.slen(self.awards)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.awards[i]:Marshal(buffer) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.needReceive) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.totalDay) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.cumulativeDay) then
    return false
  end
  return true
end

function TotalSign:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.awards[i] = require("protocols.bean.protocol.login.totalsignaward").Create()
    if not self.awards[i]:Unmarshal(buffer) then
      return false
    end
  end
  ret, self.needReceive = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.totalDay = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.cumulativeDay = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return TotalSign
