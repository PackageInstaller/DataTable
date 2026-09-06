local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CAlchemyRankLevelUp = dataclass("CAlchemyRankLevelUp", require("framework.net.protocol"))
CAlchemyRankLevelUp.ProtocolType = 2370
CAlchemyRankLevelUp.MaxSize = 65535

function CAlchemyRankLevelUp:Ctor(client)
  CAlchemyRankLevelUp.super.Ctor(self, client)
end

function CAlchemyRankLevelUp:Marshal(buffer)
  return true
end

function CAlchemyRankLevelUp:Unmarshal(buffer)
  local ret = true
  return ret
end

return CAlchemyRankLevelUp
