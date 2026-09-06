local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CFetchActivitySupply = dataclass("CFetchActivitySupply", require("framework.net.protocol"))
CFetchActivitySupply.ProtocolType = 2702
CFetchActivitySupply.MaxSize = 65535
CFetchActivitySupply.activityId = 0
CFetchActivitySupply.supply = 0

function CFetchActivitySupply:Ctor(client)
  CFetchActivitySupply.super.Ctor(self, client)
end

function CFetchActivitySupply:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.activityId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.supply) then
    return false
  end
  return true
end

function CFetchActivitySupply:Unmarshal(buffer)
  local ret = true
  ret, self.activityId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.supply = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CFetchActivitySupply
