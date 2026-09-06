local SceneInfoStaticTable = BeanManager.GetTableByName("scene.csceneinfostatic")
local CQuestEndDialogLibTable = BeanManager.GetTableByName("dialog.cquestenddialoglib")
local CGuideConditionconfig = BeanManager.GetTableByName("guide.cguideconditionconfig")
local State = {}
local controllera

function State.OnEnter(controller, lastState)
  LogInfo("BaseMainFSM", "GuideDialog Enter")
  local returnTypeGetFromServer = NekoData.BehaviorManager.BM_Game:GetTip()
  local params = CGuideConditionconfig:GetRecorder(7).parm
  local storyMirrorParam = {
    CGuideConditionconfig:GetRecorder(19).parm[1],
    CGuideConditionconfig:GetRecorder(19).parm[2],
    CGuideConditionconfig:GetRecorder(19).parm[3]
  }
  if NekoData.BehaviorManager.BM_Game:GetLastFloorId() == tonumber(params[1]) and NekoData.BehaviorManager.BM_Game:GetBattleResult().result == tonumber(params[3]) and NekoData.BehaviorManager.BM_Game:GetBattleResult().battleId == tonumber(params[2]) then
    controller._baseMainFSM:SetNumber("startDialogId", 0)
  end
  if returnTypeGetFromServer ~= 0 and returnTypeGetFromServer ~= 4 then
    local _returnType = {
      lose = 1,
      complete = 2,
      manual = 3
    }
    local lastFloorId = NekoData.BehaviorManager.BM_Game:GetLastFloorId()
    local lastFloorRecord = SceneInfoStaticTable:GetRecorder(lastFloorId)
    if lastFloorRecord then
      local condition = lastFloorRecord.worldID
      local returnType
      if returnTypeGetFromServer == 1 then
        returnType = _returnType.lose
      elseif returnTypeGetFromServer == 2 then
        returnType = _returnType.manual
      elseif returnTypeGetFromServer == 3 then
        returnType = _returnType.complete
      end
      local endDialogRecord
      for _, id in ipairs(CQuestEndDialogLibTable:GetAllIds()) do
        local temp = CQuestEndDialogLibTable:GetRecorder(id)
        if temp.playCondition == condition and temp.returnType == returnType then
          endDialogRecord = temp
          break
        end
      end
      if endDialogRecord then
        DialogManager.CreateSingletonDialog("battle.battleaccount.battleloseguidedialog"):Show(endDialogRecord.startDialogID)
        controllera = controller
        LuaNotificationCenter.AddObserver(State, State.OnDialogDestroy, Common.n_DialogWillDestroy, nil)
      else
        controller._baseMainFSM:SetNumber("startDialogId", 0)
      end
    else
      controller._baseMainFSM:SetNumber("startDialogId", 0)
    end
  else
    controller._baseMainFSM:SetNumber("startDialogId", 0)
  end
  controller._baseMainFSM:SetBoolean("returnwelfareBegin", true)
end

function State.Update(controller)
end

function State.OnExit(controller, nextState)
  LogInfo("BaseMainFSM", "GuideDialog Exit")
  LuaNotificationCenter.RemoveObserver(State)
end

function State.OnDialogDestroy(observer, notification)
  if notification.userInfo._dialogName == "battle.battleaccount.battleloseguidedialog" then
    controllera._baseMainFSM:SetNumber("startDialogId", 0)
  end
end

return State
