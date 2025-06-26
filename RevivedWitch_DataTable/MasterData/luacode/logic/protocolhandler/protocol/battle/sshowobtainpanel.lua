-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/battle/sshowobtainpanel.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  (LuaNotificationCenter.PostNotification)(Common.n_OnSShowObtainPanel, nil, protocol)
  ;
  ((NekoData.DataManager).DM_Game):OnSShowObtainPanel(protocol)
  for i,v in ipairs(protocol.awardItems) do
    LogErrorFormat("sshowobtainpanel", "--- awardItems: gain = %s, id = %s, number = %s ---", v.gain, v.id, v.number)
  end
  for k,v in pairs(protocol.awardCurrency) do
    LogErrorFormat("sshowobtainpanel", "--- awardCurrency: id = %s, number = %s ---", k, v)
  end
  LogErrorFormat("sshowobtainpanel", "--- showType = %s ---", protocol.showType)
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

