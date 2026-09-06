local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CAddGlowworm = dataclass("CAddGlowworm", require("framework.net.protocol"))
CAddGlowworm.ProtocolType = 2334
CAddGlowworm.MaxSize = 65535
CAddGlowworm.taskId = 0
CAddGlowworm.addNums = 0

function CAddGlowworm:Ctor(client)
  CAddGlowworm.super.Ctor(self, client)
end

function CAddGlowworm:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.taskId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.addNums) then
    return false
  end
  return true
end

function CAddGlowworm:Unmarshal(buffer)
  local ret = true
  ret, self.taskId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.addNums = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CAddGlowworm
