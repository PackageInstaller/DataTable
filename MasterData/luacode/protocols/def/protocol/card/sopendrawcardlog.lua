local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SOpenDrawCardLog = dataclass("SOpenDrawCardLog", require("framework.net.protocol"))
SOpenDrawCardLog.ProtocolType = 1511
SOpenDrawCardLog.MaxSize = 65535

function SOpenDrawCardLog:Ctor(client)
  SOpenDrawCardLog.super.Ctor(self, client)
  self.log = {}
end

function SOpenDrawCardLog:Marshal(buffer)
  local length = table.slen(self.log)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.log[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SOpenDrawCardLog:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.log[i] = require("protocols.bean.protocol.card.drawcardinfo").Create()
    if not self.log[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SOpenDrawCardLog
