local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CExploreOption = dataclass("CExploreOption", require("framework.net.protocol"))
CExploreOption.ProtocolType = 1928
CExploreOption.MaxSize = 65535
CExploreOption.instanceid = 0
CExploreOption.id = 0

function CExploreOption:Ctor(client)
  CExploreOption.super.Ctor(self, client)
end

function CExploreOption:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.instanceid) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  return true
end

function CExploreOption:Unmarshal(buffer)
  local ret = true
  ret, self.instanceid = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CExploreOption
