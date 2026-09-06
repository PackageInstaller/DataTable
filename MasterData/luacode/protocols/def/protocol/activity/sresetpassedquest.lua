local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SResetPassedQuest = dataclass("SResetPassedQuest", require("framework.net.protocol"))
SResetPassedQuest.ProtocolType = 2426
SResetPassedQuest.MaxSize = 65536
SResetPassedQuest.result = 0

function SResetPassedQuest:Ctor(client)
  SResetPassedQuest.super.Ctor(self, client)
end

function SResetPassedQuest:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.result) then
    return false
  end
  return true
end

function SResetPassedQuest:Unmarshal(buffer)
  local ret = true
  ret, self.result = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SResetPassedQuest
