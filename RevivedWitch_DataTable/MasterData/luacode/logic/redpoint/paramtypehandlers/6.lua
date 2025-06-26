-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/redpoint/paramtypehandlers/6.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local func = function(breakStageLevel, params)
  -- function num : 0_0 , upvalues : _ENV
  local roleId = params[1]
  local role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(roleId)
  if not role then
    return 
  end
  do return breakStageLevel > 0 and breakStageLevel <= role:GetMaxBreakLv() end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return func

