local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local UNDRChallenge = dataclass("UNDRChallenge")
UNDRChallenge.rank = 0
UNDRChallenge.NOT_ON_LIST = -1
UNDRChallenge.NOT_Challenge = -2

function UNDRChallenge:Ctor()
  self.undrPanelData = require("protocols.bean.protocol.ranking.undecidedroadpaneldata").Create()
  self.baseUserData = require("protocols.bean.protocol.chat.baseuserdata").Create()
end

function UNDRChallenge:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.rank) then
    return false
  end
  if not self.undrPanelData:Marshal(buffer) then
    return false
  end
  if not self.baseUserData:Marshal(buffer) then
    return false
  end
  return true
end

function UNDRChallenge:Unmarshal(buffer)
  local ret = true
  ret, self.rank = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  if not self.undrPanelData:Unmarshal(buffer) then
    return false
  end
  if not self.baseUserData:Unmarshal(buffer) then
    return false
  end
  return ret
end

return UNDRChallenge
