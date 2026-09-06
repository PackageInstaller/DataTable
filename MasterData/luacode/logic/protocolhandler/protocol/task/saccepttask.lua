local function p1(protocol)
  NekoData.DataManager.DM_Task:OnSAcceptTask(protocol)
  
  local task = NekoData.BehaviorManager.BM_Task:GetTask(protocol.taskinfo.taskid)
  local id = task:GetAcceptMsgID()
  if id then
    NekoData.BehaviorManager.BM_Message:SendTopMessage(id, {
      task:GetName()
    }, task:GetStatus() == 3)
  end
  local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.Base)
  if controller and controller._hasTriggerGuide then
    controller._hasTriggerGuide = false
    controller:StartLevelUpGuide()
  end
end

local function p2(protocol, client)
end

return {p1, p2}
