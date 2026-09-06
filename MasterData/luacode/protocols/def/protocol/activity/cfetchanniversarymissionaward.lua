local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CFetchAnniversaryMissionAward = dataclass("CFetchAnniversaryMissionAward", require("framework.net.protocol"))
CFetchAnniversaryMissionAward.ProtocolType = 2697
CFetchAnniversaryMissionAward.MaxSize = 65535
CFetchAnniversaryMissionAward.awardId = 0

function CFetchAnniversaryMissionAward:Ctor(client)
  CFetchAnniversaryMissionAward.super.Ctor(self, client)
end

function CFetchAnniversaryMissionAward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.awardId) then
    return false
  end
  return true
end

function CFetchAnniversaryMissionAward:Unmarshal(buffer)
  local ret = true
  ret, self.awardId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CFetchAnniversaryMissionAward
