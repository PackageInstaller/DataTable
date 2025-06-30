-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/fsm/gamefsm/maincity.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local State = {}
local UIManager = ((CS.PixelNeko).UI).UIManager
local SShowObtainPanelProtocol = require("protocols.def.protocol.battle.sshowobtainpanel")
State.enterByBattle = false
State.OnEnter = function(lastState)
  -- function num : 0_0 , upvalues : _ENV, State
  LogInfo("GameFSM", "MainCity Enter")
  State.enterByBattle = false
  State.controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).Base)
  if lastState ~= "MainCityBattleCrossing" then
    local battleId = GlobalGameFSM:GetParameter("battleId")
    if battleId == 0 and State.controller then
      (State.controller):SetBaseMainFSM()
    end
  else
    do
      if GlobalGameFSM:GetParameter("selectSummerEchoesEvent") then
        return 
      end
      if not (State.controller)._baseMainFSM and State.controller then
        (State.controller):SetBaseMainFSM()
      end
      ;
      ((NekoData.DataManager).DM_SBattleEnd):Clear()
      ;
      ((State.controller)._baseMainFSM):SetBoolean("toFirstAward", true)
      local csend = (LuaNetManager.CreateProtocol)("protocol.battle.cresourcepanel")
      csend:Send()
      local csend = (LuaNetManager.CreateProtocol)("protocol.battle.copenbosspanel")
      csend:Send()
      do
        do
          if ((NekoData.BehaviorManager).BM_WeekBoss):IsUnlock() then
            local csend = (LuaNetManager.CreateProtocol)("protocol.battle.copenweekbosspanel")
            csend:Send()
          end
          ;
          (LuaAudioManager.PlayBGM)(((NekoData.BehaviorManager).BM_Game):GetMainCityBgmID())
          if State.uIBackManagerIsActive and (UIBackManager.IsActive)() then
            (UIBackManager.SetActive)(true)
          end
          State.enterByBattle = true
          ;
          ((NekoData.BehaviorManager).BM_Dungeon):SaveAutoExploreBattleSceneId(0)
        end
      end
    end
  end
end

State.Update = function()
  -- function num : 0_1
end

State.OnExit = function(nextState)
  -- function num : 0_2 , upvalues : State, _ENV
  State.enterByBattle = false
  ;
  ((NekoData.DataManager).DM_SEnterMainCity):SetMainCityCurBattleInfo(nil)
  if nextState ~= "MainCityBattleLoading" then
    (DialogManager.DestroySingletonDialog)("base.basemainui")
    ;
    (DialogManager.DestroySingletonDialog)("base.baseinteractdialog")
    ;
    (DialogManager.DestroySingletonDialog)("base.basemainmenudialog")
    ;
    (DialogManager.DestroySingletonDialog)("chat.chatmaindialog")
    ;
    (DialogManager.DestroySingletonDialog)("debug.gmorderdialog")
    ;
    ((DialogManager.GetGroup)("Modal")):ReturnModalDialog()
  else
    State.uIBackManagerIsActive = (UIBackManager.IsActive)()
    if State.uIBackManagerIsActive then
      (UIBackManager.SetActive)(false)
    end
    ;
    (DialogManager.CreateSingletonDialog)("base.hidemaincitymodaldialog")
    ;
    (DialogManager.DestroySingletonDialog)("teamedit.teameditprewardialog")
    ;
    (DialogManager.DestroySingletonDialog)("assistbattle.choosesupportroledialog")
    ;
    (LuaAudioManager.StopBGM)(1252)
    ;
    (LuaAudioManager.StopBGM)(1253)
  end
  LogInfo("GameFSM", "MainCity Exit")
end

return State

