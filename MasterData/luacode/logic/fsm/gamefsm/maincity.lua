local State = {}
local UIManager = CS.PixelNeko.UI.UIManager
local SShowObtainPanelProtocol = require("protocols.def.protocol.battle.sshowobtainpanel")
State.enterByBattle = false

function State.OnEnter(lastState)
  LogInfo("GameFSM", "MainCity Enter")
  State.enterByBattle = false
  State.controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.Base)
  if lastState ~= "MainCityBattleCrossing" then
    local battleId = GlobalGameFSM:GetParameter("battleId")
    if battleId == 0 and State.controller then
      State.controller:SetBaseMainFSM()
    end
  else
    if GlobalGameFSM:GetParameter("selectSummerEchoesEvent") then
      return
    end
    if not State.controller._baseMainFSM then
      if State.controller then
        State.controller:SetBaseMainFSM()
      end
    else
      NekoData.DataManager.DM_SBattleEnd:Clear()
    end
    State.controller._baseMainFSM:SetBoolean("toFirstAward", true)
    local csend = LuaNetManager.CreateProtocol("protocol.battle.cresourcepanel")
    csend:Send()
    local csend = LuaNetManager.CreateProtocol("protocol.battle.copenbosspanel")
    csend:Send()
    if NekoData.BehaviorManager.BM_WeekBoss:IsUnlock() then
      local csend = LuaNetManager.CreateProtocol("protocol.battle.copenweekbosspanel")
      csend:Send()
    end
    LuaAudioManager.PlayBGM(NekoData.BehaviorManager.BM_Game:GetMainCityBgmID())
    if State.uIBackManagerIsActive and UIBackManager.IsActive() then
      UIBackManager.SetActive(true)
    end
    State.enterByBattle = true
  end
  NekoData.BehaviorManager.BM_Dungeon:SaveAutoExploreBattleSceneId(0)
end

function State.Update()
end

function State.OnExit(nextState)
  State.enterByBattle = false
  NekoData.DataManager.DM_SEnterMainCity:SetMainCityCurBattleInfo(nil)
  if nextState ~= "MainCityBattleLoading" then
    DialogManager.DestroySingletonDialog("base.basemainui")
    DialogManager.DestroySingletonDialog("base.baseinteractdialog")
    DialogManager.DestroySingletonDialog("base.basemainmenudialog")
    DialogManager.DestroySingletonDialog("chat.chatmaindialog")
    DialogManager.DestroySingletonDialog("debug.gmorderdialog")
    DialogManager.GetGroup("Modal"):ReturnModalDialog()
  else
    State.uIBackManagerIsActive = UIBackManager.IsActive()
    if State.uIBackManagerIsActive then
      UIBackManager.SetActive(false)
    end
    DialogManager.CreateSingletonDialog("base.hidemaincitymodaldialog")
    DialogManager.DestroySingletonDialog("teamedit.teameditprewardialog")
    DialogManager.DestroySingletonDialog("assistbattle.choosesupportroledialog")
    LuaAudioManager.StopBGM(1252)
    LuaAudioManager.StopBGM(1253)
  end
  LogInfo("GameFSM", "MainCity Exit")
end

return State
