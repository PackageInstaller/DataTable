local function p1(protocol)
  if protocol.playerExp > 0 then
    local level = NekoData.BehaviorManager.BM_Game:GetUserLevel()
    
    NekoData.DataManager.DM_Game:AddPlayerExp(protocol.playerExp)
    LuaNotificationCenter.PostNotification(Common.n_PlayerExpChanged, nil, nil)
    if level ~= NekoData.BehaviorManager.BM_Game:GetUserLevel() then
      SdkManager.Report("LevelUp")
    end
  end
  NekoData.DataManager.DM_OfflineSweep:OnSSweepResult(protocol)
  NekoData.DataManager.DM_AllRoles:OnSSweepreSult(protocol)
  if table.nums(protocol.itemList) == 0 and table.nums(protocol.money) == 0 then
    local dialog = DialogManager.CreateSingletonDialog("mainline.offlinesweep.offlinesweepaccountdialog")
  else
    local dialog = DialogManager.CreateSingletonDialog("mainline.offlinesweep.offlinesweepresultdialg")
    dialog:Show(false)
  end
end

local function p2(protocol, client)
end

return {p1, p2}
