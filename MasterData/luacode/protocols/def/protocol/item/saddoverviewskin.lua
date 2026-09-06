local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SAddOverviewSkin = dataclass("SAddOverviewSkin", require("framework.net.protocol"))
SAddOverviewSkin.ProtocolType = 1272
SAddOverviewSkin.MaxSize = 65535
SAddOverviewSkin.skinId = 0

function SAddOverviewSkin:Ctor(client)
  SAddOverviewSkin.super.Ctor(self, client)
end

function SAddOverviewSkin:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.skinId) then
    return false
  end
  return true
end

function SAddOverviewSkin:Unmarshal(buffer)
  local ret = true
  ret, self.skinId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SAddOverviewSkin
