local raw = {
  [1] = ProtobufI("LotteryTaskConfig", {taskType = 1, taskProgress = 1}),
  [2] = ProtobufI("LotteryTaskConfig", {taskType = 2, taskProgress = 200}),
  [3] = ProtobufI("LotteryTaskConfig", {taskType = 3, taskProgress = 100})
}
local indexed = {
  [1] = 1,
  [2] = 2,
  [3] = 3
}
return {raw, indexed}
