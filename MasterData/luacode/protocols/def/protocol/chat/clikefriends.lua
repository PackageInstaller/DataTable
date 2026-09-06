local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CLikeFriends = dataclass("CLikeFriends", require("framework.net.protocol"))
CLikeFriends.ProtocolType = 1138
CLikeFriends.MaxSize = 65535
CLikeFriends.userId = 0

function CLikeFriends:Ctor(client)
  CLikeFriends.super.Ctor(self, client)
end

function CLikeFriends:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.userId) then
    return false
  end
  return true
end

function CLikeFriends:Unmarshal(buffer)
  local ret = true
  ret, self.userId = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CLikeFriends
