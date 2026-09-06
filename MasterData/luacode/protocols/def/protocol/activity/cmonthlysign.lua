local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CMonthlySign = dataclass("CMonthlySign", require("framework.net.protocol"))
CMonthlySign.ProtocolType = 2678
CMonthlySign.MaxSize = 65535
CMonthlySign.dayId = 0

function CMonthlySign:Ctor(client)
  CMonthlySign.super.Ctor(self, client)
end

function CMonthlySign:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.dayId) then
    return false
  end
  return true
end

function CMonthlySign:Unmarshal(buffer)
  local ret = true
  ret, self.dayId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CMonthlySign
