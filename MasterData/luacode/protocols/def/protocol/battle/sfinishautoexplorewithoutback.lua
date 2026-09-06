local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SFinishAutoExploreWithoutBack = dataclass("SFinishAutoExploreWithoutBack", require("framework.net.protocol"))
SFinishAutoExploreWithoutBack.ProtocolType = 4132
SFinishAutoExploreWithoutBack.MaxSize = 65535

function SFinishAutoExploreWithoutBack:Ctor(client)
  SFinishAutoExploreWithoutBack.super.Ctor(self, client)
  self.money = {}
  self.exploreawards = {}
end

function SFinishAutoExploreWithoutBack:Marshal(buffer)
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
  local length = table.slen(self.exploreawards)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.exploreawards[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SFinishAutoExploreWithoutBack:Unmarshal(buffer)
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
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.exploreawards[i] = require("protocols.bean.protocol.item.beans.iteminfo").Create()
    if not self.exploreawards[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SFinishAutoExploreWithoutBack
