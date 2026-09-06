local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SSpringRedPacketActivity = dataclass("SSpringRedPacketActivity", require("framework.net.protocol"))
SSpringRedPacketActivity.ProtocolType = 2586
SSpringRedPacketActivity.MaxSize = 65535
SSpringRedPacketActivity.state = 0
SSpringRedPacketActivity.day = 0

function SSpringRedPacketActivity:Ctor(client)
  SSpringRedPacketActivity.super.Ctor(self, client)
  self.redPacketState = {}
end

function SSpringRedPacketActivity:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.state) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.redPacketState)) then
    return false
  end
  for key, value in pairs(self.redPacketState) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.day) then
    return false
  end
  return true
end

function SSpringRedPacketActivity:Unmarshal(buffer)
  local ret = true
  ret, self.state = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length, key, value = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    key, value = nil, nil
    ret, key = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
    ret, value = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
    self.redPacketState[key] = value
  end
  ret, self.day = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SSpringRedPacketActivity
