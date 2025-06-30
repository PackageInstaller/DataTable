-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/guide/stageconditionhandlers/1.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local func = function(conditionInfo, luaWindow)
  -- function num : 0_0 , upvalues : _ENV
  local params = conditionInfo.parm
  if luaWindow and #params > 0 then
    local dialogName = params[1]
    local dialog = (DialogManager.GetDialog)(dialogName)
    if dialog then
      local child = nil
      if not params[2] then
        child = dialog:GetRootWindow()
      else
        child = dialog:GetChild(params[2])
      end
      if luaWindow ~= child then
        do
          do
            do return not child end
            do return false end
            do return false end
            do return false end
            -- DECOMPILER ERROR: 5 unprocessed JMP targets
          end
        end
      end
    end
  end
end

return func

