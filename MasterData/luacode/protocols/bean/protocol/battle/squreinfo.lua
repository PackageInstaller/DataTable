local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SqureInfo = dataclass("SqureInfo")
SqureInfo.squreType = 0
SqureInfo.squreShow = 0
SqureInfo.eventID = ""
SqureInfo.rPos = 0
SqureInfo.lPos = 0
SqureInfo.north = 0
SqureInfo.sorth = 0
SqureInfo.east = 0
SqureInfo.west = 0
SqureInfo.squreState = 0

function SqureInfo:Ctor()
end

function SqureInfo:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.squreType) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.squreShow) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.eventID) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.rPos) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.lPos) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.north) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.sorth) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.east) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.west) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.squreState) then
    return false
  end
  return true
end

function SqureInfo:Unmarshal(buffer)
  local ret = true
  ret, self.squreType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.squreShow = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.eventID = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  ret, self.rPos = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.lPos = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.north = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.sorth = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.east = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.west = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.squreState = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SqureInfo
