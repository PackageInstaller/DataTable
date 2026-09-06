local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SGetDisplayRoomInfo = dataclass("SGetDisplayRoomInfo", require("framework.net.protocol"))
SGetDisplayRoomInfo.ProtocolType = 2506
SGetDisplayRoomInfo.MaxSize = 65535

function SGetDisplayRoomInfo:Ctor(client)
  SGetDisplayRoomInfo.super.Ctor(self, client)
  self.masks = {}
end

function SGetDisplayRoomInfo:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.masks)) then
    return false
  end
  for key, value in pairs(self.masks) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  return true
end

function SGetDisplayRoomInfo:Unmarshal(buffer)
  local ret = true
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
    self.masks[key] = value
  end
  return ret
end

return SGetDisplayRoomInfo
