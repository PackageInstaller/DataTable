local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SOpenFlowerList = dataclass("SOpenFlowerList", require("framework.net.protocol"))
SOpenFlowerList.ProtocolType = 2599
SOpenFlowerList.MaxSize = 65535

function SOpenFlowerList:Ctor(client)
  SOpenFlowerList.super.Ctor(self, client)
  self.flowerProgress = {}
end

function SOpenFlowerList:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.flowerProgress)) then
    return false
  end
  for key, value in pairs(self.flowerProgress) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not value:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SOpenFlowerList:Unmarshal(buffer)
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
    value = require("protocols.bean.protocol.activity.flowerprogress").Create()
    if not value:Unmarshal(buffer) then
      return false
    end
    self.flowerProgress[key] = value
  end
  return ret
end

return SOpenFlowerList
