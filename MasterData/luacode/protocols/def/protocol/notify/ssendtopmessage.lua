local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SSendTopMessage = dataclass("SSendTopMessage", require("framework.net.protocol"))
SSendTopMessage.ProtocolType = 1802
SSendTopMessage.MaxSize = 65535
SSendTopMessage.messageId = 0

function SSendTopMessage:Ctor(client)
  SSendTopMessage.super.Ctor(self, client)
  self.parameters = {}
end

function SSendTopMessage:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.messageId) then
    return false
  end
  local length = table.slen(self.parameters)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.parameters[i]) then
      return false
    end
  end
  return true
end

function SSendTopMessage:Unmarshal(buffer)
  local ret = true
  ret, self.messageId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.parameters[i] = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return SSendTopMessage
