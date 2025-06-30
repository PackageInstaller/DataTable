-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/item/sresspirit.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  ((NekoData.DataManager).DM_Currency):OnSResSpirit(protocol)
  ;
  ((NekoData.DataManager).DM_Game):OnSResSpirit(protocol)
  local userInfo = {}
  userInfo.spirit = protocol.spirit
  userInfo.spiritFullTime = protocol.spiritFullTime
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_RefreshSpirit, nil, userInfo)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_StrengthLimitChanged, nil, nil)
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

