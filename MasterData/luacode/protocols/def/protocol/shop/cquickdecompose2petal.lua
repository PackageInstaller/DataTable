local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CQuickDecompose2Petal = dataclass("CQuickDecompose2Petal", require("framework.net.protocol"))
CQuickDecompose2Petal.ProtocolType = 3621
CQuickDecompose2Petal.MaxSize = 65535

function CQuickDecompose2Petal:Ctor(client)
  CQuickDecompose2Petal.super.Ctor(self, client)
end

function CQuickDecompose2Petal:Marshal(buffer)
  return true
end

function CQuickDecompose2Petal:Unmarshal(buffer)
  local ret = true
  return ret
end

return CQuickDecompose2Petal
