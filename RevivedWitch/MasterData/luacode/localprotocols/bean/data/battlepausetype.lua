-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/bean/data/battlepausetype.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BattlePauseType = dataclass("BattlePauseType")
BattlePauseType.TimeLine = 1
BattlePauseType.NpcChat = 2
BattlePauseType.Ctor = function(self)
  -- function num : 0_0
end

BattlePauseType.Marshal = function(self, data)
  -- function num : 0_1
end

BattlePauseType.Unmarshal = function(self, data)
  -- function num : 0_2
end

BattlePauseType.CheckVariable = function(self)
  -- function num : 0_3
  return true
end

return BattlePauseType

