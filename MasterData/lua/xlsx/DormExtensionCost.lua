local raw = {
  [1] = ProtobufI("DormExtensionCost", {
    extType = 1,
    target = 2,
    cost = {
      [1] = ProtobufI("STResource", {type = 27, count = 1000})
    }
  }),
  [2] = ProtobufI("DormExtensionCost", {
    extType = 1,
    target = 3,
    cost = {
      [1] = ProtobufI("STResource", {type = 27, count = 1000})
    }
  }),
  [3] = ProtobufI("DormExtensionCost", {
    extType = 1,
    target = 4,
    cost = {
      [1] = ProtobufI("STResource", {type = 27, count = 1000})
    }
  }),
  [4] = ProtobufI("DormExtensionCost", {
    extType = 1,
    target = 5,
    cost = {
      [1] = ProtobufI("STResource", {type = 27, count = 1000})
    }
  }),
  [5] = ProtobufI("DormExtensionCost", {
    extType = 1,
    target = 6,
    cost = {
      [1] = ProtobufI("STResource", {type = 27, count = 1000})
    }
  }),
  [6] = ProtobufI("DormExtensionCost", {
    extType = 1,
    target = 7,
    cost = {
      [1] = ProtobufI("STResource", {type = 27, count = 1000})
    }
  }),
  [7] = ProtobufI("DormExtensionCost", {
    extType = 1,
    target = 8,
    cost = {
      [1] = ProtobufI("STResource", {type = 27, count = 1000})
    }
  }),
  [8] = ProtobufI("DormExtensionCost", {
    extType = 2,
    target = 3,
    cost = {
      [1] = ProtobufI("STResource", {type = 27, count = 100})
    }
  }),
  [9] = ProtobufI("DormExtensionCost", {
    extType = 2,
    target = 4,
    cost = {
      [1] = ProtobufI("STResource", {type = 27, count = 200})
    }
  }),
  [10] = ProtobufI("DormExtensionCost", {
    extType = 2,
    target = 5,
    cost = {
      [1] = ProtobufI("STResource", {type = 27, count = 300})
    }
  }),
  [11] = ProtobufI("DormExtensionCost", {
    extType = 2,
    target = 6,
    cost = {
      [1] = ProtobufI("STResource", {type = 27, count = 400})
    }
  }),
  [12] = ProtobufI("DormExtensionCost", {
    extType = 3,
    target = 20000,
    cost = {
      [1] = ProtobufI("STResource", {type = 27, count = 100})
    }
  }),
  [13] = ProtobufI("DormExtensionCost", {
    extType = 3,
    target = 30000,
    cost = {
      [1] = ProtobufI("STResource", {type = 27, count = 200})
    }
  }),
  [14] = ProtobufI("DormExtensionCost", {
    extType = 3,
    target = 40000,
    cost = {
      [1] = ProtobufI("STResource", {type = 27, count = 300})
    }
  }),
  [15] = ProtobufI("DormExtensionCost", {
    extType = 3,
    target = 50000,
    cost = {
      [1] = ProtobufI("STResource", {type = 27, count = 400})
    }
  }),
  [16] = ProtobufI("DormExtensionCost", {
    extType = 4,
    cost = {
      [1] = ProtobufI("STResource", {type = 27, count = 100})
    }
  })
}
local indexed = {
  [1] = {
    [2] = 1,
    [3] = 2,
    [4] = 3,
    [5] = 4,
    [6] = 5,
    [7] = 6,
    [8] = 7
  },
  [2] = {
    [3] = 8,
    [4] = 9,
    [5] = 10,
    [6] = 11
  },
  [3] = {
    [20000] = 12,
    [30000] = 13,
    [40000] = 14,
    [50000] = 15
  },
  [4] = {
    [0] = 16
  }
}
return {raw, indexed}
