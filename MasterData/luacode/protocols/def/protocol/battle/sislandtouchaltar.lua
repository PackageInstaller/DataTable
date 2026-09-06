local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SIslandTouchAltar = dataclass("SIslandTouchAltar", require("framework.net.protocol"))
SIslandTouchAltar.ProtocolType = 1998
SIslandTouchAltar.MaxSize = 65535
SIslandTouchAltar.result = 0

function SIslandTouchAltar:Ctor(client)
  SIslandTouchAltar.super.Ctor(self, client)
  self.hpInfo = {}
end

function SIslandTouchAltar:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.result) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.hpInfo)) then
    return false
  end
  for key, value in pairs(self.hpInfo) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  return true
end

function SIslandTouchAltar:Unmarshal(buffer)
  local ret = true
  ret, self.result = ProtocolBufferStaticFunctions.ReadInt32(buffer)
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
    self.hpInfo[key] = value
  end
  return ret
end

return SIslandTouchAltar
