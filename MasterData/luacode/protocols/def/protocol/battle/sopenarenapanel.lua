local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SOpenArenaPanel = dataclass("SOpenArenaPanel", require("framework.net.protocol"))
SOpenArenaPanel.ProtocolType = 4108
SOpenArenaPanel.MaxSize = 65535
SOpenArenaPanel.waiting = 0
SOpenArenaPanel.seasonId = 0
SOpenArenaPanel.arenaId = 0
SOpenArenaPanel.camp = 0
SOpenArenaPanel.firstEnter = 0
SOpenArenaPanel.apAddTimes = 0
SOpenArenaPanel.leftTime = 0
SOpenArenaPanel.NOCAMP = 0
SOpenArenaPanel.CAMP1 = 1
SOpenArenaPanel.CAMP2 = 2

function SOpenArenaPanel:Ctor(client)
  SOpenArenaPanel.super.Ctor(self, client)
end

function SOpenArenaPanel:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.waiting) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.seasonId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.arenaId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.camp) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.firstEnter) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.apAddTimes) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.leftTime) then
    return false
  end
  return true
end

function SOpenArenaPanel:Unmarshal(buffer)
  local ret = true
  ret, self.waiting = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.seasonId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.arenaId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.camp = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.firstEnter = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.apAddTimes = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.leftTime = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SOpenArenaPanel
