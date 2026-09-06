local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CSendPartyMsg = dataclass("CSendPartyMsg", require("framework.net.protocol"))
CSendPartyMsg.ProtocolType = 1152
CSendPartyMsg.MaxSize = 65535
CSendPartyMsg.partyId = 0
CSendPartyMsg.msg = ""

function CSendPartyMsg:Ctor(client)
  CSendPartyMsg.super.Ctor(self, client)
  self.hyperlinks = {}
end

function CSendPartyMsg:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.partyId) then
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

function CSendPartyMsg:Unmarshal(buffer)
  local ret = true
  ret, self.partyId = ProtocolBufferStaticFunctions.ReadInt64(buffer)
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

return CSendPartyMsg
