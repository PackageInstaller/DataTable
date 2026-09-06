local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CReceiveTowerAward = dataclass("CReceiveTowerAward", require("framework.net.protocol"))
CReceiveTowerAward.ProtocolType = 2454
CReceiveTowerAward.MaxSize = 65535
CReceiveTowerAward.id = 0

function CReceiveTowerAward:Ctor(client)
  CReceiveTowerAward.super.Ctor(self, client)
end

function CReceiveTowerAward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  return true
end

function CReceiveTowerAward:Unmarshal(buffer)
  local ret = true
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CReceiveTowerAward
