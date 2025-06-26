-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/def/action/sbossenterviolent.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SBossEnterViolent = dataclass("SBossEnterViolent")
SBossEnterViolent.ProtocolType = 63
SBossEnterViolent.Ctor = function(self, client)
  -- function num : 0_0
end

SBossEnterViolent.Marshal = function(self, data)
  -- function num : 0_1
end

SBossEnterViolent.Unmarshal = function(self, data)
  -- function num : 0_2
  return true
end

SBossEnterViolent.CheckVariable = function(self)
  -- function num : 0_3
  return true
end

return SBossEnterViolent

