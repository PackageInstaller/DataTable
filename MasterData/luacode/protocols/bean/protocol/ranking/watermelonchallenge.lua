local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local WatermelonChallenge = dataclass("WatermelonChallenge")
WatermelonChallenge.rank = 0
WatermelonChallenge.NOT_ON_LIST = -1
WatermelonChallenge.NOT_Challenge = -2

function WatermelonChallenge:Ctor()
  self.watermelonPanelData = require("protocols.bean.protocol.ranking.watermelonpaneldata").Create()
  self.baseUserData = require("protocols.bean.protocol.chat.baseuserdata").Create()
end

function WatermelonChallenge:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.rank) then
    return false
  end
  if not self.watermelonPanelData:Marshal(buffer) then
    return false
  end
  if not self.baseUserData:Marshal(buffer) then
    return false
  end
  return true
end

function WatermelonChallenge:Unmarshal(buffer)
  local ret = true
  ret, self.rank = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  if not self.watermelonPanelData:Unmarshal(buffer) then
    return false
  end
  if not self.baseUserData:Unmarshal(buffer) then
    return false
  end
  return ret
end

return WatermelonChallenge
