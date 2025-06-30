-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/framework/utils/behaviormanager.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BehaviorManager = {}
BehaviorManager.NewBehavior = function(behaviorName)
  -- function num : 0_0 , upvalues : _ENV
  local b = require("luabehavior.behavior")
  return (b.Create)(behaviorName)
end

return BehaviorManager

