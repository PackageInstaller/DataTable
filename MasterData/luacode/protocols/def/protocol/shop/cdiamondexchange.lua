local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CDiamondExchange = dataclass("CDiamondExchange", require("framework.net.protocol"))
CDiamondExchange.ProtocolType = 3626
CDiamondExchange.MaxSize = 65535
CDiamondExchange.costItem = 0
CDiamondExchange.costItemSum = 0
CDiamondExchange.exchangeCurrencyType = 0
CDiamondExchange.exchangeCurrencySum = 0

function CDiamondExchange:Ctor(client)
  CDiamondExchange.super.Ctor(self, client)
end

function CDiamondExchange:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.costItem) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.costItemSum) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.exchangeCurrencyType) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.exchangeCurrencySum) then
    return false
  end
  return true
end

function CDiamondExchange:Unmarshal(buffer)
  local ret = true
  ret, self.costItem = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.costItemSum = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.exchangeCurrencyType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.exchangeCurrencySum = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CDiamondExchange
