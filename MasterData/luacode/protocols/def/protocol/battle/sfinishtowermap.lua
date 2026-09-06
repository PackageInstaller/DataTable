local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SFinishTowerMap = dataclass("SFinishTowerMap", require("framework.net.protocol"))
SFinishTowerMap.ProtocolType = 1989
SFinishTowerMap.MaxSize = 65535
SFinishTowerMap.result = 0

function SFinishTowerMap:Ctor(client)
  SFinishTowerMap.super.Ctor(self, client)
end

function SFinishTowerMap:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.result) then
    return false
  end
  return true
end

function SFinishTowerMap:Unmarshal(buffer)
  local ret = true
  ret, self.result = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SFinishTowerMap
