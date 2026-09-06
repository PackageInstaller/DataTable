local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CBuyMonthSignNum = dataclass("CBuyMonthSignNum", require("framework.net.protocol"))
CBuyMonthSignNum.ProtocolType = 1094
CBuyMonthSignNum.MaxSize = 65535
CBuyMonthSignNum.num = 0

function CBuyMonthSignNum:Ctor(client)
  CBuyMonthSignNum.super.Ctor(self, client)
end

function CBuyMonthSignNum:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.num) then
    return false
  end
  return true
end

function CBuyMonthSignNum:Unmarshal(buffer)
  local ret = true
  ret, self.num = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CBuyMonthSignNum
