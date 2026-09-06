local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CEnterDungeon = dataclass("CEnterDungeon", require("framework.net.protocol"))
CEnterDungeon.ProtocolType = 1912
CEnterDungeon.MaxSize = 65535
CEnterDungeon.WaitProtocol = "protocol.notify.scancelloading"
CEnterDungeon.dungeonType = 0
CEnterDungeon.id = 0
CEnterDungeon.lineupId = 0

function CEnterDungeon:Ctor(client)
  CEnterDungeon.super.Ctor(self, client)
end

function CEnterDungeon:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.dungeonType) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.lineupId) then
    return false
  end
  return true
end

function CEnterDungeon:Unmarshal(buffer)
  local ret = true
  ret, self.dungeonType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.lineupId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CEnterDungeon
