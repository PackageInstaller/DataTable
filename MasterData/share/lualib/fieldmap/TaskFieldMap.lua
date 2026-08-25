local TaskFieldMap = {}
TaskFieldMap.TASK_BASE_FIELDS = {
  [1] = "tid",
  [2] = "state",
  [3] = "count"
}
TaskFieldMap.TASK_EXTEND_FIELDS = {
  [4] = "lock",
  [5] = "historyData",
  [6] = "isReplaceText",
  [7] = "ts",
  [8] = "awakerList",
  [9] = "finishTime"
}
TaskFieldMap.MODULE_FIELDS = {
  [1] = "refreshCount",
  [2] = "appointCount",
  [3] = "isSpecial"
}

function TaskFieldMap.TaskToArray(task, fieldMap)
  local arr = {}
  for i = 1, #fieldMap do
    local fieldName = fieldMap[i]
    arr[i] = task[fieldName]
  end
  return arr
end

function TaskFieldMap.ArrayToTask(arr, fieldMap)
  local task = {}
  for i = 1, #fieldMap do
    local fieldName = fieldMap[i]
    task[fieldName] = arr[i]
  end
  return task
end

return TaskFieldMap
