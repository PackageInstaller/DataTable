local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CReceiveDungeonWorldAward = dataclass("CReceiveDungeonWorldAward", require("framework.net.protocol"))
CReceiveDungeonWorldAward.ProtocolType = 1959
CReceiveDungeonWorldAward.MaxSize = 65535
CReceiveDungeonWorldAward.id = 0

function CReceiveDungeonWorldAward:Ctor(client)
  CReceiveDungeonWorldAward.super.Ctor(self, client)
end

function CReceiveDungeonWorldAward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  return true
end

function CReceiveDungeonWorldAward:Unmarshal(buffer)
  local ret = true
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CReceiveDungeonWorldAward
