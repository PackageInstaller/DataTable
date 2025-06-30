-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/login/smonthsigninfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  local str = "["
  for i,v in ipairs(protocol.receives) do
    if i ~= 1 then
      str = str .. ", "
    end
    str = str .. v
  end
  str = str .. "]"
  LogInfoFormat("smonthsigninfo", "signTotalNum = %s, receives = %s", protocol.signTotalNum, str)
  local dialog = (DialogManager.GetDialog)("welfare.monthsign.monthsignbuydialog")
  if dialog then
    dialog:Destroy()
  end
  ;
  ((NekoData.DataManager).DM_Welfare):OnSMonthSignInfo(protocol)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_RefreshMonthSign, nil, protocol)
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

