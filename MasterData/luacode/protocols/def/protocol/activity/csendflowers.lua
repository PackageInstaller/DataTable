local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CSendFlowers = dataclass("CSendFlowers", require("framework.net.protocol"))
CSendFlowers.ProtocolType = 2600
CSendFlowers.MaxSize = 65535
CSendFlowers.rewardType = 0
CSendFlowers.num = 0
CSendFlowers.LEFT = 1
CSendFlowers.RIGTH = 2

function CSendFlowers:Ctor(client)
  CSendFlowers.super.Ctor(self, client)
end

function CSendFlowers:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.rewardType) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.num) then
    return false
  end
  return true
end

function CSendFlowers:Unmarshal(buffer)
  local ret = true
  ret, self.rewardType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.num = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CSendFlowers
