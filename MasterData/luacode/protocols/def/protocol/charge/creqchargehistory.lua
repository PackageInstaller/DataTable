local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CReqChargeHistory = dataclass("CReqChargeHistory", require("framework.net.protocol"))
CReqChargeHistory.ProtocolType = 3903
CReqChargeHistory.MaxSize = 255
CReqChargeHistory.page = 0

function CReqChargeHistory:Ctor(client)
  CReqChargeHistory.super.Ctor(self, client)
end

function CReqChargeHistory:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.page) then
    return false
  end
  return true
end

function CReqChargeHistory:Unmarshal(buffer)
  local ret = true
  ret, self.page = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CReqChargeHistory
