local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SReqCoinNum = dataclass("SReqCoinNum", require("framework.net.protocol"))
SReqCoinNum.ProtocolType = 1220
SReqCoinNum.MaxSize = 65535

function SReqCoinNum:Ctor(client)
  SReqCoinNum.super.Ctor(self, client)
  self.money = {}
end

function SReqCoinNum:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.money)) then
    return false
  end
  for key, value in pairs(self.money) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt64(buffer, value) then
      return false
    end
  end
  return true
end

function SReqCoinNum:Unmarshal(buffer)
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
    ret, value = ProtocolBufferStaticFunctions.ReadInt64(buffer)
    if not ret then
      return ret
    end
    self.money[key] = value
  end
  return ret
end

return SReqCoinNum
