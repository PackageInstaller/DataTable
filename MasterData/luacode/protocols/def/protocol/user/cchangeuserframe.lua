local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CChangeUserFrame = dataclass("CChangeUserFrame", require("framework.net.protocol"))
CChangeUserFrame.ProtocolType = 2226
CChangeUserFrame.MaxSize = 65535
CChangeUserFrame.frameId = 0

function CChangeUserFrame:Ctor(client)
  CChangeUserFrame.super.Ctor(self, client)
end

function CChangeUserFrame:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.frameId) then
    return false
  end
  return true
end

function CChangeUserFrame:Unmarshal(buffer)
  local ret = true
  ret, self.frameId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CChangeUserFrame
