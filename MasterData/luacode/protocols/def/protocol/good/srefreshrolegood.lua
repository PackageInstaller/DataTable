local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SRefreshRoleGood = dataclass("SRefreshRoleGood", require("framework.net.protocol"))
SRefreshRoleGood.ProtocolType = 3402
SRefreshRoleGood.MaxSize = 65535
SRefreshRoleGood.roleId = 0
SRefreshRoleGood.level = 0
SRefreshRoleGood.progress = 0

function SRefreshRoleGood:Ctor(client)
  SRefreshRoleGood.super.Ctor(self, client)
end

function SRefreshRoleGood:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.level) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.progress) then
    return false
  end
  return true
end

function SRefreshRoleGood:Unmarshal(buffer)
  local ret = true
  ret, self.roleId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.level = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.progress = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SRefreshRoleGood
