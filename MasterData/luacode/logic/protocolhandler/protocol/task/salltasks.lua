local function p1(protocol)
  if table.nums(protocol.majorTasks) == 0 then
    LogError("task", "服务器发了空的主线任务列表")
  end
  NekoData.DataManager.DM_Task:OnSAllTasks(protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
