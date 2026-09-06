local cgoblinchesteffectconfig = BeanManager.GetTableByName("dungeonselect.cgoblinchesteffectconfig")

local function p1(protocol)
  DialogManager.DestroySingletonDialog("tower.towerchestdialog")
  NekoData.DataManager.DM_Tower:OnSOpenTowerIslandChest(protocol)
  if protocol.resultType == 1 then
    DialogManager.CreateSingletonDialog("bag.itemaccountdialog"):LoadData(protocol)
  elseif protocol.resultType == 2 then
    local recorder = cgoblinchesteffectconfig:GetRecorder(protocol.effect)
    NekoData.BehaviorManager.BM_Message:SendMessageById(100140, {
      TextManager.GetText(recorder.effectdescribeTextID)
    })
  end
  LuaNotificationCenter.PostNotification(Common.n_TowerChestOpen, {}, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
