local TaskStateEnum = LuaNetManager.GetBeanDef("protocol.yard.task")
local CCourtyardLvUpCfg = BeanManager.GetTableByName("courtyard.ccourtyardlvup")

local function p1(protocol)
  local taskInfo = NekoData.BehaviorManager.BM_MagicTree:GetTaskInfoByBuildingId(protocol.task.buildId)
  local dialog = DialogManager.GetDialog("magictree.buildinglevelupdialog")
  if dialog and taskInfo and taskInfo.taskState == TaskStateEnum.UNLOCK and protocol.task.statue ~= TaskStateEnum.UNLOCK then
    local record = CCourtyardLvUpCfg:GetRecorder(dialog._taskId)
    if record.functionID == protocol.task.buildId then
      DialogManager.DestroySingletonDialog("magictree.buildinglevelupdialog")
    end
  end
  NekoData.DataManager.DM_MagicTree:OnSRefreshTask(protocol)
  LuaNotificationCenter.PostNotification(Common.n_RefreshMagicTreeTask, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
