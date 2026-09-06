local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CBookActivity = dataclass("CBookActivity", require("framework.net.protocol"))
CBookActivity.ProtocolType = 2429
CBookActivity.MaxSize = 65535

function CBookActivity:Ctor(client)
  CBookActivity.super.Ctor(self, client)
end

function CBookActivity:Marshal(buffer)
  return true
end

function CBookActivity:Unmarshal(buffer)
  local ret = true
  return ret
end

return CBookActivity
