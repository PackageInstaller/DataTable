local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CBuyInvestProgram = dataclass("CBuyInvestProgram", require("framework.net.protocol"))
CBuyInvestProgram.ProtocolType = 2660
CBuyInvestProgram.MaxSize = 65535
CBuyInvestProgram.channelId = 0

function CBuyInvestProgram:Ctor(client)
  CBuyInvestProgram.super.Ctor(self, client)
end

function CBuyInvestProgram:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.channelId) then
    return false
  end
  return true
end

function CBuyInvestProgram:Unmarshal(buffer)
  local ret = true
  ret, self.channelId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CBuyInvestProgram
