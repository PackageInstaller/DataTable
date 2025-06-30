-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/notify/sshowspecialweapon.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  local str = ""
  for i,v in ipairs(protocol.roles) do
    if i ~= 1 then
      str = str .. ", "
    end
    str = str .. v
  end
  LogInfoFormat("SShowSpecialWeapon", "roles = %s", str)
  ;
  ((NekoData.DataManager).DM_AllRoles):OnSShowSpecialWeapon(protocol)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_UniqueEquipAvailable, nil, nil)
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

