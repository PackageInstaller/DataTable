local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CReceiveAward = dataclass("CReceiveAward", require("framework.net.protocol"))
CReceiveAward.ProtocolType = 3407
CReceiveAward.MaxSize = 65535
CReceiveAward.roleId = 0
CReceiveAward.level = 0

function CReceiveAward:Ctor(client)
  CReceiveAward.super.Ctor(self, client)
end

function CReceiveAward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.level) then
    return false
  end
  return true
end

function CReceiveAward:Unmarshal(buffer)
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

return CReceiveAward
