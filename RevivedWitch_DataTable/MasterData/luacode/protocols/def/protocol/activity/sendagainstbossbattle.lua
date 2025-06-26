-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/sendagainstbossbattle.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SEndAgainstBossBattle = dataclass("SEndAgainstBossBattle", require("framework.net.protocol"))
SEndAgainstBossBattle.ProtocolType = 2666
SEndAgainstBossBattle.MaxSize = 65535
SEndAgainstBossBattle.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SEndAgainstBossBattle, _ENV
  ((SEndAgainstBossBattle.super).Ctor)(self, client)
  self.bossInfo = ((require("protocols.bean.protocol.activity.bossinfo")).Create)()
end

SEndAgainstBossBattle.Marshal = function(self, buffer)
  -- function num : 0_1
  if not (self.bossInfo):Marshal(buffer) then
    return false
  end
  return true
end

SEndAgainstBossBattle.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  if not (self.bossInfo):Unmarshal(buffer) then
    return false
  end
  return ret
end

return SEndAgainstBossBattle

