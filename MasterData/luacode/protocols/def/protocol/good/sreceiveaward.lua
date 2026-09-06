local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SReceiveAward = dataclass("SReceiveAward", require("framework.net.protocol"))
SReceiveAward.ProtocolType = 3408
SReceiveAward.MaxSize = 65535
SReceiveAward.roleId = 0
SReceiveAward.level = 0

function SReceiveAward:Ctor(client)
  SReceiveAward.super.Ctor(self, client)
end

function SReceiveAward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.level) then
    return false
  end
  return true
end

function SReceiveAward:Unmarshal(buffer)
  local ret = true
  ret, self.roleId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.level = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SReceiveAward
