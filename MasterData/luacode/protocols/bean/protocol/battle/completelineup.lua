local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CompleteLineup = dataclass("CompleteLineup")
CompleteLineup.userId = 0
CompleteLineup.userName = ""
CompleteLineup.userLv = 0
CompleteLineup.avatarId = 0
CompleteLineup.frameId = 0

function CompleteLineup:Ctor()
  self.roles = {}
end

function CompleteLineup:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.userId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.userName) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.userLv) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.avatarId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.frameId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.roles)) then
    return false
  end
  for key, value in pairs(self.roles) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not value:Marshal(buffer) then
      return false
    end
  end
  return true
end

function CompleteLineup:Unmarshal(buffer)
  local ret = true
  ret, self.userId = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.userName = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  ret, self.userLv = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.avatarId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.frameId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
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
    value = require("protocols.bean.protocol.ranking.role").Create()
    if not value:Unmarshal(buffer) then
      return false
    end
    self.roles[key] = value
  end
  return ret
end

return CompleteLineup
