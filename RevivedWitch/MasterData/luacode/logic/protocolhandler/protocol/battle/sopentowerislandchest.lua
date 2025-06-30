-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/battle/sopentowerislandchest.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cgoblinchesteffectconfig = (BeanManager.GetTableByName)("dungeonselect.cgoblinchesteffectconfig")
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV, cgoblinchesteffectconfig
  (DialogManager.DestroySingletonDialog)("tower.towerchestdialog")
  ;
  ((NekoData.DataManager).DM_Tower):OnSOpenTowerIslandChest(protocol)
  if protocol.resultType == 1 then
    ((DialogManager.CreateSingletonDialog)("bag.itemaccountdialog")):LoadData(protocol)
  else
    if protocol.resultType == 2 then
      local recorder = cgoblinchesteffectconfig:GetRecorder(protocol.effect)
      ;
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100140, {(TextManager.GetText)(recorder.effectdescribeTextID)})
    end
  end
  do
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_TowerChestOpen, {}, protocol)
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

