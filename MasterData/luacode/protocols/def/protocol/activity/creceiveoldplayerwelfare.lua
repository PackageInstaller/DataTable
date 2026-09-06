local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CReceiveOldPlayerWelfare = dataclass("CReceiveOldPlayerWelfare", require("framework.net.protocol"))
CReceiveOldPlayerWelfare.ProtocolType = 2735
CReceiveOldPlayerWelfare.MaxSize = 65535
CReceiveOldPlayerWelfare.awardIndex = 0

function CReceiveOldPlayerWelfare:Ctor(client)
  CReceiveOldPlayerWelfare.super.Ctor(self, client)
end

function CReceiveOldPlayerWelfare:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.awardIndex) then
    return false
  end
  return true
end

function CReceiveOldPlayerWelfare:Unmarshal(buffer)
  local ret = true
  ret, self.awardIndex = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CReceiveOldPlayerWelfare
