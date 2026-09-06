local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CEvolution = dataclass("CEvolution", require("framework.net.protocol"))
CEvolution.ProtocolType = 1065
CEvolution.MaxSize = 65535
CEvolution.WaitProtocol = "protocol.notify.scancelloading"
CEvolution.roleId = 0
CEvolution.itemId = 0
CEvolution.itemNum = 0

function CEvolution:Ctor(client)
  CEvolution.super.Ctor(self, client)
end

function CEvolution:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.itemId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.itemNum) then
    return false
  end
  return true
end

function CEvolution:Unmarshal(buffer)
  local ret = true
  ret, self.roleId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.itemId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.itemNum = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CEvolution
