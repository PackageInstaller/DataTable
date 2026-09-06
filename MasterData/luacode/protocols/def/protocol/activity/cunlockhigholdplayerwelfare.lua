local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CUnlockHighOldPlayerWelfare = dataclass("CUnlockHighOldPlayerWelfare", require("framework.net.protocol"))
CUnlockHighOldPlayerWelfare.ProtocolType = 2737
CUnlockHighOldPlayerWelfare.MaxSize = 65535

function CUnlockHighOldPlayerWelfare:Ctor(client)
  CUnlockHighOldPlayerWelfare.super.Ctor(self, client)
end

function CUnlockHighOldPlayerWelfare:Marshal(buffer)
  return true
end

function CUnlockHighOldPlayerWelfare:Unmarshal(buffer)
  local ret = true
  return ret
end

return CUnlockHighOldPlayerWelfare
