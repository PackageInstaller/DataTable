-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/yard/srefreshtask.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TaskStateEnum = (LuaNetManager.GetBeanDef)("protocol.yard.task")
local CCourtyardLvUpCfg = (BeanManager.GetTableByName)("courtyard.ccourtyardlvup")
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV, TaskStateEnum, CCourtyardLvUpCfg
  local taskInfo = ((NekoData.BehaviorManager).BM_MagicTree):GetTaskInfoByBuildingId((protocol.task).buildId)
  local dialog = (DialogManager.GetDialog)("magictree.buildinglevelupdialog")
  do
    if dialog and taskInfo and taskInfo.taskState == TaskStateEnum.UNLOCK and (protocol.task).statue ~= TaskStateEnum.UNLOCK then
      local record = CCourtyardLvUpCfg:GetRecorder(dialog._taskId)
      if record.functionID == (protocol.task).buildId then
        (DialogManager.DestroySingletonDialog)("magictree.buildinglevelupdialog")
      end
    end
    ;
    ((NekoData.DataManager).DM_MagicTree):OnSRefreshTask(protocol)
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_RefreshMagicTreeTask, nil, protocol)
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

