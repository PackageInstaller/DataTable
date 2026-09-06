local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local COperateMask = dataclass("COperateMask", require("framework.net.protocol"))
COperateMask.ProtocolType = 2507
COperateMask.MaxSize = 65535
COperateMask.mask = 0
COperateMask.operate = 0

function COperateMask:Ctor(client)
  COperateMask.super.Ctor(self, client)
end

function COperateMask:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.mask) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.operate) then
    return false
  end
  return true
end

function COperateMask:Unmarshal(buffer)
  local ret = true
  ret, self.mask = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.operate = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return COperateMask
