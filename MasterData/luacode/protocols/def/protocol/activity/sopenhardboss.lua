local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SOpenHardBoss = dataclass("SOpenHardBoss", require("framework.net.protocol"))
SOpenHardBoss.ProtocolType = 2541
SOpenHardBoss.MaxSize = 65535
SOpenHardBoss.leftNum = 0

function SOpenHardBoss:Ctor(client)
  SOpenHardBoss.super.Ctor(self, client)
end

function SOpenHardBoss:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.leftNum) then
    return false
  end
  return true
end

function SOpenHardBoss:Unmarshal(buffer)
  local ret = true
  ret, self.leftNum = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SOpenHardBoss
