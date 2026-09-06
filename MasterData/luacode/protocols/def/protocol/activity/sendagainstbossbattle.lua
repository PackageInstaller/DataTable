local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SEndAgainstBossBattle = dataclass("SEndAgainstBossBattle", require("framework.net.protocol"))
SEndAgainstBossBattle.ProtocolType = 2666
SEndAgainstBossBattle.MaxSize = 65535

function SEndAgainstBossBattle:Ctor(client)
  SEndAgainstBossBattle.super.Ctor(self, client)
  self.bossInfo = require("protocols.bean.protocol.activity.bossinfo").Create()
end

function SEndAgainstBossBattle:Marshal(buffer)
  if not self.bossInfo:Marshal(buffer) then
    return false
  end
  return true
end

function SEndAgainstBossBattle:Unmarshal(buffer)
  local ret = true
  if not self.bossInfo:Unmarshal(buffer) then
    return false
  end
  return ret
end

return SEndAgainstBossBattle
