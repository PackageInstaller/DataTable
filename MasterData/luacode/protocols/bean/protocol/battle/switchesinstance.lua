local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SwitchesInstance = dataclass("SwitchesInstance")
SwitchesInstance.instanceid = 0
SwitchesInstance.id = 0
SwitchesInstance.state = 0
SwitchesInstance.touch = 0

function SwitchesInstance:Ctor()
end

function SwitchesInstance:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.instanceid) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.state) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteByte(buffer, self.touch) then
    return false
  end
  return true
end

function SwitchesInstance:Unmarshal(buffer)
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
  ret, self.touch = ProtocolBufferStaticFunctions.ReadByte(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SwitchesInstance
