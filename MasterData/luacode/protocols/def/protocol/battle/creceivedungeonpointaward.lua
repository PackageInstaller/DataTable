local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CReceiveDungeonPointAward = dataclass("CReceiveDungeonPointAward", require("framework.net.protocol"))
CReceiveDungeonPointAward.ProtocolType = 1961
CReceiveDungeonPointAward.MaxSize = 65535
CReceiveDungeonPointAward.id = 0

function CReceiveDungeonPointAward:Ctor(client)
  CReceiveDungeonPointAward.super.Ctor(self, client)
end

function CReceiveDungeonPointAward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  return true
end

function CReceiveDungeonPointAward:Unmarshal(buffer)
  local ret = true
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CReceiveDungeonPointAward
