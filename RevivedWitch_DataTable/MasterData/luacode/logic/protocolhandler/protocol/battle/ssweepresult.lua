-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/battle/ssweepresult.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  do
    if protocol.playerExp > 0 then
      local level = ((NekoData.BehaviorManager).BM_Game):GetUserLevel()
      ;
      ((NekoData.DataManager).DM_Game):AddPlayerExp(protocol.playerExp)
      ;
      (LuaNotificationCenter.PostNotification)(Common.n_PlayerExpChanged, nil, nil)
      if level ~= ((NekoData.BehaviorManager).BM_Game):GetUserLevel() then
        (SdkManager.Report)("LevelUp")
      end
    end
    ;
    ((NekoData.DataManager).DM_OfflineSweep):OnSSweepResult(protocol)
    ;
    ((NekoData.DataManager).DM_AllRoles):OnSSweepreSult(protocol)
    if (table.nums)(protocol.itemList) == 0 and (table.nums)(protocol.money) == 0 then
      local dialog = (DialogManager.CreateSingletonDialog)("mainline.offlinesweep.offlinesweepaccountdialog")
    else
      do
        local dialog = (DialogManager.CreateSingletonDialog)("mainline.offlinesweep.offlinesweepresultdialg")
        dialog:Show(false)
      end
    end
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

