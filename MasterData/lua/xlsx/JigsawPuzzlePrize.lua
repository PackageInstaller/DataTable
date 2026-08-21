local raw = {
  [1] = ProtobufI("JigsawPuzzlePrize", {
    prize = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 31019,
        count = 1
      })
    }
  }),
  [2] = ProtobufI("JigsawPuzzlePrize", {
    lightNum = 5,
    prize = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 90001,
        count = 3
      }),
      [2] = ProtobufI("STResource", {type = 7, count = 30000})
    }
  }),
  [3] = ProtobufI("JigsawPuzzlePrize", {
    lightNum = 15,
    prize = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 74003,
        count = 1
      }),
      [2] = ProtobufI("STResource", {type = 5, count = 50}),
      [3] = ProtobufI("STResource", {type = 7, count = 50000})
    }
  }),
  [4] = ProtobufI("JigsawPuzzlePrize", {
    lightNum = 30,
    prize = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 60001,
        count = 1
      }),
      [2] = ProtobufI("STResource", {
        type = 11,
        id = 90001,
        count = 5
      }),
      [3] = ProtobufI("STResource", {type = 7, count = 80000})
    }
  })
}
local indexed = {
  [0] = 1,
  [5] = 2,
  [15] = 3,
  [30] = 4
}
return {raw, indexed}
