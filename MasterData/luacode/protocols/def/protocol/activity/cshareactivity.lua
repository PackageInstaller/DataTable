local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CShareActivity = dataclass("CShareActivity", require("framework.net.protocol"))
CShareActivity.ProtocolType = 2447
CShareActivity.MaxSize = 65535
CShareActivity.bannerId = 0

function CShareActivity:Ctor(client)
  CShareActivity.super.Ctor(self, client)
end

function CShareActivity:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.bannerId) then
    return false
  end
  return true
end

function CShareActivity:Unmarshal(buffer)
  local ret = true
  ret, self.bannerId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CShareActivity
