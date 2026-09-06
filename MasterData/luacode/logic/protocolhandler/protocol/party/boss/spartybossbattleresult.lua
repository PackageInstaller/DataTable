local function p1(protocol)
  NekoData.DataManager.DM_Guild:OnPartyBossBattleResultProcess(protocol)
  
  local roleExp = {}
  local roleGoodCurExp = {}
  local rolesIndex = {}
  NekoData.DataManager.DM_Dungeon:SetBattleAccountData(protocol.itemList, protocol.money, roleExp, protocol.battletime, roleGoodCurExp, rolesIndex, 0)
  local dialog = DialogManager.CreateSingletonDialog("battle.battleaccount.battlewinaccountdialog")
  if dialog then
    dialog:SetIsGuildBoss(true)
    dialog:Show(false)
  end
  local GuildBossData = NekoData.BehaviorManager.BM_Guild:GetGuildBossData()
  GuildBossData.chances = protocol.chances
  for k, v in pairs(GuildBossData.bossstates) do
    if v.bossid == protocol.bossid then
      GuildBossData.bossstates[k].hp = protocol.beforescore - protocol.realscore
      if 0 >= protocol.beforescore - protocol.realscore then
        GuildBossData.bossstates[k].state = 2
      end
      NekoData.DataManager.DM_Guild:OnPartyBossPanelInfoProcess(GuildBossData)
      local infoDialog = DialogManager.GetDialog("guildboss.guildbossbattleinfodialog")
      if infoDialog then
        infoDialog._data.serverData.hp = protocol.beforescore - protocol.realscore
        if 0 >= protocol.beforescore - protocol.realscore then
          infoDialog._data.serverData.state = 2
        end
        infoDialog:Refresh()
      end
      local mainDialog = DialogManager.GetDialog("guildboss.guildbossmaindialog")
      if mainDialog then
        mainDialog:Init()
      end
      break
    end
  end
end

local function p2(protocol, client)
end

return {p1, p2}
