-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/party/boss/spartybossbattleresult.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  ((NekoData.DataManager).DM_Guild):OnPartyBossBattleResultProcess(protocol)
  local roleExp = {}
  local roleGoodCurExp = {}
  local rolesIndex = {}
  ;
  ((NekoData.DataManager).DM_Dungeon):SetBattleAccountData(protocol.itemList, protocol.money, roleExp, protocol.battletime, roleGoodCurExp, rolesIndex, 0)
  local dialog = (DialogManager.CreateSingletonDialog)("battle.battleaccount.battlewinaccountdialog")
  if dialog then
    dialog:SetIsGuildBoss(true)
    dialog:Show(false)
  end
  local GuildBossData = ((NekoData.BehaviorManager).BM_Guild):GetGuildBossData()
  GuildBossData.chances = protocol.chances
  for k,v in pairs(GuildBossData.bossstates) do
    -- DECOMPILER ERROR at PC53: Confused about usage of register: R11 in 'UnsetPending'

    if v.bossid == protocol.bossid then
      ((GuildBossData.bossstates)[k]).hp = protocol.beforescore - protocol.realscore
      -- DECOMPILER ERROR at PC61: Confused about usage of register: R11 in 'UnsetPending'

      if protocol.beforescore - protocol.realscore <= 0 then
        ((GuildBossData.bossstates)[k]).state = 2
      end
      ;
      ((NekoData.DataManager).DM_Guild):OnPartyBossPanelInfoProcess(GuildBossData)
      local infoDialog = (DialogManager.GetDialog)("guildboss.guildbossbattleinfodialog")
      -- DECOMPILER ERROR at PC79: Confused about usage of register: R12 in 'UnsetPending'

      if infoDialog then
        ((infoDialog._data).serverData).hp = protocol.beforescore - protocol.realscore
        -- DECOMPILER ERROR at PC87: Confused about usage of register: R12 in 'UnsetPending'

        if protocol.beforescore - protocol.realscore <= 0 then
          ((infoDialog._data).serverData).state = 2
        end
        infoDialog:Refresh()
      end
      local mainDialog = (DialogManager.GetDialog)("guildboss.guildbossmaindialog")
      if mainDialog then
        mainDialog:Init()
      end
      break
    end
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

