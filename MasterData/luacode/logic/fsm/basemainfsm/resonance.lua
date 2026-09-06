local State = {}
local controllera
local RuneStateEnum = LuaNetManager.GetProtocolDef("protocol.rune.sruneinfo")
local GuideType = LuaNetManager.GetBeanDef("protocol.user.guidtypes")

function State.OnEnter(controller, lastState)
  LogInfo("BaseMainFSM", "Resonance Enter")
  local tag = NekoData.BehaviorManager.BM_Game:GetGuideTagByType(GuideType.RUNE)
  local runeInfo = NekoData.BehaviorManager.BM_Game:GetRuneInfo()
  local resonanceTagEvery = NekoData.BehaviorManager.BM_Game:GetResonanceTag()
  if tag and tag ~= 0 and runeInfo and runeInfo.state == RuneStateEnum.NO_RUNE and not resonanceTagEvery then
    NekoData.DataManager.DM_Game:SetResonanceTag()
    local dialog = DialogManager.GetDialog("base.baseinteractdialog")
    if dialog then
      dialog:ClickChar1Chat()
      controllera = controller
      LuaNotificationCenter.AddObserver(State, State.OnDialogDestroy, Common.n_DialogWillDestroy, nil)
      LuaNotificationCenter.AddObserver(State, State.OnResonanceNpcChatEnd, Common.n_ResonanceNpcChatEnd, nil)
    end
    controller._baseMainFSM:SetBoolean("haveFSMHandleOrMainCityGuide", true)
  else
    controller._baseMainFSM:SetBoolean("resonanceBegin", false)
    controller._baseMainFSM:SetBoolean("toSimpleShow", true)
  end
end

function State.Update(controller)
end

function State.OnExit(controller, nextState)
  LogInfo("BaseMainFSM", "Resonance Exit")
  LuaNotificationCenter.RemoveObserver(State)
end

function State.OnDialogDestroy(observer, notification)
  if notification.userInfo._dialogName == "resonance.resonancedialog" then
    controllera._baseMainFSM:SetBoolean("resonanceBegin", false)
    controllera._baseMainFSM:SetBoolean("toSimpleShow", true)
  end
end

function State.OnResonanceNpcChatEnd(observer, notification)
  controllera._baseMainFSM:SetBoolean("resonanceBegin", false)
  controllera._baseMainFSM:SetBoolean("toSimpleShow", true)
end

return State
