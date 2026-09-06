local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CChooseSupportRole = dataclass("CChooseSupportRole", require("framework.net.protocol"))
CChooseSupportRole.ProtocolType = 1147
CChooseSupportRole.MaxSize = 65535
CChooseSupportRole.userId = 0

function CChooseSupportRole:Ctor(client)
  CChooseSupportRole.super.Ctor(self, client)
end

function CChooseSupportRole:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.userId) then
    return false
  end
  return true
end

function CChooseSupportRole:Unmarshal(buffer)
  local ret = true
  ret, self.userId = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CChooseSupportRole
