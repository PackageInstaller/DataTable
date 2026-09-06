local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SFirstChargeOpenPanel = dataclass("SFirstChargeOpenPanel", require("framework.net.protocol"))
SFirstChargeOpenPanel.ProtocolType = 2767
SFirstChargeOpenPanel.MaxSize = 65535

function SFirstChargeOpenPanel:Ctor(client)
  SFirstChargeOpenPanel.super.Ctor(self, client)
  self.chargeDays = {}
  self.awards = {}
end

function SFirstChargeOpenPanel:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.chargeDays)) then
    return false
  end
  for key, value in pairs(self.chargeDays) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  local length = table.slen(self.awards)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.awards[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SFirstChargeOpenPanel:Unmarshal(buffer)
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
    self.chargeDays[key] = value
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.awards[i] = require("protocols.bean.protocol.activity.firstchargeaward").Create()
    if not self.awards[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SFirstChargeOpenPanel
