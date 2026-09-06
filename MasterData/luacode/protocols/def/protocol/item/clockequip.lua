local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CLockEquip = dataclass("CLockEquip", require("framework.net.protocol"))
CLockEquip.ProtocolType = 1228
CLockEquip.MaxSize = 65535
CLockEquip.key = 0

function CLockEquip:Ctor(client)
  CLockEquip.super.Ctor(self, client)
end

function CLockEquip:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.key) then
    return false
  end
  return true
end

function CLockEquip:Unmarshal(buffer)
  local ret = true
  ret, self.key = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CLockEquip
