-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/fsm/battlefsm/retreat.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local State = {}
local dialogKey = 0
local battleFSM = nil
local CBattleStartProtocol = require("protocols.def.protocol.battle.cbattlestart")
State.OnEnter = function(controller, lastState)
  -- function num : 0_0 , upvalues : _ENV, State, CBattleStartProtocol, dialogKey, battleFSM
  LogInfo("BattleFSM", "Retreat Enter")
  ;
  (LuaNotificationCenter.RemoveObserver)(State)
  ;
  (LuaAudioManager.PlayBGM)(137)
  if ((NekoData.BehaviorManager).BM_SBattleStart):GetBattleType() == CBattleStartProtocol.TEST then
    GlobalGameFSM:SetNumber("battleId", 0)
    return 
  end
  if ((NekoData.BehaviorManager).BM_Battle):GetBattleId() == 1122 then
    (controller._bsc_battleFSM):SetBoolean("retreatEnd", true)
    return 
  end
  local losedialog = (DialogManager.CreateSingletonDialog)("battle.battleaccount.battlelosetextdialog")
  if losedialog then
    (LuaNotificationCenter.AddObserver)(State, State.OnDialogDestroy, Common.n_DialogWillDestroy, nil)
    dialogKey = losedialog._dialogKey
    battleFSM = controller._bsc_battleFSM
  else
    ;
    (controller._bsc_battleFSM):SetBoolean("retreatEnd", true)
  end
end

State.Update = function(controller, deltaTime)
  -- function num : 0_1
end

State.OnExit = function(controller, nextState)
  -- function num : 0_2 , upvalues : _ENV, State, battleFSM
  LogInfo("BattleFSM", "Retreat Exit")
  ;
  (LuaNotificationCenter.RemoveObserver)(State)
  battleFSM = nil
  ;
  (controller._bsc_battleFSM):SetBoolean("retreatEnd", false)
end

State.OnDialogDestroy = function(self, notification)
  -- function num : 0_3 , upvalues : dialogKey, battleFSM
  if (notification.userInfo)._dialogKey == dialogKey then
    battleFSM:SetBoolean("retreatEnd", true)
  end
end

return State

