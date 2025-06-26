-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/fsm/battlefsm/lose.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local State = {}
local dialogKey = 0
local battleFSM = nil
local CBattleStartProtocol = require("protocols.def.protocol.battle.cbattlestart")
State.OnEnter = function(controller, lastState)
  -- function num : 0_0 , upvalues : _ENV, State, CBattleStartProtocol, battleFSM, dialogKey
  LogInfo("BattleFSM", "Lose Enter")
  ;
  (LuaNotificationCenter.RemoveObserver)(State)
  ;
  (LuaAudioManager.PlayBGM)(137)
  if ((NekoData.BehaviorManager).BM_SBattleStart):GetBattleType() == CBattleStartProtocol.TEST then
    GlobalGameFSM:SetNumber("battleId", 0)
    return 
  end
  if ((NekoData.BehaviorManager).BM_Battle):GetBattleId() == 1186 then
    battleFSM = controller._bsc_battleFSM
    local lose1186dialog = (DialogManager.CreateSingletonDialog)("battle.battleaccount.battlelose1186dialog")
    if lose1186dialog then
      dialogKey = lose1186dialog._dialogKey
      ;
      (LuaNotificationCenter.AddObserver)(State, State.OnBattleLoseAnimationEnd, Common.n_BattleLoseAnimationEnd, nil)
    else
      battleFSM:SetBoolean("loseEnd", true)
    end
    return 
  end
  do
    if ((NekoData.BehaviorManager).BM_Battle):GetBattleId() == 1122 then
      (controller._bsc_battleFSM):SetBoolean("loseEnd", true)
      return 
    end
    if ((NekoData.BehaviorManager).BM_Dungeon):GetMode() == "auto" then
      if ((NekoData.BehaviorManager).BM_Battle):GetBattleType() ~= 19 then
        (controller._bsc_battleFSM):SetBoolean("loseEnd", true)
        return 
      else
        ;
        ((NekoData.DataManager).DM_Dungeon):SetMode()
      end
    end
    if ((NekoData.BehaviorManager).BM_Battle):GetBattleType() == 18 then
      (controller._bsc_battleFSM):SetBoolean("loseEnd", true)
      return 
    end
    local losedialog = (DialogManager.CreateSingletonDialog)("battle.battleaccount.battlelosetextdialog")
    if losedialog then
      (LuaNotificationCenter.AddObserver)(State, State.OnDialogDestroy, Common.n_DialogWillDestroy, nil)
      dialogKey = losedialog._dialogKey
      battleFSM = controller._bsc_battleFSM
    else
      local dialog = (DialogManager.CreateSingletonDialog)("battle.battleaccount.battlelosedialog")
      if dialog then
        (LuaNotificationCenter.AddObserver)(State, State.OnBattleLoseAnimationEnd, Common.n_BattleLoseAnimationEnd, nil)
        dialogKey = dialog._dialogKey
        battleFSM = controller._bsc_battleFSM
      else
        ;
        (controller._bsc_battleFSM):SetBoolean("loseEnd", true)
      end
    end
  end
end

State.Update = function(controller, deltaTime)
  -- function num : 0_1
end

State.OnExit = function(controller, nextState)
  -- function num : 0_2 , upvalues : _ENV, State, battleFSM
  LogInfo("BattleFSM", "Lose Exit")
  ;
  (LuaNotificationCenter.RemoveObserver)(State)
  battleFSM = nil
  ;
  (controller._bsc_battleFSM):SetBoolean("loseEnd", false)
end

State.OnDialogDestroy = function(self, notification)
  -- function num : 0_3 , upvalues : dialogKey, _ENV, CBattleStartProtocol, battleFSM, State
  if (notification.userInfo)._dialogKey == dialogKey then
    if ((NekoData.BehaviorManager).BM_SBattleStart):GetBattleType() == CBattleStartProtocol.ARENA then
      battleFSM:SetBoolean("loseEnd", true)
      return 
    end
    if ((NekoData.BehaviorManager).BM_SBattleEnd):GetBattleId() == 1186 then
      local lose1186dialog = (DialogManager.CreateSingletonDialog)("battle.battleaccount.battlelose1186dialog")
      if lose1186dialog then
        dialogKey = lose1186dialog._dialogKey
        ;
        (LuaNotificationCenter.AddObserver)(State, State.OnBattleLoseAnimationEnd, Common.n_BattleLoseAnimationEnd, nil)
      else
        battleFSM:SetBoolean("loseEnd", true)
      end
    else
      do
        if GlobalGameFSM:GetParameter("sceneId") == 30009 then
          battleFSM:SetBoolean("toAccounts", true)
          battleFSM:SetBoolean("loseEnd", true)
        else
          if GlobalGameFSM:GetParameter("sceneId") == 30014 then
            battleFSM:SetBoolean("toAccounts", true)
            battleFSM:SetBoolean("loseEnd", true)
          else
            local dialog = (DialogManager.CreateSingletonDialog)("battle.battleaccount.battlelosedialog")
            if dialog then
              (LuaNotificationCenter.AddObserver)(State, State.OnBattleLoseAnimationEnd, Common.n_BattleLoseAnimationEnd, nil)
            else
              battleFSM:SetBoolean("loseEnd", true)
            end
          end
        end
      end
    end
  end
end

State.OnBattleLoseAnimationEnd = function(self, notification)
  -- function num : 0_4 , upvalues : battleFSM
  battleFSM:SetBoolean("loseEnd", true)
end

return State

