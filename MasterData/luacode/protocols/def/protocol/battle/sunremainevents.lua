local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SUnRemainEvents = dataclass("SUnRemainEvents", require("framework.net.protocol"))
SUnRemainEvents.ProtocolType = 1940
SUnRemainEvents.MaxSize = 65535

function SUnRemainEvents:Ctor(client)
  SUnRemainEvents.super.Ctor(self, client)
  self.events = {}
end

function SUnRemainEvents:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.events)) then
    return false
  end
  for key, value in pairs(self.events) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  return true
end

function SUnRemainEvents:Unmarshal(buffer)
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
    self.events[key] = value
  end
  return ret
end

return SUnRemainEvents
