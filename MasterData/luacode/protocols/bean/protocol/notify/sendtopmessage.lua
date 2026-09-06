local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SendTopMessage = dataclass("SendTopMessage")
SendTopMessage.messageId = 0

function SendTopMessage:Ctor()
  self.parameters = {}
end

function SendTopMessage:Marshal(buffer)
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

function SendTopMessage:Unmarshal(buffer)
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

return SendTopMessage
