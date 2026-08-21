local raw = {
  [1] = ProtobufI("ChatChannel", {
    channel = 1,
    interval = 10,
    levelLimit = 12,
    cost = ProtobufI("STResource", {}),
    clearOverTime = 60,
    maxGetNum = 50,
    maxShowNum = 100
  }),
  [2] = ProtobufI("ChatChannel", {
    channel = 2,
    cost = ProtobufI("STResource", {}),
    maxGetNum = 5,
    maxShowNum = 100
  }),
  [3] = ProtobufI("ChatChannel", {
    channel = 3,
    interval = 1,
    levelLimit = 12,
    cost = ProtobufI("STResource", {}),
    maxGetNum = 50,
    maxShowNum = 100
  }),
  [4] = ProtobufI("ChatChannel", {
    channel = 4,
    cost = ProtobufI("STResource", {}),
    maxGetNum = 5,
    maxShowNum = 100
  }),
  [5] = ProtobufI("ChatChannel", {
    channel = 5,
    interval = 1,
    levelLimit = 12,
    cost = ProtobufI("STResource", {}),
    maxShowNum = 100
  }),
  [6] = ProtobufI("ChatChannel", {
    channel = 6,
    interval = 3,
    cost = ProtobufI("STResource", {}),
    maxShowNum = 100
  }),
  [7] = ProtobufI("ChatChannel", {
    channel = 7,
    cost = ProtobufI("STResource", {}),
    maxShowNum = 100
  }),
  [8] = ProtobufI("ChatChannel", {
    channel = 9,
    cost = ProtobufI("STResource", {}),
    maxGetNum = 50,
    maxShowNum = 100
  })
}
local indexed = {
  [1] = 1,
  [2] = 2,
  [3] = 3,
  [4] = 4,
  [5] = 5,
  [6] = 6,
  [7] = 7,
  [9] = 8
}
return {raw, indexed}
