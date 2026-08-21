local raw = {
  [1] = ProtobufI("SingleActorGroup", {
    groupID = 1,
    groupmember = {
      [1] = 1002,
      [2] = 1003,
      [3] = 1008,
      [4] = 2132,
      [5] = 2105,
      [6] = 2108
    }
  }),
  [2] = ProtobufI("SingleActorGroup", {
    groupID = 2,
    groupmember = {}
  }),
  [3] = ProtobufI("SingleActorGroup", {
    groupID = 3,
    groupmember = {}
  }),
  [4] = ProtobufI("SingleActorGroup", {
    groupID = 4,
    groupmember = {}
  }),
  [5] = ProtobufI("SingleActorGroup", {
    groupID = 5,
    groupmember = {}
  })
}
local indexed = {
  [1] = 1,
  [2] = 2,
  [3] = 3,
  [4] = 4,
  [5] = 5
}
return {raw, indexed}
