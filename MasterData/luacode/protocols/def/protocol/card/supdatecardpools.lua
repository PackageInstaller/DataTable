local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SUpdateCardPools = dataclass("SUpdateCardPools", require("framework.net.protocol"))
SUpdateCardPools.ProtocolType = 1529
SUpdateCardPools.MaxSize = 65535

function SUpdateCardPools:Ctor(client)
  SUpdateCardPools.super.Ctor(self, client)
  self.pools = {}
end

function SUpdateCardPools:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.pools)) then
    return false
  end
  for key, value in pairs(self.pools) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not value:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SUpdateCardPools:Unmarshal(buffer)
  local ret = true
  local length, key, value = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    key, value = nil, nil
    ret, key = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
    value = require("protocols.bean.protocol.card.cardpool").Create()
    if not value:Unmarshal(buffer) then
      return false
    end
    self.pools[key] = value
  end
  return ret
end

return SUpdateCardPools
