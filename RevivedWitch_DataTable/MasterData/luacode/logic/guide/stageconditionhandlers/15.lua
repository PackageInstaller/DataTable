-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/guide/stageconditionhandlers/15.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local func = function(conditionInfo, luaWindow)
  -- function num : 0_0 , upvalues : _ENV
  if luaWindow then
    return true
  else
    local params = conditionInfo.parm
    local dialogName = params[1]
    local dialog = (DialogManager.GetDialog)(dialogName)
    return not dialog or dialog._tag ~= 4
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

return func

