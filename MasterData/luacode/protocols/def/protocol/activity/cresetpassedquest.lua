local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CResetPassedQuest = dataclass("CResetPassedQuest", require("framework.net.protocol"))
CResetPassedQuest.ProtocolType = 2425
CResetPassedQuest.MaxSize = 65536
CResetPassedQuest.resetID = 0

function CResetPassedQuest:Ctor(client)
  CResetPassedQuest.super.Ctor(self, client)
end

function CResetPassedQuest:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.resetID) then
    return false
  end
  return true
end

function CResetPassedQuest:Unmarshal(buffer)
  local ret = true
  ret, self.resetID = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CResetPassedQuest
