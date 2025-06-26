-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/guide/stageconditionhandlers/6.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local func = function(conditionInfo, luaWindow)
  -- function num : 0_0 , upvalues : _ENV
  local params = conditionInfo.parm
  local dialogName = params[1]
  if dialogName then
    local value = tonumber(params[2])
    if value == 0 then
      return not (DialogManager.GetDialog)(dialogName)
    else
      if (DialogManager.GetDialog)(dialogName) == nil then
        do
          do return value ~= 1 end
          -- DECOMPILER ERROR: 2 unprocessed JMP targets
        end
      end
    end
  end
end

return func

