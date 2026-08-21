local raw = {
  [1] = ProtobufI("QuestionActivtyProcess", {
    activityId = 99001,
    process = 1,
    rewards = {
      [1] = ProtobufI("STResource", {type = 6, count = 6}),
      [2] = ProtobufI("STResource", {type = 7, count = 10000})
    }
  }),
  [2] = ProtobufI("QuestionActivtyProcess", {
    activityId = 99001,
    process = 2,
    rewards = {
      [1] = ProtobufI("STResource", {type = 6, count = 6}),
      [2] = ProtobufI("STResource", {type = 7, count = 10000})
    }
  }),
  [3] = ProtobufI("QuestionActivtyProcess", {
    activityId = 99001,
    process = 3,
    rewards = {
      [1] = ProtobufI("STResource", {type = 6, count = 6}),
      [2] = ProtobufI("STResource", {type = 7, count = 10000})
    }
  }),
  [4] = ProtobufI("QuestionActivtyProcess", {
    activityId = 99001,
    process = 4,
    rewards = {
      [1] = ProtobufI("STResource", {type = 6, count = 6}),
      [2] = ProtobufI("STResource", {type = 7, count = 10000})
    }
  }),
  [5] = ProtobufI("QuestionActivtyProcess", {
    activityId = 99001,
    process = 5,
    rewards = {
      [1] = ProtobufI("STResource", {type = 6, count = 6}),
      [2] = ProtobufI("STResource", {type = 7, count = 10000})
    }
  })
}
local indexed = {
  [99001] = {
    [1] = 1,
    [2] = 2,
    [3] = 3,
    [4] = 4,
    [5] = 5
  }
}
return {raw, indexed}
