local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CUserLineupData = dataclass("CUserLineupData", require("framework.net.protocol"))
CUserLineupData.ProtocolType = 3505
CUserLineupData.MaxSize = 65535
CUserLineupData.uniqueId = 0
CUserLineupData.rankType = 0
CUserLineupData.rankId = ""

function CUserLineupData:Ctor(client)
  CUserLineupData.super.Ctor(self, client)
end

function CUserLineupData:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.uniqueId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.rankType) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.rankId) then
    return false
  end
  return true
end

function CUserLineupData:Unmarshal(buffer)
  local ret = true
  ret, self.uniqueId = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.rankType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.rankId = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CUserLineupData
