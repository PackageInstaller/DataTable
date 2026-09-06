local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SFinishAutoExplore = dataclass("SFinishAutoExplore", require("framework.net.protocol"))
SFinishAutoExplore.ProtocolType = 1965
SFinishAutoExplore.MaxSize = 65535
SFinishAutoExplore.dungeonType = 0

function SFinishAutoExplore:Ctor(client)
  SFinishAutoExplore.super.Ctor(self, client)
  self.battleResult = require("protocols.bean.protocol.battle.battleresult").Create()
end

function SFinishAutoExplore:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.dungeonType) then
    return false
  end
  if not self.battleResult:Marshal(buffer) then
    return false
  end
  return true
end

function SFinishAutoExplore:Unmarshal(buffer)
  local ret = true
  ret, self.dungeonType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  if not self.battleResult:Unmarshal(buffer) then
    return false
  end
  return ret
end

return SFinishAutoExplore
