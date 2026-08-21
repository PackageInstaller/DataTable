local raw = {
  [1] = ProtobufI("ContinuousLoginPrize", {
    days = 1,
    prize = {
      [1] = ProtobufI("STResource", {type = 7, count = 6000})
    }
  }),
  [2] = ProtobufI("ContinuousLoginPrize", {
    days = 2,
    prize = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 60001,
        count = 1
      })
    }
  }),
  [3] = ProtobufI("ContinuousLoginPrize", {
    days = 3,
    prize = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 10001,
        count = 5
      })
    }
  }),
  [4] = ProtobufI("ContinuousLoginPrize", {
    days = 4,
    prize = {
      [1] = ProtobufI("STResource", {type = 6, count = 10})
    }
  }),
  [5] = ProtobufI("ContinuousLoginPrize", {
    days = 5,
    prize = {
      [1] = ProtobufI("STResource", {
        type = 15,
        id = 1011,
        count = 1,
        param = 8
      })
    }
  }),
  [6] = ProtobufI("ContinuousLoginPrize", {
    days = 6,
    prize = {
      [1] = ProtobufI("STResource", {type = 7, count = 6000})
    }
  }),
  [7] = ProtobufI("ContinuousLoginPrize", {
    days = 7,
    prize = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 60001,
        count = 1
      })
    }
  }),
  [8] = ProtobufI("ContinuousLoginPrize", {
    days = 8,
    prize = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 51002,
        count = 1
      })
    }
  }),
  [9] = ProtobufI("ContinuousLoginPrize", {
    days = 9,
    prize = {
      [1] = ProtobufI("STResource", {type = 6, count = 20})
    }
  }),
  [10] = ProtobufI("ContinuousLoginPrize", {
    days = 10,
    prize = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 60001,
        count = 1
      })
    }
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
  [8] = 8,
  [9] = 9,
  [10] = 10
}
return {raw, indexed}
