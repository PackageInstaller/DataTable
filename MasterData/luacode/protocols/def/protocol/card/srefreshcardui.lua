local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SRefreshCardUI = dataclass("SRefreshCardUI", require("framework.net.protocol"))
SRefreshCardUI.ProtocolType = 1502
SRefreshCardUI.MaxSize = 65535
SRefreshCardUI.drawTimes = 0
SRefreshCardUI.curDayTimes = 0

function SRefreshCardUI:Ctor(client)
  SRefreshCardUI.super.Ctor(self, client)
  self.pools = {}
end

function SRefreshCardUI:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.pools)) then
    return false
  end
  for key, value in pairs(self.pools) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not value:Marshal(buffer) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.drawTimes) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.curDayTimes) then
    return false
  end
  return true
end

function SRefreshCardUI:Unmarshal(buffer)
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
    value = require("protocols.bean.protocol.card.cardpool").Create()
    if not value:Unmarshal(buffer) then
      return false
    end
    self.pools[key] = value
  end
  ret, self.drawTimes = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.curDayTimes = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SRefreshCardUI
