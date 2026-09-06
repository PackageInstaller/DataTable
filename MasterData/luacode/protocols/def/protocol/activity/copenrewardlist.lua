local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local COpenRewardList = dataclass("COpenRewardList", require("framework.net.protocol"))
COpenRewardList.ProtocolType = 2487
COpenRewardList.MaxSize = 65535

function COpenRewardList:Ctor(client)
  COpenRewardList.super.Ctor(self, client)
end

function COpenRewardList:Marshal(buffer)
  return true
end

function COpenRewardList:Unmarshal(buffer)
  local ret = true
  return ret
end

return COpenRewardList
