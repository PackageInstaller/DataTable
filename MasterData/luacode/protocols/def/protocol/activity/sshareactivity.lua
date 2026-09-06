local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SShareActivity = dataclass("SShareActivity", require("framework.net.protocol"))
SShareActivity.ProtocolType = 2446
SShareActivity.MaxSize = 65535

function SShareActivity:Ctor(client)
  SShareActivity.super.Ctor(self, client)
  self.share = {}
end

function SShareActivity:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.share)) then
    return false
  end
  for key, value in pairs(self.share) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  return true
end

function SShareActivity:Unmarshal(buffer)
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
    self.share[key] = value
  end
  return ret
end

return SShareActivity
