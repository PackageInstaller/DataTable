local raw = {
  [1] = ProtobufI("LotteryConfig", {
    lotteryId = 1,
    lotteryLevel = 1,
    lotteryProbability = 2500,
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 30012,
        count = 1
      }),
      [2] = ProtobufI("STResource", {
        type = 11,
        id = 30001,
        count = 1
      })
    }
  }),
  [2] = ProtobufI("LotteryConfig", {
    lotteryId = 1,
    lotteryLevel = 2,
    lotteryProbability = 5000,
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 30012,
        count = 1
      }),
      [2] = ProtobufI("STResource", {
        type = 11,
        id = 30001,
        count = 2
      })
    }
  }),
  [3] = ProtobufI("LotteryConfig", {
    lotteryId = 1,
    lotteryLevel = 3,
    lotteryProbability = 7500,
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 30012,
        count = 1
      }),
      [2] = ProtobufI("STResource", {
        type = 11,
        id = 30001,
        count = 3
      })
    }
  }),
  [4] = ProtobufI("LotteryConfig", {
    lotteryId = 1,
    lotteryLevel = 4,
    lotteryProbability = 10000,
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 30012,
        count = 1
      }),
      [2] = ProtobufI("STResource", {
        type = 11,
        id = 30001,
        count = 4
      })
    }
  }),
  [5] = ProtobufI("LotteryConfig", {
    lotteryId = 2,
    lotteryLevel = 1,
    lotteryProbability = 2500,
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 10003,
        count = 1
      }),
      [2] = ProtobufI("STResource", {
        type = 11,
        id = 40002,
        count = 5
      })
    }
  }),
  [6] = ProtobufI("LotteryConfig", {
    lotteryId = 2,
    lotteryLevel = 2,
    lotteryProbability = 5000,
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 10003,
        count = 2
      }),
      [2] = ProtobufI("STResource", {
        type = 11,
        id = 40002,
        count = 6
      })
    }
  }),
  [7] = ProtobufI("LotteryConfig", {
    lotteryId = 2,
    lotteryLevel = 3,
    lotteryProbability = 7500,
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 10003,
        count = 3
      }),
      [2] = ProtobufI("STResource", {
        type = 11,
        id = 40002,
        count = 7
      })
    }
  }),
  [8] = ProtobufI("LotteryConfig", {
    lotteryId = 2,
    lotteryLevel = 4,
    lotteryProbability = 10000,
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 10003,
        count = 4
      }),
      [2] = ProtobufI("STResource", {
        type = 11,
        id = 40002,
        count = 8
      })
    }
  }),
  [9] = ProtobufI("LotteryConfig", {
    lotteryId = 3,
    lotteryLevel = 1,
    lotteryProbability = 2500,
    reward = {
      [1] = ProtobufI("STResource", {type = 7, count = 2333}),
      [2] = ProtobufI("STResource", {type = 6, count = 10})
    }
  }),
  [10] = ProtobufI("LotteryConfig", {
    lotteryId = 3,
    lotteryLevel = 2,
    lotteryProbability = 5000,
    reward = {
      [1] = ProtobufI("STResource", {type = 7, count = 4666}),
      [2] = ProtobufI("STResource", {type = 6, count = 12})
    }
  }),
  [11] = ProtobufI("LotteryConfig", {
    lotteryId = 3,
    lotteryLevel = 3,
    lotteryProbability = 7500,
    reward = {
      [1] = ProtobufI("STResource", {type = 7, count = 6666}),
      [2] = ProtobufI("STResource", {type = 6, count = 14})
    }
  }),
  [12] = ProtobufI("LotteryConfig", {
    lotteryId = 3,
    lotteryLevel = 4,
    lotteryProbability = 10000,
    reward = {
      [1] = ProtobufI("STResource", {type = 7, count = 8888}),
      [2] = ProtobufI("STResource", {type = 6, count = 16})
    }
  })
}
local indexed = {
  [1] = {
    [1] = 1,
    [2] = 2,
    [3] = 3,
    [4] = 4
  },
  [2] = {
    [1] = 5,
    [2] = 6,
    [3] = 7,
    [4] = 8
  },
  [3] = {
    [1] = 9,
    [2] = 10,
    [3] = 11,
    [4] = 12
  }
}
return {raw, indexed}
