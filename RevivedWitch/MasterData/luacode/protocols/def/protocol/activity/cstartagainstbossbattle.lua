-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/cstartagainstbossbattle.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CStartAgainstBossBattle = dataclass("CStartAgainstBossBattle", require("framework.net.protocol"))
CStartAgainstBossBattle.ProtocolType = 2667
CStartAgainstBossBattle.MaxSize = 65535
CStartAgainstBossBattle.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CStartAgainstBossBattle
  ((CStartAgainstBossBattle.super).Ctor)(self, client)
end

CStartAgainstBossBattle.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CStartAgainstBossBattle.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CStartAgainstBossBattle

