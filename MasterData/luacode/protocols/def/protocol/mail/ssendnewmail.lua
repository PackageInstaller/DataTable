local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SSendNewMail = dataclass("SSendNewMail", require("framework.net.protocol"))
SSendNewMail.ProtocolType = 1403
SSendNewMail.MaxSize = 65535

function SSendNewMail:Ctor(client)
  SSendNewMail.super.Ctor(self, client)
  self.mails = {}
end

function SSendNewMail:Marshal(buffer)
  local length = table.slen(self.mails)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.mails[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SSendNewMail:Unmarshal(buffer)
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
  return ret
end

return SSendNewMail
