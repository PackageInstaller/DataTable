local raw = {
  [1] = ProtobufI("TalentMisc", {
    interval = {
      [1] = ProtobufI("TalentMisc.TalentScoreInterval", {val = 1.0}),
      [2] = ProtobufI("TalentMisc.TalentScoreInterval", {val = 24.0}),
      [3] = ProtobufI("TalentMisc.TalentScoreInterval", {val = 49.0}),
      [4] = ProtobufI("TalentMisc.TalentScoreInterval", {val = 74.0}),
      [5] = ProtobufI("TalentMisc.TalentScoreInterval", {val = 100.0})
    },
    cultivationCoe = 1.138
  })
}
local indexed = {}
return {raw, indexed}
