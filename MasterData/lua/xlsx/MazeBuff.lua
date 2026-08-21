local raw = {
  [1] = ProtobufI("MazeBuff", {
    buffId = 1,
    type = 1,
    duration = 5,
    persistentType = 1,
    range = 1,
    param = ProtobufI("MazeBuff.BuffParam", {
      type = 3,
      value = -5000,
      isRatio = 1
    }),
    buffIcon = "Tbuff_DamageUp_x",
    buffBigIcon = "Tbuff_DamageUp_XL"
  }),
  [2] = ProtobufI("MazeBuff", {
    buffId = 2,
    type = 1,
    duration = 5,
    persistentType = 1,
    range = 1,
    param = ProtobufI("MazeBuff.BuffParam", {
      type = 3,
      value = 5000,
      isRatio = 1
    }),
    buffIcon = "Tdebuff_DamageDown_x",
    buffBigIcon = "Tdebuff_DamageDown_XL"
  }),
  [3] = ProtobufI("MazeBuff", {
    buffId = 3,
    type = 1,
    duration = 3,
    persistentType = 2,
    range = 1,
    param = ProtobufI("MazeBuff.BuffParam", {
      type = 5,
      value = -5000,
      isRatio = 1
    }),
    buffIcon = "Tbuff_DefenseUp_x",
    buffBigIcon = "Tbuff_DefenseUp_XL"
  }),
  [4] = ProtobufI("MazeBuff", {
    buffId = 4,
    type = 1,
    duration = 3,
    persistentType = 2,
    range = 1,
    param = ProtobufI("MazeBuff.BuffParam", {
      type = 5,
      value = 5000,
      isRatio = 1
    }),
    buffIcon = "Tdebuff_DefenseDown_x",
    buffBigIcon = "Tdebuff_DefenseDown_XL"
  }),
  [5] = ProtobufI("MazeBuff", {
    buffId = 5,
    type = 1,
    duration = 3,
    persistentType = 2,
    range = 1,
    param = ProtobufI("MazeBuff.BuffParam", {
      type = 13,
      value = -5000,
      isRatio = 1
    }),
    buffIcon = "Tbuff_StatusUp_x",
    buffBigIcon = "Tbuff_StatusUp_XL"
  }),
  [6] = ProtobufI("MazeBuff", {
    buffId = 6,
    type = 1,
    duration = 3,
    persistentType = 2,
    range = 1,
    param = ProtobufI("MazeBuff.BuffParam", {
      type = 13,
      value = 5000,
      isRatio = 1
    }),
    buffIcon = "Tdebuff_StatusDown_x",
    buffBigIcon = "Tdebuff_StatusDown_XL"
  }),
  [7] = ProtobufI("MazeBuff", {
    buffId = 7,
    type = 2,
    persistentType = 3,
    range = 1,
    param = ProtobufI("MazeBuff.BuffParam", {value = 1}),
    buffIcon = "buff_HealUp_x",
    buffBigIcon = "buff_HealUp_XL"
  }),
  [8] = ProtobufI("MazeBuff", {
    buffId = 8,
    type = 2,
    persistentType = 3,
    range = 1,
    param = ProtobufI("MazeBuff.BuffParam", {value = 1}),
    buffIcon = "buff_HoT_x",
    buffBigIcon = "buff_HoT_XL"
  }),
  [9] = ProtobufI("MazeBuff", {
    buffId = 9,
    type = 3,
    persistentType = 3,
    range = 1,
    param = ProtobufI("MazeBuff.BuffParam", {value = 1}),
    buffIcon = "Tbuff_HealUp_x",
    buffBigIcon = "Tbuff_HealUp_XL"
  }),
  [10] = ProtobufI("MazeBuff", {
    buffId = 10,
    type = 3,
    persistentType = 3,
    range = 1,
    param = ProtobufI("MazeBuff.BuffParam", {value = 1}),
    buffIcon = "Tdebuff_HealDown_x",
    buffBigIcon = "Tdebuff_HealDown_XL"
  }),
  [11] = ProtobufI("MazeBuff", {
    buffId = 11,
    type = 2,
    persistentType = 4,
    range = 1,
    param = ProtobufI("MazeBuff.BuffParam", {value = 1}),
    buffIcon = "buff_HealUp_x",
    buffBigIcon = "buff_HealUp_XL"
  }),
  [12] = ProtobufI("MazeBuff", {
    buffId = 12,
    type = 2,
    persistentType = 4,
    range = 1,
    param = ProtobufI("MazeBuff.BuffParam", {value = 1}),
    buffIcon = "buff_HoT_x",
    buffBigIcon = "buff_HoT_XL"
  }),
  [13] = ProtobufI("MazeBuff", {
    buffId = 13,
    type = 3,
    persistentType = 4,
    range = 1,
    param = ProtobufI("MazeBuff.BuffParam", {value = 1}),
    buffIcon = "Tbuff_HealUp_x",
    buffBigIcon = "Tbuff_HealUp_XL"
  }),
  [14] = ProtobufI("MazeBuff", {
    buffId = 14,
    type = 3,
    persistentType = 4,
    range = 1,
    param = ProtobufI("MazeBuff.BuffParam", {value = 1}),
    buffIcon = "Tdebuff_HealDown_x",
    buffBigIcon = "Tdebuff_HealDown_XL"
  }),
  [15] = ProtobufI("MazeBuff", {
    buffId = 15,
    type = 4,
    persistentType = 4,
    range = 1,
    param = ProtobufI("MazeBuff.BuffParam", {value = 1014131}),
    buffIcon = "Tbuff_Spine_x",
    buffBigIcon = "Tbuff_Spine_XL"
  })
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
  [10] = 10,
  [11] = 11,
  [12] = 12,
  [13] = 13,
  [14] = 14,
  [15] = 15
}
return {raw, indexed}
