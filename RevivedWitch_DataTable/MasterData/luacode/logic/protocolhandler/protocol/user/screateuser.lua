-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/user/screateuser.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  ((NekoData.DataManager).DM_Game):OnSCreateUser(protocol)
  local dialog = (DialogManager.GetDialog)("login.createroledialog")
  if dialog then
    (DialogManager.DestroySingletonDialog)("login.createroledialog")
  end
  local jsonStr = (JSON.encode)({eventName = "4"})
  ;
  (ThinkingAnalyticsInterface.SetUserPropertiesOnce_TA)(jsonStr)
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

