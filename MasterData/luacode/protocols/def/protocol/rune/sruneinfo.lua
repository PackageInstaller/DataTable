local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SRuneInfo = dataclass("SRuneInfo", require("framework.net.protocol"))
SRuneInfo.ProtocolType = 3701
SRuneInfo.MaxSize = 65535
SRuneInfo.state = 0
SRuneInfo.dialogId = 0
SRuneInfo.RUNE = 1
SRuneInfo.NO_RUNE = 0

function SRuneInfo:Ctor(client)
  SRuneInfo.super.Ctor(self, client)
end

function SRuneInfo:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.state) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.dialogId) then
    return false
  end
  return true
end

function SRuneInfo:Unmarshal(buffer)
  local ret = true
  ret, self.state = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.dialogId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SRuneInfo
