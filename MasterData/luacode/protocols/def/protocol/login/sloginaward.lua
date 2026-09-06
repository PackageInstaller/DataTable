local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SLoginAward = dataclass("SLoginAward", require("framework.net.protocol"))
SLoginAward.ProtocolType = 1068
SLoginAward.MaxSize = 65535

function SLoginAward:Ctor(client)
  SLoginAward.super.Ctor(self, client)
  self.totalSign = require("protocols.bean.protocol.login.totalsign").Create()
end

function SLoginAward:Marshal(buffer)
  if not self.totalSign:Marshal(buffer) then
    return false
  end
  return true
end

function SLoginAward:Unmarshal(buffer)
  local ret = true
  if not self.totalSign:Unmarshal(buffer) then
    return false
  end
  return ret
end

return SLoginAward
