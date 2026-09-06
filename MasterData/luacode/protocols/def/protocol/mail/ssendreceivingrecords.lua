local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SSendReceivingRecords = dataclass("SSendReceivingRecords", require("framework.net.protocol"))
SSendReceivingRecords.ProtocolType = 1405
SSendReceivingRecords.MaxSize = 65535

function SSendReceivingRecords:Ctor(client)
  SSendReceivingRecords.super.Ctor(self, client)
  self.records = {}
end

function SSendReceivingRecords:Marshal(buffer)
  local length = table.slen(self.records)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.records[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SSendReceivingRecords:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.records[i] = require("protocols.bean.protocol.mail.receivingrecord").Create()
    if not self.records[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SSendReceivingRecords
