local raw = {
  [1] = ProtobufI("UnlockWindowPos", {
    windowType = 12,
    targetName = "ButtonRelation"
  }),
  [2] = ProtobufI("UnlockWindowPos", {windowType = 19, targetName = "Task"}),
  [3] = ProtobufI("UnlockWindowPos", {windowType = 5, targetName = "Portal"}),
  [4] = ProtobufI("UnlockWindowPos", {
    windowType = 7,
    targetName = "ButtonChallenge"
  }),
  [5] = ProtobufI("UnlockWindowPos", {
    windowType = 42,
    targetName = "ButtonChallenge"
  }),
  [6] = ProtobufI("UnlockWindowPos", {
    windowType = 18,
    targetName = "ButtonChallenge"
  }),
  [7] = ProtobufI("UnlockWindowPos", {
    windowType = 13,
    targetName = "ButtonChallenge"
  }),
  [8] = ProtobufI("UnlockWindowPos", {
    windowType = 1,
    targetName = "ButtonRelation"
  }),
  [9] = ProtobufI("UnlockWindowPos", {
    windowType = 39,
    targetName = "ButtonRelation"
  }),
  [10] = ProtobufI("UnlockWindowPos", {
    windowType = 27,
    targetName = "ButtonChallenge"
  }),
  [11] = ProtobufI("UnlockWindowPos", {
    windowType = 26,
    targetName = "ButtonChallenge"
  }),
  [12] = ProtobufI("UnlockWindowPos", {
    windowType = 31,
    targetName = "ButtonChallenge"
  })
}
local indexed = {
  [1] = 8,
  [5] = 3,
  [7] = 4,
  [12] = 1,
  [13] = 7,
  [18] = 6,
  [19] = 2,
  [26] = 11,
  [27] = 10,
  [31] = 12,
  [39] = 9,
  [42] = 5
}
return {raw, indexed}
