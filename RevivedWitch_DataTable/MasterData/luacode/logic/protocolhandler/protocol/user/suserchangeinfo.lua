-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/user/suserchangeinfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SUserChangeInfoProtocol = require("protocols.def.protocol.user.suserchangeinfo")
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV, SUserChangeInfoProtocol
  local level = ((NekoData.BehaviorManager).BM_Game):GetUserLevel()
  for k,v in pairs(protocol.changeInfo) do
    if k == SUserChangeInfoProtocol.PLAYER_EXP then
      ((NekoData.DataManager).DM_Game):AddPlayerExp(v)
      ;
      (LuaNotificationCenter.PostNotification)(Common.n_PlayerExpChanged, nil, nil)
    end
  end
  if level ~= ((NekoData.BehaviorManager).BM_Game):GetUserLevel() then
    (SdkManager.Report)("LevelUp")
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

