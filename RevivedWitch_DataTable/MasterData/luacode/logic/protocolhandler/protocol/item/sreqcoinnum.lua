-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/item/sreqcoinnum.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  local str = nil
  for k,v in pairs(protocol.money) do
    if not str then
      str = "{"
    else
      str = str .. ", "
    end
    str = str .. "[" .. k .. "] = " .. v
  end
  if str then
    str = str .. "}"
  end
  LogInfoFormat("sreqcoinnum", "--- money = %s ---", str)
  ;
  ((NekoData.DataManager).DM_Currency):OnSReqcoinnum(protocol)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_RefreshCurrency, nil, protocol)
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

