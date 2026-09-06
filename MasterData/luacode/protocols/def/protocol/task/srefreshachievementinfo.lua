local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SRefreshAchievementInfo = dataclass("SRefreshAchievementInfo", require("framework.net.protocol"))
SRefreshAchievementInfo.ProtocolType = 1620
SRefreshAchievementInfo.MaxSize = 65535
SRefreshAchievementInfo.sendType = 0

function SRefreshAchievementInfo:Ctor(client)
  SRefreshAchievementInfo.super.Ctor(self, client)
  self.achievement = require("protocols.bean.protocol.task.achievementinfo").Create()
end

function SRefreshAchievementInfo:Marshal(buffer)
  if not self.achievement:Marshal(buffer) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.sendType) then
    return false
  end
  return true
end

function SRefreshAchievementInfo:Unmarshal(buffer)
  local ret = true
  if not self.achievement:Unmarshal(buffer) then
    return false
  end
  ret, self.sendType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SRefreshAchievementInfo
