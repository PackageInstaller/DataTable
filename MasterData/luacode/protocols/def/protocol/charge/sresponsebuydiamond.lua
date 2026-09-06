local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SResponseBuyDiamond = dataclass("SResponseBuyDiamond", require("framework.net.protocol"))
SResponseBuyDiamond.ProtocolType = 3902
SResponseBuyDiamond.MaxSize = 65535
SResponseBuyDiamond.gameorderid = ""
SResponseBuyDiamond.goodid = ""
SResponseBuyDiamond.goodname = ""
SResponseBuyDiamond.platType = 0
SResponseBuyDiamond.gearid = 0
SResponseBuyDiamond.extraparam = ""
SResponseBuyDiamond.price = 0
SResponseBuyDiamond.url = ""

function SResponseBuyDiamond:Ctor(client)
  SResponseBuyDiamond.super.Ctor(self, client)
end

function SResponseBuyDiamond:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.gameorderid) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.goodid) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.goodname) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.platType) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.gearid) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.extraparam) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.price) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.url) then
    return false
  end
  return true
end

function SResponseBuyDiamond:Unmarshal(buffer)
  local ret = true
  ret, self.gameorderid = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  ret, self.goodid = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  ret, self.goodname = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  ret, self.platType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.gearid = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.extraparam = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  ret, self.price = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.url = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SResponseBuyDiamond
