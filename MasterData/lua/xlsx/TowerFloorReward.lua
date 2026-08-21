local raw = {
  [1] = ProtobufI("TowerFloorReward", {
    towerFloor = 4,
    reward = {
      [1] = ProtobufI("STResource", {type = 5, count = 20}),
      [2] = ProtobufI("STResource", {type = 7, count = 2500})
    }
  }),
  [2] = ProtobufI("TowerFloorReward", {
    towerFloor = 8,
    reward = {
      [1] = ProtobufI("STResource", {type = 5, count = 20}),
      [2] = ProtobufI("STResource", {type = 7, count = 2500}),
      [3] = ProtobufI("STResource", {
        type = 11,
        id = 20108,
        count = 5
      })
    }
  }),
  [3] = ProtobufI("TowerFloorReward", {
    towerFloor = 12,
    reward = {
      [1] = ProtobufI("STResource", {type = 5, count = 40}),
      [2] = ProtobufI("STResource", {type = 7, count = 5000})
    }
  }),
  [4] = ProtobufI("TowerFloorReward", {
    towerFloor = 16,
    reward = {
      [1] = ProtobufI("STResource", {type = 5, count = 40}),
      [2] = ProtobufI("STResource", {type = 7, count = 5000}),
      [3] = ProtobufI("STResource", {
        type = 11,
        id = 20108,
        count = 5
      })
    }
  }),
  [5] = ProtobufI("TowerFloorReward", {
    towerFloor = 20,
    reward = {
      [1] = ProtobufI("STResource", {type = 5, count = 60}),
      [2] = ProtobufI("STResource", {type = 7, count = 7500})
    }
  }),
  [6] = ProtobufI("TowerFloorReward", {
    towerFloor = 24,
    reward = {
      [1] = ProtobufI("STResource", {type = 5, count = 60}),
      [2] = ProtobufI("STResource", {type = 7, count = 7500}),
      [3] = ProtobufI("STResource", {
        type = 11,
        id = 20108,
        count = 5
      })
    }
  }),
  [7] = ProtobufI("TowerFloorReward", {
    towerFloor = 28,
    reward = {
      [1] = ProtobufI("STResource", {type = 5, count = 80}),
      [2] = ProtobufI("STResource", {type = 7, count = 10000})
    }
  }),
  [8] = ProtobufI("TowerFloorReward", {
    towerFloor = 30,
    reward = {
      [1] = ProtobufI("STResource", {
        type = 8,
        id = 3001,
        count = 1
      }),
      [2] = ProtobufI("STResource", {type = 7, count = 10000}),
      [3] = ProtobufI("STResource", {
        type = 11,
        id = 20108,
        count = 5
      })
    }
  }),
  [9] = ProtobufI("TowerFloorReward", {
    towerFloor = 32,
    reward = {
      [1] = ProtobufI("STResource", {type = 5, count = 80}),
      [2] = ProtobufI("STResource", {type = 7, count = 10000})
    }
  }),
  [10] = ProtobufI("TowerFloorReward", {
    towerFloor = 36,
    reward = {
      [1] = ProtobufI("STResource", {type = 5, count = 100}),
      [2] = ProtobufI("STResource", {type = 7, count = 12500}),
      [3] = ProtobufI("STResource", {
        type = 11,
        id = 20108,
        count = 5
      })
    }
  }),
  [11] = ProtobufI("TowerFloorReward", {
    towerFloor = 40,
    reward = {
      [1] = ProtobufI("STResource", {type = 5, count = 100}),
      [2] = ProtobufI("STResource", {type = 7, count = 12500})
    }
  }),
  [12] = ProtobufI("TowerFloorReward", {
    towerFloor = 44,
    reward = {
      [1] = ProtobufI("STResource", {type = 5, count = 125}),
      [2] = ProtobufI("STResource", {type = 7, count = 12500}),
      [3] = ProtobufI("STResource", {
        type = 11,
        id = 20108,
        count = 5
      })
    }
  }),
  [13] = ProtobufI("TowerFloorReward", {
    towerFloor = 48,
    reward = {
      [1] = ProtobufI("STResource", {type = 5, count = 125}),
      [2] = ProtobufI("STResource", {type = 7, count = 15000})
    }
  }),
  [14] = ProtobufI("TowerFloorReward", {
    towerFloor = 52,
    reward = {
      [1] = ProtobufI("STResource", {type = 5, count = 150}),
      [2] = ProtobufI("STResource", {type = 7, count = 15000}),
      [3] = ProtobufI("STResource", {
        type = 11,
        id = 20108,
        count = 5
      })
    }
  }),
  [15] = ProtobufI("TowerFloorReward", {
    towerFloor = 56,
    reward = {
      [1] = ProtobufI("STResource", {type = 5, count = 150}),
      [2] = ProtobufI("STResource", {type = 7, count = 15000})
    }
  }),
  [16] = ProtobufI("TowerFloorReward", {
    towerFloor = 60,
    reward = {
      [1] = ProtobufI("STResource", {
        type = 8,
        id = 3002,
        count = 1
      }),
      [2] = ProtobufI("STResource", {type = 7, count = 20000}),
      [3] = ProtobufI("STResource", {
        type = 11,
        id = 20108,
        count = 5
      })
    }
  })
}
local indexed = {
  [4] = 1,
  [8] = 2,
  [12] = 3,
  [16] = 4,
  [20] = 5,
  [24] = 6,
  [28] = 7,
  [30] = 8,
  [32] = 9,
  [36] = 10,
  [40] = 11,
  [44] = 12,
  [48] = 13,
  [52] = 14,
  [56] = 15,
  [60] = 16
}
return {raw, indexed}
