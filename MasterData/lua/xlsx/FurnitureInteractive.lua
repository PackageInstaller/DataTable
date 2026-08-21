local raw = {
  [1] = ProtobufI("FurnitureInteractive", {
    id = 100003,
    attached = true,
    interactiveProbability = 1250,
    actorAnim = ProtobufI("FurnitureInteractive.ActorAnim", {
      name = "sleep",
      x = 1.13,
      y = 0.74
    }),
    condition = ProtobufI("FurnitureInteractive.Condition", {})
  }),
  [2] = ProtobufI("FurnitureInteractive", {
    id = 100004,
    attached = true,
    interactiveProbability = 1250,
    actorAnim = ProtobufI("FurnitureInteractive.ActorAnim", {
      name = "sleep",
      x = 1.13,
      y = 0.74
    }),
    condition = ProtobufI("FurnitureInteractive.Condition", {})
  }),
  [3] = ProtobufI("FurnitureInteractive", {
    id = 100112,
    attached = true,
    interactiveProbability = 1250,
    actorAnim = ProtobufI("FurnitureInteractive.ActorAnim", {
      name = "idle",
      x = 0.9,
      y = -0.4
    }),
    condition = ProtobufI("FurnitureInteractive.Condition", {})
  }),
  [4] = ProtobufI("FurnitureInteractive", {
    id = 100205,
    attached = true,
    interactiveProbability = 1250,
    actorAnim = ProtobufI("FurnitureInteractive.ActorAnim", {
      name = "sleep",
      x = 1.13,
      y = 0.74
    }),
    condition = ProtobufI("FurnitureInteractive.Condition", {})
  }),
  [5] = ProtobufI("FurnitureInteractive", {
    id = 100213,
    attached = true,
    interactiveProbability = 1250,
    actorAnim = ProtobufI("FurnitureInteractive.ActorAnim", {
      name = "sit",
      x = 0.8,
      y = 0.35
    }),
    condition = ProtobufI("FurnitureInteractive.Condition", {})
  }),
  [6] = ProtobufI("FurnitureInteractive", {
    id = 100218,
    attached = true,
    interactiveProbability = 1250,
    actorAnim = ProtobufI("FurnitureInteractive.ActorAnim", {
      name = "idle",
      x = 0.9,
      y = -0.4
    }),
    condition = ProtobufI("FurnitureInteractive.Condition", {})
  }),
  [7] = ProtobufI("FurnitureInteractive", {
    id = 100303,
    attached = true,
    interactiveProbability = 1250,
    actorAnim = ProtobufI("FurnitureInteractive.ActorAnim", {
      name = "sleep",
      x = 1.13,
      y = 0.74
    }),
    condition = ProtobufI("FurnitureInteractive.Condition", {})
  }),
  [8] = ProtobufI("FurnitureInteractive", {
    id = 100315,
    attached = true,
    interactiveProbability = 1250,
    actorAnim = ProtobufI("FurnitureInteractive.ActorAnim", {
      name = "sit",
      x = 0.8,
      y = 0.35
    }),
    condition = ProtobufI("FurnitureInteractive.Condition", {})
  }),
  [9] = ProtobufI("FurnitureInteractive", {
    id = 100008,
    interactiveProbability = 1250,
    actorAnim = ProtobufI("FurnitureInteractive.ActorAnim", {name = "idle"}),
    condition = ProtobufI("FurnitureInteractive.Condition", {dir = 1}),
    dialogueIndex = 100,
    duration = 1
  }),
  [10] = ProtobufI("FurnitureInteractive", {
    id = 100404,
    attached = true,
    interactiveProbability = 1250,
    actorAnim = ProtobufI("FurnitureInteractive.ActorAnim", {
      name = "idle",
      x = 0.89,
      y = 0.22
    }),
    condition = ProtobufI("FurnitureInteractive.Condition", {})
  }),
  [11] = ProtobufI("FurnitureInteractive", {
    id = 100405,
    attached = true,
    interactiveProbability = 1250,
    actorAnim = ProtobufI("FurnitureInteractive.ActorAnim", {name = "sit", y = 0.57}),
    condition = ProtobufI("FurnitureInteractive.Condition", {})
  })
}
local indexed = {
  [100003] = 1,
  [100004] = 2,
  [100008] = 9,
  [100112] = 3,
  [100205] = 4,
  [100213] = 5,
  [100218] = 6,
  [100303] = 7,
  [100315] = 8,
  [100404] = 10,
  [100405] = 11
}
return {raw, indexed}
