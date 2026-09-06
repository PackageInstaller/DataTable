local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SSendFlowers = dataclass("SSendFlowers", require("framework.net.protocol"))
SSendFlowers.ProtocolType = 2763
SSendFlowers.MaxSize = 65535
SSendFlowers.targetRoleId = 0
SSendFlowers.roleName = ""
SSendFlowers.num = 0
SSendFlowers.msgId = 0

function SSendFlowers:Ctor(client)
  SSendFlowers.super.Ctor(self, client)
end

function SSendFlowers:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.targetRoleId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.roleName) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.num) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.msgId) then
    return false
  end
  return true
end

function SSendFlowers:Unmarshal(buffer)
  local ret = true
  ret, self.targetRoleId = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.roleName = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  ret, self.num = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.msgId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SSendFlowers
