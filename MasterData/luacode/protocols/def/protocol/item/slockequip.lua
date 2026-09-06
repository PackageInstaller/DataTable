local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SLockEquip = dataclass("SLockEquip", require("framework.net.protocol"))
SLockEquip.ProtocolType = 1229
SLockEquip.MaxSize = 65535
SLockEquip.key = 0
SLockEquip.lock = 0

function SLockEquip:Ctor(client)
  SLockEquip.super.Ctor(self, client)
end

function SLockEquip:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.key) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.lock) then
    return false
  end
  return true
end

function SLockEquip:Unmarshal(buffer)
  local ret = true
  ret, self.key = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.lock = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SLockEquip
