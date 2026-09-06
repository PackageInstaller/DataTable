local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SRefreshPumpkin = dataclass("SRefreshPumpkin", require("framework.net.protocol"))
SRefreshPumpkin.ProtocolType = 2516
SRefreshPumpkin.MaxSize = 65535
SRefreshPumpkin.refreshTime = 0

function SRefreshPumpkin:Ctor(client)
  SRefreshPumpkin.super.Ctor(self, client)
  self.pumpkins = {}
end

function SRefreshPumpkin:Marshal(buffer)
  local length = table.slen(self.pumpkins)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.pumpkins[i]) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.refreshTime) then
    return false
  end
  return true
end

function SRefreshPumpkin:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.pumpkins[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  ret, self.refreshTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SRefreshPumpkin
