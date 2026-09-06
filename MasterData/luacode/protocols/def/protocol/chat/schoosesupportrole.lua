local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SChooseSupportRole = dataclass("SChooseSupportRole", require("framework.net.protocol"))
SChooseSupportRole.ProtocolType = 1148
SChooseSupportRole.MaxSize = 65535
SChooseSupportRole.userId = 0

function SChooseSupportRole:Ctor(client)
  SChooseSupportRole.super.Ctor(self, client)
end

function SChooseSupportRole:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.userId) then
    return false
  end
  return true
end

function SChooseSupportRole:Unmarshal(buffer)
  local ret = true
  ret, self.userId = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SChooseSupportRole
