local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SShowObtainPanel = dataclass("SShowObtainPanel", require("framework.net.protocol"))
SShowObtainPanel.ProtocolType = 4102
SShowObtainPanel.MaxSize = 65535
SShowObtainPanel.showType = 0
SShowObtainPanel.AWARD = 1
SShowObtainPanel.RETURN = 2
SShowObtainPanel.RETURN_SHOW = 3

function SShowObtainPanel:Ctor(client)
  SShowObtainPanel.super.Ctor(self, client)
  self.awardCurrency = {}
  self.awardItems = {}
end

function SShowObtainPanel:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.awardCurrency)) then
    return false
  end
  for key, value in pairs(self.awardCurrency) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt64(buffer, value) then
      return false
    end
  end
  local length = table.slen(self.awardItems)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.awardItems[i]:Marshal(buffer) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteByte(buffer, self.showType) then
    return false
  end
  return true
end

function SShowObtainPanel:Unmarshal(buffer)
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
    self.awardCurrency[key] = value
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.awardItems[i] = require("protocols.bean.protocol.item.beans.iteminfo").Create()
    if not self.awardItems[i]:Unmarshal(buffer) then
      return false
    end
  end
  ret, self.showType = ProtocolBufferStaticFunctions.ReadByte(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SShowObtainPanel
