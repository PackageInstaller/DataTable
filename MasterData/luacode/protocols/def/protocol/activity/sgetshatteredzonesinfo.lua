local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SGetShatteredZonesInfo = dataclass("SGetShatteredZonesInfo", require("framework.net.protocol"))
SGetShatteredZonesInfo.ProtocolType = 2411
SGetShatteredZonesInfo.MaxSize = 65535
SGetShatteredZonesInfo.reloadInfoTime = 0

function SGetShatteredZonesInfo:Ctor(client)
  SGetShatteredZonesInfo.super.Ctor(self, client)
  self.zones = {}
  self.zonesClearReward = {}
end

function SGetShatteredZonesInfo:Marshal(buffer)
  local length = table.slen(self.zones)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.zones[i]:Marshal(buffer) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.zonesClearReward)) then
    return false
  end
  for key, value in pairs(self.zonesClearReward) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.reloadInfoTime) then
    return false
  end
  return true
end

function SGetShatteredZonesInfo:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.zones[i] = require("protocols.bean.protocol.activity.shatteredzone").Create()
    if not self.zones[i]:Unmarshal(buffer) then
      return false
    end
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
    self.zonesClearReward[key] = value
  end
  ret, self.reloadInfoTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SGetShatteredZonesInfo
