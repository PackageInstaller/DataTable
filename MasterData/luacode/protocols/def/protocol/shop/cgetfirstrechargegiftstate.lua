local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CGetFirstRechargeGiftState = dataclass("CGetFirstRechargeGiftState", require("framework.net.protocol"))
CGetFirstRechargeGiftState.ProtocolType = 3629
CGetFirstRechargeGiftState.MaxSize = 65535

function CGetFirstRechargeGiftState:Ctor(client)
  CGetFirstRechargeGiftState.super.Ctor(self, client)
end

function CGetFirstRechargeGiftState:Marshal(buffer)
  return true
end

function CGetFirstRechargeGiftState:Unmarshal(buffer)
  local ret = true
  return ret
end

return CGetFirstRechargeGiftState
