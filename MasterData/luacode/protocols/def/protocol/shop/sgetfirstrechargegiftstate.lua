local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SGetFirstRechargeGiftState = dataclass("SGetFirstRechargeGiftState", require("framework.net.protocol"))
SGetFirstRechargeGiftState.ProtocolType = 3630
SGetFirstRechargeGiftState.MaxSize = 65535
SGetFirstRechargeGiftState.statue = 0

function SGetFirstRechargeGiftState:Ctor(client)
  SGetFirstRechargeGiftState.super.Ctor(self, client)
  self.giftsState = {}
end

function SGetFirstRechargeGiftState:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.statue) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.giftsState)) then
    return false
  end
  for key, value in pairs(self.giftsState) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  return true
end

function SGetFirstRechargeGiftState:Unmarshal(buffer)
  local ret = true
  ret, self.statue = ProtocolBufferStaticFunctions.ReadInt32(buffer)
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
    self.giftsState[key] = value
  end
  return ret
end

return SGetFirstRechargeGiftState
