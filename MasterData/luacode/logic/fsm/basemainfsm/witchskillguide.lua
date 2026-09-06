local CWitchSkillUnlock = BeanManager.GetTableByName("role.cwitchskillunlock")
local CSkillMapTable = BeanManager.GetTableByName("skill.cskillmap")
local State = {}
local controllera
local _witchSkillUnlockTable = {}
local progress = false

function State.OnEnter(controller, lastState)
  LogInfo("BaseMainFSM", "WitchSkillGuide Enter")
  _witchSkillUnlockTable = {}
  for _, id in ipairs(CWitchSkillUnlock:GetAllIds()) do
    _witchSkillUnlockTable[id] = CWitchSkillUnlock:GetRecorder(id)
  end
  controller._baseMainFSM:SetBoolean("toFunctionUnlock", true)
  progress = false
  controllera = controller
end

function State.Update(controller)
  if not progress then
    progress = true
    local witchSkillGuideList = NekoData.BehaviorManager.BM_Game:GetWitchSkillIdList()
    if witchSkillGuideList and #witchSkillGuideList ~= 0 then
      local map = {}
      local allIds = CSkillMapTable:GetAllIds()
      local len = #allIds
      for i = 1, len do
        local record = CSkillMapTable:GetRecorder(allIds[i])
        if record.roleID == 1 then
          map[record.id] = record
        end
      end
      local record
      for _, r in pairs(_witchSkillUnlockTable) do
        if map[r.skillMapNodeID].skillID == witchSkillGuideList[1] then
          record = r
          break
        end
      end
      if record then
        controllera = controller
        LuaNotificationCenter.AddObserver(State, State.OnDialogCloseBtnClick, Common.n_DialogCloseBtnClick, nil)
        if not NekoData.BehaviorManager.BM_Game:GetIfFirstWitchSkillGuide() then
          local csend = LuaNetManager.CreateProtocol("protocol.user.cfinishwitchskillguide")
          csend.skillItemId = witchSkillGuideList[1]
          csend:Send()
        end
        local dialog = DialogManager.CreateSingletonDialog("newbattle.battleteachguidedialog")
        if dialog then
          dialog:Init(record.guideID)
          controller._baseMainFSM:SetBoolean("haveFSMHandleOrMainCityGuide", true)
        else
          controller._baseMainFSM:SetNumber("witchSkillGuideId", 0)
        end
      else
        LogErrorFormat("BaseSceneController", "cwitchskillunlock doesnt have record with skill id %s", witchSkillGuideList[1])
        controller._baseMainFSM:SetNumber("witchSkillGuideId", 0)
      end
    else
      controller._baseMainFSM:SetNumber("witchSkillGuideId", 0)
    end
  end
end

function State.OnExit(controller, nextState)
  LogInfo("BaseMainFSM", "WitchSkillGuide Exit")
  LuaNotificationCenter.RemoveObserver(State)
end

function State.OnDialogCloseBtnClick(observer, notification)
  if notification.userInfo._dialogName == "newbattle.battleteachguidedialog" then
    local witchSkillGuideList = NekoData.BehaviorManager.BM_Game:GetWitchSkillIdList()
    if witchSkillGuideList and #witchSkillGuideList ~= 0 then
      local csend = LuaNetManager.CreateProtocol("protocol.user.cfinishwitchskillguide")
      csend.skillItemId = witchSkillGuideList[1]
      csend:Send()
      table.remove(witchSkillGuideList, 1)
      progress = false
    else
      controllera._baseMainFSM:SetNumber("witchSkillGuideId", 0)
    end
  end
end

return State
