local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CFetchScoreAward = dataclass("CFetchScoreAward", require("framework.net.protocol"))
CFetchScoreAward.ProtocolType = 2651
CFetchScoreAward.MaxSize = 65535
CFetchScoreAward.node = 0

function CFetchScoreAward:Ctor(client)
  CFetchScoreAward.super.Ctor(self, client)
end

function CFetchScoreAward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.node) then
    return false
  end
  return true
end

function CFetchScoreAward:Unmarshal(buffer)
  local ret = true
  ret, self.node = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CFetchScoreAward
