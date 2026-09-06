local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SWorldChatSwitch = dataclass("SWorldChatSwitch", require("framework.net.protocol"))
SWorldChatSwitch.ProtocolType = 1170
SWorldChatSwitch.MaxSize = 65535
SWorldChatSwitch.state = 0

function SWorldChatSwitch:Ctor(client)
  SWorldChatSwitch.super.Ctor(self, client)
end

function SWorldChatSwitch:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.state) then
    return false
  end
  return true
end

function SWorldChatSwitch:Unmarshal(buffer)
  local ret = true
  ret, self.state = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SWorldChatSwitch
