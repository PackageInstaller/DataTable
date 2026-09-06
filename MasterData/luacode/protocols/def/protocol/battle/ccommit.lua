local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CCommit = dataclass("CCommit", require("framework.net.protocol"))
CCommit.ProtocolType = 1943
CCommit.MaxSize = 65535
CCommit.kind = 0
CCommit.value = 0

function CCommit:Ctor(client)
  CCommit.super.Ctor(self, client)
end

function CCommit:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.kind) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.value) then
    return false
  end
  return true
end

function CCommit:Unmarshal(buffer)
  local ret = true
  ret, self.kind = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.value = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CCommit
