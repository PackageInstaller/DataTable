local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SCheckGainNumber = dataclass("SCheckGainNumber", require("framework.net.protocol"))
SCheckGainNumber.ProtocolType = 2607
SCheckGainNumber.MaxSize = 65535
SCheckGainNumber.number = 0

function SCheckGainNumber:Ctor(client)
  SCheckGainNumber.super.Ctor(self, client)
end

function SCheckGainNumber:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.number) then
    return false
  end
  return true
end

function SCheckGainNumber:Unmarshal(buffer)
  local ret = true
  ret, self.number = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SCheckGainNumber
