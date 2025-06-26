-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/task/srefreshachievementinfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SRefreshAchievementInfo = dataclass("SRefreshAchievementInfo", require("framework.net.protocol"))
SRefreshAchievementInfo.ProtocolType = 1620
SRefreshAchievementInfo.MaxSize = 65535
SRefreshAchievementInfo.sendType = 0
SRefreshAchievementInfo.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SRefreshAchievementInfo, _ENV
  ((SRefreshAchievementInfo.super).Ctor)(self, client)
  self.achievement = ((require("protocols.bean.protocol.task.achievementinfo")).Create)()
end

SRefreshAchievementInfo.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (self.achievement):Marshal(buffer) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.sendType) then
    return false
  end
  return true
end

SRefreshAchievementInfo.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  if not (self.achievement):Unmarshal(buffer) then
    return false
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SRefreshAchievementInfo

