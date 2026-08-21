local raw = {
  [1] = ProtobufI("ResourceCompose", {
    targetRes = ProtobufI("STResource", {
      type = 40,
      id = 3006,
      count = 1
    }),
    materialRes = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 2019,
        count = 4
      })
    }
  })
}
local indexed = {}
return {raw, indexed}
