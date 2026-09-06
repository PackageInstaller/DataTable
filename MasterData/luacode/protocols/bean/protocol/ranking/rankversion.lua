local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local RankVersion = dataclass("RankVersion")
RankVersion.version = 9

function RankVersion:Ctor()
end

function RankVersion:Marshal(buffer)
  return true
end

function RankVersion:Unmarshal(buffer)
  local ret = true
  return ret
end

return RankVersion
