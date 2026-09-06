local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local Choice = dataclass("Choice")
Choice.taskid = 0

function Choice:Ctor()
  self.choices = {}
end

function Choice:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.taskid) then
    return false
  end
  local length = table.slen(self.choices)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.choices[i]) then
      return false
    end
  end
  return true
end

function Choice:Unmarshal(buffer)
  local ret = true
  ret, self.taskid = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.choices[i] = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return Choice
