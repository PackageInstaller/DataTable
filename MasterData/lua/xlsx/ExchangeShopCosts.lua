local raw = {
  [1] = ProtobufI("ExchangeShopCosts", {
    activityId = 84001,
    cost = {
      [1] = ProtobufI("STResource", {type = 11, id = 3201})
    }
  }),
  [2] = ProtobufI("ExchangeShopCosts", {
    activityId = 84003,
    cost = {
      [1] = ProtobufI("STResource", {type = 11, id = 3201})
    }
  }),
  [3] = ProtobufI("ExchangeShopCosts", {
    activityId = 84002,
    cost = {
      [1] = ProtobufI("STResource", {type = 11, id = 60006})
    }
  }),
  [4] = ProtobufI("ExchangeShopCosts", {
    activityId = 201002,
    cost = {
      [1] = ProtobufI("STResource", {type = 11, id = 2037})
    }
  })
}
local indexed = {
  [84001] = 1,
  [84002] = 3,
  [84003] = 2,
  [201002] = 4
}
return {raw, indexed}
