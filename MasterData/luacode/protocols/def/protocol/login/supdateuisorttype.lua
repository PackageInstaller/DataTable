local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SUpdateUISortType = dataclass("SUpdateUISortType", require("framework.net.protocol"))
SUpdateUISortType.ProtocolType = 1086
SUpdateUISortType.MaxSize = 65535

function SUpdateUISortType:Ctor(client)
  SUpdateUISortType.super.Ctor(self, client)
  self.uiSortTypes = {}
end

function SUpdateUISortType:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.uiSortTypes)) then
    return false
  end
  for key, value in pairs(self.uiSortTypes) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  return true
end

function SUpdateUISortType:Unmarshal(buffer)
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
    self.uiSortTypes[key] = value
  end
  return ret
end

return SUpdateUISortType
