local function p1(protocol)
  local dm = NekoData.DataManager.DM_Foresight
  
  local bm = NekoData.BehaviorManager.BM_Foresight
  dm:OnSGeneralForesightAct(protocol)
  bm:OnSGeneralForesightAct(protocol)
  LuaNotificationCenter.PostNotification(Common.n_OnSGeneralForesightAct, nil, protocol)
  if PrintTable then
    PrintTable(protocol, "3", "sgeneralforesightact")
  end
end

local function p2(protocol, client)
end

return {p1, p2}
