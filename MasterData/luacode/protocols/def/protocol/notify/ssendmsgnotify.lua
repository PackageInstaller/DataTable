local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SSendMsgNotify = dataclass("SSendMsgNotify", require("framework.net.protocol"))
SSendMsgNotify.ProtocolType = 1801
SSendMsgNotify.MaxSize = 65535
SSendMsgNotify.msgId = 0
SSendMsgNotify.GM_MESSAGE_ID = 100106

function SSendMsgNotify:Ctor(client)
  SSendMsgNotify.super.Ctor(self, client)
  self.parameters = {}
end

function SSendMsgNotify:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.msgId) then
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

function SSendMsgNotify:Unmarshal(buffer)
  local ret = true
  ret, self.msgId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
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

return SSendMsgNotify
