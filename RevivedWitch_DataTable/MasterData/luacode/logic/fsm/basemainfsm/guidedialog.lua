-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/fsm/basemainfsm/guidedialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SceneInfoStaticTable = (BeanManager.GetTableByName)("scene.csceneinfostatic")
local CQuestEndDialogLibTable = (BeanManager.GetTableByName)("dialog.cquestenddialoglib")
local CGuideConditionconfig = (BeanManager.GetTableByName)("guide.cguideconditionconfig")
local State = {}
local controllera = nil
State.OnEnter = function(controller, lastState)
  -- function num : 0_0 , upvalues : _ENV, CGuideConditionconfig, SceneInfoStaticTable, CQuestEndDialogLibTable, controllera, State
  LogInfo("BaseMainFSM", "GuideDialog Enter")
  local returnTypeGetFromServer = ((NekoData.BehaviorManager).BM_Game):GetTip()
  local params = (CGuideConditionconfig:GetRecorder(7)).parm
  local storyMirrorParam = {((CGuideConditionconfig:GetRecorder(19)).parm)[1], ((CGuideConditionconfig:GetRecorder(19)).parm)[2], ((CGuideConditionconfig:GetRecorder(19)).parm)[3]}
  if ((NekoData.BehaviorManager).BM_Game):GetLastFloorId() == tonumber(params[1]) and (((NekoData.BehaviorManager).BM_Game):GetBattleResult()).result == tonumber(params[3]) and (((NekoData.BehaviorManager).BM_Game):GetBattleResult()).battleId == tonumber(params[2]) then
    (controller._baseMainFSM):SetNumber("startDialogId", 0)
  end
  if returnTypeGetFromServer ~= 0 and returnTypeGetFromServer ~= 4 then
    local _returnType = {lose = 1, complete = 2, manual = 3}
    local lastFloorId = ((NekoData.BehaviorManager).BM_Game):GetLastFloorId()
    local lastFloorRecord = SceneInfoStaticTable:GetRecorder(lastFloorId)
    if lastFloorRecord then
      local condition = lastFloorRecord.worldID
      local returnType = nil
      if returnTypeGetFromServer == 1 then
        returnType = _returnType.lose
      else
        if returnTypeGetFromServer == 2 then
          returnType = _returnType.manual
        else
          if returnTypeGetFromServer == 3 then
            returnType = _returnType.complete
          end
        end
      end
      local endDialogRecord = nil
      for _,id in ipairs(CQuestEndDialogLibTable:GetAllIds()) do
        local temp = CQuestEndDialogLibTable:GetRecorder(id)
        if temp.playCondition == condition and temp.returnType == returnType then
          endDialogRecord = temp
          break
        end
      end
      do
        do
          do
            if endDialogRecord then
              ((DialogManager.CreateSingletonDialog)("battle.battleaccount.battleloseguidedialog")):Show(endDialogRecord.startDialogID)
              controllera = controller
              ;
              (LuaNotificationCenter.AddObserver)(State, State.OnDialogDestroy, Common.n_DialogWillDestroy, nil)
            else
              ;
              (controller._baseMainFSM):SetNumber("startDialogId", 0)
            end
            ;
            (controller._baseMainFSM):SetNumber("startDialogId", 0)
            ;
            (controller._baseMainFSM):SetNumber("startDialogId", 0)
            ;
            (controller._baseMainFSM):SetBoolean("returnwelfareBegin", true)
          end
        end
      end
    end
  end
end

State.Update = function(controller)
  -- function num : 0_1
end

State.OnExit = function(controller, nextState)
  -- function num : 0_2 , upvalues : _ENV, State
  LogInfo("BaseMainFSM", "GuideDialog Exit")
  ;
  (LuaNotificationCenter.RemoveObserver)(State)
end

State.OnDialogDestroy = function(observer, notification)
  -- function num : 0_3 , upvalues : controllera
  if (notification.userInfo)._dialogName == "battle.battleaccount.battleloseguidedialog" then
    (controllera._baseMainFSM):SetNumber("startDialogId", 0)
  end
end

return State

