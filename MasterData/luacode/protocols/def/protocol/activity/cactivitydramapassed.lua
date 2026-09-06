local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CActivityDramaPassed = dataclass("CActivityDramaPassed", require("framework.net.protocol"))
CActivityDramaPassed.ProtocolType = 2445
CActivityDramaPassed.MaxSize = 65535
CActivityDramaPassed.dramaType = 0
CActivityDramaPassed.activity = 0
CActivityDramaPassed.battleID = 0
CActivityDramaPassed.BEFORE_BATTLE = 1
CActivityDramaPassed.AFTER_BATTLE = 2

function CActivityDramaPassed:Ctor(client)
  CActivityDramaPassed.super.Ctor(self, client)
end

function CActivityDramaPassed:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.dramaType) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.activity) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.battleID) then
    return false
  end
  return true
end

function CActivityDramaPassed:Unmarshal(buffer)
  local ret = true
  ret, self.dramaType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.activity = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.battleID = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CActivityDramaPassed
