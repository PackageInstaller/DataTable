local raw = {
  [1] = ProtobufI("DormFoodConfig", {
    foodId = 200001,
    eatAdd = 100,
    expRatio = 5,
    expTime = 1800
  }),
  [2] = ProtobufI("DormFoodConfig", {
    foodId = 200002,
    eatAdd = 500,
    expRatio = 10,
    expTime = 3600
  }),
  [3] = ProtobufI("DormFoodConfig", {
    foodId = 200003,
    eatAdd = 1000,
    expRatio = 20,
    expTime = 7200
  })
}
local indexed = {
  [200001] = 1,
  [200002] = 2,
  [200003] = 3
}
return {raw, indexed}
