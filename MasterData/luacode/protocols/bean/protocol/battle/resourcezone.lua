local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local ResourceZone = dataclass("ResourceZone")
ResourceZone.status = 0
ResourceZone.starttime = ""
ResourceZone.endTime = 0
ResourceZone.curStage = 0
ResourceZone.UNSTART = 0
ResourceZone.UNCLEAR = 1
ResourceZone.CLEAR = 2

function ResourceZone:Ctor()
  self.passes = {}
end

function ResourceZone:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.status) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.starttime) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.endTime) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.passes)) then
    return false
  end
  for key, value in pairs(self.passes) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not value:Marshal(buffer) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.curStage) then
    return false
  end
  return true
end

function ResourceZone:Unmarshal(buffer)
  local ret = true
  ret, self.status = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.starttime = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  ret, self.endTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
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
    value = require("protocols.bean.protocol.battle.resourcepass").Create()
    if not value:Unmarshal(buffer) then
      return false
    end
    self.passes[key] = value
  end
  ret, self.curStage = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return ResourceZone
