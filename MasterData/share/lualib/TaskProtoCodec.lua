local TaskProtoCodec = {}
local ProtoEntityConverter = require("LuaLib.ProtoEntityConverter")
local OnOpenFieldMapByType = {
  default = {
    "tid",
    "state",
    "count"
  },
  Achivement = {
    "tid",
    "state",
    "count",
    "lock",
    "historyData",
    "isReplaceText"
  },
  Appoint = {
    "tid",
    "state",
    "count",
    "lock",
    "ts",
    "awakerList"
  }
}

function TaskProtoCodec.GetOnOpenFieldMap(taskTypeKey)
  local fieldMap = OnOpenFieldMapByType[taskTypeKey]
  fieldMap = fieldMap or OnOpenFieldMapByType.default
  return fieldMap
end

function TaskProtoCodec.EncodeTaskForOnOpen(task, taskTypeKey)
  local fieldMap = TaskProtoCodec.GetOnOpenFieldMap(taskTypeKey)
  do return ProtoEntityConverter.ToArray, task end
  return ProtoEntityConverter.ToArray, task, fieldMap
end

function TaskProtoCodec.DecodeTaskForOnOpen(taskTypeKey, arr)
  local fieldMap = TaskProtoCodec.GetOnOpenFieldMap(taskTypeKey)
  do return ProtoEntityConverter.ToObject, arr end
  return ProtoEntityConverter.ToObject, arr, fieldMap
end

function TaskProtoCodec.TaskDataToKeyValue(taskData)
  if #taskData > 0 then
    local kv = {
      tid = taskData[1],
      uid = taskData[1],
      state = taskData[2],
      count = taskData[3],
      lock = taskData[4],
      historyData = taskData[5],
      isReplaceText = taskData[6],
      ts = taskData[5],
      awakerList = taskData[6]
    }
    return kv
  end
  return taskData
end

return TaskProtoCodec
