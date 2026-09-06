local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SBookActivity = dataclass("SBookActivity", require("framework.net.protocol"))
SBookActivity.ProtocolType = 2428
SBookActivity.MaxSize = 65535
SBookActivity.isOpen = 0
SBookActivity.itemId = 0
SBookActivity.itemNum = 0

function SBookActivity:Ctor(client)
  SBookActivity.super.Ctor(self, client)
end

function SBookActivity:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteByte(buffer, self.isOpen) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.itemId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.itemNum) then
    return false
  end
  return true
end

function SBookActivity:Unmarshal(buffer)
  local ret = true
  ret, self.isOpen = ProtocolBufferStaticFunctions.ReadByte(buffer)
  if not ret then
    return ret
  end
  ret, self.itemId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.itemNum = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SBookActivity
