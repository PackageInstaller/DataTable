local function func(conditionInfo)
  if NekoData.BehaviorManager.BM_Activity:IsActivityOpenById(21) then
    local params = conditionInfo.parm
    
    local taskId = tonumber(params[1])
    local isFinished = tonumber(params[2]) == 1
    local taskData = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SummerActivityManagerID):GetMissions()
    for i, v in ipairs(taskData) do
      if v.ID == taskId then
        if isFinished and v.isFinish == 1 then
          return true
        end
        return false
      end
    end
  end
  return false
end

return func
