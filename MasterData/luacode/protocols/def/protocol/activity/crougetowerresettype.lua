local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CRougeTowerResetType = dataclass("CRougeTowerResetType", require("framework.net.protocol"))
CRougeTowerResetType.ProtocolType = 2451
CRougeTowerResetType.MaxSize = 65535
CRougeTowerResetType.resetType = 0

function CRougeTowerResetType:Ctor(client)
  CRougeTowerResetType.super.Ctor(self, client)
end

function CRougeTowerResetType:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.resetType) then
    return false
  end
  return true
end

function CRougeTowerResetType:Unmarshal(buffer)
  local ret = true
  ret, self.resetType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CRougeTowerResetType
