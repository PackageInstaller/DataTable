-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/guide/guideconditionhandlers/15.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local func = function(conditionInfo)
  -- function num : 0_0 , upvalues : _ENV
  local userInfo = ((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()
  do
    if userInfo then
      local roleId = userInfo.backgroundRole
      if ((NekoData.BehaviorManager).BM_Guide):HasFinished(24) and roleId == 0 then
        return true
      end
    end
    ;
    ((NekoData.BehaviorManager).BM_Guide):HasFinished(22)
  end
end

return func

