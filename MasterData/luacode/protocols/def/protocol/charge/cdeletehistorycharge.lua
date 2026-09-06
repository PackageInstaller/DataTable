local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CDeleteHistoryCharge = dataclass("CDeleteHistoryCharge", require("framework.net.protocol"))
CDeleteHistoryCharge.ProtocolType = 3905
CDeleteHistoryCharge.MaxSize = 255
CDeleteHistoryCharge.gameorderid = 0
CDeleteHistoryCharge.currentpage = 0

function CDeleteHistoryCharge:Ctor(client)
  CDeleteHistoryCharge.super.Ctor(self, client)
end

function CDeleteHistoryCharge:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.gameorderid) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.currentpage) then
    return false
  end
  return true
end

function CDeleteHistoryCharge:Unmarshal(buffer)
  local ret = true
  ret, self.gameorderid = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.currentpage = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CDeleteHistoryCharge
