local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SAddTheme = dataclass("SAddTheme", require("framework.net.protocol"))
SAddTheme.ProtocolType = 2362
SAddTheme.MaxSize = 65535

function SAddTheme:Ctor(client)
  SAddTheme.super.Ctor(self, client)
  self.theme = require("protocols.bean.protocol.yard.theme").Create()
end

function SAddTheme:Marshal(buffer)
  if not self.theme:Marshal(buffer) then
    return false
  end
  return true
end

function SAddTheme:Unmarshal(buffer)
  local ret = true
  if not self.theme:Unmarshal(buffer) then
    return false
  end
  return ret
end

return SAddTheme
