local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CRecoverBlackList = dataclass("CRecoverBlackList", require("framework.net.protocol"))
CRecoverBlackList.ProtocolType = 1127
CRecoverBlackList.MaxSize = 65535
CRecoverBlackList.userId = 0

function CRecoverBlackList:Ctor(client)
  CRecoverBlackList.super.Ctor(self, client)
end

function CRecoverBlackList:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.userId) then
    return false
  end
  return true
end

function CRecoverBlackList:Unmarshal(buffer)
  local ret = true
  ret, self.userId = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CRecoverBlackList
