local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CDecomposeItems = dataclass("CDecomposeItems", require("framework.net.protocol"))
CDecomposeItems.ProtocolType = 1206
CDecomposeItems.MaxSize = 65535
CDecomposeItems.itemId = 0
CDecomposeItems.ItemNum = 0

function CDecomposeItems:Ctor(client)
  CDecomposeItems.super.Ctor(self, client)
end

function CDecomposeItems:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.itemId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.ItemNum) then
    return false
  end
  return true
end

function CDecomposeItems:Unmarshal(buffer)
  local ret = true
  ret, self.itemId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.ItemNum = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CDecomposeItems
