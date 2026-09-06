local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CSySynchronizationRefreshNums = dataclass("CSySynchronizationRefreshNums", require("framework.net.protocol"))
CSySynchronizationRefreshNums.ProtocolType = 2330
CSySynchronizationRefreshNums.MaxSize = 65535

function CSySynchronizationRefreshNums:Ctor(client)
  CSySynchronizationRefreshNums.super.Ctor(self, client)
end

function CSySynchronizationRefreshNums:Marshal(buffer)
  return true
end

function CSySynchronizationRefreshNums:Unmarshal(buffer)
  local ret = true
  return ret
end

return CSySynchronizationRefreshNums
