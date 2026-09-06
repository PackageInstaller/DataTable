local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CRandomName = dataclass("CRandomName", require("framework.net.protocol"))
CRandomName.ProtocolType = 2203
CRandomName.MaxSize = 65535

function CRandomName:Ctor(client)
  CRandomName.super.Ctor(self, client)
end

function CRandomName:Marshal(buffer)
  return true
end

function CRandomName:Unmarshal(buffer)
  local ret = true
  return ret
end

return CRandomName
