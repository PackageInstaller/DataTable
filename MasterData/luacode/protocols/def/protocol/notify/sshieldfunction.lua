local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SShieldFunction = dataclass("SShieldFunction", require("framework.net.protocol"))
SShieldFunction.ProtocolType = 1806
SShieldFunction.MaxSize = 65535
SShieldFunction.CHANGENAME = 1
SShieldFunction.NAMING = 2
SShieldFunction.CHANGEINTRODUCE = 3
SShieldFunction.HOLDPARTY = 4
SShieldFunction.CHANGEPARTYNAME = 5
SShieldFunction.CHANGEPARTYINTRODUCE = 6
SShieldFunction.ROLECOMMENT = 7
SShieldFunction.SEND_MESSAGE = 8

function SShieldFunction:Ctor(client)
  SShieldFunction.super.Ctor(self, client)
  self.shieldFunction = {}
end

function SShieldFunction:Marshal(buffer)
  local length = table.slen(self.shieldFunction)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.shieldFunction[i]) then
      return false
    end
  end
  return true
end

function SShieldFunction:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.shieldFunction[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return SShieldFunction
