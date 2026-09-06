local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CLookCardBaseAttr = dataclass("CLookCardBaseAttr", require("framework.net.protocol"))
CLookCardBaseAttr.ProtocolType = 1527
CLookCardBaseAttr.MaxSize = 65535
CLookCardBaseAttr.roleId = 0
CLookCardBaseAttr.cfgId = 0

function CLookCardBaseAttr:Ctor(client)
  CLookCardBaseAttr.super.Ctor(self, client)
end

function CLookCardBaseAttr:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.cfgId) then
    return false
  end
  return true
end

function CLookCardBaseAttr:Unmarshal(buffer)
  local ret = true
  ret, self.roleId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.cfgId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CLookCardBaseAttr
