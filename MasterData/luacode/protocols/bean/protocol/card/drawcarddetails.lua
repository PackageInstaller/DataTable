local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local DrawCardDetails = dataclass("DrawCardDetails")

function DrawCardDetails:Ctor()
  self.upRoles = {}
  self.ssr = require("protocols.bean.protocol.card.rolepool").Create()
  self.sr = require("protocols.bean.protocol.card.rolepool").Create()
  self.r = require("protocols.bean.protocol.card.rolepool").Create()
  self.ur = require("protocols.bean.protocol.card.rolepool").Create()
end

function DrawCardDetails:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.upRoles)) then
    return false
  end
  for key, value in pairs(self.upRoles) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  if not self.ssr:Marshal(buffer) then
    return false
  end
  if not self.sr:Marshal(buffer) then
    return false
  end
  if not self.r:Marshal(buffer) then
    return false
  end
  if not self.ur:Marshal(buffer) then
    return false
  end
  return true
end

function DrawCardDetails:Unmarshal(buffer)
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
    self.upRoles[key] = value
  end
  if not self.ssr:Unmarshal(buffer) then
    return false
  end
  if not self.sr:Unmarshal(buffer) then
    return false
  end
  if not self.r:Unmarshal(buffer) then
    return false
  end
  if not self.ur:Unmarshal(buffer) then
    return false
  end
  return ret
end

return DrawCardDetails
