local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CTotalSignAward = dataclass("CTotalSignAward", require("framework.net.protocol"))
CTotalSignAward.ProtocolType = 1072
CTotalSignAward.MaxSize = 65535

function CTotalSignAward:Ctor(client)
  CTotalSignAward.super.Ctor(self, client)
end

function CTotalSignAward:Marshal(buffer)
  return true
end

function CTotalSignAward:Unmarshal(buffer)
  local ret = true
  return ret
end

return CTotalSignAward
