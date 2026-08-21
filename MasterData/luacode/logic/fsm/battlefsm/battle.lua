-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/fsm/battlefsm/battle.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local State = {}
State.OnEnter = function(controller, lastState)
  -- function num : 0_0 , upvalues : _ENV
  LogInfo("BattleFSM", "Battle Enter")
  local cbattleEndInfo = ((NekoData.BehaviorManager).BM_Login):GetCBattleEndInfo()
  local flag = ((NekoData.BehaviorManager).BM_Login):IfCanUseLocalCBattleEnd(((NekoData.BehaviorManager).BM_SBattleStart):GetProtocol())
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R4 in 'UnsetPending'

  if flag then
    (cbattleEndInfo.super)._mainClient = (LuaNetManager.GetMainConnect)()
    cbattleEndInfo:Send(true)
  end
end

State.Update = function(controller, deltaTime)
  -- function num : 0_1
  controller:BSC_UpdateBattleLogic(deltaTime)
end

State.OnExit = function(controller, nextState)
  -- function num : 0_2 , upvalues : _ENV
  LogInfo("BattleFSM", "Battle Exit")
  local pauseState = (controller._bsc_battleFSM):GetParameter("pasue")
  if not pauseState then
    controller:BSC_BattleLogicEnd()
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_BattleEnd, LuaNotificationCenter, {battleId = (controller._bsc_battleStartProtocol).battleid})
    GlobalGameFSM:SetBoolean("toBreakOrReconnect", true)
  end
end

return State

