local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local BossChallenge = dataclass("BossChallenge")
BossChallenge.rank = 0
BossChallenge.NOT_ON_LIST = -1
BossChallenge.NOT_Challenge = -2

function BossChallenge:Ctor()
  self.bossPanelData = require("protocols.bean.protocol.ranking.bosspaneldata").Create()
  self.baseUserData = require("protocols.bean.protocol.chat.baseuserdata").Create()
end

function BossChallenge:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.rank) then
    return false
  end
  if not self.bossPanelData:Marshal(buffer) then
    return false
  end
  if not self.baseUserData:Marshal(buffer) then
    return false
  end
  return true
end

function BossChallenge:Unmarshal(buffer)
  local ret = true
  ret, self.rank = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  if not self.bossPanelData:Unmarshal(buffer) then
    return false
  end
  if not self.baseUserData:Unmarshal(buffer) then
    return false
  end
  return ret
end

return BossChallenge
