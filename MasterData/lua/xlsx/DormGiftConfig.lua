local raw = {
  [1] = ProtobufI("DormGiftConfig", {levelMax = 20, dormGiftGroup = 1}),
  [2] = ProtobufI("DormGiftConfig", {
    levelMin = 20,
    levelMax = 40,
    dormGiftGroup = 2
  }),
  [3] = ProtobufI("DormGiftConfig", {
    levelMin = 40,
    levelMax = 60,
    dormGiftGroup = 3
  })
}
local indexed = {}
return {raw, indexed}
