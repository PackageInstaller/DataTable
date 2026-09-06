local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SAddGlowworm = dataclass("SAddGlowworm", require("framework.net.protocol"))
SAddGlowworm.ProtocolType = 2346
SAddGlowworm.MaxSize = 65535
SAddGlowworm.taskId = 0
SAddGlowworm.glowwormTotalNums = 0

function SAddGlowworm:Ctor(client)
  SAddGlowworm.super.Ctor(self, client)
end

function SAddGlowworm:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.taskId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.glowwormTotalNums) then
    return false
  end
  return true
end

function SAddGlowworm:Unmarshal(buffer)
  local ret = true
  ret, self.taskId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.glowwormTotalNums = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SAddGlowworm
