local raw = {
  [1] = ProtobufI("PostcardPrize", {
    prize = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 60001,
        count = 1
      }),
      [2] = ProtobufI("STResource", {
        type = 11,
        id = 224060,
        count = 1
      })
    },
    timeStart = "2019-08-19 06:00:00"
  }),
  [2] = ProtobufI("PostcardPrize", {
    postcardId = 1,
    prize = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 224060,
        count = 4
      }),
      [2] = ProtobufI("STResource", {
        type = 11,
        id = 124049,
        count = 2
      }),
      [3] = ProtobufI("STResource", {type = 7, count = 40000})
    },
    timeStart = "2019-08-19 06:00:00"
  }),
  [3] = ProtobufI("PostcardPrize", {
    postcardId = 2,
    prize = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 224060,
        count = 1
      }),
      [2] = ProtobufI("STResource", {
        type = 11,
        id = 124057,
        count = 10
      }),
      [3] = ProtobufI("STResource", {type = 7, count = 40000})
    },
    timeStart = "2019-08-19 06:00:00"
  }),
  [4] = ProtobufI("PostcardPrize", {
    postcardId = 3,
    prize = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 61000,
        count = 1
      }),
      [2] = ProtobufI("STResource", {
        type = 11,
        id = 32000,
        count = 400
      }),
      [3] = ProtobufI("STResource", {
        type = 11,
        id = 224060,
        count = 1
      })
    },
    timeStart = "2019-08-19 06:00:00"
  })
}
local indexed = {
  [0] = 1,
  [1] = 2,
  [2] = 3,
  [3] = 4
}
return {raw, indexed}
