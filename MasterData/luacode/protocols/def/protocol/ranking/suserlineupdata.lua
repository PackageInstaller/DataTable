local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SUserLineupData = dataclass("SUserLineupData", require("framework.net.protocol"))
SUserLineupData.ProtocolType = 3506
SUserLineupData.MaxSize = 65535
SUserLineupData.uniqueId = 0
SUserLineupData.rankType = 0
SUserLineupData.rankId = ""

function SUserLineupData:Ctor(client)
  SUserLineupData.super.Ctor(self, client)
  self.lineup = require("protocols.bean.protocol.ranking.lineup").Create()
end

function SUserLineupData:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.uniqueId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.rankType) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.rankId) then
    return false
  end
  if not self.lineup:Marshal(buffer) then
    return false
  end
  return true
end

function SUserLineupData:Unmarshal(buffer)
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
  if not self.lineup:Unmarshal(buffer) then
    return false
  end
  return ret
end

return SUserLineupData
