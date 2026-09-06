local SUserChangeInfoProtocol = require("protocols.def.protocol.user.suserchangeinfo")

local function p1(protocol)
  local level = NekoData.BehaviorManager.BM_Game:GetUserLevel()
  for k, v in pairs(protocol.changeInfo) do
    if k == SUserChangeInfoProtocol.PLAYER_EXP then
      NekoData.DataManager.DM_Game:AddPlayerExp(v)
      LuaNotificationCenter.PostNotification(Common.n_PlayerExpChanged, nil, nil)
    end
  end
  if level ~= NekoData.BehaviorManager.BM_Game:GetUserLevel() then
    SdkManager.Report("LevelUp")
  end
end

local function p2(protocol, client)
end

return {p1, p2}
