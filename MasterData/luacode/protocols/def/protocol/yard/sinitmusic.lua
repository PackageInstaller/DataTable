local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SInitMusic = dataclass("SInitMusic", require("framework.net.protocol"))
SInitMusic.ProtocolType = 2386
SInitMusic.MaxSize = 65535

function SInitMusic:Ctor(client)
  SInitMusic.super.Ctor(self, client)
  self.music = require("protocols.bean.protocol.yard.music").Create()
end

function SInitMusic:Marshal(buffer)
  if not self.music:Marshal(buffer) then
    return false
  end
  return true
end

function SInitMusic:Unmarshal(buffer)
  local ret = true
  if not self.music:Unmarshal(buffer) then
    return false
  end
  return ret
end

return SInitMusic
