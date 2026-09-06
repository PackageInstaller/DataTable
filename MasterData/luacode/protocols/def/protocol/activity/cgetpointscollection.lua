local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CGetPointsCollection = dataclass("CGetPointsCollection", require("framework.net.protocol"))
CGetPointsCollection.ProtocolType = 2436
CGetPointsCollection.MaxSize = 65535
CGetPointsCollection.activityID = 0

function CGetPointsCollection:Ctor(client)
  CGetPointsCollection.super.Ctor(self, client)
end

function CGetPointsCollection:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.activityID) then
    return false
  end
  return true
end

function CGetPointsCollection:Unmarshal(buffer)
  local ret = true
  ret, self.activityID = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CGetPointsCollection
