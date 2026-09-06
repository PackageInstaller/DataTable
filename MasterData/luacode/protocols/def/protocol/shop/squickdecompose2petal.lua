local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SQuickDecompose2Petal = dataclass("SQuickDecompose2Petal", require("framework.net.protocol"))
SQuickDecompose2Petal.ProtocolType = 3622
SQuickDecompose2Petal.MaxSize = 65535
SQuickDecompose2Petal.result = 0

function SQuickDecompose2Petal:Ctor(client)
  SQuickDecompose2Petal.super.Ctor(self, client)
end

function SQuickDecompose2Petal:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.result) then
    return false
  end
  return true
end

function SQuickDecompose2Petal:Unmarshal(buffer)
  local ret = true
  ret, self.result = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SQuickDecompose2Petal
