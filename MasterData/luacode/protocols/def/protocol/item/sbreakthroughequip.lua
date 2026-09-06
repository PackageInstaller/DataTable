local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SBreakThroughEquip = dataclass("SBreakThroughEquip", require("framework.net.protocol"))
SBreakThroughEquip.ProtocolType = 1242
SBreakThroughEquip.MaxSize = 65535
SBreakThroughEquip.equipKey = 0
SBreakThroughEquip.stage = 0

function SBreakThroughEquip:Ctor(client)
  SBreakThroughEquip.super.Ctor(self, client)
end

function SBreakThroughEquip:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.equipKey) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.stage) then
    return false
  end
  return true
end

function SBreakThroughEquip:Unmarshal(buffer)
  local ret = true
  ret, self.equipKey = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.stage = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SBreakThroughEquip
