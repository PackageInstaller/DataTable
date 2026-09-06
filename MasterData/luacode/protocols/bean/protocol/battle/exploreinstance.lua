local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local ExploreInstance = dataclass("ExploreInstance")
ExploreInstance.instanceid = 0
ExploreInstance.id = 0
ExploreInstance.state = 0

function ExploreInstance:Ctor()
end

function ExploreInstance:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.instanceid) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.state) then
    return false
  end
  return true
end

function ExploreInstance:Unmarshal(buffer)
  local ret = true
  ret, self.instanceid = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.state = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return ExploreInstance
