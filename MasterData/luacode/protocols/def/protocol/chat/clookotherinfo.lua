local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CLookOtherInfo = dataclass("CLookOtherInfo", require("framework.net.protocol"))
CLookOtherInfo.ProtocolType = 1136
CLookOtherInfo.MaxSize = 65535
CLookOtherInfo.userId = 0

function CLookOtherInfo:Ctor(client)
  CLookOtherInfo.super.Ctor(self, client)
end

function CLookOtherInfo:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.userId) then
    return false
  end
  return true
end

function CLookOtherInfo:Unmarshal(buffer)
  local ret = true
  ret, self.userId = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CLookOtherInfo
