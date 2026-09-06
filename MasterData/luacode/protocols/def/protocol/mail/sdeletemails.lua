local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SDeleteMails = dataclass("SDeleteMails", require("framework.net.protocol"))
SDeleteMails.ProtocolType = 1410
SDeleteMails.MaxSize = 65535

function SDeleteMails:Ctor(client)
  SDeleteMails.super.Ctor(self, client)
  self.uniqueIds = {}
end

function SDeleteMails:Marshal(buffer)
  local length = table.slen(self.uniqueIds)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.uniqueIds[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SDeleteMails:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.uniqueIds[i] = require("protocols.bean.protocol.mail.operateresult").Create()
    if not self.uniqueIds[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SDeleteMails
