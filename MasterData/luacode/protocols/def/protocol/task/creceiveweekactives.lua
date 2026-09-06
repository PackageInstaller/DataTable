local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CReceiveWeekActives = dataclass("CReceiveWeekActives", require("framework.net.protocol"))
CReceiveWeekActives.ProtocolType = 1626
CReceiveWeekActives.MaxSize = 65535
CReceiveWeekActives.value = 0

function CReceiveWeekActives:Ctor(client)
  CReceiveWeekActives.super.Ctor(self, client)
end

function CReceiveWeekActives:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.value) then
    return false
  end
  return true
end

function CReceiveWeekActives:Unmarshal(buffer)
  local ret = true
  ret, self.value = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CReceiveWeekActives
