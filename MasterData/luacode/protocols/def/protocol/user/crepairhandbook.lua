local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CRepairHandbook = dataclass("CRepairHandbook", require("framework.net.protocol"))
CRepairHandbook.ProtocolType = 2277
CRepairHandbook.MaxSize = 65535
CRepairHandbook.id = 0

function CRepairHandbook:Ctor(client)
  CRepairHandbook.super.Ctor(self, client)
end

function CRepairHandbook:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  return true
end

function CRepairHandbook:Unmarshal(buffer)
  local ret = true
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CRepairHandbook
