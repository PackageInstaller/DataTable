local function p1(protocol)
  NekoData.DataManager.DM_Team:OnSBattleStart(protocol)
  
  EffectFactory.CreateThawEffect():Run()
  DialogManager.DestroySingletonDialog("assistbattle.choosesupportroledialog")
  DialogManager.DestroySingletonDialog("teamedit.teameditprewardialog")
  DialogManager.DestroySingletonDialog("teamedit.offlineteameditdialog")
  DialogManager.DestroySingletonDialog("teamedit.undecidedroadteameditdialog")
  DialogManager.DestroySingletonDialog("activity.christmas.christmaspart2commonbattledteameditdialog")
  DialogManager.DestroySingletonDialog("teamedit.springfestivalteameditdialog")
  NekoData.DataManager.DM_SBattleStart:OnSBattleStart(protocol.battleInfo)
  LogErrorFormat("SBattleStart", "--- battleid = %s, battleSceneId = %s ---", protocol.battleInfo.battleid, protocol.battleInfo.battleSceneId)
  GlobalGameFSM:SetNumber("battleId", protocol.battleInfo.battleid)
end

local function p2(protocol, client)
end

return {p1, p2}
