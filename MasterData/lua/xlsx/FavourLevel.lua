local raw = {
  [1] = ProtobufI("FavourLevel", {level = 1, favour = 15}),
  [2] = ProtobufI("FavourLevel", {level = 2, favour = 50}),
  [3] = ProtobufI("FavourLevel", {level = 3, favour = 80}),
  [4] = ProtobufI("FavourLevel", {level = 4, favour = 100}),
  [5] = ProtobufI("FavourLevel", {level = 5, favour = 250}),
  [6] = ProtobufI("FavourLevel", {level = 6, favour = 400}),
  [7] = ProtobufI("FavourLevel", {level = 7, favour = 700}),
  [8] = ProtobufI("FavourLevel", {level = 8, favour = 1200}),
  [9] = ProtobufI("FavourLevel", {level = 9, favour = 2200}),
  [10] = ProtobufI("FavourLevel", {level = 10, favour = 4000})
}
local indexed = {
  [1] = 1,
  [2] = 2,
  [3] = 3,
  [4] = 4,
  [5] = 5,
  [6] = 6,
  [7] = 7,
  [8] = 8,
  [9] = 9,
  [10] = 10
}
return {raw, indexed}
