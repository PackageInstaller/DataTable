-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/fsm/basemainfsm/resonance.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local State = {}
local controllera = nil
local RuneStateEnum = (LuaNetManager.GetProtocolDef)("protocol.rune.sruneinfo")
local GuideType = (LuaNetManager.GetBeanDef)("protocol.user.guidtypes")
State.OnEnter = function(controller, lastState)
  -- function num : 0_0 , upvalues : _ENV, GuideType, RuneStateEnum, controllera, State
  LogInfo("BaseMainFSM", "Resonance Enter")
  local tag = ((NekoData.BehaviorManager).BM_Game):GetGuideTagByType(GuideType.RUNE)
  local runeInfo = ((NekoData.BehaviorManager).BM_Game):GetRuneInfo()
  local resonanceTagEvery = ((NekoData.BehaviorManager).BM_Game):GetResonanceTag()
  if tag and tag ~= 0 and runeInfo and runeInfo.state == RuneStateEnum.NO_RUNE and not resonanceTagEvery then
    ((NekoData.DataManager).DM_Game):SetResonanceTag()
    local dialog = (DialogManager.GetDialog)("base.baseinteractdialog")
    if dialog then
      dialog:ClickChar1Chat()
      controllera = controller
      ;
      (LuaNotificationCenter.AddObserver)(State, State.OnDialogDestroy, Common.n_DialogWillDestroy, nil)
      ;
      (LuaNotificationCenter.AddObserver)(State, State.OnResonanceNpcChatEnd, Common.n_ResonanceNpcChatEnd, nil)
    end
    ;
    (controller._baseMainFSM):SetBoolean("haveFSMHandleOrMainCityGuide", true)
  else
    do
      ;
      (controller._baseMainFSM):SetBoolean("resonanceBegin", false)
      ;
      (controller._baseMainFSM):SetBoolean("toSimpleShow", true)
    end
  end
end

State.Update = function(controller)
  -- function num : 0_1
end

State.OnExit = function(controller, nextState)
  -- function num : 0_2 , upvalues : _ENV, State
  LogInfo("BaseMainFSM", "Resonance Exit")
  ;
  (LuaNotificationCenter.RemoveObserver)(State)
end

State.OnDialogDestroy = function(observer, notification)
  -- function num : 0_3 , upvalues : controllera
  if (notification.userInfo)._dialogName == "resonance.resonancedialog" then
    (controllera._baseMainFSM):SetBoolean("resonanceBegin", false)
    ;
    (controllera._baseMainFSM):SetBoolean("toSimpleShow", true)
  end
end

State.OnResonanceNpcChatEnd = function(observer, notification)
  -- function num : 0_4 , upvalues : controllera
  (controllera._baseMainFSM):SetBoolean("resonanceBegin", false)
  ;
  (controllera._baseMainFSM):SetBoolean("toSimpleShow", true)
end

return State

