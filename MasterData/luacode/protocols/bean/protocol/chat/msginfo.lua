local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local MsgInfo = dataclass("MsgInfo")
MsgInfo.position = 0
MsgInfo.sendTime = 0
MsgInfo.msgType = 0
MsgInfo.msg = ""
MsgInfo.chat = 1
MsgInfo.notify = 2

function MsgInfo:Ctor()
  self.baseUserData = require("protocols.bean.protocol.chat.baseuserdata").Create()
  self.hyperlinks = {}
end

function MsgInfo:Marshal(buffer)
  if not self.baseUserData:Marshal(buffer) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.position) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.sendTime) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.msgType) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.msg) then
    return false
  end
  local length = table.slen(self.hyperlinks)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.hyperlinks[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function MsgInfo:Unmarshal(buffer)
  local ret = true
  if not self.baseUserData:Unmarshal(buffer) then
    return false
  end
  ret, self.position = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.sendTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.msgType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.msg = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.hyperlinks[i] = require("protocols.bean.protocol.chat.hyperlink").Create()
    if not self.hyperlinks[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return MsgInfo
