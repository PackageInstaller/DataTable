local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local Favor = dataclass("Favor")
Favor.favorLv = 0
Favor.favorExp = 0

function Favor:Ctor()
  self.favorAward = {}
end

function Favor:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt16(buffer, self.favorLv) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.favorExp) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.favorAward)) then
    return false
  end
  for key, value in pairs(self.favorAward) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not value:Marshal(buffer) then
      return false
    end
  end
  return true
end

function Favor:Unmarshal(buffer)
  local ret = true
  ret, self.favorLv = ProtocolBufferStaticFunctions.ReadInt16(buffer)
  if not ret then
    return ret
  end
  ret, self.favorExp = ProtocolBufferStaticFunctions.ReadInt64(buffer)
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
    value = require("protocols.bean.protocol.login.favorawardinfo").Create()
    if not value:Unmarshal(buffer) then
      return false
    end
    self.favorAward[key] = value
  end
  return ret
end

return Favor
