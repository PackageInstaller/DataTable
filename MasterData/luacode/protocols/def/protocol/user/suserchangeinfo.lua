local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SUserChangeInfo = dataclass("SUserChangeInfo", require("framework.net.protocol"))
SUserChangeInfo.ProtocolType = 2268
SUserChangeInfo.MaxSize = 65535
SUserChangeInfo.PLAYER_EXP = 1

function SUserChangeInfo:Ctor(client)
  SUserChangeInfo.super.Ctor(self, client)
  self.changeInfo = {}
end

function SUserChangeInfo:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.changeInfo)) then
    return false
  end
  for key, value in pairs(self.changeInfo) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  return true
end

function SUserChangeInfo:Unmarshal(buffer)
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
    self.changeInfo[key] = value
  end
  return ret
end

return SUserChangeInfo
