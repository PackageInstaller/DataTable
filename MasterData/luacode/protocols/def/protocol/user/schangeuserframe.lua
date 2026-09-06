local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SChangeUserFrame = dataclass("SChangeUserFrame", require("framework.net.protocol"))
SChangeUserFrame.ProtocolType = 2227
SChangeUserFrame.MaxSize = 65535
SChangeUserFrame.frameId = 0

function SChangeUserFrame:Ctor(client)
  SChangeUserFrame.super.Ctor(self, client)
end

function SChangeUserFrame:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.frameId) then
    return false
  end
  return true
end

function SChangeUserFrame:Unmarshal(buffer)
  local ret = true
  ret, self.frameId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SChangeUserFrame
