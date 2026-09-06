local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CFetchInvestAward = dataclass("CFetchInvestAward", require("framework.net.protocol"))
CFetchInvestAward.ProtocolType = 2661
CFetchInvestAward.MaxSize = 65535

function CFetchInvestAward:Ctor(client)
  CFetchInvestAward.super.Ctor(self, client)
end

function CFetchInvestAward:Marshal(buffer)
  return true
end

function CFetchInvestAward:Unmarshal(buffer)
  local ret = true
  return ret
end

return CFetchInvestAward
