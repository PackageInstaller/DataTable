local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SUseBackInviteCode = dataclass("SUseBackInviteCode", require("framework.net.protocol"))
SUseBackInviteCode.ProtocolType = 2552
SUseBackInviteCode.MaxSize = 65535
SUseBackInviteCode.result = 0
SUseBackInviteCode.fail = 0
SUseBackInviteCode.success = 1

function SUseBackInviteCode:Ctor(client)
  SUseBackInviteCode.super.Ctor(self, client)
end

function SUseBackInviteCode:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.result) then
    return false
  end
  return true
end

function SUseBackInviteCode:Unmarshal(buffer)
  local ret = true
  ret, self.result = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SUseBackInviteCode
