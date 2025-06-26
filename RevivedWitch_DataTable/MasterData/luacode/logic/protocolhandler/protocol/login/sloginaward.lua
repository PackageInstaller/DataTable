-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/login/sloginaward.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  ((NekoData.DataManager).DM_Welfare):OnSLoginAward(protocol)
  local accumulate = true
  if (protocol.totalSign).needReceive ~= 0 then
    accumulate = false
  end
  ;
  ((NekoData.DataManager).DM_Welfare):SetSignState(accumulate)
  ;
  ((NekoData.DataManager).DM_Welfare):SetTotleSignState(accumulate)
  ;
  ((NekoData.DataManager).DM_Welfare):SetCumulativeSignDay((protocol.totalSign).cumulativeDay)
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

