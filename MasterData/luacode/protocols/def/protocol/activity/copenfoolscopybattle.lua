local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local COpenFoolsCopyBattle = dataclass("COpenFoolsCopyBattle", require("framework.net.protocol"))
COpenFoolsCopyBattle.ProtocolType = 2635
COpenFoolsCopyBattle.MaxSize = 65535

function COpenFoolsCopyBattle:Ctor(client)
  COpenFoolsCopyBattle.super.Ctor(self, client)
end

function COpenFoolsCopyBattle:Marshal(buffer)
  return true
end

function COpenFoolsCopyBattle:Unmarshal(buffer)
  local ret = true
  return ret
end

return COpenFoolsCopyBattle
