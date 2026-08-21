local raw = {
  [1] = ProtobufI("GachaActorChipChance", {
    id = 5,
    remainder = 1,
    chance = 1000
  }),
  [2] = ProtobufI("GachaActorChipChance", {
    id = 5,
    remainder = 2,
    chance = 2000
  }),
  [3] = ProtobufI("GachaActorChipChance", {
    id = 5,
    remainder = 3,
    chance = 3000
  }),
  [4] = ProtobufI("GachaActorChipChance", {
    id = 5,
    remainder = 4,
    chance = 4000
  }),
  [5] = ProtobufI("GachaActorChipChance", {
    id = 5,
    remainder = 5,
    chance = 5000
  }),
  [6] = ProtobufI("GachaActorChipChance", {
    id = 5,
    remainder = 6,
    chance = 6000
  }),
  [7] = ProtobufI("GachaActorChipChance", {
    id = 5,
    remainder = 7,
    chance = 7000
  }),
  [8] = ProtobufI("GachaActorChipChance", {
    id = 5,
    remainder = 8,
    chance = 8000
  }),
  [9] = ProtobufI("GachaActorChipChance", {
    id = 5,
    remainder = 9,
    chance = 9000
  })
}
local indexed = {
  [5] = {
    [1] = 1,
    [2] = 2,
    [3] = 3,
    [4] = 4,
    [5] = 5,
    [6] = 6,
    [7] = 7,
    [8] = 8,
    [9] = 9
  }
}
return {raw, indexed}
