local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CResetPositionTrap = dataclass("CResetPositionTrap", require("framework.net.protocol"))
CResetPositionTrap.ProtocolType = 4101
CResetPositionTrap.MaxSize = 65535
CResetPositionTrap.trapGroupId = 0
CResetPositionTrap.status = 0

function CResetPositionTrap:Ctor(client)
  CResetPositionTrap.super.Ctor(self, client)
end

function CResetPositionTrap:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.trapGroupId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.status) then
    return false
  end
  return true
end

function CResetPositionTrap:Unmarshal(buffer)
  local ret = true
  ret, self.trapGroupId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.status = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CResetPositionTrap
