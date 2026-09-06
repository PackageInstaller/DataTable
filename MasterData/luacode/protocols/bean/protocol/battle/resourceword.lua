local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local ResourceWord = dataclass("ResourceWord")
ResourceWord.status = 0
ResourceWord.LOCK = 0
ResourceWord.UNSTART = 1
ResourceWord.UNCLEAR = 2
ResourceWord.CLEAR = 3

function ResourceWord:Ctor()
  self.zones = {}
end

function ResourceWord:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.status) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.zones)) then
    return false
  end
  for key, value in pairs(self.zones) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not value:Marshal(buffer) then
      return false
    end
  end
  return true
end

function ResourceWord:Unmarshal(buffer)
  local ret = true
  ret, self.status = ProtocolBufferStaticFunctions.ReadInt32(buffer)
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
    value = require("protocols.bean.protocol.battle.resourcezone").Create()
    if not value:Unmarshal(buffer) then
      return false
    end
    self.zones[key] = value
  end
  return ret
end

return ResourceWord
