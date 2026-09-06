local function p1(protocol)
  if NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Task_Every) and table.nums(protocol.dailyTasks) == 0 then
    LogError("task", "服务器发了空的日常任务列表")
  end
  NekoData.DataManager.DM_Task:OnSDailyTaskForAccept(protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
