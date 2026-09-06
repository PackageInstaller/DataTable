local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SCommit = dataclass("SCommit", require("framework.net.protocol"))
SCommit.ProtocolType = 1954
SCommit.MaxSize = 65535
SCommit.kind = 0
SCommit.kindValue = 0

function SCommit:Ctor(client)
  SCommit.super.Ctor(self, client)
end

function SCommit:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.kind) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.kindValue) then
    return false
  end
  return true
end

function SCommit:Unmarshal(buffer)
  local ret = true
  ret, self.kind = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.kindValue = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SCommit
