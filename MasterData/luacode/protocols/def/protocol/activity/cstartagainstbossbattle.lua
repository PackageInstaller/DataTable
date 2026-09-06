local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CStartAgainstBossBattle = dataclass("CStartAgainstBossBattle", require("framework.net.protocol"))
CStartAgainstBossBattle.ProtocolType = 2667
CStartAgainstBossBattle.MaxSize = 65535

function CStartAgainstBossBattle:Ctor(client)
  CStartAgainstBossBattle.super.Ctor(self, client)
end

function CStartAgainstBossBattle:Marshal(buffer)
  return true
end

function CStartAgainstBossBattle:Unmarshal(buffer)
  local ret = true
  return ret
end

return CStartAgainstBossBattle
