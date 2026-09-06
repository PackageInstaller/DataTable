local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SRefreshMagicTree = dataclass("SRefreshMagicTree", require("framework.net.protocol"))
SRefreshMagicTree.ProtocolType = 2311
SRefreshMagicTree.MaxSize = 65535

function SRefreshMagicTree:Ctor(client)
  SRefreshMagicTree.super.Ctor(self, client)
  self.magicTree = require("protocols.bean.protocol.yard.magictree").Create()
end

function SRefreshMagicTree:Marshal(buffer)
  if not self.magicTree:Marshal(buffer) then
    return false
  end
  return true
end

function SRefreshMagicTree:Unmarshal(buffer)
  local ret = true
  if not self.magicTree:Unmarshal(buffer) then
    return false
  end
  return ret
end

return SRefreshMagicTree
