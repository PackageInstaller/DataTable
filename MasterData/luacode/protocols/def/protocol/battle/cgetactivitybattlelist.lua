local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CGetActivityBattleList = dataclass("CGetActivityBattleList", require("framework.net.protocol"))
CGetActivityBattleList.ProtocolType = 4123
CGetActivityBattleList.MaxSize = 65535
CGetActivityBattleList.activityId = 0

function CGetActivityBattleList:Ctor(client)
  CGetActivityBattleList.super.Ctor(self, client)
end

function CGetActivityBattleList:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.activityId) then
    return false
  end
  return true
end

function CGetActivityBattleList:Unmarshal(buffer)
  local ret = true
  ret, self.activityId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CGetActivityBattleList
