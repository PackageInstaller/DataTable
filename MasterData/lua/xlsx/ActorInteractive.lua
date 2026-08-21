local raw = {
  [1] = ProtobufI("ActorInteractive", {
    id = 1,
    interactiveProbability = 10000,
    participants = {
      [1] = ProtobufI("ActorInteractive.Participant", {actorId = 1001}),
      [2] = ProtobufI("ActorInteractive.Participant", {actorId = 1008})
    },
    scenarios = {
      [1] = ProtobufI("ActorInteractive.Scenario", {actorId = 1008, duration = 1.0}),
      [2] = ProtobufI("ActorInteractive.Scenario", {actorId = 1001, duration = 1.0}),
      [3] = ProtobufI("ActorInteractive.Scenario", {actorId = 1008, duration = 1.0}),
      [4] = ProtobufI("ActorInteractive.Scenario", {actorId = 1001, duration = 1.0})
    }
  }),
  [2] = ProtobufI("ActorInteractive", {
    id = 2,
    interactiveProbability = 10000,
    participants = {
      [1] = ProtobufI("ActorInteractive.Participant", {actorId = 1011, furnitureId = 100405}),
      [2] = ProtobufI("ActorInteractive.Participant", {actorId = 1002})
    },
    scenarios = {
      [1] = ProtobufI("ActorInteractive.Scenario", {actorId = 1002, duration = 1.0}),
      [2] = ProtobufI("ActorInteractive.Scenario", {actorId = 1011, duration = 1.0})
    }
  })
}
local indexed = {
  [1] = 1,
  [2] = 2
}
return {raw, indexed}
