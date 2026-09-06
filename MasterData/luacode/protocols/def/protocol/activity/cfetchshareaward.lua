local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CFetchShareAward = dataclass("CFetchShareAward", require("framework.net.protocol"))
CFetchShareAward.ProtocolType = 2695
CFetchShareAward.MaxSize = 65535
CFetchShareAward.awardId = 0

function CFetchShareAward:Ctor(client)
  CFetchShareAward.super.Ctor(self, client)
end

function CFetchShareAward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.awardId) then
    return false
  end
  return true
end

function CFetchShareAward:Unmarshal(buffer)
  local ret = true
  ret, self.awardId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CFetchShareAward
