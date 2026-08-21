local raw = {
  [1] = ProtobufI("FavourIncreaseRule", {
    ruleType = 1,
    dailyIncreaseLimit = 99999,
    increaseParams = {}
  }),
  [2] = ProtobufI("FavourIncreaseRule", {
    ruleType = 2,
    totalIncreaseLimit = 500,
    increaseParams = {
      [1] = 10800,
      [2] = 1
    }
  }),
  [3] = ProtobufI("FavourIncreaseRule", {
    ruleType = 3,
    dailyIncreaseLimit = 50,
    totalIncreaseLimit = 500,
    increaseParams = {
      [1] = 3600,
      [2] = 1
    }
  }),
  [4] = ProtobufI("FavourIncreaseRule", {
    ruleType = 4,
    dailyIncreaseLimit = 50,
    totalIncreaseLimit = 5000,
    increaseParams = {
      [1] = 1,
      [2] = 0
    }
  }),
  [5] = ProtobufI("FavourIncreaseRule", {
    ruleType = 5,
    increaseParams = {}
  }),
  [6] = ProtobufI("FavourIncreaseRule", {
    ruleType = 6,
    totalIncreaseLimit = 1000,
    increaseParams = {
      [1] = 2,
      [2] = 3,
      [3] = 3,
      [4] = 10,
      [5] = 4,
      [6] = 25,
      [7] = 5,
      [8] = 50,
      [9] = 6,
      [10] = 100
    }
  }),
  [7] = ProtobufI("FavourIncreaseRule", {
    ruleType = 7,
    totalIncreaseLimit = 1000,
    increaseParams = {
      [1] = 10,
      [2] = 3,
      [3] = 20,
      [4] = 10,
      [5] = 30,
      [6] = 25,
      [7] = 40,
      [8] = 50,
      [9] = 50,
      [10] = 100
    }
  }),
  [8] = ProtobufI("FavourIncreaseRule", {
    ruleType = 8,
    totalIncreaseLimit = 2000,
    increaseParams = {
      [1] = 1,
      [2] = 6,
      [3] = 2,
      [4] = 15,
      [5] = 3,
      [6] = 40,
      [7] = 4,
      [8] = 100
    }
  }),
  [9] = ProtobufI("FavourIncreaseRule", {
    ruleType = 9,
    totalIncreaseLimit = 1000,
    increaseParams = {
      [1] = 5,
      [2] = 3,
      [3] = 10,
      [4] = 10,
      [5] = 15,
      [6] = 25,
      [7] = 20,
      [8] = 50,
      [9] = 25,
      [10] = 100
    }
  }),
  [10] = ProtobufI("FavourIncreaseRule", {
    ruleType = 10,
    totalIncreaseLimit = 1000,
    increaseParams = {
      [1] = 100,
      [2] = 15,
      [3] = 150,
      [4] = 50,
      [5] = 200,
      [6] = 100,
      [7] = 250,
      [8] = 250,
      [9] = 300,
      [10] = 400
    }
  }),
  [11] = ProtobufI("FavourIncreaseRule", {
    ruleType = 11,
    totalIncreaseLimit = 500,
    increaseParams = {
      [1] = 28800,
      [2] = 1
    }
  }),
  [12] = ProtobufI("FavourIncreaseRule", {
    ruleType = 12,
    totalIncreaseLimit = 500,
    increaseParams = {
      [1] = 28800,
      [2] = 1
    }
  }),
  [13] = ProtobufI("FavourIncreaseRule", {
    ruleType = 13,
    totalIncreaseLimit = 500,
    increaseParams = {
      [1] = 28800,
      [2] = 1
    }
  }),
  [14] = ProtobufI("FavourIncreaseRule", {
    ruleType = 14,
    totalIncreaseLimit = 500,
    increaseParams = {
      [1] = 28800,
      [2] = 1
    }
  }),
  [15] = ProtobufI("FavourIncreaseRule", {
    ruleType = 15,
    dailyIncreaseLimit = 10,
    totalIncreaseLimit = 500,
    increaseParams = {
      [1] = 1,
      [2] = 0
    }
  }),
  [16] = ProtobufI("FavourIncreaseRule", {
    ruleType = 16,
    increaseParams = {
      [1] = 1,
      [2] = 3,
      [3] = 2,
      [4] = 6,
      [5] = 3,
      [6] = 15,
      [7] = 4,
      [8] = 40
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
  [10] = 10,
  [11] = 11,
  [12] = 12,
  [13] = 13,
  [14] = 14,
  [15] = 15,
  [16] = 16
}
return {raw, indexed}
