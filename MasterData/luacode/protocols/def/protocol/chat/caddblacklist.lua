local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CAddBlackList = dataclass("CAddBlackList", require("framework.net.protocol"))
CAddBlackList.ProtocolType = 1126
CAddBlackList.MaxSize = 65535
CAddBlackList.userId = 0

function CAddBlackList:Ctor(client)
  CAddBlackList.super.Ctor(self, client)
end

function CAddBlackList:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.userId) then
    return false
  end
  return true
end

function CAddBlackList:Unmarshal(buffer)
  local ret = true
  ret, self.userId = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CAddBlackList
