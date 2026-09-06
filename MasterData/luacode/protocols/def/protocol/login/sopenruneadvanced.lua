local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SOpenRuneAdvanced = dataclass("SOpenRuneAdvanced", require("framework.net.protocol"))
SOpenRuneAdvanced.ProtocolType = 1096
SOpenRuneAdvanced.MaxSize = 65535
SOpenRuneAdvanced.roleId = 0

function SOpenRuneAdvanced:Ctor(client)
  SOpenRuneAdvanced.super.Ctor(self, client)
  self.baseRune = {}
end

function SOpenRuneAdvanced:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.baseRune)) then
    return false
  end
  for key, value in pairs(self.baseRune) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  return true
end

function SOpenRuneAdvanced:Unmarshal(buffer)
  local ret = true
  ret, self.roleId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
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
    ret, value = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
    self.baseRune[key] = value
  end
  return ret
end

return SOpenRuneAdvanced
