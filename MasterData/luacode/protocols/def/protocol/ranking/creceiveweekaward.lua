local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CReceiveWeekAward = dataclass("CReceiveWeekAward", require("framework.net.protocol"))
CReceiveWeekAward.ProtocolType = 3522
CReceiveWeekAward.MaxSize = 65535
CReceiveWeekAward.id = 0
CReceiveWeekAward.stageId = 0

function CReceiveWeekAward:Ctor(client)
  CReceiveWeekAward.super.Ctor(self, client)
end

function CReceiveWeekAward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.stageId) then
    return false
  end
  return true
end

function CReceiveWeekAward:Unmarshal(buffer)
  local ret = true
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.stageId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CReceiveWeekAward
