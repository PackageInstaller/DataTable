local raw = {
  [1] = ProtobufI("ActivityInviteActorInfo", {
    activityType = 54,
    roleId = 1,
    actorId = 1001,
    index = 1,
    inviteCount = 10,
    goodId = 3,
    animRes = "5001a"
  }),
  [2] = ProtobufI("ActivityInviteActorInfo", {
    activityType = 54,
    roleId = 5,
    actorId = 1005,
    index = 2,
    inviteCount = 10,
    goodId = 6,
    animRes = "5005a"
  }),
  [3] = ProtobufI("ActivityInviteActorInfo", {
    activityType = 54,
    roleId = 11,
    actorId = 1011,
    index = 3,
    inviteCount = 10,
    goodId = 4,
    animRes = "5011a"
  }),
  [4] = ProtobufI("ActivityInviteActorInfo", {
    activityType = 54,
    roleId = 15,
    actorId = 1015,
    index = 4,
    inviteCount = 10,
    goodId = 1,
    animRes = "5015a"
  }),
  [5] = ProtobufI("ActivityInviteActorInfo", {
    activityType = 54,
    roleId = 101,
    actorId = 2101,
    index = 5,
    inviteCount = 10,
    goodId = 5,
    animRes = "5101a"
  }),
  [6] = ProtobufI("ActivityInviteActorInfo", {
    activityType = 54,
    roleId = 117,
    actorId = 2117,
    index = 6,
    inviteCount = 10,
    goodId = 2,
    animRes = "5117a"
  })
}
local indexed = {
  [54] = {
    [1] = 1,
    [5] = 2,
    [11] = 3,
    [15] = 4,
    [101] = 5,
    [117] = 6
  }
}
return {raw, indexed}
