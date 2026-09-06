local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CGetReceivingRecords = dataclass("CGetReceivingRecords", require("framework.net.protocol"))
CGetReceivingRecords.ProtocolType = 1404
CGetReceivingRecords.MaxSize = 65535

function CGetReceivingRecords:Ctor(client)
  CGetReceivingRecords.super.Ctor(self, client)
end

function CGetReceivingRecords:Marshal(buffer)
  return true
end

function CGetReceivingRecords:Unmarshal(buffer)
  local ret = true
  return ret
end

return CGetReceivingRecords
