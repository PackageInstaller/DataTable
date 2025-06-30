-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/guide/guideconditionhandlers/38.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local func = function(conditionInfo)
  -- function num : 0_0 , upvalues : _ENV
  local params = conditionInfo.parm
  local groupName = (DataCommon.Group)[tonumber(params[1])]
  local group = (DialogManager.GetGroup)(groupName)
  local active = tonumber(params[2]) == 1
  do return not group or group:GetObjectActive() == active end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

return func

