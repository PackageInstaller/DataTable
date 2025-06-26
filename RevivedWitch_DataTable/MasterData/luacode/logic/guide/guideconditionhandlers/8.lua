-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/guide/guideconditionhandlers/8.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local func = function(conditionInfo)
  -- function num : 0_0 , upvalues : _ENV
  local params = conditionInfo.parm
  local groupName = (DataCommon.Group)[tonumber(params[1])]
  local group = (DialogManager.GetGroup)(groupName)
  local active = tonumber(params[2]) == 1
  local tag = nil
  local dialogName = (DataCommon.Dialog)[tonumber(params[3])]
  if dialogName then
    local value = tonumber(params[4])
    if value == 0 then
      tag = not (DialogManager.GetDialog)(dialogName)
    elseif (DialogManager.GetDialog)(dialogName) == nil then
      do
        tag = value ~= 1
        -- DECOMPILER ERROR at PC55: Unhandled construct in 'MakeBoolean' P3

        do return (group and group:GetObjectActive() == active) end
        -- DECOMPILER ERROR: 7 unprocessed JMP targets
      end
    end
  end
end

return func

