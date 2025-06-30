-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/guide/stageconditionhandlers/14.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local func = function(conditionInfo, luaWindow)
  -- function num : 0_0 , upvalues : _ENV
  local params = conditionInfo.parm
  local dialogName = params[1]
  local dialog = (DialogManager.GetDialog)(dialogName)
  local tag = false
  if dialog then
    do
      if luaWindow then
        local child = dialog:GetChild(params[2])
        tag = not child or luaWindow == child
      end
      tag = tag or dialog._tag ~= tonumber(params[3])
      do return tag end
      -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
  end
end

return func

