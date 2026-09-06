local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CClickPumpkin = dataclass("CClickPumpkin", require("framework.net.protocol"))
CClickPumpkin.ProtocolType = 2517
CClickPumpkin.MaxSize = 65535
CClickPumpkin.pumpkinId = 0

function CClickPumpkin:Ctor(client)
  CClickPumpkin.super.Ctor(self, client)
end

function CClickPumpkin:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.pumpkinId) then
    return false
  end
  return true
end

function CClickPumpkin:Unmarshal(buffer)
  local ret = true
  ret, self.pumpkinId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CClickPumpkin
