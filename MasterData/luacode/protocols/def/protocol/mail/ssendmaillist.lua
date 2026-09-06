local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SSendMailList = dataclass("SSendMailList", require("framework.net.protocol"))
SSendMailList.ProtocolType = 1402
SSendMailList.MaxSize = 65535
SSendMailList.maxNum = 0

function SSendMailList:Ctor(client)
  SSendMailList.super.Ctor(self, client)
  self.mails = {}
end

function SSendMailList:Marshal(buffer)
  local length = table.slen(self.mails)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.mails[i]:Marshal(buffer) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.maxNum) then
    return false
  end
  return true
end

function SSendMailList:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.mails[i] = require("protocols.bean.protocol.mail.mail").Create()
    if not self.mails[i]:Unmarshal(buffer) then
      return false
    end
  end
  ret, self.maxNum = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SSendMailList
