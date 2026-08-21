local raw = {
  [1] = ProtobufI("ClawCraneStock", {
    id = 1,
    day = 1,
    stock = 10
  }),
  [2] = ProtobufI("ClawCraneStock", {
    id = 2,
    day = 1,
    stock = 200
  }),
  [3] = ProtobufI("ClawCraneStock", {
    id = 3,
    day = 1,
    stock = 350
  }),
  [4] = ProtobufI("ClawCraneStock", {
    id = 1,
    day = 2,
    stock = 10
  }),
  [5] = ProtobufI("ClawCraneStock", {
    id = 2,
    day = 2,
    stock = 200
  }),
  [6] = ProtobufI("ClawCraneStock", {
    id = 3,
    day = 2,
    stock = 350
  }),
  [7] = ProtobufI("ClawCraneStock", {
    id = 1,
    day = 3,
    stock = 10
  }),
  [8] = ProtobufI("ClawCraneStock", {
    id = 2,
    day = 3,
    stock = 200
  }),
  [9] = ProtobufI("ClawCraneStock", {
    id = 3,
    day = 3,
    stock = 350
  }),
  [10] = ProtobufI("ClawCraneStock", {
    id = 1,
    day = 28,
    stock = 10
  }),
  [11] = ProtobufI("ClawCraneStock", {
    id = 2,
    day = 28,
    stock = 200
  }),
  [12] = ProtobufI("ClawCraneStock", {
    id = 3,
    day = 28,
    stock = 350
  })
}
local indexed = {
  [1] = {
    [1] = 1,
    [2] = 4,
    [3] = 7,
    [28] = 10
  },
  [2] = {
    [1] = 2,
    [2] = 5,
    [3] = 8,
    [28] = 11
  },
  [3] = {
    [1] = 3,
    [2] = 6,
    [3] = 9,
    [28] = 12
  }
}
return {raw, indexed}
