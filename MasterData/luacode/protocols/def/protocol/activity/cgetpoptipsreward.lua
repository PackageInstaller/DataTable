local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CGetPopTipsReward = dataclass("CGetPopTipsReward", require("framework.net.protocol"))
CGetPopTipsReward.ProtocolType = 2560
CGetPopTipsReward.MaxSize = 65535
CGetPopTipsReward.activityID = 0

function CGetPopTipsReward:Ctor(client)
  CGetPopTipsReward.super.Ctor(self, client)
end

function CGetPopTipsReward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.activityID) then
    return false
  end
  return true
end

function CGetPopTipsReward:Unmarshal(buffer)
  local ret = true
  ret, self.activityID = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CGetPopTipsReward
