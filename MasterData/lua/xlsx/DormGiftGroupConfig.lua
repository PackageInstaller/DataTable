local raw = {
  [1] = ProtobufI("DormGiftGroupConfig", {
    giftGroupId = 1,
    giftConf = {
      [1] = ProtobufI("DormGiftGroupConfig.GiftConf", {probability = 5000, detailId = 1}),
      [2] = ProtobufI("DormGiftGroupConfig.GiftConf", {probability = 5000}),
      [3] = ProtobufI("DormGiftGroupConfig.GiftConf", {detailId = 4})
    }
  }),
  [2] = ProtobufI("DormGiftGroupConfig", {
    giftGroupId = 2,
    giftConf = {
      [1] = ProtobufI("DormGiftGroupConfig.GiftConf", {probability = 5000, detailId = 2}),
      [2] = ProtobufI("DormGiftGroupConfig.GiftConf", {probability = 5000}),
      [3] = ProtobufI("DormGiftGroupConfig.GiftConf", {detailId = 5})
    }
  }),
  [3] = ProtobufI("DormGiftGroupConfig", {
    giftGroupId = 3,
    giftConf = {
      [1] = ProtobufI("DormGiftGroupConfig.GiftConf", {probability = 5000, detailId = 3}),
      [2] = ProtobufI("DormGiftGroupConfig.GiftConf", {probability = 5000}),
      [3] = ProtobufI("DormGiftGroupConfig.GiftConf", {detailId = 6})
    }
  })
}
local indexed = {
  [1] = 1,
  [2] = 2,
  [3] = 3
}
return {raw, indexed}
