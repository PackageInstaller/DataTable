local raw = {
  [1] = ProtobufI("DormFloorConfig", {
    level = 1,
    showSeatCount = 2,
    size = 18,
    limits = {
      [1] = ProtobufI("DormFloorConfig.FurnitureLimit", {category = 4}),
      [2] = ProtobufI("DormFloorConfig.FurnitureLimit", {category = 5}),
      [3] = ProtobufI("DormFloorConfig.FurnitureLimit", {category = 3})
    }
  }),
  [2] = ProtobufI("DormFloorConfig", {
    level = 2,
    showSeatCount = 3,
    size = 22,
    limits = {
      [1] = ProtobufI("DormFloorConfig.FurnitureLimit", {category = 4}),
      [2] = ProtobufI("DormFloorConfig.FurnitureLimit", {category = 5}),
      [3] = ProtobufI("DormFloorConfig.FurnitureLimit", {category = 3})
    }
  }),
  [3] = ProtobufI("DormFloorConfig", {
    level = 3,
    showSeatCount = 5,
    size = 26,
    limits = {
      [1] = ProtobufI("DormFloorConfig.FurnitureLimit", {category = 4}),
      [2] = ProtobufI("DormFloorConfig.FurnitureLimit", {category = 5}),
      [3] = ProtobufI("DormFloorConfig.FurnitureLimit", {category = 3})
    }
  }),
  [4] = ProtobufI("DormFloorConfig", {
    level = 4,
    showSeatCount = 6,
    size = 30,
    limits = {
      [1] = ProtobufI("DormFloorConfig.FurnitureLimit", {category = 4}),
      [2] = ProtobufI("DormFloorConfig.FurnitureLimit", {category = 5}),
      [3] = ProtobufI("DormFloorConfig.FurnitureLimit", {category = 3})
    }
  })
}
local indexed = {
  [1] = 1,
  [2] = 2,
  [3] = 3,
  [4] = 4
}
return {raw, indexed}
