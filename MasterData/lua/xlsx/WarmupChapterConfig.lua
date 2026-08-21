local raw = {
  [1] = ProtobufI("WarmupChapterConfig", {
    chapterId = 1,
    activityType = 87,
    activityId = 87001,
    talk = {
      [1] = "ArmWarmup_0_1",
      [2] = "ArmWarmup_0_2"
    },
    unlockTaskId = {
      [1] = 108734,
      [2] = 108739
    }
  }),
  [2] = ProtobufI("WarmupChapterConfig", {
    chapterId = 2,
    activityType = 87,
    activityId = 87002,
    talk = {
      [1] = "ArmWarmup_0_1",
      [2] = "ArmWarmup_0_2",
      [3] = "ArmWarmup_0_4"
    },
    unlockTaskId = {}
  }),
  [3] = ProtobufI("WarmupChapterConfig", {
    chapterId = 3,
    activityType = 87,
    activityId = 87003,
    talk = {
      [1] = "ArmWarmup_0_1",
      [2] = "ArmWarmup_0_2",
      [3] = "ArmWarmup_0_5"
    },
    unlockTaskId = {}
  }),
  [4] = ProtobufI("WarmupChapterConfig", {
    chapterId = 4,
    activityType = 87,
    activityId = 87004,
    talk = {
      [1] = "ArmWarmup_0_1",
      [2] = "ArmWarmup_0_3",
      [3] = "ArmWarmup_0_6"
    },
    unlockTaskId = {}
  }),
  [5] = ProtobufI("WarmupChapterConfig", {
    chapterId = 5,
    activityType = 87,
    activityId = 87005,
    talk = {
      [1] = "ArmWarmup_0_1",
      [2] = "ArmWarmup_0_3",
      [3] = "ArmWarmup_0_7"
    },
    unlockTaskId = {}
  })
}
local indexed = {
  [1] = 1,
  [2] = 2,
  [3] = 3,
  [4] = 4,
  [5] = 5
}
return {raw, indexed}
