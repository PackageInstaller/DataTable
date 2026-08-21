local raw = {
  [1] = ProtobufI("GachaFriendshipRate", {rate = 1, dropId = "Gacha_06"}),
  [2] = ProtobufI("GachaFriendshipRate", {rate = 10, dropId = "Gacha_07"}),
  [3] = ProtobufI("GachaFriendshipRate", {rate = 50, dropId = "Gacha_08"}),
  [4] = ProtobufI("GachaFriendshipRate", {rate = 100, dropId = "Gacha_09"})
}
local indexed = {
  [1] = 1,
  [10] = 2,
  [50] = 3,
  [100] = 4
}
return {raw, indexed}
