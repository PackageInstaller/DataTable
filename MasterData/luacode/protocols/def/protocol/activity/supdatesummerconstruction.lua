local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SUpdateSummerConstruction = dataclass("SUpdateSummerConstruction", require("framework.net.protocol"))
SUpdateSummerConstruction.ProtocolType = 2472
SUpdateSummerConstruction.MaxSize = 65535
SUpdateSummerConstruction.result = 0

function SUpdateSummerConstruction:Ctor(client)
  SUpdateSummerConstruction.super.Ctor(self, client)
  self.construction = require("protocols.bean.protocol.activity.summerconstruction").Create()
end

function SUpdateSummerConstruction:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.result) then
    return false
  end
  if not self.construction:Marshal(buffer) then
    return false
  end
  return true
end

function SUpdateSummerConstruction:Unmarshal(buffer)
  local ret = true
  ret, self.result = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  if not self.construction:Unmarshal(buffer) then
    return false
  end
  return ret
end

return SUpdateSummerConstruction
