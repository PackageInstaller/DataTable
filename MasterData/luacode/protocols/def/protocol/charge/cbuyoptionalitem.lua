local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CBuyOptionalItem = dataclass("CBuyOptionalItem", require("framework.net.protocol"))
CBuyOptionalItem.ProtocolType = 3912
CBuyOptionalItem.MaxSize = 65535
CBuyOptionalItem.WaitProtocol = "protocol.notify.scancelloading"
CBuyOptionalItem.goodId = 0

function CBuyOptionalItem:Ctor(client)
  CBuyOptionalItem.super.Ctor(self, client)
  self.option = {}
end

function CBuyOptionalItem:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.goodId) then
    return false
  end
  local length = table.slen(self.option)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.option[i]) then
      return false
    end
  end
  return true
end

function CBuyOptionalItem:Unmarshal(buffer)
  local ret = true
  ret, self.goodId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.option[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return CBuyOptionalItem
