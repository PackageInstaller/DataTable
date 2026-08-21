local raw = {
  [1] = ProtobufI("MonologueConfig", {
    id = 1,
    roles = {
      [1] = 201,
      [2] = 202
    },
    favourLevel = 10,
    cartoon = 1001
  })
}
local indexed = {
  [1] = 1
}
return {raw, indexed}
