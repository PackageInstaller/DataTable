-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/battle/sbattlestart.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  ((NekoData.DataManager).DM_Team):OnSBattleStart(protocol)
  ;
  ((EffectFactory.CreateThawEffect)()):Run()
  ;
  (DialogManager.DestroySingletonDialog)("assistbattle.choosesupportroledialog")
  ;
  (DialogManager.DestroySingletonDialog)("teamedit.teameditprewardialog")
  ;
  (DialogManager.DestroySingletonDialog)("teamedit.offlineteameditdialog")
  ;
  (DialogManager.DestroySingletonDialog)("teamedit.undecidedroadteameditdialog")
  ;
  (DialogManager.DestroySingletonDialog)("activity.christmas.christmaspart2commonbattledteameditdialog")
  ;
  (DialogManager.DestroySingletonDialog)("teamedit.springfestivalteameditdialog")
  ;
  ((NekoData.DataManager).DM_SBattleStart):OnSBattleStart(protocol.battleInfo)
  LogErrorFormat("SBattleStart", "--- battleid = %s, battleSceneId = %s ---", (protocol.battleInfo).battleid, (protocol.battleInfo).battleSceneId)
  GlobalGameFSM:SetNumber("battleId", (protocol.battleInfo).battleid)
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

