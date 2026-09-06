local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CBlockWorldMsg = dataclass("CBlockWorldMsg", require("framework.net.protocol"))
CBlockWorldMsg.ProtocolType = 1168
CBlockWorldMsg.MaxSize = 65535
CBlockWorldMsg.userId = 0

function CBlockWorldMsg:Ctor(client)
  CBlockWorldMsg.super.Ctor(self, client)
end

function CBlockWorldMsg:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.userId) then
    return false
  end
  return true
end

function CBlockWorldMsg:Unmarshal(buffer)
  local ret = true
  ret, self.userId = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CBlockWorldMsg
