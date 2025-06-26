-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/activity/sgeneralforesightact.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  local dm = (NekoData.DataManager).DM_Foresight
  local bm = (NekoData.BehaviorManager).BM_Foresight
  dm:OnSGeneralForesightAct(protocol)
  bm:OnSGeneralForesightAct(protocol)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_OnSGeneralForesightAct, nil, protocol)
  if PrintTable then
    PrintTable(protocol, "3", "sgeneralforesightact")
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

