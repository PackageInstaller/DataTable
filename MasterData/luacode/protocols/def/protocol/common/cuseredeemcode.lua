local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CUseRedeemCode = dataclass("CUseRedeemCode", require("framework.net.protocol"))
CUseRedeemCode.ProtocolType = 201
CUseRedeemCode.MaxSize = 10240
CUseRedeemCode.code = ""

function CUseRedeemCode:Ctor(client)
  CUseRedeemCode.super.Ctor(self, client)
end

function CUseRedeemCode:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.code) then
    return false
  end
  return true
end

function CUseRedeemCode:Unmarshal(buffer)
  local ret = true
  ret, self.code = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CUseRedeemCode
