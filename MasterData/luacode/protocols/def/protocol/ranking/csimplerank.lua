local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CSimpleRank = dataclass("CSimpleRank", require("framework.net.protocol"))
CSimpleRank.ProtocolType = 3517
CSimpleRank.MaxSize = 65535
CSimpleRank.rankType = 0
CSimpleRank.rankId = 0

function CSimpleRank:Ctor(client)
  CSimpleRank.super.Ctor(self, client)
end

function CSimpleRank:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.rankType) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.rankId) then
    return false
  end
  return true
end

function CSimpleRank:Unmarshal(buffer)
  local ret = true
  ret, self.rankType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.rankId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CSimpleRank
