local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SMonthCardState = dataclass("SMonthCardState", require("framework.net.protocol"))
SMonthCardState.ProtocolType = 3601
SMonthCardState.MaxSize = 65535

function SMonthCardState:Ctor(client)
  SMonthCardState.super.Ctor(self, client)
  self.monthcards = {}
end

function SMonthCardState:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.monthcards)) then
    return false
  end
  for key, value in pairs(self.monthcards) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not value:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SMonthCardState:Unmarshal(buffer)
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
    value = require("protocols.bean.protocol.shop.monthcardinfo").Create()
    if not value:Unmarshal(buffer) then
      return false
    end
    self.monthcards[key] = value
  end
  return ret
end

return SMonthCardState
