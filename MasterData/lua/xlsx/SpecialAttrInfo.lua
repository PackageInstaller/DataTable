local raw = {
  [1] = ProtobufI("SpecialAttrInfo", {
    index = 992001,
    maxLevel = 2000,
    timing = 6,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [2] = ProtobufI("SpecialAttrInfo", {
    index = 992002,
    maxLevel = 2000,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [3] = ProtobufI("SpecialAttrInfo", {
    index = 992011,
    maxLevel = 2000,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 4,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [4] = ProtobufI("SpecialAttrInfo", {
    index = 992021,
    maxLevel = 2000,
    timing = 4,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [5] = ProtobufI("SpecialAttrInfo", {
    index = 992023,
    maxLevel = 2000,
    timing = 1,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 992024
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 9,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [6] = ProtobufI("SpecialAttrInfo", {
    index = 992024,
    maxLevel = 1,
    timing = 6,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [7] = ProtobufI("SpecialAttrInfo", {
    index = 992025,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        operation = 2,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [8] = ProtobufI("SpecialAttrInfo", {
    index = 992031,
    maxLevel = 2000,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 4,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [9] = ProtobufI("SpecialAttrInfo", {
    index = 992032,
    maxLevel = 2000,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [10] = ProtobufI("SpecialAttrInfo", {
    index = 992041,
    maxLevel = 1,
    timing = 6,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 992043,
      [2] = 992045
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 2
        },
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [11] = ProtobufI("SpecialAttrInfo", {
    index = 992043,
    maxLevel = 1,
    timing = 6,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 2
        },
        targetValue = 2,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [12] = ProtobufI("SpecialAttrInfo", {
    index = 992045,
    maxLevel = 1,
    timing = 6,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 2
        },
        targetValue = 3,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [13] = ProtobufI("SpecialAttrInfo", {
    index = 992052,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [14] = ProtobufI("SpecialAttrInfo", {
    index = 993011,
    maxLevel = 2000,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [15] = ProtobufI("SpecialAttrInfo", {
    index = 993021,
    maxLevel = 2000,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [16] = ProtobufI("SpecialAttrInfo", {
    index = 993031,
    maxLevel = 2000,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [17] = ProtobufI("SpecialAttrInfo", {
    index = 993041,
    maxLevel = 2000,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [18] = ProtobufI("SpecialAttrInfo", {
    index = 993051,
    maxLevel = 2000,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [19] = ProtobufI("SpecialAttrInfo", {
    index = 993061,
    maxLevel = 2000,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [20] = ProtobufI("SpecialAttrInfo", {
    index = 993071,
    maxLevel = 2000,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [21] = ProtobufI("SpecialAttrInfo", {
    index = 993081,
    maxLevel = 2000,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [22] = ProtobufI("SpecialAttrInfo", {
    index = 993091,
    maxLevel = 2000,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [23] = ProtobufI("SpecialAttrInfo", {
    index = 993101,
    maxLevel = 2000,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [24] = ProtobufI("SpecialAttrInfo", {
    index = 993111,
    maxLevel = 2000,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [25] = ProtobufI("SpecialAttrInfo", {
    index = 993121,
    maxLevel = 2000,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [26] = ProtobufI("SpecialAttrInfo", {
    index = 993131,
    maxLevel = 2000,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 993134
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {
          [1] = "%"
        },
        sourceOperand = {
          [1] = 2.0
        }
      })
    }
  }),
  [27] = ProtobufI("SpecialAttrInfo", {
    index = 993134,
    maxLevel = 2000,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        sourceOperation = {
          [1] = "%"
        },
        sourceOperand = {
          [1] = 2.0
        }
      })
    }
  }),
  [28] = ProtobufI("SpecialAttrInfo", {
    index = 993141,
    maxLevel = 2000,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [29] = ProtobufI("SpecialAttrInfo", {
    index = 993142,
    maxLevel = 2000,
    timing = 2,
    ownerIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [30] = ProtobufI("SpecialAttrInfo", {
    index = 993151,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [31] = ProtobufI("SpecialAttrInfo", {
    index = 993152,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [32] = ProtobufI("SpecialAttrInfo", {
    index = 993153,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [33] = ProtobufI("SpecialAttrInfo", {
    index = 993161,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [34] = ProtobufI("SpecialAttrInfo", {
    index = 993162,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [35] = ProtobufI("SpecialAttrInfo", {
    index = 993163,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [36] = ProtobufI("SpecialAttrInfo", {
    index = 993171,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [37] = ProtobufI("SpecialAttrInfo", {
    index = 993172,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [38] = ProtobufI("SpecialAttrInfo", {
    index = 993181,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [39] = ProtobufI("SpecialAttrInfo", {
    index = 993191,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [40] = ProtobufI("SpecialAttrInfo", {
    index = 993201,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [41] = ProtobufI("SpecialAttrInfo", {
    index = 993401,
    maxLevel = 5,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [42] = ProtobufI("SpecialAttrInfo", {
    index = 993402,
    maxLevel = 5,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [43] = ProtobufI("SpecialAttrInfo", {
    index = 993411,
    maxLevel = 5,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [44] = ProtobufI("SpecialAttrInfo", {
    index = 993412,
    maxLevel = 5,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [45] = ProtobufI("SpecialAttrInfo", {
    index = 993421,
    maxLevel = 5,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [46] = ProtobufI("SpecialAttrInfo", {
    index = 993501,
    maxLevel = 2000,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [47] = ProtobufI("SpecialAttrInfo", {
    index = 993511,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [48] = ProtobufI("SpecialAttrInfo", {
    index = 993521,
    maxLevel = 1,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [49] = ProtobufI("SpecialAttrInfo", {
    index = 993531,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [50] = ProtobufI("SpecialAttrInfo", {
    index = 993532,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [51] = ProtobufI("SpecialAttrInfo", {
    index = 993541,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [52] = ProtobufI("SpecialAttrInfo", {
    index = 993542,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [53] = ProtobufI("SpecialAttrInfo", {
    index = 993551,
    maxLevel = 2000,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [54] = ProtobufI("SpecialAttrInfo", {
    index = 993561,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [55] = ProtobufI("SpecialAttrInfo", {
    index = 993571,
    maxLevel = 2000,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [56] = ProtobufI("SpecialAttrInfo", {
    index = 993581,
    maxLevel = 2000,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [57] = ProtobufI("SpecialAttrInfo", {
    index = 993591,
    maxLevel = 2000,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [58] = ProtobufI("SpecialAttrInfo", {
    index = 993601,
    maxLevel = 2000,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [59] = ProtobufI("SpecialAttrInfo", {
    index = 993611,
    maxLevel = 2000,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [60] = ProtobufI("SpecialAttrInfo", {
    index = 993621,
    maxLevel = 2000,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [61] = ProtobufI("SpecialAttrInfo", {
    index = 993631,
    maxLevel = 2000,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [62] = ProtobufI("SpecialAttrInfo", {
    index = 993641,
    maxLevel = 2000,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [63] = ProtobufI("SpecialAttrInfo", {
    index = 993651,
    maxLevel = 2000,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [64] = ProtobufI("SpecialAttrInfo", {
    index = 993661,
    maxLevel = 2000,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [65] = ProtobufI("SpecialAttrInfo", {
    index = 993671,
    maxLevel = 2000,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [66] = ProtobufI("SpecialAttrInfo", {
    index = 993681,
    maxLevel = 2000,
    timing = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [67] = ProtobufI("SpecialAttrInfo", {
    index = 994001,
    maxLevel = 5,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [68] = ProtobufI("SpecialAttrInfo", {
    index = 994002,
    maxLevel = 5,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [69] = ProtobufI("SpecialAttrInfo", {
    index = 994004,
    maxLevel = 5,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [70] = ProtobufI("SpecialAttrInfo", {
    index = 994005,
    maxLevel = 5,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [71] = ProtobufI("SpecialAttrInfo", {
    index = 994011,
    maxLevel = 3,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [72] = ProtobufI("SpecialAttrInfo", {
    index = 994021,
    maxLevel = 3,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [73] = ProtobufI("SpecialAttrInfo", {
    index = 994031,
    maxLevel = 3,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [74] = ProtobufI("SpecialAttrInfo", {
    index = 994041,
    maxLevel = 3,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [75] = ProtobufI("SpecialAttrInfo", {
    index = 994051,
    maxLevel = 1,
    timing = 4,
    ownerIdentityCategory = 3,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [76] = ProtobufI("SpecialAttrInfo", {
    index = 994061,
    maxLevel = 1,
    timing = 8,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 994062,
      [2] = 994063
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 5000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 13,
        sourceIdentityCategory = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 1
        },
        operation = 4,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [77] = ProtobufI("SpecialAttrInfo", {
    index = 994062,
    maxLevel = 1,
    timing = 8,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 5000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 13,
        sourceIdentityCategory = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 2
        },
        operation = 4,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [78] = ProtobufI("SpecialAttrInfo", {
    index = 994063,
    maxLevel = 1,
    timing = 8,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 5000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 13,
        sourceIdentityCategory = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 3
        },
        operation = 4,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [79] = ProtobufI("SpecialAttrInfo", {
    index = 994071,
    maxLevel = 1,
    timing = 4,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [80] = ProtobufI("SpecialAttrInfo", {
    index = 994081,
    maxLevel = 1,
    timing = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 994082,
      [2] = 994083,
      [3] = 994085
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 10000,
        [2] = 0
      }
    }),
    conditions = {}
  }),
  [81] = ProtobufI("SpecialAttrInfo", {
    index = 994082,
    maxLevel = 1,
    timing = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 0,
        [2] = 10000
      }
    }),
    conditions = {}
  }),
  [82] = ProtobufI("SpecialAttrInfo", {
    index = 994083,
    maxLevel = 1,
    timing = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      bigSkillProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {}
  }),
  [83] = ProtobufI("SpecialAttrInfo", {
    index = 994084,
    maxLevel = 1,
    timing = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 994085
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 10000,
        [2] = 10000
      }
    }),
    conditions = {}
  }),
  [84] = ProtobufI("SpecialAttrInfo", {
    index = 994085,
    maxLevel = 1,
    timing = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      linkProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {}
  }),
  [85] = ProtobufI("SpecialAttrInfo", {
    index = 994911,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 994913
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [86] = ProtobufI("SpecialAttrInfo", {
    index = 994913,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [87] = ProtobufI("SpecialAttrInfo", {
    index = 994921,
    maxLevel = 1,
    timing = 8,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 994922
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 13,
        sourceIdentityCategory = 4,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 1
        },
        operation = 4,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [88] = ProtobufI("SpecialAttrInfo", {
    index = 994922,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [89] = ProtobufI("SpecialAttrInfo", {
    index = 994931,
    maxLevel = 1,
    timing = 8,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 994933
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 13,
        sourceIdentityCategory = 4,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 3
        },
        operation = 4,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [90] = ProtobufI("SpecialAttrInfo", {
    index = 994933,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [91] = ProtobufI("SpecialAttrInfo", {
    index = 994941,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [92] = ProtobufI("SpecialAttrInfo", {
    index = 995000,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 5,
        operation = 2,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [93] = ProtobufI("SpecialAttrInfo", {
    index = 995003,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [94] = ProtobufI("SpecialAttrInfo", {
    index = 995007,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 7,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [95] = ProtobufI("SpecialAttrInfo", {
    index = 996000,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [96] = ProtobufI("SpecialAttrInfo", {
    index = 996001,
    maxLevel = 1,
    timing = 8,
    targetIdentityCategory = 3,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 13,
        sourceIdentityCategory = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 101
        },
        operation = 4,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [97] = ProtobufI("SpecialAttrInfo", {
    index = 996002,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 996003
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [98] = ProtobufI("SpecialAttrInfo", {
    index = 996003,
    maxLevel = 1,
    timing = 2,
    ownerIdentityCategory = 2,
    targetIdentityCategory = 3,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [99] = ProtobufI("SpecialAttrInfo", {
    index = 996004,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [100] = ProtobufI("SpecialAttrInfo", {
    index = 996006,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [101] = ProtobufI("SpecialAttrInfo", {
    index = 996007,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [102] = ProtobufI("SpecialAttrInfo", {
    index = 996008,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [103] = ProtobufI("SpecialAttrInfo", {
    index = 996009,
    maxLevel = 1,
    timing = 4,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [104] = ProtobufI("SpecialAttrInfo", {
    index = 996010,
    maxLevel = 1,
    timing = 4,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [105] = ProtobufI("SpecialAttrInfo", {
    index = 996011,
    maxLevel = 1,
    timing = 4,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [106] = ProtobufI("SpecialAttrInfo", {
    index = 996012,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [107] = ProtobufI("SpecialAttrInfo", {
    index = 996013,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [108] = ProtobufI("SpecialAttrInfo", {
    index = 996014,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [109] = ProtobufI("SpecialAttrInfo", {
    index = 996015,
    maxLevel = 1,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 101
        },
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [110] = ProtobufI("SpecialAttrInfo", {
    index = 996016,
    maxLevel = 1,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 101
        },
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [111] = ProtobufI("SpecialAttrInfo", {
    index = 996017,
    maxLevel = 1,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 101
        },
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [112] = ProtobufI("SpecialAttrInfo", {
    index = 996018,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [113] = ProtobufI("SpecialAttrInfo", {
    index = 996019,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [114] = ProtobufI("SpecialAttrInfo", {
    index = 996020,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [115] = ProtobufI("SpecialAttrInfo", {
    index = 996021,
    maxLevel = 1,
    timing = 2,
    ownerIdentityCategory = 2,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [116] = ProtobufI("SpecialAttrInfo", {
    index = 996022,
    maxLevel = 1,
    timing = 2,
    ownerIdentityCategory = 2,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [117] = ProtobufI("SpecialAttrInfo", {
    index = 996023,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 996021,
      [2] = 996022
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [118] = ProtobufI("SpecialAttrInfo", {
    index = 996025,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [119] = ProtobufI("SpecialAttrInfo", {
    index = 996027,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [120] = ProtobufI("SpecialAttrInfo", {
    index = 996029,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [121] = ProtobufI("SpecialAttrInfo", {
    index = 996031,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [122] = ProtobufI("SpecialAttrInfo", {
    index = 996032,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [123] = ProtobufI("SpecialAttrInfo", {
    index = 996033,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [124] = ProtobufI("SpecialAttrInfo", {
    index = 996034,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [125] = ProtobufI("SpecialAttrInfo", {
    index = 996035,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [126] = ProtobufI("SpecialAttrInfo", {
    index = 996036,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [127] = ProtobufI("SpecialAttrInfo", {
    index = 996037,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 101
        },
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [128] = ProtobufI("SpecialAttrInfo", {
    index = 996038,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 102
        },
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [129] = ProtobufI("SpecialAttrInfo", {
    index = 996039,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 102
        },
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [130] = ProtobufI("SpecialAttrInfo", {
    index = 996040,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 102
        },
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [131] = ProtobufI("SpecialAttrInfo", {
    index = 996042,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 101
        },
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [132] = ProtobufI("SpecialAttrInfo", {
    index = 996043,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [133] = ProtobufI("SpecialAttrInfo", {
    index = 996044,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [134] = ProtobufI("SpecialAttrInfo", {
    index = 996045,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [135] = ProtobufI("SpecialAttrInfo", {
    index = 996046,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [136] = ProtobufI("SpecialAttrInfo", {
    index = 996047,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [137] = ProtobufI("SpecialAttrInfo", {
    index = 996048,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [138] = ProtobufI("SpecialAttrInfo", {
    index = 996049,
    maxLevel = 1,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 101
        },
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [139] = ProtobufI("SpecialAttrInfo", {
    index = 996052,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [140] = ProtobufI("SpecialAttrInfo", {
    index = 996053,
    maxLevel = 1,
    timing = 8,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 12,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 923
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 12,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 1,
          [2] = 13
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [141] = ProtobufI("SpecialAttrInfo", {
    index = 996054,
    maxLevel = 1,
    timing = 8,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 12,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 21
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 12,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 1,
          [2] = 2
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [142] = ProtobufI("SpecialAttrInfo", {
    index = 996055,
    maxLevel = 1,
    timing = 8,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 12,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 22
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 12,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 1,
          [2] = 2
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [143] = ProtobufI("SpecialAttrInfo", {
    index = 996056,
    maxLevel = 1,
    timing = 8,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 12,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 923
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 12,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 1,
          [2] = 6
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [144] = ProtobufI("SpecialAttrInfo", {
    index = 996057,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 996053,
      [2] = 996054,
      [3] = 996055,
      [4] = 996056,
      [5] = 996059,
      [6] = 996060,
      [7] = 996061,
      [8] = 996062
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [145] = ProtobufI("SpecialAttrInfo", {
    index = 996058,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [146] = ProtobufI("SpecialAttrInfo", {
    index = 996059,
    maxLevel = 1,
    timing = 11,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 18,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 923
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 18,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 1,
          [2] = 13
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [147] = ProtobufI("SpecialAttrInfo", {
    index = 996060,
    maxLevel = 1,
    timing = 11,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 18,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 21
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 18,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 1,
          [2] = 2
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [148] = ProtobufI("SpecialAttrInfo", {
    index = 996061,
    maxLevel = 1,
    timing = 11,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 18,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 22
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 18,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 1,
          [2] = 2
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [149] = ProtobufI("SpecialAttrInfo", {
    index = 996062,
    maxLevel = 1,
    timing = 11,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 18,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 923
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 18,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 1,
          [2] = 6
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [150] = ProtobufI("SpecialAttrInfo", {
    index = 996063,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [151] = ProtobufI("SpecialAttrInfo", {
    index = 996064,
    maxLevel = 1,
    timing = 4,
    ownerIdentityCategory = 3,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [152] = ProtobufI("SpecialAttrInfo", {
    index = 996065,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 996064
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [153] = ProtobufI("SpecialAttrInfo", {
    index = 996066,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [154] = ProtobufI("SpecialAttrInfo", {
    index = 996067,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 996069
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [155] = ProtobufI("SpecialAttrInfo", {
    index = 996068,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [156] = ProtobufI("SpecialAttrInfo", {
    index = 996069,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [157] = ProtobufI("SpecialAttrInfo", {
    index = 996070,
    maxLevel = 1,
    timing = 2,
    ownerIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [158] = ProtobufI("SpecialAttrInfo", {
    index = 996071,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [159] = ProtobufI("SpecialAttrInfo", {
    index = 996072,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [160] = ProtobufI("SpecialAttrInfo", {
    index = 996073,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [161] = ProtobufI("SpecialAttrInfo", {
    index = 996074,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [162] = ProtobufI("SpecialAttrInfo", {
    index = 996075,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [163] = ProtobufI("SpecialAttrInfo", {
    index = 996078,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {
          [1] = "%"
        },
        sourceOperand = {
          [1] = 2.0
        }
      })
    }
  }),
  [164] = ProtobufI("SpecialAttrInfo", {
    index = 996079,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [165] = ProtobufI("SpecialAttrInfo", {
    index = 996080,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 996081,
      [2] = 996082,
      [3] = 996083,
      [4] = 996084,
      [5] = 996085
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 5000,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 6000,
        operation = 2,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [166] = ProtobufI("SpecialAttrInfo", {
    index = 996081,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 6000,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 7000,
        operation = 2,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [167] = ProtobufI("SpecialAttrInfo", {
    index = 996082,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 7000,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 8000,
        operation = 2,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [168] = ProtobufI("SpecialAttrInfo", {
    index = 996083,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 8000,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 9000,
        operation = 2,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [169] = ProtobufI("SpecialAttrInfo", {
    index = 996084,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 9000,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 9500,
        operation = 2,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [170] = ProtobufI("SpecialAttrInfo", {
    index = 996085,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 9500,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 10000,
        operation = 3,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [171] = ProtobufI("SpecialAttrInfo", {
    index = 996086,
    maxLevel = 1,
    timing = 14,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 996087,
      [2] = 996088
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [172] = ProtobufI("SpecialAttrInfo", {
    index = 996087,
    maxLevel = 1,
    timing = 14,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [173] = ProtobufI("SpecialAttrInfo", {
    index = 996088,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [174] = ProtobufI("SpecialAttrInfo", {
    index = 996089,
    maxLevel = 1,
    timing = 2,
    ownerIdentityCategory = 2,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 996091
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [175] = ProtobufI("SpecialAttrInfo", {
    index = 996090,
    maxLevel = 1,
    timing = 2,
    ownerIdentityCategory = 2,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 996092
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [176] = ProtobufI("SpecialAttrInfo", {
    index = 996091,
    maxLevel = 1,
    timing = 2,
    ownerIdentityCategory = 2,
    targetIdentityCategory = 3,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [177] = ProtobufI("SpecialAttrInfo", {
    index = 996092,
    maxLevel = 1,
    timing = 2,
    ownerIdentityCategory = 2,
    targetIdentityCategory = 3,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [178] = ProtobufI("SpecialAttrInfo", {
    index = 996093,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [179] = ProtobufI("SpecialAttrInfo", {
    index = 996094,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [180] = ProtobufI("SpecialAttrInfo", {
    index = 996095,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [181] = ProtobufI("SpecialAttrInfo", {
    index = 996096,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 996097
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [182] = ProtobufI("SpecialAttrInfo", {
    index = 996097,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [183] = ProtobufI("SpecialAttrInfo", {
    index = 996098,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 1000999
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [184] = ProtobufI("SpecialAttrInfo", {
    index = 996099,
    maxLevel = 1,
    timing = 6,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 996100,
      [2] = 996101,
      [3] = 996102,
      [4] = 996103
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 8000,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 10000,
        operation = 3,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [185] = ProtobufI("SpecialAttrInfo", {
    index = 996100,
    maxLevel = 1,
    timing = 6,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 5000,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 8000,
        operation = 2,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [186] = ProtobufI("SpecialAttrInfo", {
    index = 996101,
    maxLevel = 1,
    timing = 6,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 3000,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 5000,
        operation = 2,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [187] = ProtobufI("SpecialAttrInfo", {
    index = 996102,
    maxLevel = 1,
    timing = 6,
    ownerIdentityCategory = 1,
    targetIdentityCategory = 3,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 3000,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 5000,
        operation = 2,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [188] = ProtobufI("SpecialAttrInfo", {
    index = 996103,
    maxLevel = 1,
    timing = 6,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 3000,
        operation = 2,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [189] = ProtobufI("SpecialAttrInfo", {
    index = 996104,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [190] = ProtobufI("SpecialAttrInfo", {
    index = 996105,
    maxLevel = 1,
    timing = 4,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [191] = ProtobufI("SpecialAttrInfo", {
    index = 996106,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [192] = ProtobufI("SpecialAttrInfo", {
    index = 996107,
    maxLevel = 1,
    timing = 13,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [193] = ProtobufI("SpecialAttrInfo", {
    index = 996108,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [194] = ProtobufI("SpecialAttrInfo", {
    index = 996109,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 2,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [195] = ProtobufI("SpecialAttrInfo", {
    index = 996110,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 2,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [196] = ProtobufI("SpecialAttrInfo", {
    index = 996111,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 2,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [197] = ProtobufI("SpecialAttrInfo", {
    index = 996112,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 996113
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 2,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [198] = ProtobufI("SpecialAttrInfo", {
    index = 996113,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetIdentityCategory = 3,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 2,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [199] = ProtobufI("SpecialAttrInfo", {
    index = 996114,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [200] = ProtobufI("SpecialAttrInfo", {
    index = 996115,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 2,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [201] = ProtobufI("SpecialAttrInfo", {
    index = 996116,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [202] = ProtobufI("SpecialAttrInfo", {
    index = 996117,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 2,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [203] = ProtobufI("SpecialAttrInfo", {
    index = 996118,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [204] = ProtobufI("SpecialAttrInfo", {
    index = 996119,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [205] = ProtobufI("SpecialAttrInfo", {
    index = 996120,
    maxLevel = 1,
    timing = 13,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [206] = ProtobufI("SpecialAttrInfo", {
    index = 996121,
    maxLevel = 1,
    timing = 13,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [207] = ProtobufI("SpecialAttrInfo", {
    index = 996122,
    maxLevel = 1,
    timing = 14,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [208] = ProtobufI("SpecialAttrInfo", {
    index = 996123,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [209] = ProtobufI("SpecialAttrInfo", {
    index = 996124,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 101
        },
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [210] = ProtobufI("SpecialAttrInfo", {
    index = 996125,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 996124
        },
        operation = 4,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [211] = ProtobufI("SpecialAttrInfo", {
    index = 996126,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [212] = ProtobufI("SpecialAttrInfo", {
    index = 996127,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [213] = ProtobufI("SpecialAttrInfo", {
    index = 996128,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 3,
        sourceIdentityCategory = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 2,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [214] = ProtobufI("SpecialAttrInfo", {
    index = 996130,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 996131
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [215] = ProtobufI("SpecialAttrInfo", {
    index = 996131,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetIdentityCategory = 3,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 996124
        },
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 2,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [216] = ProtobufI("SpecialAttrInfo", {
    index = 996132,
    maxLevel = 1,
    timing = 14,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [217] = ProtobufI("SpecialAttrInfo", {
    index = 996133,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [218] = ProtobufI("SpecialAttrInfo", {
    index = 996134,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 996135
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {
          [1] = "%"
        },
        sourceOperand = {
          [1] = 2.0
        }
      })
    }
  }),
  [219] = ProtobufI("SpecialAttrInfo", {
    index = 996135,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        sourceOperation = {
          [1] = "%"
        },
        sourceOperand = {
          [1] = 2.0
        }
      })
    }
  }),
  [220] = ProtobufI("SpecialAttrInfo", {
    index = 996138,
    maxLevel = 1,
    timing = 6,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 3,
        sourceExtraParam = {
          [1] = 0,
          [2] = 2
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [221] = ProtobufI("SpecialAttrInfo", {
    index = 996139,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [222] = ProtobufI("SpecialAttrInfo", {
    index = 996140,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [223] = ProtobufI("SpecialAttrInfo", {
    index = 996141,
    maxLevel = 1,
    timing = 4,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [224] = ProtobufI("SpecialAttrInfo", {
    index = 996143,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 996144
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [225] = ProtobufI("SpecialAttrInfo", {
    index = 996144,
    maxLevel = 1,
    timing = 4,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {}
  }),
  [226] = ProtobufI("SpecialAttrInfo", {
    index = 996145,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [227] = ProtobufI("SpecialAttrInfo", {
    index = 996146,
    maxLevel = 1,
    timing = 4,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {}
  }),
  [228] = ProtobufI("SpecialAttrInfo", {
    index = 996147,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [229] = ProtobufI("SpecialAttrInfo", {
    index = 996148,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [230] = ProtobufI("SpecialAttrInfo", {
    index = 996149,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [231] = ProtobufI("SpecialAttrInfo", {
    index = 996150,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 996151
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [232] = ProtobufI("SpecialAttrInfo", {
    index = 996151,
    maxLevel = 1,
    timing = 4,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {}
  }),
  [233] = ProtobufI("SpecialAttrInfo", {
    index = 996152,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 996153
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [234] = ProtobufI("SpecialAttrInfo", {
    index = 996153,
    maxLevel = 1,
    timing = 4,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {}
  }),
  [235] = ProtobufI("SpecialAttrInfo", {
    index = 996154,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 996155,
      [2] = 996156
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [236] = ProtobufI("SpecialAttrInfo", {
    index = 996155,
    maxLevel = 1,
    timing = 1,
    ownerIdentityCategory = 3,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 6000,
        operation = 2,
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 996154
        },
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [237] = ProtobufI("SpecialAttrInfo", {
    index = 996156,
    maxLevel = 1,
    timing = 4,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {}
  }),
  [238] = ProtobufI("SpecialAttrInfo", {
    index = 996157,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 996158,
      [2] = 996159,
      [3] = 996160,
      [4] = 996161
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [239] = ProtobufI("SpecialAttrInfo", {
    index = 996158,
    maxLevel = 1,
    timing = 1,
    ownerIdentityCategory = 3,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 5000,
        operation = 2,
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 996157
        },
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [240] = ProtobufI("SpecialAttrInfo", {
    index = 996159,
    maxLevel = 1,
    timing = 6,
    ownerIdentityCategory = 1,
    targetIdentityCategory = 3,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 5000,
        operation = 2,
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 996160
        },
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [241] = ProtobufI("SpecialAttrInfo", {
    index = 996160,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [242] = ProtobufI("SpecialAttrInfo", {
    index = 996161,
    maxLevel = 1,
    timing = 1,
    ownerIdentityCategory = 3,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 996160
        },
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [243] = ProtobufI("SpecialAttrInfo", {
    index = 997000,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [244] = ProtobufI("SpecialAttrInfo", {
    index = 997001,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceExtraParam = {},
        targetValue = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [245] = ProtobufI("SpecialAttrInfo", {
    index = 997002,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [246] = ProtobufI("SpecialAttrInfo", {
    index = 997003,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [247] = ProtobufI("SpecialAttrInfo", {
    index = 997004,
    maxLevel = 1,
    timing = 4,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [248] = ProtobufI("SpecialAttrInfo", {
    index = 997005,
    maxLevel = 1,
    timing = 4,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 997007
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [249] = ProtobufI("SpecialAttrInfo", {
    index = 997006,
    maxLevel = 1,
    timing = 4,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 997008
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [250] = ProtobufI("SpecialAttrInfo", {
    index = 997007,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [251] = ProtobufI("SpecialAttrInfo", {
    index = 997008,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [252] = ProtobufI("SpecialAttrInfo", {
    index = 997009,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [253] = ProtobufI("SpecialAttrInfo", {
    index = 997010,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 997011,
      [2] = 997012,
      [3] = 997016
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [254] = ProtobufI("SpecialAttrInfo", {
    index = 997011,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [255] = ProtobufI("SpecialAttrInfo", {
    index = 997012,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 2,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [256] = ProtobufI("SpecialAttrInfo", {
    index = 997013,
    maxLevel = 1,
    timing = 4,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 997014
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [257] = ProtobufI("SpecialAttrInfo", {
    index = 997014,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [258] = ProtobufI("SpecialAttrInfo", {
    index = 997016,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [259] = ProtobufI("SpecialAttrInfo", {
    index = 997015,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [260] = ProtobufI("SpecialAttrInfo", {
    index = 997017,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [261] = ProtobufI("SpecialAttrInfo", {
    index = 997018,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [262] = ProtobufI("SpecialAttrInfo", {
    index = 997021,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [263] = ProtobufI("SpecialAttrInfo", {
    index = 997022,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [264] = ProtobufI("SpecialAttrInfo", {
    index = 997023,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [265] = ProtobufI("SpecialAttrInfo", {
    index = 997024,
    maxLevel = 1,
    timing = 4,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [266] = ProtobufI("SpecialAttrInfo", {
    index = 997025,
    maxLevel = 1,
    timing = 4,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [267] = ProtobufI("SpecialAttrInfo", {
    index = 997026,
    maxLevel = 1,
    timing = 4,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [268] = ProtobufI("SpecialAttrInfo", {
    index = 997030,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [269] = ProtobufI("SpecialAttrInfo", {
    index = 997031,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 997030,
      [2] = 997034,
      [3] = 997035
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [270] = ProtobufI("SpecialAttrInfo", {
    index = 997032,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 997030,
      [2] = 997034,
      [3] = 997036
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [271] = ProtobufI("SpecialAttrInfo", {
    index = 997033,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 997030,
      [2] = 997034,
      [3] = 997037
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [272] = ProtobufI("SpecialAttrInfo", {
    index = 997034,
    maxLevel = 1,
    timing = 4,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [273] = ProtobufI("SpecialAttrInfo", {
    index = 997035,
    maxLevel = 1,
    timing = 4,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [274] = ProtobufI("SpecialAttrInfo", {
    index = 997036,
    maxLevel = 1,
    timing = 4,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [275] = ProtobufI("SpecialAttrInfo", {
    index = 997037,
    maxLevel = 1,
    timing = 4,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [276] = ProtobufI("SpecialAttrInfo", {
    index = 997040,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 997041
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [277] = ProtobufI("SpecialAttrInfo", {
    index = 997041,
    maxLevel = 1,
    timing = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [278] = ProtobufI("SpecialAttrInfo", {
    index = 997050,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [279] = ProtobufI("SpecialAttrInfo", {
    index = 997051,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 997052
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [280] = ProtobufI("SpecialAttrInfo", {
    index = 997052,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [281] = ProtobufI("SpecialAttrInfo", {
    index = 997053,
    maxLevel = 1,
    timing = 8,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 997051
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [282] = ProtobufI("SpecialAttrInfo", {
    index = 997054,
    maxLevel = 1,
    timing = 8,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 997051
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [283] = ProtobufI("SpecialAttrInfo", {
    index = 997055,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [284] = ProtobufI("SpecialAttrInfo", {
    index = 997056,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [285] = ProtobufI("SpecialAttrInfo", {
    index = 997057,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 997055
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [286] = ProtobufI("SpecialAttrInfo", {
    index = 997061,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [287] = ProtobufI("SpecialAttrInfo", {
    index = 997062,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [288] = ProtobufI("SpecialAttrInfo", {
    index = 997063,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [289] = ProtobufI("SpecialAttrInfo", {
    index = 997071,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [290] = ProtobufI("SpecialAttrInfo", {
    index = 997072,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [291] = ProtobufI("SpecialAttrInfo", {
    index = 997073,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [292] = ProtobufI("SpecialAttrInfo", {
    index = 997074,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [293] = ProtobufI("SpecialAttrInfo", {
    index = 997075,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [294] = ProtobufI("SpecialAttrInfo", {
    index = 997076,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [295] = ProtobufI("SpecialAttrInfo", {
    index = 997081,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 997085
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {
          [1] = "%"
        },
        sourceOperand = {
          [1] = 3.0
        }
      })
    }
  }),
  [296] = ProtobufI("SpecialAttrInfo", {
    index = 997082,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 997086
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 2,
        sourceOperation = {
          [1] = "%"
        },
        sourceOperand = {
          [1] = 3.0
        }
      })
    }
  }),
  [297] = ProtobufI("SpecialAttrInfo", {
    index = 997083,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 997084
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        sourceOperation = {
          [1] = "%"
        },
        sourceOperand = {
          [1] = 3.0
        }
      })
    }
  }),
  [298] = ProtobufI("SpecialAttrInfo", {
    index = 997084,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {
          [1] = "%"
        },
        sourceOperand = {
          [1] = 3.0
        }
      })
    }
  }),
  [299] = ProtobufI("SpecialAttrInfo", {
    index = 997085,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 2,
        sourceOperation = {
          [1] = "%"
        },
        sourceOperand = {
          [1] = 3.0
        }
      })
    }
  }),
  [300] = ProtobufI("SpecialAttrInfo", {
    index = 997086,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        sourceOperation = {
          [1] = "%"
        },
        sourceOperand = {
          [1] = 3.0
        }
      })
    }
  }),
  [301] = ProtobufI("SpecialAttrInfo", {
    index = 997087,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [302] = ProtobufI("SpecialAttrInfo", {
    index = 997091,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [303] = ProtobufI("SpecialAttrInfo", {
    index = 997095,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [304] = ProtobufI("SpecialAttrInfo", {
    index = 997101,
    maxLevel = 1,
    timing = 8,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 13,
        sourceIdentityCategory = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 2
        },
        operation = 4,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [305] = ProtobufI("SpecialAttrInfo", {
    index = 997111,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [306] = ProtobufI("SpecialAttrInfo", {
    index = 997112,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [307] = ProtobufI("SpecialAttrInfo", {
    index = 997121,
    maxLevel = 2,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [308] = ProtobufI("SpecialAttrInfo", {
    index = 997131,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [309] = ProtobufI("SpecialAttrInfo", {
    index = 997135,
    maxLevel = 1,
    timing = 2,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 997131
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 0,
        [2] = 10000
      }
    }),
    conditions = {}
  }),
  [310] = ProtobufI("SpecialAttrInfo", {
    index = 997137,
    maxLevel = 1,
    timing = 2,
    targetIdentityCategory = 3,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 997131,
      [2] = 997138
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 0,
        [2] = 10000
      }
    }),
    conditions = {}
  }),
  [311] = ProtobufI("SpecialAttrInfo", {
    index = 997138,
    maxLevel = 1,
    timing = 2,
    targetIdentityCategory = 3,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      bigSkillProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {}
  }),
  [312] = ProtobufI("SpecialAttrInfo", {
    index = 997139,
    maxLevel = 1,
    timing = 2,
    targetIdentityCategory = 3,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 997131
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 0,
        [2] = 10000
      }
    }),
    conditions = {}
  }),
  [313] = ProtobufI("SpecialAttrInfo", {
    index = 997201,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [314] = ProtobufI("SpecialAttrInfo", {
    index = 997202,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 997205
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [315] = ProtobufI("SpecialAttrInfo", {
    index = 997203,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 997206
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [316] = ProtobufI("SpecialAttrInfo", {
    index = 997204,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 997207
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [317] = ProtobufI("SpecialAttrInfo", {
    index = 997205,
    maxLevel = 1,
    timing = 4,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [318] = ProtobufI("SpecialAttrInfo", {
    index = 997206,
    maxLevel = 1,
    timing = 4,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [319] = ProtobufI("SpecialAttrInfo", {
    index = 997207,
    maxLevel = 1,
    timing = 4,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [320] = ProtobufI("SpecialAttrInfo", {
    index = 997211,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [321] = ProtobufI("SpecialAttrInfo", {
    index = 997213,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [322] = ProtobufI("SpecialAttrInfo", {
    index = 997221,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [323] = ProtobufI("SpecialAttrInfo", {
    index = 997222,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [324] = ProtobufI("SpecialAttrInfo", {
    index = 997223,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [325] = ProtobufI("SpecialAttrInfo", {
    index = 997224,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [326] = ProtobufI("SpecialAttrInfo", {
    index = 997225,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [327] = ProtobufI("SpecialAttrInfo", {
    index = 997226,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [328] = ProtobufI("SpecialAttrInfo", {
    index = 997227,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [329] = ProtobufI("SpecialAttrInfo", {
    index = 997228,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [330] = ProtobufI("SpecialAttrInfo", {
    index = 997229,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [331] = ProtobufI("SpecialAttrInfo", {
    index = 997230,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [332] = ProtobufI("SpecialAttrInfo", {
    index = 997231,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [333] = ProtobufI("SpecialAttrInfo", {
    index = 997232,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [334] = ProtobufI("SpecialAttrInfo", {
    index = 997233,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [335] = ProtobufI("SpecialAttrInfo", {
    index = 997234,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [336] = ProtobufI("SpecialAttrInfo", {
    index = 997235,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [337] = ProtobufI("SpecialAttrInfo", {
    index = 997236,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [338] = ProtobufI("SpecialAttrInfo", {
    index = 997237,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [339] = ProtobufI("SpecialAttrInfo", {
    index = 997238,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [340] = ProtobufI("SpecialAttrInfo", {
    index = 997239,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [341] = ProtobufI("SpecialAttrInfo", {
    index = 997240,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [342] = ProtobufI("SpecialAttrInfo", {
    index = 997241,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [343] = ProtobufI("SpecialAttrInfo", {
    index = 997301,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      bigSkillProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {}
  }),
  [344] = ProtobufI("SpecialAttrInfo", {
    index = 997311,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 997315,
      [2] = 997316,
      [3] = 997317,
      [4] = 997318,
      [5] = 997319,
      [6] = 997320,
      [7] = 997321
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [345] = ProtobufI("SpecialAttrInfo", {
    index = 997312,
    maxLevel = 1,
    timing = 6,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [346] = ProtobufI("SpecialAttrInfo", {
    index = 997315,
    maxLevel = 1,
    timing = 1,
    ownerIdentityCategory = 3,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 997311
        },
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 997315
        },
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [347] = ProtobufI("SpecialAttrInfo", {
    index = 997316,
    maxLevel = 1,
    timing = 1,
    ownerIdentityCategory = 3,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 997311
        },
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 997316
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [348] = ProtobufI("SpecialAttrInfo", {
    index = 997317,
    maxLevel = 1,
    timing = 1,
    ownerIdentityCategory = 3,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 997311
        },
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 997317
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [349] = ProtobufI("SpecialAttrInfo", {
    index = 997318,
    maxLevel = 1,
    timing = 1,
    ownerIdentityCategory = 3,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 997311
        },
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 997318
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [350] = ProtobufI("SpecialAttrInfo", {
    index = 997319,
    maxLevel = 1,
    timing = 2,
    ownerIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      bigSkillProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {}
  }),
  [351] = ProtobufI("SpecialAttrInfo", {
    index = 997320,
    maxLevel = 1,
    timing = 2,
    ownerIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      linkProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {}
  }),
  [352] = ProtobufI("SpecialAttrInfo", {
    index = 997321,
    maxLevel = 1,
    timing = 6,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 3,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 1
        },
        targetValue = 3,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [353] = ProtobufI("SpecialAttrInfo", {
    index = 997341,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 997348,
      [2] = 997350
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [354] = ProtobufI("SpecialAttrInfo", {
    index = 997343,
    maxLevel = 1,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {
        [1] = 10000,
        [2] = 0
      }
    }),
    conditions = {}
  }),
  [355] = ProtobufI("SpecialAttrInfo", {
    index = 997348,
    maxLevel = 1,
    timing = 6,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 2
        },
        targetValue = 3,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [356] = ProtobufI("SpecialAttrInfo", {
    index = 997350,
    maxLevel = 1,
    timing = 6,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 3,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 997354
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 3,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 997358
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      }),
      [3] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 3,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 997362
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [357] = ProtobufI("SpecialAttrInfo", {
    index = 997351,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 997352,
      [2] = 997354
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [358] = ProtobufI("SpecialAttrInfo", {
    index = 997352,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {
        [1] = 10000,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 997351
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [359] = ProtobufI("SpecialAttrInfo", {
    index = 997353,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {
        [1] = 10000,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 997352
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [360] = ProtobufI("SpecialAttrInfo", {
    index = 997354,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {
        [1] = 0,
        [2] = 10000
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 997353
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [361] = ProtobufI("SpecialAttrInfo", {
    index = 997355,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 997357,
      [2] = 997358
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [362] = ProtobufI("SpecialAttrInfo", {
    index = 997356,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      linkProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 997355
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [363] = ProtobufI("SpecialAttrInfo", {
    index = 997357,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {
        [1] = 10000,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 997356
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [364] = ProtobufI("SpecialAttrInfo", {
    index = 997358,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      bigSkillProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 997357
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [365] = ProtobufI("SpecialAttrInfo", {
    index = 997359,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 997360,
      [2] = 997361,
      [3] = 997362
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [366] = ProtobufI("SpecialAttrInfo", {
    index = 997360,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {
        [1] = 10000,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 997359
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [367] = ProtobufI("SpecialAttrInfo", {
    index = 997361,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {
        [1] = 0,
        [2] = 10000
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 997360
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [368] = ProtobufI("SpecialAttrInfo", {
    index = 997362,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {
        [1] = 10000,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 997361
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [369] = ProtobufI("SpecialAttrInfo", {
    index = 997371,
    maxLevel = 1,
    timing = 4,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [370] = ProtobufI("SpecialAttrInfo", {
    index = 997373,
    maxLevel = 1,
    timing = 3,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 5000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 1
        },
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [371] = ProtobufI("SpecialAttrInfo", {
    index = 997401,
    maxLevel = 1,
    timing = 1,
    ownerIdentityCategory = 3,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 997415,
      [2] = 997403,
      [3] = 997411,
      [4] = 997412,
      [5] = 997413,
      [6] = 997405
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 7000,
        operation = 3,
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 997402
        },
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [372] = ProtobufI("SpecialAttrInfo", {
    index = 997403,
    maxLevel = 1,
    timing = 1,
    ownerIdentityCategory = 3,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 4000,
        operation = 3,
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 997404
        },
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [373] = ProtobufI("SpecialAttrInfo", {
    index = 997405,
    maxLevel = 1,
    timing = 6,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 997406,
      [2] = 997407,
      [3] = 997408,
      [4] = 997409,
      [5] = 997410
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 21,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 997411
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [374] = ProtobufI("SpecialAttrInfo", {
    index = 997406,
    maxLevel = 1,
    timing = 6,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 21,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 997411
        },
        targetValue = 2,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [375] = ProtobufI("SpecialAttrInfo", {
    index = 997407,
    maxLevel = 1,
    timing = 6,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 21,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 997411
        },
        targetValue = 3,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [376] = ProtobufI("SpecialAttrInfo", {
    index = 997408,
    maxLevel = 1,
    timing = 6,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 21,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 997412
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [377] = ProtobufI("SpecialAttrInfo", {
    index = 997409,
    maxLevel = 1,
    timing = 6,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 21,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 997412
        },
        targetValue = 2,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [378] = ProtobufI("SpecialAttrInfo", {
    index = 997410,
    maxLevel = 1,
    timing = 6,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 21,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 997412
        },
        targetValue = 3,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [379] = ProtobufI("SpecialAttrInfo", {
    index = 997411,
    maxLevel = 1,
    timing = 6,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 997401
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [380] = ProtobufI("SpecialAttrInfo", {
    index = 997412,
    maxLevel = 1,
    timing = 6,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 997403
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [381] = ProtobufI("SpecialAttrInfo", {
    index = 997413,
    maxLevel = 1,
    timing = 4,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [382] = ProtobufI("SpecialAttrInfo", {
    index = 997415,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [383] = ProtobufI("SpecialAttrInfo", {
    index = 998001,
    maxLevel = 1,
    timing = 4,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 998007,
      [2] = 998008,
      [3] = 998011
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [384] = ProtobufI("SpecialAttrInfo", {
    index = 998002,
    maxLevel = 1,
    timing = 4,
    targetIdentityCategory = 3,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 998007,
      [2] = 998009,
      [3] = 998012
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [385] = ProtobufI("SpecialAttrInfo", {
    index = 998003,
    maxLevel = 1,
    timing = 4,
    targetIdentityCategory = 3,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 998007,
      [2] = 998010,
      [3] = 998013
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [386] = ProtobufI("SpecialAttrInfo", {
    index = 998007,
    maxLevel = 1,
    timing = 4,
    targetIdentityCategory = 3,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [387] = ProtobufI("SpecialAttrInfo", {
    index = 998008,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [388] = ProtobufI("SpecialAttrInfo", {
    index = 998009,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [389] = ProtobufI("SpecialAttrInfo", {
    index = 998010,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [390] = ProtobufI("SpecialAttrInfo", {
    index = 998011,
    maxLevel = 1,
    timing = 2,
    ownerIdentityCategory = 2,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [391] = ProtobufI("SpecialAttrInfo", {
    index = 998012,
    maxLevel = 1,
    timing = 2,
    ownerIdentityCategory = 2,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [392] = ProtobufI("SpecialAttrInfo", {
    index = 998013,
    maxLevel = 1,
    timing = 2,
    ownerIdentityCategory = 2,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [393] = ProtobufI("SpecialAttrInfo", {
    index = 999101,
    maxLevel = 1,
    timing = 2,
    ownerIdentityCategory = 2,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 999103
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [394] = ProtobufI("SpecialAttrInfo", {
    index = 999102,
    maxLevel = 1,
    timing = 2,
    ownerIdentityCategory = 2,
    targetIdentityCategory = 3,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [395] = ProtobufI("SpecialAttrInfo", {
    index = 999103,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [396] = ProtobufI("SpecialAttrInfo", {
    index = 999201,
    maxLevel = 1,
    timing = 2,
    ownerIdentityCategory = 2,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 999203
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [397] = ProtobufI("SpecialAttrInfo", {
    index = 999202,
    maxLevel = 1,
    timing = 2,
    ownerIdentityCategory = 2,
    targetIdentityCategory = 3,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [398] = ProtobufI("SpecialAttrInfo", {
    index = 999203,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [399] = ProtobufI("SpecialAttrInfo", {
    index = 999301,
    maxLevel = 1,
    timing = 2,
    ownerIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [400] = ProtobufI("SpecialAttrInfo", {
    index = 999302,
    maxLevel = 20,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 999301
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [401] = ProtobufI("SpecialAttrInfo", {
    index = 998101,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 998102,
      [2] = 998103,
      [3] = 998104,
      [4] = 998105,
      [5] = 998106,
      [6] = 998107,
      [7] = 998108,
      [8] = 998109
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [402] = ProtobufI("SpecialAttrInfo", {
    index = 998102,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 2,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [403] = ProtobufI("SpecialAttrInfo", {
    index = 998103,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 3,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [404] = ProtobufI("SpecialAttrInfo", {
    index = 998104,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 4,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [405] = ProtobufI("SpecialAttrInfo", {
    index = 998105,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [406] = ProtobufI("SpecialAttrInfo", {
    index = 998106,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 6,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [407] = ProtobufI("SpecialAttrInfo", {
    index = 998107,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 7,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [408] = ProtobufI("SpecialAttrInfo", {
    index = 998108,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 8,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [409] = ProtobufI("SpecialAttrInfo", {
    index = 998109,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 9,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [410] = ProtobufI("SpecialAttrInfo", {
    index = 998201,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [411] = ProtobufI("SpecialAttrInfo", {
    index = 998202,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [412] = ProtobufI("SpecialAttrInfo", {
    index = 998203,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [413] = ProtobufI("SpecialAttrInfo", {
    index = 998301,
    maxLevel = 3,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 998302,
      [2] = 998303,
      [3] = 998304,
      [4] = 998305,
      [5] = 998306,
      [6] = 998307
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [414] = ProtobufI("SpecialAttrInfo", {
    index = 998302,
    maxLevel = 3,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 2,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [415] = ProtobufI("SpecialAttrInfo", {
    index = 998303,
    maxLevel = 3,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [416] = ProtobufI("SpecialAttrInfo", {
    index = 998304,
    maxLevel = 3,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 8,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [417] = ProtobufI("SpecialAttrInfo", {
    index = 998305,
    maxLevel = 3,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 11,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [418] = ProtobufI("SpecialAttrInfo", {
    index = 998306,
    maxLevel = 3,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 14,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [419] = ProtobufI("SpecialAttrInfo", {
    index = 998307,
    maxLevel = 3,
    timing = 1,
    targetIdentityCategory = 3,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      bigSkillProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {}
  }),
  [420] = ProtobufI("SpecialAttrInfo", {
    index = 998401,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [421] = ProtobufI("SpecialAttrInfo", {
    index = 998402,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 998407
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [422] = ProtobufI("SpecialAttrInfo", {
    index = 998403,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 998405
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [423] = ProtobufI("SpecialAttrInfo", {
    index = 998405,
    maxLevel = 1,
    timing = 4,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [424] = ProtobufI("SpecialAttrInfo", {
    index = 998407,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [425] = ProtobufI("SpecialAttrInfo", {
    index = 998501,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 998502,
      [2] = 998504
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [426] = ProtobufI("SpecialAttrInfo", {
    index = 998502,
    maxLevel = 1,
    timing = 1,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 998501
        },
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [427] = ProtobufI("SpecialAttrInfo", {
    index = 998503,
    maxLevel = 1,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {
        [1] = 10000,
        [2] = 0
      }
    }),
    conditions = {}
  }),
  [428] = ProtobufI("SpecialAttrInfo", {
    index = 998504,
    maxLevel = 1,
    timing = 4,
    ownerIdentityCategory = 3,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {}
  }),
  [429] = ProtobufI("SpecialAttrInfo", {
    index = 998511,
    maxLevel = 1,
    timing = 4,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [430] = ProtobufI("SpecialAttrInfo", {
    index = 998514,
    maxLevel = 1,
    timing = 4,
    targetIdentityCategory = 3,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 998516
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [431] = ProtobufI("SpecialAttrInfo", {
    index = 998515,
    maxLevel = 1,
    timing = 6,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceAttackType = 1,
        sourceExtraParam = {},
        targetValue = 5000,
        operation = 3,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [432] = ProtobufI("SpecialAttrInfo", {
    index = 998516,
    maxLevel = 1,
    timing = 4,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [433] = ProtobufI("SpecialAttrInfo", {
    index = 998517,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [434] = ProtobufI("SpecialAttrInfo", {
    index = 34010101,
    maxLevel = 10000,
    timing = 1,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [435] = ProtobufI("SpecialAttrInfo", {
    index = 34010201,
    maxLevel = 10000,
    timing = 1,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [436] = ProtobufI("SpecialAttrInfo", {
    index = 34010301,
    maxLevel = 10000,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 34010302
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [437] = ProtobufI("SpecialAttrInfo", {
    index = 34010302,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [438] = ProtobufI("SpecialAttrInfo", {
    index = 34010401,
    maxLevel = 10000,
    timing = 1,
    targetIdentityCategory = 3,
    targetAttackType = 1,
    childSpecialAttrInfoId = {
      [1] = 34010402,
      [2] = 34010403
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [439] = ProtobufI("SpecialAttrInfo", {
    index = 34010402,
    maxLevel = 1,
    timing = 1,
    targetIdentityCategory = 3,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [440] = ProtobufI("SpecialAttrInfo", {
    index = 34010403,
    maxLevel = 1,
    timing = 6,
    ownerIdentityCategory = 1,
    targetIdentityCategory = 3,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 3,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 34010302
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [441] = ProtobufI("SpecialAttrInfo", {
    index = 34020101,
    maxLevel = 10000,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [442] = ProtobufI("SpecialAttrInfo", {
    index = 34020201,
    maxLevel = 10000,
    timing = 8,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 8000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 13,
        sourceIdentityCategory = 4,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 3
        },
        operation = 4,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [443] = ProtobufI("SpecialAttrInfo", {
    index = 34020301,
    maxLevel = 10000,
    timing = 10,
    targetIdentityCategory = 3,
    targetAttackType = 1,
    childSpecialAttrInfoId = {
      [1] = 34020303,
      [2] = 34020304,
      [3] = 34020305,
      [4] = 34020306,
      [5] = 34020302
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 16,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        operation = 4,
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 34020302
        },
        sourceOperation = {},
        sourceOperand = {}
      }),
      [3] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 14,
        sourceExtraParam = {},
        targetValue = 3,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [444] = ProtobufI("SpecialAttrInfo", {
    index = 34020302,
    maxLevel = 10000,
    timing = 10,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 16,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        operation = 4,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [445] = ProtobufI("SpecialAttrInfo", {
    index = 34020303,
    maxLevel = 10000,
    timing = 10,
    targetIdentityCategory = 3,
    targetAttackType = 1,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 16,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        operation = 4,
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 34020302
        },
        sourceOperation = {},
        sourceOperand = {}
      }),
      [3] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 14,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [446] = ProtobufI("SpecialAttrInfo", {
    index = 34020304,
    maxLevel = 10000,
    timing = 10,
    targetIdentityCategory = 3,
    targetAttackType = 1,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 16,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        operation = 4,
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 34020302
        },
        sourceOperation = {},
        sourceOperand = {}
      }),
      [3] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 14,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [447] = ProtobufI("SpecialAttrInfo", {
    index = 34020305,
    maxLevel = 10000,
    timing = 10,
    targetIdentityCategory = 3,
    targetAttackType = 1,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 16,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        operation = 4,
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 34020302
        },
        sourceOperation = {},
        sourceOperand = {}
      }),
      [3] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 14,
        sourceExtraParam = {},
        targetValue = 2,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [448] = ProtobufI("SpecialAttrInfo", {
    index = 34020306,
    maxLevel = 10000,
    timing = 10,
    targetIdentityCategory = 3,
    targetAttackType = 1,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 16,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        operation = 4,
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 34020302
        },
        sourceOperation = {},
        sourceOperand = {}
      }),
      [3] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 15,
        sourceExtraParam = {},
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [449] = ProtobufI("SpecialAttrInfo", {
    index = 34030101,
    maxLevel = 10000,
    timing = 8,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 13,
        sourceIdentityCategory = 4,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 1
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [450] = ProtobufI("SpecialAttrInfo", {
    index = 34030102,
    maxLevel = 10000,
    timing = 8,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 13,
        sourceIdentityCategory = 4,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 1
        },
        targetValue = 2,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [451] = ProtobufI("SpecialAttrInfo", {
    index = 34030201,
    maxLevel = 10000,
    timing = 8,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 13,
        sourceIdentityCategory = 4,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 1
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [452] = ProtobufI("SpecialAttrInfo", {
    index = 34030202,
    maxLevel = 10000,
    timing = 8,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 13,
        sourceIdentityCategory = 4,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 1
        },
        targetValue = 2,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [453] = ProtobufI("SpecialAttrInfo", {
    index = 34030301,
    maxLevel = 10000,
    timing = 8,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 7000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 13,
        sourceIdentityCategory = 4,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 1
        },
        operation = 4,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [454] = ProtobufI("SpecialAttrInfo", {
    index = 34040101,
    maxLevel = 10000,
    timing = 8,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 13,
        sourceIdentityCategory = 4,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 2
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [455] = ProtobufI("SpecialAttrInfo", {
    index = 34040102,
    maxLevel = 10000,
    timing = 8,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 13,
        sourceIdentityCategory = 4,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 2
        },
        targetValue = 2,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [456] = ProtobufI("SpecialAttrInfo", {
    index = 34040201,
    maxLevel = 10000,
    timing = 8,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 13,
        sourceIdentityCategory = 4,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 2
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [457] = ProtobufI("SpecialAttrInfo", {
    index = 34040202,
    maxLevel = 10000,
    timing = 8,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 13,
        sourceIdentityCategory = 4,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 2
        },
        targetValue = 2,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [458] = ProtobufI("SpecialAttrInfo", {
    index = 34040301,
    maxLevel = 10000,
    timing = 8,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 7000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 13,
        sourceIdentityCategory = 4,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 2
        },
        operation = 4,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [459] = ProtobufI("SpecialAttrInfo", {
    index = 34050101,
    maxLevel = 10000,
    timing = 8,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 12,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 132
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [460] = ProtobufI("SpecialAttrInfo", {
    index = 34050201,
    maxLevel = 10000,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 34050202
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 34050202
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [461] = ProtobufI("SpecialAttrInfo", {
    index = 34050202,
    maxLevel = 10000,
    timing = 3,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 132
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [462] = ProtobufI("SpecialAttrInfo", {
    index = 34050301,
    maxLevel = 10000,
    timing = 8,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 12,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 132
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [463] = ProtobufI("SpecialAttrInfo", {
    index = 34060101,
    maxLevel = 10000,
    timing = 8,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 12,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 103
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [464] = ProtobufI("SpecialAttrInfo", {
    index = 34060201,
    maxLevel = 10000,
    timing = 8,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 12,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 103
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [465] = ProtobufI("SpecialAttrInfo", {
    index = 34060301,
    maxLevel = 10000,
    timing = 8,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 34060302,
      [2] = 34060303
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 12,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 103
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 34060302
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [466] = ProtobufI("SpecialAttrInfo", {
    index = 34060302,
    maxLevel = 1,
    timing = 6,
    ownerIdentityCategory = 1,
    targetIdentityCategory = 3,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 4,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 103
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [467] = ProtobufI("SpecialAttrInfo", {
    index = 34060303,
    maxLevel = 10000,
    timing = 11,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 18,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 103
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [468] = ProtobufI("SpecialAttrInfo", {
    index = 34070101,
    maxLevel = 10000,
    timing = 8,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 12,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 202
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [469] = ProtobufI("SpecialAttrInfo", {
    index = 34070201,
    maxLevel = 10000,
    timing = 3,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 5000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 202
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [470] = ProtobufI("SpecialAttrInfo", {
    index = 34070301,
    maxLevel = 10000,
    timing = 5,
    ownerIdentityCategory = 1,
    targetIdentityCategory = 3,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 4,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 202
        },
        targetValue = 2,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [471] = ProtobufI("SpecialAttrInfo", {
    index = 34080101,
    maxLevel = 10000,
    timing = 8,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 12,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 1
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [472] = ProtobufI("SpecialAttrInfo", {
    index = 34080201,
    maxLevel = 10000,
    timing = 6,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 1
        },
        targetValue = 2,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [473] = ProtobufI("SpecialAttrInfo", {
    index = 34080301,
    maxLevel = 10000,
    timing = 2,
    ownerIdentityCategory = 2,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 1
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [474] = ProtobufI("SpecialAttrInfo", {
    index = 34090101,
    maxLevel = 10000,
    timing = 8,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 12,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 51
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [475] = ProtobufI("SpecialAttrInfo", {
    index = 34090201,
    maxLevel = 10000,
    timing = 2,
    ownerIdentityCategory = 2,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 51
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [476] = ProtobufI("SpecialAttrInfo", {
    index = 34090301,
    maxLevel = 10000,
    timing = 5,
    ownerIdentityCategory = 1,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 7000,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [477] = ProtobufI("SpecialAttrInfo", {
    index = 34100101,
    maxLevel = 10000,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [478] = ProtobufI("SpecialAttrInfo", {
    index = 34100201,
    maxLevel = 10000,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [479] = ProtobufI("SpecialAttrInfo", {
    index = 34100301,
    maxLevel = 10000,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [480] = ProtobufI("SpecialAttrInfo", {
    index = 34100401,
    maxLevel = 10000,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [481] = ProtobufI("SpecialAttrInfo", {
    index = 34100501,
    maxLevel = 10000,
    timing = 5,
    ownerIdentityCategory = 1,
    targetIdentityCategory = 3,
    targetAttackType = 1,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 9000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [482] = ProtobufI("SpecialAttrInfo", {
    index = 34110101,
    maxLevel = 1,
    timing = 14,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [483] = ProtobufI("SpecialAttrInfo", {
    index = 35010101,
    maxLevel = 10000,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [484] = ProtobufI("SpecialAttrInfo", {
    index = 35010201,
    maxLevel = 10000,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 35010206
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [485] = ProtobufI("SpecialAttrInfo", {
    index = 35010202,
    maxLevel = 10000,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 35010207
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [486] = ProtobufI("SpecialAttrInfo", {
    index = 35010203,
    maxLevel = 10000,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 35010208
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [487] = ProtobufI("SpecialAttrInfo", {
    index = 35010204,
    maxLevel = 10000,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 35010209
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [488] = ProtobufI("SpecialAttrInfo", {
    index = 35010205,
    maxLevel = 10000,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 35010210
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [489] = ProtobufI("SpecialAttrInfo", {
    index = 35010206,
    maxLevel = 10000,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 4000,
        operation = 2,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [490] = ProtobufI("SpecialAttrInfo", {
    index = 35010207,
    maxLevel = 10000,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 4000,
        operation = 2,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [491] = ProtobufI("SpecialAttrInfo", {
    index = 35010208,
    maxLevel = 10000,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 5000,
        operation = 2,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [492] = ProtobufI("SpecialAttrInfo", {
    index = 35010209,
    maxLevel = 10000,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 6000,
        operation = 2,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [493] = ProtobufI("SpecialAttrInfo", {
    index = 35010210,
    maxLevel = 10000,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 8000,
        operation = 2,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [494] = ProtobufI("SpecialAttrInfo", {
    index = 35010301,
    maxLevel = 10000,
    timing = 14,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [495] = ProtobufI("SpecialAttrInfo", {
    index = 35010401,
    maxLevel = 10000,
    timing = 14,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [496] = ProtobufI("SpecialAttrInfo", {
    index = 35010501,
    maxLevel = 10000,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [497] = ProtobufI("SpecialAttrInfo", {
    index = 35010601,
    maxLevel = 10000,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [498] = ProtobufI("SpecialAttrInfo", {
    index = 35010701,
    maxLevel = 10000,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [499] = ProtobufI("SpecialAttrInfo", {
    index = 35010801,
    maxLevel = 10000,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 35010806
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 14,
        sourceExtraParam = {},
        targetValue = 5,
        operation = 4,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [500] = ProtobufI("SpecialAttrInfo", {
    index = 35010802,
    maxLevel = 10000,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 35010807
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 14,
        sourceExtraParam = {},
        targetValue = 4,
        operation = 4,
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 9,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [501] = ProtobufI("SpecialAttrInfo", {
    index = 35010803,
    maxLevel = 10000,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 35010808
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 14,
        sourceExtraParam = {},
        targetValue = 3,
        operation = 4,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [502] = ProtobufI("SpecialAttrInfo", {
    index = 35010804,
    maxLevel = 10000,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 35010809
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 14,
        sourceExtraParam = {},
        targetValue = 2,
        operation = 4,
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 9,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [503] = ProtobufI("SpecialAttrInfo", {
    index = 35010805,
    maxLevel = 10000,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 35010810
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 14,
        sourceExtraParam = {},
        targetValue = 2,
        operation = 4,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [504] = ProtobufI("SpecialAttrInfo", {
    index = 35010806,
    maxLevel = 10000,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [505] = ProtobufI("SpecialAttrInfo", {
    index = 35010807,
    maxLevel = 10000,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [506] = ProtobufI("SpecialAttrInfo", {
    index = 35010808,
    maxLevel = 10000,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [507] = ProtobufI("SpecialAttrInfo", {
    index = 35010809,
    maxLevel = 10000,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [508] = ProtobufI("SpecialAttrInfo", {
    index = 35010810,
    maxLevel = 10000,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [509] = ProtobufI("SpecialAttrInfo", {
    index = 35020101,
    maxLevel = 10000,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 5000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {}
  }),
  [510] = ProtobufI("SpecialAttrInfo", {
    index = 35020201,
    maxLevel = 10000,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 5000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {}
  }),
  [511] = ProtobufI("SpecialAttrInfo", {
    index = 35020301,
    maxLevel = 10000,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 5000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {}
  }),
  [512] = ProtobufI("SpecialAttrInfo", {
    index = 35020401,
    maxLevel = 10000,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 5000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {}
  }),
  [513] = ProtobufI("SpecialAttrInfo", {
    index = 35020501,
    maxLevel = 10000,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 5000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {}
  }),
  [514] = ProtobufI("SpecialAttrInfo", {
    index = 35020601,
    maxLevel = 10000,
    timing = 1,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 5000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {}
  }),
  [515] = ProtobufI("SpecialAttrInfo", {
    index = 35020701,
    maxLevel = 10000,
    timing = 1,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 5000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {}
  }),
  [516] = ProtobufI("SpecialAttrInfo", {
    index = 35020801,
    maxLevel = 10000,
    timing = 1,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 5000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {}
  }),
  [517] = ProtobufI("SpecialAttrInfo", {
    index = 35020901,
    maxLevel = 10000,
    timing = 1,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 5000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {}
  }),
  [518] = ProtobufI("SpecialAttrInfo", {
    index = 35030101,
    maxLevel = 10000,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [519] = ProtobufI("SpecialAttrInfo", {
    index = 35030301,
    maxLevel = 10000,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [520] = ProtobufI("SpecialAttrInfo", {
    index = 35030601,
    maxLevel = 10000,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [521] = ProtobufI("SpecialAttrInfo", {
    index = 8001,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [522] = ProtobufI("SpecialAttrInfo", {
    index = 8002,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [523] = ProtobufI("SpecialAttrInfo", {
    index = 8003,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [524] = ProtobufI("SpecialAttrInfo", {
    index = 1000000,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 6,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [525] = ProtobufI("SpecialAttrInfo", {
    index = 1000010,
    maxLevel = 3,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {}
  }),
  [526] = ProtobufI("SpecialAttrInfo", {
    index = 1000020,
    maxLevel = 3,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {}
  }),
  [527] = ProtobufI("SpecialAttrInfo", {
    index = 1000030,
    maxLevel = 3,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {}
  }),
  [528] = ProtobufI("SpecialAttrInfo", {
    index = 1000040,
    maxLevel = 3,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {}
  }),
  [529] = ProtobufI("SpecialAttrInfo", {
    index = 1000050,
    maxLevel = 100,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 2,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [530] = ProtobufI("SpecialAttrInfo", {
    index = 1000060,
    maxLevel = 100,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 2,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [531] = ProtobufI("SpecialAttrInfo", {
    index = 1000070,
    maxLevel = 100,
    timing = 4,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [532] = ProtobufI("SpecialAttrInfo", {
    index = 1000080,
    maxLevel = 100,
    timing = 4,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [533] = ProtobufI("SpecialAttrInfo", {
    index = 1000090,
    maxLevel = 10,
    timing = 1,
    targetAttackType = 3,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 9,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [534] = ProtobufI("SpecialAttrInfo", {
    index = 1000100,
    maxLevel = 2,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [535] = ProtobufI("SpecialAttrInfo", {
    index = 1000110,
    maxLevel = 30,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [536] = ProtobufI("SpecialAttrInfo", {
    index = 1000120,
    maxLevel = 10,
    timing = 1,
    ownerIdentityCategory = 3,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 2000,
        operation = 3,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [537] = ProtobufI("SpecialAttrInfo", {
    index = 1000130,
    maxLevel = 1,
    timing = 1,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {}
  }),
  [538] = ProtobufI("SpecialAttrInfo", {
    index = 1000140,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [539] = ProtobufI("SpecialAttrInfo", {
    index = 1000150,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [540] = ProtobufI("SpecialAttrInfo", {
    index = 1000160,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [541] = ProtobufI("SpecialAttrInfo", {
    index = 1000170,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 1000171,
      [2] = 1000172,
      [3] = 1000173,
      [4] = 1000174,
      [5] = 1000175,
      [6] = 1000176
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [542] = ProtobufI("SpecialAttrInfo", {
    index = 1000171,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 2,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [543] = ProtobufI("SpecialAttrInfo", {
    index = 1000172,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 3,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [544] = ProtobufI("SpecialAttrInfo", {
    index = 1000173,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 4,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [545] = ProtobufI("SpecialAttrInfo", {
    index = 1000174,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [546] = ProtobufI("SpecialAttrInfo", {
    index = 1000175,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 6,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [547] = ProtobufI("SpecialAttrInfo", {
    index = 1000176,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 7,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [548] = ProtobufI("SpecialAttrInfo", {
    index = 1000180,
    maxLevel = 1,
    timing = 4,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 1000181
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [549] = ProtobufI("SpecialAttrInfo", {
    index = 1000181,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [550] = ProtobufI("SpecialAttrInfo", {
    index = 1000190,
    maxLevel = 1,
    timing = 7,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 1000191
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [551] = ProtobufI("SpecialAttrInfo", {
    index = 1000191,
    maxLevel = 1,
    timing = 7,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceIdentityCategory = 3,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 2000,
        operation = 3,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [552] = ProtobufI("SpecialAttrInfo", {
    index = 1000200,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 1000201,
      [2] = 1000202,
      [3] = 1000203,
      [4] = 1000204,
      [5] = 1000205,
      [6] = 1000206
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [553] = ProtobufI("SpecialAttrInfo", {
    index = 1000201,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 2,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [554] = ProtobufI("SpecialAttrInfo", {
    index = 1000202,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 3,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [555] = ProtobufI("SpecialAttrInfo", {
    index = 1000203,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 4,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [556] = ProtobufI("SpecialAttrInfo", {
    index = 1000204,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [557] = ProtobufI("SpecialAttrInfo", {
    index = 1000205,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 6,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [558] = ProtobufI("SpecialAttrInfo", {
    index = 1000206,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 7,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [559] = ProtobufI("SpecialAttrInfo", {
    index = 1000210,
    maxLevel = 1,
    timing = 4,
    ownerIdentityCategory = 3,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {}
  }),
  [560] = ProtobufI("SpecialAttrInfo", {
    index = 1000220,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 1000221
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [561] = ProtobufI("SpecialAttrInfo", {
    index = 1000221,
    maxLevel = 1,
    timing = 6,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceIdentityCategory = 3,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 3000,
        operation = 3,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [562] = ProtobufI("SpecialAttrInfo", {
    index = 1000230,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 1000231
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [563] = ProtobufI("SpecialAttrInfo", {
    index = 1000231,
    maxLevel = 1,
    timing = 6,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceIdentityCategory = 3,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 8000,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [564] = ProtobufI("SpecialAttrInfo", {
    index = 1000280,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [565] = ProtobufI("SpecialAttrInfo", {
    index = 1000290,
    maxLevel = 1,
    timing = 6,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 5000,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [566] = ProtobufI("SpecialAttrInfo", {
    index = 1000291,
    maxLevel = 1,
    timing = 6,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 5000,
        operation = 2,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [567] = ProtobufI("SpecialAttrInfo", {
    index = 1000300,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {}
  }),
  [568] = ProtobufI("SpecialAttrInfo", {
    index = 1000991,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 0,
        [2] = 10000
      }
    }),
    conditions = {}
  }),
  [569] = ProtobufI("SpecialAttrInfo", {
    index = 1000992,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 10000,
        [2] = 0
      }
    }),
    conditions = {}
  }),
  [570] = ProtobufI("SpecialAttrInfo", {
    index = 1000993,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 1000995,
      [2] = 1000996
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [571] = ProtobufI("SpecialAttrInfo", {
    index = 1000994,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 1000996
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [572] = ProtobufI("SpecialAttrInfo", {
    index = 1000995,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      bigSkillProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {}
  }),
  [573] = ProtobufI("SpecialAttrInfo", {
    index = 1000996,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      bigSkillProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {}
  }),
  [574] = ProtobufI("SpecialAttrInfo", {
    index = 1000999,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [575] = ProtobufI("SpecialAttrInfo", {
    index = 1001201,
    maxLevel = 1,
    timing = 7,
    ownerIdentityCategory = 10,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [576] = ProtobufI("SpecialAttrInfo", {
    index = 1001301,
    maxLevel = 1,
    timing = 7,
    ownerIdentityCategory = 11,
    targetIdentityCategory = 1,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [577] = ProtobufI("SpecialAttrInfo", {
    index = 1001401,
    maxLevel = 1,
    timing = 7,
    ownerIdentityCategory = 12,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [578] = ProtobufI("SpecialAttrInfo", {
    index = 2,
    maxLevel = 20,
    timing = 7,
    ownerIdentityCategory = 10,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {}
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [579] = ProtobufI("SpecialAttrInfo", {
    index = 7,
    maxLevel = 20,
    timing = 7,
    ownerIdentityCategory = 10,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {}
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [580] = ProtobufI("SpecialAttrInfo", {
    index = 9,
    maxLevel = 20,
    timing = 7,
    ownerIdentityCategory = 10,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {}
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [581] = ProtobufI("SpecialAttrInfo", {
    index = 10,
    maxLevel = 20,
    timing = 7,
    ownerIdentityCategory = 10,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {}
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [582] = ProtobufI("SpecialAttrInfo", {
    index = 13,
    maxLevel = 20,
    timing = 7,
    ownerIdentityCategory = 10,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {}
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [583] = ProtobufI("SpecialAttrInfo", {
    index = 14,
    maxLevel = 20,
    timing = 7,
    ownerIdentityCategory = 10,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {}
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [584] = ProtobufI("SpecialAttrInfo", {
    index = 105,
    maxLevel = 20,
    timing = 7,
    ownerIdentityCategory = 10,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {}
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [585] = ProtobufI("SpecialAttrInfo", {
    index = 106,
    maxLevel = 20,
    timing = 7,
    ownerIdentityCategory = 10,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {}
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [586] = ProtobufI("SpecialAttrInfo", {
    index = 205,
    maxLevel = 20,
    timing = 7,
    ownerIdentityCategory = 10,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {}
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [587] = ProtobufI("SpecialAttrInfo", {
    index = 206,
    maxLevel = 20,
    timing = 7,
    ownerIdentityCategory = 10,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {}
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [588] = ProtobufI("SpecialAttrInfo", {
    index = 305,
    maxLevel = 20,
    timing = 7,
    ownerIdentityCategory = 10,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {}
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [589] = ProtobufI("SpecialAttrInfo", {
    index = 306,
    maxLevel = 20,
    timing = 7,
    ownerIdentityCategory = 10,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {}
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [590] = ProtobufI("SpecialAttrInfo", {
    index = 101,
    maxLevel = 20,
    timing = 7,
    ownerIdentityCategory = 10,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {}
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [591] = ProtobufI("SpecialAttrInfo", {
    index = 201,
    maxLevel = 20,
    timing = 7,
    ownerIdentityCategory = 10,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {}
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [592] = ProtobufI("SpecialAttrInfo", {
    index = 301,
    maxLevel = 20,
    timing = 7,
    ownerIdentityCategory = 10,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {}
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [593] = ProtobufI("SpecialAttrInfo", {
    index = 103,
    maxLevel = 20,
    timing = 7,
    ownerIdentityCategory = 10,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {}
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [594] = ProtobufI("SpecialAttrInfo", {
    index = 203,
    maxLevel = 20,
    timing = 7,
    ownerIdentityCategory = 10,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {}
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [595] = ProtobufI("SpecialAttrInfo", {
    index = 303,
    maxLevel = 20,
    timing = 7,
    ownerIdentityCategory = 10,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {}
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [596] = ProtobufI("SpecialAttrInfo", {
    index = 900,
    maxLevel = 25,
    timing = 7,
    ownerIdentityCategory = 10,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [597] = ProtobufI("SpecialAttrInfo", {
    index = 901,
    maxLevel = 25,
    timing = 7,
    ownerIdentityCategory = 10,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [598] = ProtobufI("SpecialAttrInfo", {
    index = 902,
    maxLevel = 25,
    timing = 7,
    ownerIdentityCategory = 10,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [599] = ProtobufI("SpecialAttrInfo", {
    index = 903,
    maxLevel = 25,
    timing = 7,
    ownerIdentityCategory = 10,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [600] = ProtobufI("SpecialAttrInfo", {
    index = 13200,
    maxLevel = 1,
    timing = 7,
    ownerIdentityCategory = 10,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [601] = ProtobufI("SpecialAttrInfo", {
    index = 13400,
    maxLevel = 1,
    timing = 7,
    ownerIdentityCategory = 10,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [602] = ProtobufI("SpecialAttrInfo", {
    index = 13201,
    maxLevel = 1,
    timing = 7,
    ownerIdentityCategory = 10,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [603] = ProtobufI("SpecialAttrInfo", {
    index = 13401,
    maxLevel = 1,
    timing = 7,
    ownerIdentityCategory = 10,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [604] = ProtobufI("SpecialAttrInfo", {
    index = 13202,
    maxLevel = 1,
    timing = 7,
    ownerIdentityCategory = 10,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [605] = ProtobufI("SpecialAttrInfo", {
    index = 13402,
    maxLevel = 1,
    timing = 7,
    ownerIdentityCategory = 10,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [606] = ProtobufI("SpecialAttrInfo", {
    index = 12200,
    maxLevel = 1,
    timing = 7,
    ownerIdentityCategory = 10,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [607] = ProtobufI("SpecialAttrInfo", {
    index = 12400,
    maxLevel = 1,
    timing = 7,
    ownerIdentityCategory = 10,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [608] = ProtobufI("SpecialAttrInfo", {
    index = 12201,
    maxLevel = 1,
    timing = 7,
    ownerIdentityCategory = 10,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [609] = ProtobufI("SpecialAttrInfo", {
    index = 12401,
    maxLevel = 1,
    timing = 7,
    ownerIdentityCategory = 10,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [610] = ProtobufI("SpecialAttrInfo", {
    index = 12202,
    maxLevel = 1,
    timing = 7,
    ownerIdentityCategory = 10,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [611] = ProtobufI("SpecialAttrInfo", {
    index = 12402,
    maxLevel = 1,
    timing = 7,
    ownerIdentityCategory = 10,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [612] = ProtobufI("SpecialAttrInfo", {
    index = 23200,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [613] = ProtobufI("SpecialAttrInfo", {
    index = 23400,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [614] = ProtobufI("SpecialAttrInfo", {
    index = 22200,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [615] = ProtobufI("SpecialAttrInfo", {
    index = 22400,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [616] = ProtobufI("SpecialAttrInfo", {
    index = 23201,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [617] = ProtobufI("SpecialAttrInfo", {
    index = 23401,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [618] = ProtobufI("SpecialAttrInfo", {
    index = 22201,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [619] = ProtobufI("SpecialAttrInfo", {
    index = 22401,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [620] = ProtobufI("SpecialAttrInfo", {
    index = 23202,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [621] = ProtobufI("SpecialAttrInfo", {
    index = 23402,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [622] = ProtobufI("SpecialAttrInfo", {
    index = 22202,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [623] = ProtobufI("SpecialAttrInfo", {
    index = 22402,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [624] = ProtobufI("SpecialAttrInfo", {
    index = 23203,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 15,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [625] = ProtobufI("SpecialAttrInfo", {
    index = 23403,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 15,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [626] = ProtobufI("SpecialAttrInfo", {
    index = 22203,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 15,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [627] = ProtobufI("SpecialAttrInfo", {
    index = 22403,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 15,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [628] = ProtobufI("SpecialAttrInfo", {
    index = 23204,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 15,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [629] = ProtobufI("SpecialAttrInfo", {
    index = 23404,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 15,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [630] = ProtobufI("SpecialAttrInfo", {
    index = 22204,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 15,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [631] = ProtobufI("SpecialAttrInfo", {
    index = 22404,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 15,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [632] = ProtobufI("SpecialAttrInfo", {
    index = 23205,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 15,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [633] = ProtobufI("SpecialAttrInfo", {
    index = 23405,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 15,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [634] = ProtobufI("SpecialAttrInfo", {
    index = 22205,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 15,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [635] = ProtobufI("SpecialAttrInfo", {
    index = 22405,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 15,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [636] = ProtobufI("SpecialAttrInfo", {
    index = 23206,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 9,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [637] = ProtobufI("SpecialAttrInfo", {
    index = 23406,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 9,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [638] = ProtobufI("SpecialAttrInfo", {
    index = 22206,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 9,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [639] = ProtobufI("SpecialAttrInfo", {
    index = 22406,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 9,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [640] = ProtobufI("SpecialAttrInfo", {
    index = 23207,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 9,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [641] = ProtobufI("SpecialAttrInfo", {
    index = 23407,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 9,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [642] = ProtobufI("SpecialAttrInfo", {
    index = 22207,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 9,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [643] = ProtobufI("SpecialAttrInfo", {
    index = 22407,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 9,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [644] = ProtobufI("SpecialAttrInfo", {
    index = 23208,
    maxLevel = 1,
    timing = 8,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 13,
        sourceExtraParam = {
          [1] = 0,
          [2] = 1
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [645] = ProtobufI("SpecialAttrInfo", {
    index = 23408,
    maxLevel = 1,
    timing = 8,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 13,
        sourceExtraParam = {
          [1] = 0,
          [2] = 1
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [646] = ProtobufI("SpecialAttrInfo", {
    index = 22208,
    maxLevel = 1,
    timing = 8,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 13,
        sourceExtraParam = {
          [1] = 0,
          [2] = 1
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [647] = ProtobufI("SpecialAttrInfo", {
    index = 22408,
    maxLevel = 1,
    timing = 8,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 13,
        sourceExtraParam = {
          [1] = 0,
          [2] = 1
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [648] = ProtobufI("SpecialAttrInfo", {
    index = 23209,
    maxLevel = 1,
    timing = 8,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 13,
        sourceExtraParam = {
          [1] = 0,
          [2] = 2
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [649] = ProtobufI("SpecialAttrInfo", {
    index = 23409,
    maxLevel = 1,
    timing = 8,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 13,
        sourceExtraParam = {
          [1] = 0,
          [2] = 2
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [650] = ProtobufI("SpecialAttrInfo", {
    index = 22209,
    maxLevel = 1,
    timing = 8,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 13,
        sourceExtraParam = {
          [1] = 0,
          [2] = 2
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [651] = ProtobufI("SpecialAttrInfo", {
    index = 22409,
    maxLevel = 1,
    timing = 8,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 13,
        sourceExtraParam = {
          [1] = 0,
          [2] = 2
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [652] = ProtobufI("SpecialAttrInfo", {
    index = 23210,
    maxLevel = 1,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [653] = ProtobufI("SpecialAttrInfo", {
    index = 23410,
    maxLevel = 1,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [654] = ProtobufI("SpecialAttrInfo", {
    index = 22210,
    maxLevel = 1,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [655] = ProtobufI("SpecialAttrInfo", {
    index = 22410,
    maxLevel = 1,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [656] = ProtobufI("SpecialAttrInfo", {
    index = 23211,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [657] = ProtobufI("SpecialAttrInfo", {
    index = 23411,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [658] = ProtobufI("SpecialAttrInfo", {
    index = 22211,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [659] = ProtobufI("SpecialAttrInfo", {
    index = 22411,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [660] = ProtobufI("SpecialAttrInfo", {
    index = 23212,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [661] = ProtobufI("SpecialAttrInfo", {
    index = 23412,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [662] = ProtobufI("SpecialAttrInfo", {
    index = 22212,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [663] = ProtobufI("SpecialAttrInfo", {
    index = 22412,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [664] = ProtobufI("SpecialAttrInfo", {
    index = 23213,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 11,
        sourceExtraParam = {},
        targetValue = 6,
        operation = 2,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [665] = ProtobufI("SpecialAttrInfo", {
    index = 23413,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 11,
        sourceExtraParam = {},
        targetValue = 6,
        operation = 2,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [666] = ProtobufI("SpecialAttrInfo", {
    index = 22213,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 11,
        sourceExtraParam = {},
        targetValue = 6,
        operation = 2,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [667] = ProtobufI("SpecialAttrInfo", {
    index = 22413,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 11,
        sourceExtraParam = {},
        targetValue = 6,
        operation = 2,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [668] = ProtobufI("SpecialAttrInfo", {
    index = 23214,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [669] = ProtobufI("SpecialAttrInfo", {
    index = 23414,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [670] = ProtobufI("SpecialAttrInfo", {
    index = 22214,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [671] = ProtobufI("SpecialAttrInfo", {
    index = 22414,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [672] = ProtobufI("SpecialAttrInfo", {
    index = 23215,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [673] = ProtobufI("SpecialAttrInfo", {
    index = 23415,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [674] = ProtobufI("SpecialAttrInfo", {
    index = 22215,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [675] = ProtobufI("SpecialAttrInfo", {
    index = 22415,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [676] = ProtobufI("SpecialAttrInfo", {
    index = 23216,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [677] = ProtobufI("SpecialAttrInfo", {
    index = 23416,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [678] = ProtobufI("SpecialAttrInfo", {
    index = 22216,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [679] = ProtobufI("SpecialAttrInfo", {
    index = 22416,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [680] = ProtobufI("SpecialAttrInfo", {
    index = 23217,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 10,
        sourceExtraParam = {},
        targetValue = 5,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 9,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [681] = ProtobufI("SpecialAttrInfo", {
    index = 23417,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 10,
        sourceExtraParam = {},
        targetValue = 5,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 9,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [682] = ProtobufI("SpecialAttrInfo", {
    index = 22217,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 10,
        sourceExtraParam = {},
        targetValue = 5,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 9,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [683] = ProtobufI("SpecialAttrInfo", {
    index = 22417,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 10,
        sourceExtraParam = {},
        targetValue = 5,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 9,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [684] = ProtobufI("SpecialAttrInfo", {
    index = 23218,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        sourceOperation = {
          [1] = "%"
        },
        sourceOperand = {
          [1] = 2.0
        }
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 9,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [685] = ProtobufI("SpecialAttrInfo", {
    index = 23418,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        sourceOperation = {
          [1] = "%"
        },
        sourceOperand = {
          [1] = 2.0
        }
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 9,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [686] = ProtobufI("SpecialAttrInfo", {
    index = 22218,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        sourceOperation = {
          [1] = "%"
        },
        sourceOperand = {
          [1] = 2.0
        }
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 9,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [687] = ProtobufI("SpecialAttrInfo", {
    index = 22418,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        sourceOperation = {
          [1] = "%"
        },
        sourceOperand = {
          [1] = 2.0
        }
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 9,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [688] = ProtobufI("SpecialAttrInfo", {
    index = 23219,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {
          [1] = "%"
        },
        sourceOperand = {
          [1] = 2.0
        }
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 9,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [689] = ProtobufI("SpecialAttrInfo", {
    index = 23419,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {
          [1] = "%"
        },
        sourceOperand = {
          [1] = 2.0
        }
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 9,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [690] = ProtobufI("SpecialAttrInfo", {
    index = 22219,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {
          [1] = "%"
        },
        sourceOperand = {
          [1] = 2.0
        }
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 9,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [691] = ProtobufI("SpecialAttrInfo", {
    index = 22419,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {
          [1] = "%"
        },
        sourceOperand = {
          [1] = 2.0
        }
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 9,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [692] = ProtobufI("SpecialAttrInfo", {
    index = 23220,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [693] = ProtobufI("SpecialAttrInfo", {
    index = 23420,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [694] = ProtobufI("SpecialAttrInfo", {
    index = 22220,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [695] = ProtobufI("SpecialAttrInfo", {
    index = 22420,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [696] = ProtobufI("SpecialAttrInfo", {
    index = 23221,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 14,
        sourceExtraParam = {},
        targetValue = 3,
        operation = 4,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [697] = ProtobufI("SpecialAttrInfo", {
    index = 23421,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 14,
        sourceExtraParam = {},
        targetValue = 3,
        operation = 4,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [698] = ProtobufI("SpecialAttrInfo", {
    index = 22221,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 14,
        sourceExtraParam = {},
        targetValue = 3,
        operation = 4,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [699] = ProtobufI("SpecialAttrInfo", {
    index = 22421,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 14,
        sourceExtraParam = {},
        targetValue = 3,
        operation = 4,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [700] = ProtobufI("SpecialAttrInfo", {
    index = 23222,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 14,
        sourceExtraParam = {},
        targetValue = 3,
        operation = 3,
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 15,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [701] = ProtobufI("SpecialAttrInfo", {
    index = 23422,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 14,
        sourceExtraParam = {},
        targetValue = 3,
        operation = 3,
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 15,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [702] = ProtobufI("SpecialAttrInfo", {
    index = 22222,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 14,
        sourceExtraParam = {},
        targetValue = 3,
        operation = 3,
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 15,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [703] = ProtobufI("SpecialAttrInfo", {
    index = 22422,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 14,
        sourceExtraParam = {},
        targetValue = 3,
        operation = 3,
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 15,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [704] = ProtobufI("SpecialAttrInfo", {
    index = 23223,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 14,
        sourceExtraParam = {},
        targetValue = 4,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [705] = ProtobufI("SpecialAttrInfo", {
    index = 23423,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 14,
        sourceExtraParam = {},
        targetValue = 4,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [706] = ProtobufI("SpecialAttrInfo", {
    index = 22223,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 14,
        sourceExtraParam = {},
        targetValue = 4,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [707] = ProtobufI("SpecialAttrInfo", {
    index = 22423,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 14,
        sourceExtraParam = {},
        targetValue = 4,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [708] = ProtobufI("SpecialAttrInfo", {
    index = 23224,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 14,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 15,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      }),
      [3] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 9,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [709] = ProtobufI("SpecialAttrInfo", {
    index = 23424,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 14,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 15,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      }),
      [3] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 9,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [710] = ProtobufI("SpecialAttrInfo", {
    index = 22224,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 14,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 15,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      }),
      [3] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 9,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [711] = ProtobufI("SpecialAttrInfo", {
    index = 22424,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 14,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 15,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      }),
      [3] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 9,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [712] = ProtobufI("SpecialAttrInfo", {
    index = 23225,
    maxLevel = 1,
    timing = 8,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 232250
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 12,
        sourceExtraParam = {
          [1] = 0,
          [2] = 923
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [713] = ProtobufI("SpecialAttrInfo", {
    index = 23425,
    maxLevel = 1,
    timing = 8,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 234250
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 12,
        sourceExtraParam = {
          [1] = 0,
          [2] = 923
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [714] = ProtobufI("SpecialAttrInfo", {
    index = 22225,
    maxLevel = 1,
    timing = 8,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 222250
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 12,
        sourceExtraParam = {
          [1] = 0,
          [2] = 923
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [715] = ProtobufI("SpecialAttrInfo", {
    index = 22425,
    maxLevel = 1,
    timing = 8,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 224250
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 12,
        sourceExtraParam = {
          [1] = 0,
          [2] = 923
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [716] = ProtobufI("SpecialAttrInfo", {
    index = 232250,
    maxLevel = 1,
    timing = 11,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 18,
        sourceExtraParam = {
          [1] = 0,
          [2] = 923
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [717] = ProtobufI("SpecialAttrInfo", {
    index = 234250,
    maxLevel = 1,
    timing = 11,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 18,
        sourceExtraParam = {
          [1] = 0,
          [2] = 923
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [718] = ProtobufI("SpecialAttrInfo", {
    index = 222250,
    maxLevel = 1,
    timing = 11,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 18,
        sourceExtraParam = {
          [1] = 0,
          [2] = 923
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [719] = ProtobufI("SpecialAttrInfo", {
    index = 224250,
    maxLevel = 1,
    timing = 11,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 18,
        sourceExtraParam = {
          [1] = 0,
          [2] = 923
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [720] = ProtobufI("SpecialAttrInfo", {
    index = 23226,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 15,
        sourceExtraParam = {},
        targetValue = 6,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [721] = ProtobufI("SpecialAttrInfo", {
    index = 23426,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 15,
        sourceExtraParam = {},
        targetValue = 6,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [722] = ProtobufI("SpecialAttrInfo", {
    index = 22226,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 15,
        sourceExtraParam = {},
        targetValue = 6,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [723] = ProtobufI("SpecialAttrInfo", {
    index = 22426,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 15,
        sourceExtraParam = {},
        targetValue = 6,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [724] = ProtobufI("SpecialAttrInfo", {
    index = 23227,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 15,
        sourceExtraParam = {},
        targetValue = 6,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [725] = ProtobufI("SpecialAttrInfo", {
    index = 23427,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 15,
        sourceExtraParam = {},
        targetValue = 6,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [726] = ProtobufI("SpecialAttrInfo", {
    index = 22227,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 15,
        sourceExtraParam = {},
        targetValue = 6,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [727] = ProtobufI("SpecialAttrInfo", {
    index = 22427,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 15,
        sourceExtraParam = {},
        targetValue = 6,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [728] = ProtobufI("SpecialAttrInfo", {
    index = 23228,
    maxLevel = 1,
    timing = 8,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 12,
        sourceExtraParam = {
          [1] = 0,
          [2] = 923
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [729] = ProtobufI("SpecialAttrInfo", {
    index = 23428,
    maxLevel = 1,
    timing = 8,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 12,
        sourceExtraParam = {
          [1] = 0,
          [2] = 923
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [730] = ProtobufI("SpecialAttrInfo", {
    index = 22228,
    maxLevel = 1,
    timing = 8,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 12,
        sourceExtraParam = {
          [1] = 0,
          [2] = 923
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [731] = ProtobufI("SpecialAttrInfo", {
    index = 22428,
    maxLevel = 1,
    timing = 8,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 12,
        sourceExtraParam = {
          [1] = 0,
          [2] = 923
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [732] = ProtobufI("SpecialAttrInfo", {
    index = 23229,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 14,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 15,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      }),
      [3] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 9,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [733] = ProtobufI("SpecialAttrInfo", {
    index = 23429,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 14,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 15,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      }),
      [3] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 9,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [734] = ProtobufI("SpecialAttrInfo", {
    index = 22229,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 14,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 15,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      }),
      [3] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 9,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [735] = ProtobufI("SpecialAttrInfo", {
    index = 22429,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 14,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 15,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      }),
      [3] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 9,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [736] = ProtobufI("SpecialAttrInfo", {
    index = 23230,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      bigSkillProbability = 10000,
      cardNumProbability = {
        [1] = 10000,
        [2] = 10000
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 10,
        sourceExtraParam = {},
        targetValue = 5,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 9,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [737] = ProtobufI("SpecialAttrInfo", {
    index = 23430,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      bigSkillProbability = 10000,
      cardNumProbability = {
        [1] = 10000,
        [2] = 10000
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 10,
        sourceExtraParam = {},
        targetValue = 5,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 9,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [738] = ProtobufI("SpecialAttrInfo", {
    index = 22230,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      bigSkillProbability = 10000,
      cardNumProbability = {
        [1] = 10000,
        [2] = 10000
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 10,
        sourceExtraParam = {},
        targetValue = 5,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 9,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [739] = ProtobufI("SpecialAttrInfo", {
    index = 22430,
    maxLevel = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      bigSkillProbability = 10000,
      cardNumProbability = {
        [1] = 10000,
        [2] = 10000
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 10,
        sourceExtraParam = {},
        targetValue = 5,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 9,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [740] = ProtobufI("SpecialAttrInfo", {
    index = 23231,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 14,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 15,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      }),
      [3] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 9,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [741] = ProtobufI("SpecialAttrInfo", {
    index = 23431,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 14,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 15,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      }),
      [3] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 9,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [742] = ProtobufI("SpecialAttrInfo", {
    index = 22231,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 14,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 15,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      }),
      [3] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 9,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [743] = ProtobufI("SpecialAttrInfo", {
    index = 22431,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 14,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 15,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      }),
      [3] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 9,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [744] = ProtobufI("SpecialAttrInfo", {
    index = 23232,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 9,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [745] = ProtobufI("SpecialAttrInfo", {
    index = 23432,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 9,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [746] = ProtobufI("SpecialAttrInfo", {
    index = 22232,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 9,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [747] = ProtobufI("SpecialAttrInfo", {
    index = 22432,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 9,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [748] = ProtobufI("SpecialAttrInfo", {
    index = 23233,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 9,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [749] = ProtobufI("SpecialAttrInfo", {
    index = 23433,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 9,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [750] = ProtobufI("SpecialAttrInfo", {
    index = 22233,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 9,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [751] = ProtobufI("SpecialAttrInfo", {
    index = 22433,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 9,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [752] = ProtobufI("SpecialAttrInfo", {
    index = 23234,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 232340
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      bigSkillProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [753] = ProtobufI("SpecialAttrInfo", {
    index = 23434,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 234340
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      bigSkillProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [754] = ProtobufI("SpecialAttrInfo", {
    index = 22234,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 222340
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      bigSkillProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [755] = ProtobufI("SpecialAttrInfo", {
    index = 22434,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 224340
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      bigSkillProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [756] = ProtobufI("SpecialAttrInfo", {
    index = 232340,
    maxLevel = 1,
    timing = 6,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceIdentityCategory = 3,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 3000,
        operation = 3,
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 23234
        },
        operation = 4,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [757] = ProtobufI("SpecialAttrInfo", {
    index = 234340,
    maxLevel = 1,
    timing = 6,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceIdentityCategory = 3,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 3000,
        operation = 3,
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 23434
        },
        operation = 4,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [758] = ProtobufI("SpecialAttrInfo", {
    index = 222340,
    maxLevel = 1,
    timing = 6,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceIdentityCategory = 3,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 3000,
        operation = 3,
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 22234
        },
        operation = 4,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [759] = ProtobufI("SpecialAttrInfo", {
    index = 224340,
    maxLevel = 1,
    timing = 6,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceIdentityCategory = 3,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 3000,
        operation = 3,
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 22434
        },
        operation = 4,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [760] = ProtobufI("SpecialAttrInfo", {
    index = 1001131,
    maxLevel = 20,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 5000,
      cardNumProbability = {}
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [761] = ProtobufI("SpecialAttrInfo", {
    index = 1002131,
    maxLevel = 20,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [762] = ProtobufI("SpecialAttrInfo", {
    index = 1003131,
    maxLevel = 20,
    timing = 6,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceIdentityCategory = 3,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 3000,
        operation = 3,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [763] = ProtobufI("SpecialAttrInfo", {
    index = 1004131,
    maxLevel = 20,
    timing = 4,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [764] = ProtobufI("SpecialAttrInfo", {
    index = 1005131,
    maxLevel = 20,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [765] = ProtobufI("SpecialAttrInfo", {
    index = 1006131,
    maxLevel = 20,
    timing = 5,
    ownerIdentityCategory = 1,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 1006132,
      [2] = 1006133
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [766] = ProtobufI("SpecialAttrInfo", {
    index = 1006132,
    maxLevel = 20,
    timing = 4,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [767] = ProtobufI("SpecialAttrInfo", {
    index = 1006133,
    maxLevel = 20,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [768] = ProtobufI("SpecialAttrInfo", {
    index = 1007131,
    maxLevel = 20,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 7000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [769] = ProtobufI("SpecialAttrInfo", {
    index = 1008131,
    maxLevel = 20,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      bigSkillProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [770] = ProtobufI("SpecialAttrInfo", {
    index = 1009131,
    maxLevel = 20,
    timing = 6,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceAttackType = 1,
        sourceExtraParam = {},
        targetValue = 6000,
        operation = 3,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [771] = ProtobufI("SpecialAttrInfo", {
    index = 1010131,
    maxLevel = 20,
    timing = 6,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceIdentityCategory = 3,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 7000,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [772] = ProtobufI("SpecialAttrInfo", {
    index = 1011131,
    maxLevel = 20,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [773] = ProtobufI("SpecialAttrInfo", {
    index = 1012131,
    maxLevel = 20,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {
        [1] = 0,
        [2] = 10000
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [774] = ProtobufI("SpecialAttrInfo", {
    index = 1013131,
    maxLevel = 20,
    timing = 2,
    ownerIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [775] = ProtobufI("SpecialAttrInfo", {
    index = 1014131,
    maxLevel = 20,
    timing = 1,
    targetAttackType = 1,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 6000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [776] = ProtobufI("SpecialAttrInfo", {
    index = 1015131,
    maxLevel = 20,
    timing = 4,
    ownerIdentityCategory = 3,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 1015132
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [777] = ProtobufI("SpecialAttrInfo", {
    index = 1015132,
    maxLevel = 20,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [778] = ProtobufI("SpecialAttrInfo", {
    index = 1016131,
    maxLevel = 20,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 1016132
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [779] = ProtobufI("SpecialAttrInfo", {
    index = 1016132,
    maxLevel = 20,
    timing = 5,
    ownerIdentityCategory = 1,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [780] = ProtobufI("SpecialAttrInfo", {
    index = 1017131,
    maxLevel = 20,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [781] = ProtobufI("SpecialAttrInfo", {
    index = 1018131,
    maxLevel = 20,
    timing = 6,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 5000,
      cardNumProbability = {}
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [782] = ProtobufI("SpecialAttrInfo", {
    index = 1019131,
    maxLevel = 20,
    ownerIdentityCategory = 3,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [783] = ProtobufI("SpecialAttrInfo", {
    index = 1101131,
    maxLevel = 20,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 10000,
        [2] = 0
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [784] = ProtobufI("SpecialAttrInfo", {
    index = 1106131,
    maxLevel = 20,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [785] = ProtobufI("SpecialAttrInfo", {
    index = 1107131,
    maxLevel = 20,
    timing = 3,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 6,
        sourceIdentityCategory = 3,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 3000,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [786] = ProtobufI("SpecialAttrInfo", {
    index = 1112131,
    maxLevel = 20,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceAttackType = 3,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 3000,
        operation = 2,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [787] = ProtobufI("SpecialAttrInfo", {
    index = 1113131,
    maxLevel = 20,
    timing = 1,
    ownerIdentityCategory = 3,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 6250,
      cardNumProbability = {}
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [788] = ProtobufI("SpecialAttrInfo", {
    index = 1115131,
    maxLevel = 20,
    timing = 6,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 1115132
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 3,
        sourceExtraParam = {
          [1] = 0,
          [2] = 2
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [789] = ProtobufI("SpecialAttrInfo", {
    index = 1115132,
    maxLevel = 20,
    timing = 6,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 1,
        sourceExtraParam = {
          [1] = 0,
          [2] = 2
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [790] = ProtobufI("SpecialAttrInfo", {
    index = 1301131,
    maxLevel = 20,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 1301132,
      [2] = 1301133,
      [3] = 1301134,
      [4] = 1301135,
      [5] = 1301136
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [791] = ProtobufI("SpecialAttrInfo", {
    index = 1301132,
    maxLevel = 20,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 21,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 1301001
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [792] = ProtobufI("SpecialAttrInfo", {
    index = 1301133,
    maxLevel = 20,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 21,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 1301001
        },
        targetValue = 2,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [793] = ProtobufI("SpecialAttrInfo", {
    index = 1301134,
    maxLevel = 20,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 21,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 1301001
        },
        targetValue = 3,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [794] = ProtobufI("SpecialAttrInfo", {
    index = 1301135,
    maxLevel = 20,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 21,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 1301001
        },
        targetValue = 4,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [795] = ProtobufI("SpecialAttrInfo", {
    index = 1301136,
    maxLevel = 20,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 21,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 1301001
        },
        targetValue = 5,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [796] = ProtobufI("SpecialAttrInfo", {
    index = 1401131,
    maxLevel = 20,
    timing = 1,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      bigSkillProbability = 10000,
      linkProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 10000
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [797] = ProtobufI("SpecialAttrInfo", {
    index = 1409131,
    maxLevel = 20,
    timing = 1,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      bigSkillProbability = 10000,
      linkProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 10000
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [798] = ProtobufI("SpecialAttrInfo", {
    index = 1501131,
    maxLevel = 20,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 8000,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [799] = ProtobufI("SpecialAttrInfo", {
    index = 1502131,
    maxLevel = 20,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [800] = ProtobufI("SpecialAttrInfo", {
    index = 1504131,
    maxLevel = 20,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceAttackType = 3,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 3000,
        operation = 2,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [801] = ProtobufI("SpecialAttrInfo", {
    index = 1505131,
    maxLevel = 20,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      bigSkillProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [802] = ProtobufI("SpecialAttrInfo", {
    index = 1508131,
    maxLevel = 20,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 1508132
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      bigSkillProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 10000
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [803] = ProtobufI("SpecialAttrInfo", {
    index = 1508132,
    maxLevel = 20,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 9,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [804] = ProtobufI("SpecialAttrInfo", {
    index = 1509131,
    maxLevel = 20,
    timing = 6,
    ownerIdentityCategory = 1,
    targetIdentityCategory = 3,
    targetAttackType = 1,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [805] = ProtobufI("SpecialAttrInfo", {
    index = 1511131,
    maxLevel = 20,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 1511132
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 7000,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [806] = ProtobufI("SpecialAttrInfo", {
    index = 1511132,
    maxLevel = 20,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [807] = ProtobufI("SpecialAttrInfo", {
    index = 1514131,
    maxLevel = 20,
    timing = 4,
    ownerIdentityCategory = 3,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 1514132
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [808] = ProtobufI("SpecialAttrInfo", {
    index = 1514132,
    maxLevel = 20,
    timing = 4,
    ownerIdentityCategory = 3,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [809] = ProtobufI("SpecialAttrInfo", {
    index = 1514133,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [810] = ProtobufI("SpecialAttrInfo", {
    index = 1515131,
    maxLevel = 20,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 1515132,
      [2] = 1515133
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 10000,
        [2] = 0
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [811] = ProtobufI("SpecialAttrInfo", {
    index = 1515132,
    maxLevel = 20,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 0,
        [2] = 10000
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [812] = ProtobufI("SpecialAttrInfo", {
    index = 1515133,
    maxLevel = 20,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      cardNumProbability = {}
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [813] = ProtobufI("SpecialAttrInfo", {
    index = 1517131,
    maxLevel = 20,
    timing = 5,
    ownerIdentityCategory = 1,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 1517132
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [814] = ProtobufI("SpecialAttrInfo", {
    index = 1001151,
    maxLevel = 20,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 5000,
      cardNumProbability = {}
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [815] = ProtobufI("SpecialAttrInfo", {
    index = 1002151,
    maxLevel = 20,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [816] = ProtobufI("SpecialAttrInfo", {
    index = 1003151,
    maxLevel = 20,
    timing = 6,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceIdentityCategory = 3,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 3000,
        operation = 3,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [817] = ProtobufI("SpecialAttrInfo", {
    index = 1004151,
    maxLevel = 20,
    timing = 4,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [818] = ProtobufI("SpecialAttrInfo", {
    index = 1005151,
    maxLevel = 20,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [819] = ProtobufI("SpecialAttrInfo", {
    index = 1006151,
    maxLevel = 20,
    timing = 5,
    ownerIdentityCategory = 1,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 1006152,
      [2] = 1006153
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [820] = ProtobufI("SpecialAttrInfo", {
    index = 1006152,
    maxLevel = 20,
    timing = 4,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [821] = ProtobufI("SpecialAttrInfo", {
    index = 1006153,
    maxLevel = 20,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [822] = ProtobufI("SpecialAttrInfo", {
    index = 1007151,
    maxLevel = 20,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 5000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [823] = ProtobufI("SpecialAttrInfo", {
    index = 1008151,
    maxLevel = 20,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      bigSkillProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [824] = ProtobufI("SpecialAttrInfo", {
    index = 1009151,
    maxLevel = 20,
    timing = 6,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceAttackType = 1,
        sourceExtraParam = {},
        targetValue = 5000,
        operation = 3,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [825] = ProtobufI("SpecialAttrInfo", {
    index = 1010151,
    maxLevel = 20,
    timing = 6,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceIdentityCategory = 3,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 7000,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [826] = ProtobufI("SpecialAttrInfo", {
    index = 1011151,
    maxLevel = 20,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [827] = ProtobufI("SpecialAttrInfo", {
    index = 1012151,
    maxLevel = 20,
    timing = 1,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [828] = ProtobufI("SpecialAttrInfo", {
    index = 1013151,
    maxLevel = 20,
    timing = 2,
    ownerIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [829] = ProtobufI("SpecialAttrInfo", {
    index = 1014151,
    maxLevel = 20,
    timing = 1,
    targetAttackType = 1,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [830] = ProtobufI("SpecialAttrInfo", {
    index = 1015151,
    maxLevel = 20,
    timing = 4,
    ownerIdentityCategory = 3,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 1015152
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [831] = ProtobufI("SpecialAttrInfo", {
    index = 1015152,
    maxLevel = 20,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [832] = ProtobufI("SpecialAttrInfo", {
    index = 1016151,
    maxLevel = 20,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 1016132
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [833] = ProtobufI("SpecialAttrInfo", {
    index = 1017151,
    maxLevel = 20,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [834] = ProtobufI("SpecialAttrInfo", {
    index = 1018151,
    maxLevel = 20,
    timing = 6,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 5000,
      cardNumProbability = {}
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [835] = ProtobufI("SpecialAttrInfo", {
    index = 1019151,
    maxLevel = 20,
    ownerIdentityCategory = 3,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 5000,
      cardNumProbability = {
        [1] = 0
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [836] = ProtobufI("SpecialAttrInfo", {
    index = 1101151,
    maxLevel = 20,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 10000,
        [2] = 0
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [837] = ProtobufI("SpecialAttrInfo", {
    index = 1106151,
    maxLevel = 20,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [838] = ProtobufI("SpecialAttrInfo", {
    index = 1107151,
    maxLevel = 20,
    timing = 3,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 6,
        sourceIdentityCategory = 3,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 3000,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [839] = ProtobufI("SpecialAttrInfo", {
    index = 1112151,
    maxLevel = 20,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceAttackType = 3,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 3000,
        operation = 2,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [840] = ProtobufI("SpecialAttrInfo", {
    index = 1113151,
    maxLevel = 20,
    timing = 1,
    ownerIdentityCategory = 3,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 6250,
      cardNumProbability = {}
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [841] = ProtobufI("SpecialAttrInfo", {
    index = 1115151,
    maxLevel = 20,
    timing = 6,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 1115152
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 3,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 2
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [842] = ProtobufI("SpecialAttrInfo", {
    index = 1115152,
    maxLevel = 20,
    timing = 6,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 2
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [843] = ProtobufI("SpecialAttrInfo", {
    index = 1401151,
    maxLevel = 20,
    timing = 1,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      bigSkillProbability = 7000,
      linkProbability = 7000,
      cardNumProbability = {
        [1] = 0,
        [2] = 7000
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [844] = ProtobufI("SpecialAttrInfo", {
    index = 1409151,
    maxLevel = 20,
    timing = 1,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      bigSkillProbability = 7000,
      linkProbability = 7000,
      cardNumProbability = {
        [1] = 0,
        [2] = 7000
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [845] = ProtobufI("SpecialAttrInfo", {
    index = 1501151,
    maxLevel = 20,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 8000,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [846] = ProtobufI("SpecialAttrInfo", {
    index = 1502151,
    maxLevel = 20,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [847] = ProtobufI("SpecialAttrInfo", {
    index = 1504151,
    maxLevel = 20,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceAttackType = 3,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 3000,
        operation = 2,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [848] = ProtobufI("SpecialAttrInfo", {
    index = 1505151,
    maxLevel = 20,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      bigSkillProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [849] = ProtobufI("SpecialAttrInfo", {
    index = 1508151,
    maxLevel = 20,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 1508132
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      bigSkillProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 10000
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [850] = ProtobufI("SpecialAttrInfo", {
    index = 1508152,
    maxLevel = 20,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 9,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [851] = ProtobufI("SpecialAttrInfo", {
    index = 1509151,
    maxLevel = 20,
    timing = 6,
    ownerIdentityCategory = 1,
    targetIdentityCategory = 3,
    targetAttackType = 1,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [852] = ProtobufI("SpecialAttrInfo", {
    index = 1511151,
    maxLevel = 20,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 1511152
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 7000,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [853] = ProtobufI("SpecialAttrInfo", {
    index = 1511152,
    maxLevel = 20,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [854] = ProtobufI("SpecialAttrInfo", {
    index = 1514151,
    maxLevel = 20,
    timing = 4,
    ownerIdentityCategory = 3,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 1514152
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [855] = ProtobufI("SpecialAttrInfo", {
    index = 1514152,
    maxLevel = 20,
    timing = 4,
    ownerIdentityCategory = 3,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [856] = ProtobufI("SpecialAttrInfo", {
    index = 1515151,
    maxLevel = 20,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 1515152
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 10000,
        [2] = 0
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [857] = ProtobufI("SpecialAttrInfo", {
    index = 1515152,
    maxLevel = 20,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 0,
        [2] = 10000
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [858] = ProtobufI("SpecialAttrInfo", {
    index = 1517151,
    maxLevel = 20,
    timing = 5,
    ownerIdentityCategory = 1,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 1517152
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [859] = ProtobufI("SpecialAttrInfo", {
    index = 1001161,
    maxLevel = 20,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 5000,
      cardNumProbability = {}
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [860] = ProtobufI("SpecialAttrInfo", {
    index = 1002161,
    maxLevel = 20,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [861] = ProtobufI("SpecialAttrInfo", {
    index = 1003161,
    maxLevel = 20,
    timing = 6,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceIdentityCategory = 3,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 3000,
        operation = 3,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [862] = ProtobufI("SpecialAttrInfo", {
    index = 1004161,
    maxLevel = 20,
    timing = 4,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [863] = ProtobufI("SpecialAttrInfo", {
    index = 1005161,
    maxLevel = 20,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [864] = ProtobufI("SpecialAttrInfo", {
    index = 1006161,
    maxLevel = 20,
    timing = 5,
    ownerIdentityCategory = 1,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 1006162,
      [2] = 1006163
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [865] = ProtobufI("SpecialAttrInfo", {
    index = 1006162,
    maxLevel = 20,
    timing = 4,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [866] = ProtobufI("SpecialAttrInfo", {
    index = 1006163,
    maxLevel = 20,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [867] = ProtobufI("SpecialAttrInfo", {
    index = 1007161,
    maxLevel = 20,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 5000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [868] = ProtobufI("SpecialAttrInfo", {
    index = 1008161,
    maxLevel = 20,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      bigSkillProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [869] = ProtobufI("SpecialAttrInfo", {
    index = 1009161,
    maxLevel = 20,
    timing = 6,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceAttackType = 1,
        sourceExtraParam = {},
        targetValue = 5000,
        operation = 3,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [870] = ProtobufI("SpecialAttrInfo", {
    index = 1010161,
    maxLevel = 20,
    timing = 6,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceIdentityCategory = 3,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 7000,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [871] = ProtobufI("SpecialAttrInfo", {
    index = 1011161,
    maxLevel = 20,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [872] = ProtobufI("SpecialAttrInfo", {
    index = 1012161,
    maxLevel = 20,
    timing = 1,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [873] = ProtobufI("SpecialAttrInfo", {
    index = 1013161,
    maxLevel = 20,
    timing = 2,
    ownerIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [874] = ProtobufI("SpecialAttrInfo", {
    index = 1014161,
    maxLevel = 20,
    timing = 1,
    targetAttackType = 1,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 5000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [875] = ProtobufI("SpecialAttrInfo", {
    index = 1015161,
    maxLevel = 20,
    timing = 4,
    ownerIdentityCategory = 3,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 1015162
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [876] = ProtobufI("SpecialAttrInfo", {
    index = 1015162,
    maxLevel = 20,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [877] = ProtobufI("SpecialAttrInfo", {
    index = 1016161,
    maxLevel = 20,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 1016132
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [878] = ProtobufI("SpecialAttrInfo", {
    index = 1017161,
    maxLevel = 20,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [879] = ProtobufI("SpecialAttrInfo", {
    index = 1018161,
    maxLevel = 20,
    timing = 6,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 5000,
      cardNumProbability = {}
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [880] = ProtobufI("SpecialAttrInfo", {
    index = 1019161,
    maxLevel = 20,
    ownerIdentityCategory = 3,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 5000,
      cardNumProbability = {
        [1] = 0
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [881] = ProtobufI("SpecialAttrInfo", {
    index = 1101161,
    maxLevel = 20,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 10000,
        [2] = 0
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [882] = ProtobufI("SpecialAttrInfo", {
    index = 1106161,
    maxLevel = 20,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [883] = ProtobufI("SpecialAttrInfo", {
    index = 1107161,
    maxLevel = 20,
    timing = 3,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 6,
        sourceIdentityCategory = 3,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 3000,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [884] = ProtobufI("SpecialAttrInfo", {
    index = 1112161,
    maxLevel = 20,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceAttackType = 3,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 3000,
        operation = 2,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [885] = ProtobufI("SpecialAttrInfo", {
    index = 1113161,
    maxLevel = 20,
    timing = 1,
    ownerIdentityCategory = 3,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 6250,
      cardNumProbability = {}
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [886] = ProtobufI("SpecialAttrInfo", {
    index = 1115161,
    maxLevel = 20,
    timing = 6,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 1115162
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 3,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 2
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [887] = ProtobufI("SpecialAttrInfo", {
    index = 1115162,
    maxLevel = 20,
    timing = 6,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 2
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [888] = ProtobufI("SpecialAttrInfo", {
    index = 1401161,
    maxLevel = 20,
    timing = 1,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      bigSkillProbability = 7000,
      linkProbability = 7000,
      cardNumProbability = {
        [1] = 0,
        [2] = 7000
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [889] = ProtobufI("SpecialAttrInfo", {
    index = 1409161,
    maxLevel = 20,
    timing = 1,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      bigSkillProbability = 7000,
      linkProbability = 7000,
      cardNumProbability = {
        [1] = 0,
        [2] = 7000
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [890] = ProtobufI("SpecialAttrInfo", {
    index = 1501161,
    maxLevel = 20,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 8000,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [891] = ProtobufI("SpecialAttrInfo", {
    index = 1502161,
    maxLevel = 20,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [892] = ProtobufI("SpecialAttrInfo", {
    index = 1504161,
    maxLevel = 20,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceAttackType = 3,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 3000,
        operation = 2,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [893] = ProtobufI("SpecialAttrInfo", {
    index = 1505161,
    maxLevel = 20,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      bigSkillProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [894] = ProtobufI("SpecialAttrInfo", {
    index = 1508161,
    maxLevel = 20,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 1508132
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      bigSkillProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 10000
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [895] = ProtobufI("SpecialAttrInfo", {
    index = 1508162,
    maxLevel = 20,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 9,
        sourceExtraParam = {},
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [896] = ProtobufI("SpecialAttrInfo", {
    index = 1509161,
    maxLevel = 20,
    timing = 6,
    ownerIdentityCategory = 1,
    targetIdentityCategory = 3,
    targetAttackType = 1,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [897] = ProtobufI("SpecialAttrInfo", {
    index = 1511161,
    maxLevel = 20,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 1511162
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 7000,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [898] = ProtobufI("SpecialAttrInfo", {
    index = 1511162,
    maxLevel = 20,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [899] = ProtobufI("SpecialAttrInfo", {
    index = 1514161,
    maxLevel = 20,
    timing = 4,
    ownerIdentityCategory = 3,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 1514162
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [900] = ProtobufI("SpecialAttrInfo", {
    index = 1514162,
    maxLevel = 20,
    timing = 4,
    ownerIdentityCategory = 3,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [901] = ProtobufI("SpecialAttrInfo", {
    index = 1515161,
    maxLevel = 20,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 1515162
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 10000,
        [2] = 0
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [902] = ProtobufI("SpecialAttrInfo", {
    index = 1515162,
    maxLevel = 20,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 0,
        [2] = 10000
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [903] = ProtobufI("SpecialAttrInfo", {
    index = 1517161,
    maxLevel = 20,
    timing = 5,
    ownerIdentityCategory = 1,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 1517162
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [904] = ProtobufI("SpecialAttrInfo", {
    index = 1101031,
    maxLevel = 20,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 0,
        [2] = 10000
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [905] = ProtobufI("SpecialAttrInfo", {
    index = 1101041,
    maxLevel = 20,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      bigSkillProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [906] = ProtobufI("SpecialAttrInfo", {
    index = 1115211,
    maxLevel = 11,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 3,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 3
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [907] = ProtobufI("SpecialAttrInfo", {
    index = 1301001,
    maxLevel = 25,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 1301002
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {
        [1] = 10000,
        [2] = 0
      }
    }),
    conditions = {}
  }),
  [908] = ProtobufI("SpecialAttrInfo", {
    index = 1301002,
    maxLevel = 25,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {
        [1] = 3000,
        [2] = 0
      }
    }),
    conditions = {}
  }),
  [909] = ProtobufI("SpecialAttrInfo", {
    index = 1301011,
    maxLevel = 25,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 1301012,
      [2] = 1301013
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {
        [1] = 0,
        [2] = 10000
      }
    }),
    conditions = {}
  }),
  [910] = ProtobufI("SpecialAttrInfo", {
    index = 1301012,
    maxLevel = 25,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {
        [1] = 0,
        [2] = 6000
      }
    }),
    conditions = {}
  }),
  [911] = ProtobufI("SpecialAttrInfo", {
    index = 1301013,
    maxLevel = 25,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {
        [1] = 0,
        [2] = 3000
      }
    }),
    conditions = {}
  }),
  [912] = ProtobufI("SpecialAttrInfo", {
    index = 1301021,
    maxLevel = 25,
    timing = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 1301024,
      [2] = 1301025,
      [3] = 1301026,
      [4] = 1301027,
      [5] = 1301028,
      [6] = 1301022,
      [7] = 1301023
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      bigSkillProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {}
  }),
  [913] = ProtobufI("SpecialAttrInfo", {
    index = 1301022,
    maxLevel = 25,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      bigSkillProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 1301002
        },
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [914] = ProtobufI("SpecialAttrInfo", {
    index = 1301023,
    maxLevel = 25,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      bigSkillProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 1301002
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [915] = ProtobufI("SpecialAttrInfo", {
    index = 1301024,
    maxLevel = 25,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      bigSkillProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 21,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 1301001
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [916] = ProtobufI("SpecialAttrInfo", {
    index = 1301025,
    maxLevel = 25,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      bigSkillProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 21,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 1301001
        },
        targetValue = 2,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [917] = ProtobufI("SpecialAttrInfo", {
    index = 1301026,
    maxLevel = 25,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      bigSkillProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 21,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 1301001
        },
        targetValue = 3,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [918] = ProtobufI("SpecialAttrInfo", {
    index = 1301027,
    maxLevel = 25,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      bigSkillProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 21,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 1301001
        },
        targetValue = 4,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [919] = ProtobufI("SpecialAttrInfo", {
    index = 1301028,
    maxLevel = 25,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      bigSkillProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 21,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 1301001
        },
        targetValue = 5,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [920] = ProtobufI("SpecialAttrInfo", {
    index = 1505011,
    maxLevel = 20,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 0,
        [2] = 10000
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 21,
        sourceIdentityCategory = 3,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 150501
        },
        targetValue = 5,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [921] = ProtobufI("SpecialAttrInfo", {
    index = 1505012,
    maxLevel = 20,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 0,
        [2] = 10000
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 21,
        sourceIdentityCategory = 3,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 150501
        },
        targetValue = 5,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [922] = ProtobufI("SpecialAttrInfo", {
    index = 1505013,
    maxLevel = 20,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 0,
        [2] = 10000
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 21,
        sourceIdentityCategory = 3,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 150501
        },
        targetValue = 5,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [923] = ProtobufI("SpecialAttrInfo", {
    index = 1505014,
    maxLevel = 20,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 0,
        [2] = 10000
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 21,
        sourceIdentityCategory = 3,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 150501
        },
        targetValue = 5,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [924] = ProtobufI("SpecialAttrInfo", {
    index = 1505015,
    maxLevel = 20,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 0,
        [2] = 10000
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 21,
        sourceIdentityCategory = 3,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 150501
        },
        targetValue = 5,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [925] = ProtobufI("SpecialAttrInfo", {
    index = 1508001,
    maxLevel = 25,
    timing = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 10000,
        [2] = 0
      }
    }),
    conditions = {}
  }),
  [926] = ProtobufI("SpecialAttrInfo", {
    index = 1508011,
    maxLevel = 25,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 0,
        [2] = 10000
      }
    }),
    conditions = {}
  }),
  [927] = ProtobufI("SpecialAttrInfo", {
    index = 1508021,
    maxLevel = 25,
    timing = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      bigSkillProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {}
  }),
  [928] = ProtobufI("SpecialAttrInfo", {
    index = 1508201,
    maxLevel = 25,
    timing = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      linkProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {}
  }),
  [929] = ProtobufI("SpecialAttrInfo", {
    index = 1508211,
    maxLevel = 25,
    timing = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      linkProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {}
  }),
  [930] = ProtobufI("SpecialAttrInfo", {
    index = 1511001,
    maxLevel = 20,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 10000,
        [2] = 0
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [931] = ProtobufI("SpecialAttrInfo", {
    index = 1511002,
    maxLevel = 20,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 10000,
        [2] = 0
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [932] = ProtobufI("SpecialAttrInfo", {
    index = 1511003,
    maxLevel = 20,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 10000,
        [2] = 0
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [933] = ProtobufI("SpecialAttrInfo", {
    index = 1511004,
    maxLevel = 20,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 10000,
        [2] = 0
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [934] = ProtobufI("SpecialAttrInfo", {
    index = 1511005,
    maxLevel = 20,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 10000,
        [2] = 0
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [935] = ProtobufI("SpecialAttrInfo", {
    index = 1511011,
    maxLevel = 20,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 0,
        [2] = 10000
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [936] = ProtobufI("SpecialAttrInfo", {
    index = 1511012,
    maxLevel = 20,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 0,
        [2] = 10000
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [937] = ProtobufI("SpecialAttrInfo", {
    index = 1511013,
    maxLevel = 20,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 0,
        [2] = 10000
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [938] = ProtobufI("SpecialAttrInfo", {
    index = 1511014,
    maxLevel = 20,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 0,
        [2] = 10000
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [939] = ProtobufI("SpecialAttrInfo", {
    index = 1511015,
    maxLevel = 20,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 0,
        [2] = 10000
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [940] = ProtobufI("SpecialAttrInfo", {
    index = 1511111,
    maxLevel = 20,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 1511011
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [941] = ProtobufI("SpecialAttrInfo", {
    index = 1511112,
    maxLevel = 20,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 1511012
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [942] = ProtobufI("SpecialAttrInfo", {
    index = 1511113,
    maxLevel = 20,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 1511013
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [943] = ProtobufI("SpecialAttrInfo", {
    index = 1511114,
    maxLevel = 20,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 1511014
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [944] = ProtobufI("SpecialAttrInfo", {
    index = 1511115,
    maxLevel = 20,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 1511015
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [945] = ProtobufI("SpecialAttrInfo", {
    index = 1511031,
    maxLevel = 20,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      bigSkillProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [946] = ProtobufI("SpecialAttrInfo", {
    index = 1511032,
    maxLevel = 20,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      bigSkillProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [947] = ProtobufI("SpecialAttrInfo", {
    index = 1511033,
    maxLevel = 20,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      bigSkillProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [948] = ProtobufI("SpecialAttrInfo", {
    index = 1511034,
    maxLevel = 20,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      bigSkillProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [949] = ProtobufI("SpecialAttrInfo", {
    index = 1511035,
    maxLevel = 20,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      bigSkillProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [950] = ProtobufI("SpecialAttrInfo", {
    index = 1514001,
    maxLevel = 20,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 10000,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 4,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 151401
        },
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 4,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 151402
        },
        sourceOperation = {},
        sourceOperand = {}
      }),
      [3] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 4,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 151403
        },
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [951] = ProtobufI("SpecialAttrInfo", {
    index = 1514002,
    maxLevel = 20,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 10000,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 4,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 151401
        },
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 4,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 151402
        },
        sourceOperation = {},
        sourceOperand = {}
      }),
      [3] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 4,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 151403
        },
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [952] = ProtobufI("SpecialAttrInfo", {
    index = 1514003,
    maxLevel = 20,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 10000,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 4,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 151401
        },
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 4,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 151402
        },
        sourceOperation = {},
        sourceOperand = {}
      }),
      [3] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 4,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 151403
        },
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [953] = ProtobufI("SpecialAttrInfo", {
    index = 1514004,
    maxLevel = 20,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 10000,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 4,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 151401
        },
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 4,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 151402
        },
        sourceOperation = {},
        sourceOperand = {}
      }),
      [3] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 4,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 151403
        },
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [954] = ProtobufI("SpecialAttrInfo", {
    index = 1514005,
    maxLevel = 20,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 10000,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 4,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 151401
        },
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 4,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 151402
        },
        sourceOperation = {},
        sourceOperand = {}
      }),
      [3] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 4,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 151403
        },
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [955] = ProtobufI("SpecialAttrInfo", {
    index = 1514101,
    maxLevel = 20,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 10000,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 4,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 151401
        },
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [956] = ProtobufI("SpecialAttrInfo", {
    index = 1514102,
    maxLevel = 20,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 10000,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 4,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 151401
        },
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [957] = ProtobufI("SpecialAttrInfo", {
    index = 1514103,
    maxLevel = 20,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 10000,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 4,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 151401
        },
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [958] = ProtobufI("SpecialAttrInfo", {
    index = 1514104,
    maxLevel = 20,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 10000,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 4,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 151401
        },
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [959] = ProtobufI("SpecialAttrInfo", {
    index = 1514105,
    maxLevel = 20,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 10000,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 4,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 151401
        },
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [960] = ProtobufI("SpecialAttrInfo", {
    index = 1514201,
    maxLevel = 20,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 10000,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 4,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 151402
        },
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [961] = ProtobufI("SpecialAttrInfo", {
    index = 1514202,
    maxLevel = 20,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 10000,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 4,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 151402
        },
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [962] = ProtobufI("SpecialAttrInfo", {
    index = 1514203,
    maxLevel = 20,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 10000,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 4,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 151402
        },
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [963] = ProtobufI("SpecialAttrInfo", {
    index = 1514204,
    maxLevel = 20,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 10000,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 4,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 151402
        },
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [964] = ProtobufI("SpecialAttrInfo", {
    index = 1514205,
    maxLevel = 20,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 10000,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 4,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 151402
        },
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [965] = ProtobufI("SpecialAttrInfo", {
    index = 1514301,
    maxLevel = 20,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 1514201,
      [2] = 1514101,
      [3] = 1514001
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 10000,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 4,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 151403
        },
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [966] = ProtobufI("SpecialAttrInfo", {
    index = 1514302,
    maxLevel = 20,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 1514202,
      [2] = 1514102,
      [3] = 1514002
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 10000,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 4,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 151403
        },
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [967] = ProtobufI("SpecialAttrInfo", {
    index = 1514303,
    maxLevel = 20,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 1514203,
      [2] = 1514103,
      [3] = 1514003
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 10000,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 4,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 151403
        },
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [968] = ProtobufI("SpecialAttrInfo", {
    index = 1514304,
    maxLevel = 20,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 1514204,
      [2] = 1514104,
      [3] = 1514004
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 10000,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 4,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 151403
        },
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [969] = ProtobufI("SpecialAttrInfo", {
    index = 1514305,
    maxLevel = 20,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 1514205,
      [2] = 1514105,
      [3] = 1514005
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 10000,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 4,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 151403
        },
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [970] = ProtobufI("SpecialAttrInfo", {
    index = 1514411,
    maxLevel = 20,
    timing = 8,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 13,
        sourceIdentityCategory = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 2
        },
        operation = 4,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [971] = ProtobufI("SpecialAttrInfo", {
    index = 1514412,
    maxLevel = 20,
    timing = 8,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 13,
        sourceIdentityCategory = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 2
        },
        operation = 4,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [972] = ProtobufI("SpecialAttrInfo", {
    index = 1514413,
    maxLevel = 20,
    timing = 8,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 13,
        sourceIdentityCategory = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 2
        },
        operation = 4,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [973] = ProtobufI("SpecialAttrInfo", {
    index = 1514414,
    maxLevel = 20,
    timing = 8,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 13,
        sourceIdentityCategory = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 2
        },
        operation = 4,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [974] = ProtobufI("SpecialAttrInfo", {
    index = 1514415,
    maxLevel = 20,
    timing = 8,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 13,
        sourceIdentityCategory = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 2
        },
        operation = 4,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [975] = ProtobufI("SpecialAttrInfo", {
    index = 1515001,
    maxLevel = 25,
    timing = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 1515002
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 10000,
        [2] = 0
      }
    }),
    conditions = {}
  }),
  [976] = ProtobufI("SpecialAttrInfo", {
    index = 1515002,
    maxLevel = 25,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 10000,
        [2] = 0
      }
    }),
    conditions = {}
  }),
  [977] = ProtobufI("SpecialAttrInfo", {
    index = 1515011,
    maxLevel = 25,
    timing = 2,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 1515012
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 0,
        [2] = 10000
      }
    }),
    conditions = {}
  }),
  [978] = ProtobufI("SpecialAttrInfo", {
    index = 1515012,
    maxLevel = 25,
    timing = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 0,
        [2] = 10000
      }
    }),
    conditions = {}
  }),
  [979] = ProtobufI("SpecialAttrInfo", {
    index = 1515021,
    maxLevel = 25,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      bigSkillProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 151504
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [980] = ProtobufI("SpecialAttrInfo", {
    index = 1515201,
    maxLevel = 25,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      linkProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {}
  }),
  [981] = ProtobufI("SpecialAttrInfo", {
    index = 1515211,
    maxLevel = 25,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      linkProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {}
  }),
  [982] = ProtobufI("SpecialAttrInfo", {
    index = 2114401,
    maxLevel = 20,
    timing = 8,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 13,
        sourceIdentityCategory = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 2
        },
        operation = 4,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [983] = ProtobufI("SpecialAttrInfo", {
    index = 2114402,
    maxLevel = 20,
    timing = 8,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 13,
        sourceIdentityCategory = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 2
        },
        operation = 4,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [984] = ProtobufI("SpecialAttrInfo", {
    index = 2114403,
    maxLevel = 20,
    timing = 8,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 13,
        sourceIdentityCategory = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 2
        },
        operation = 4,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [985] = ProtobufI("SpecialAttrInfo", {
    index = 2114404,
    maxLevel = 20,
    timing = 8,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 13,
        sourceIdentityCategory = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 2
        },
        operation = 4,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [986] = ProtobufI("SpecialAttrInfo", {
    index = 2114405,
    maxLevel = 20,
    timing = 8,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 13,
        sourceIdentityCategory = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 2
        },
        operation = 4,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [987] = ProtobufI("SpecialAttrInfo", {
    index = 2115001,
    maxLevel = 25,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 2115101
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {
        [1] = 10000,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 1
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [988] = ProtobufI("SpecialAttrInfo", {
    index = 2115002,
    maxLevel = 25,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 2115102
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {
        [1] = 10000,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 1
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [989] = ProtobufI("SpecialAttrInfo", {
    index = 2115003,
    maxLevel = 25,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 2115103
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {
        [1] = 10000,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 1
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [990] = ProtobufI("SpecialAttrInfo", {
    index = 2115004,
    maxLevel = 25,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 2115104
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {
        [1] = 10000,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 1
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [991] = ProtobufI("SpecialAttrInfo", {
    index = 2115005,
    maxLevel = 25,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 2115105
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {
        [1] = 10000,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 1
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [992] = ProtobufI("SpecialAttrInfo", {
    index = 2115101,
    maxLevel = 25,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {
        [1] = 10000,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 1
        },
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [993] = ProtobufI("SpecialAttrInfo", {
    index = 2115102,
    maxLevel = 25,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {
        [1] = 10000,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 1
        },
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [994] = ProtobufI("SpecialAttrInfo", {
    index = 2115103,
    maxLevel = 25,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {
        [1] = 10000,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 1
        },
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [995] = ProtobufI("SpecialAttrInfo", {
    index = 2115104,
    maxLevel = 25,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {
        [1] = 10000,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 1
        },
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [996] = ProtobufI("SpecialAttrInfo", {
    index = 2115105,
    maxLevel = 25,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {
        [1] = 10000,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 1
        },
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [997] = ProtobufI("SpecialAttrInfo", {
    index = 2119401,
    maxLevel = 20,
    timing = 8,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 13,
        sourceIdentityCategory = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 2
        },
        operation = 4,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [998] = ProtobufI("SpecialAttrInfo", {
    index = 2119402,
    maxLevel = 20,
    timing = 8,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 13,
        sourceIdentityCategory = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 2
        },
        operation = 4,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [999] = ProtobufI("SpecialAttrInfo", {
    index = 2119403,
    maxLevel = 20,
    timing = 8,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 13,
        sourceIdentityCategory = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 2
        },
        operation = 4,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [1000] = ProtobufI("SpecialAttrInfo", {
    index = 2119404,
    maxLevel = 20,
    timing = 8,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 13,
        sourceIdentityCategory = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 2
        },
        operation = 4,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [1001] = ProtobufI("SpecialAttrInfo", {
    index = 2119405,
    maxLevel = 20,
    timing = 8,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 13,
        sourceIdentityCategory = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 2
        },
        operation = 4,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [1002] = ProtobufI("SpecialAttrInfo", {
    index = 2007001,
    maxLevel = 25,
    timing = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 10000,
        [2] = 0
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [1003] = ProtobufI("SpecialAttrInfo", {
    index = 2007002,
    maxLevel = 25,
    timing = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 10000,
        [2] = 0
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [1004] = ProtobufI("SpecialAttrInfo", {
    index = 2007003,
    maxLevel = 25,
    timing = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 10000,
        [2] = 0
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [1005] = ProtobufI("SpecialAttrInfo", {
    index = 2007004,
    maxLevel = 25,
    timing = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 10000,
        [2] = 0
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [1006] = ProtobufI("SpecialAttrInfo", {
    index = 2007005,
    maxLevel = 25,
    timing = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 10000,
        [2] = 0
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [1007] = ProtobufI("SpecialAttrInfo", {
    index = 2107001,
    maxLevel = 25,
    timing = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 2107011,
      [2] = 2107021
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {
        [1] = 0,
        [2] = 10000
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceIdentityCategory = 3,
        sourceAttackType = 4,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 6000,
        operation = 3,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [1008] = ProtobufI("SpecialAttrInfo", {
    index = 2107002,
    maxLevel = 25,
    timing = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 2107012,
      [2] = 2107022
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {
        [1] = 0,
        [2] = 10000
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceIdentityCategory = 3,
        sourceAttackType = 4,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 6000,
        operation = 3,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [1009] = ProtobufI("SpecialAttrInfo", {
    index = 2107003,
    maxLevel = 25,
    timing = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 2107013,
      [2] = 2107023
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {
        [1] = 0,
        [2] = 10000
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceIdentityCategory = 3,
        sourceAttackType = 4,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 6000,
        operation = 3,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [1010] = ProtobufI("SpecialAttrInfo", {
    index = 2107004,
    maxLevel = 25,
    timing = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 2107014,
      [2] = 2107024
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {
        [1] = 0,
        [2] = 10000
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceIdentityCategory = 3,
        sourceAttackType = 4,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 6000,
        operation = 3,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [1011] = ProtobufI("SpecialAttrInfo", {
    index = 2107005,
    maxLevel = 25,
    timing = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 2107015,
      [2] = 2107025
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {
        [1] = 0,
        [2] = 10000
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceIdentityCategory = 3,
        sourceAttackType = 4,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 6000,
        operation = 3,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [1012] = ProtobufI("SpecialAttrInfo", {
    index = 2107011,
    maxLevel = 25,
    timing = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {
        [1] = 0,
        [2] = 10000
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceIdentityCategory = 1,
        sourceAttackType = 4,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 6000,
        operation = 3,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [1013] = ProtobufI("SpecialAttrInfo", {
    index = 2107012,
    maxLevel = 25,
    timing = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {
        [1] = 0,
        [2] = 10000
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceIdentityCategory = 1,
        sourceAttackType = 4,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 6000,
        operation = 3,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [1014] = ProtobufI("SpecialAttrInfo", {
    index = 2107013,
    maxLevel = 25,
    timing = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {
        [1] = 0,
        [2] = 10000
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceIdentityCategory = 1,
        sourceAttackType = 4,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 6000,
        operation = 3,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [1015] = ProtobufI("SpecialAttrInfo", {
    index = 2107014,
    maxLevel = 25,
    timing = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {
        [1] = 0,
        [2] = 10000
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceIdentityCategory = 1,
        sourceAttackType = 4,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 6000,
        operation = 3,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [1016] = ProtobufI("SpecialAttrInfo", {
    index = 2107015,
    maxLevel = 25,
    timing = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {
        [1] = 0,
        [2] = 10000
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceIdentityCategory = 1,
        sourceAttackType = 4,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 6000,
        operation = 3,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [1017] = ProtobufI("SpecialAttrInfo", {
    index = 2107021,
    maxLevel = 25,
    timing = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {
        [1] = 0,
        [2] = 10000
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [1018] = ProtobufI("SpecialAttrInfo", {
    index = 2107022,
    maxLevel = 25,
    timing = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {
        [1] = 0,
        [2] = 10000
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [1019] = ProtobufI("SpecialAttrInfo", {
    index = 2107023,
    maxLevel = 25,
    timing = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {
        [1] = 0,
        [2] = 10000
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [1020] = ProtobufI("SpecialAttrInfo", {
    index = 2107024,
    maxLevel = 25,
    timing = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {
        [1] = 0,
        [2] = 10000
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [1021] = ProtobufI("SpecialAttrInfo", {
    index = 2107025,
    maxLevel = 25,
    timing = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      cardNumProbability = {
        [1] = 0,
        [2] = 10000
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [1022] = ProtobufI("SpecialAttrInfo", {
    index = 2123401,
    maxLevel = 20,
    timing = 8,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 13,
        sourceIdentityCategory = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 2
        },
        operation = 4,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [1023] = ProtobufI("SpecialAttrInfo", {
    index = 2123402,
    maxLevel = 20,
    timing = 8,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 13,
        sourceIdentityCategory = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 2
        },
        operation = 4,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [1024] = ProtobufI("SpecialAttrInfo", {
    index = 2123403,
    maxLevel = 20,
    timing = 8,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 13,
        sourceIdentityCategory = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 2
        },
        operation = 4,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [1025] = ProtobufI("SpecialAttrInfo", {
    index = 2123404,
    maxLevel = 20,
    timing = 8,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 13,
        sourceIdentityCategory = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 2
        },
        operation = 4,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [1026] = ProtobufI("SpecialAttrInfo", {
    index = 2123405,
    maxLevel = 20,
    timing = 8,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 13,
        sourceIdentityCategory = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 2
        },
        operation = 4,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [1027] = ProtobufI("SpecialAttrInfo", {
    index = 2127101,
    maxLevel = 25,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 0,
        [2] = 10000
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [1028] = ProtobufI("SpecialAttrInfo", {
    index = 2127102,
    maxLevel = 25,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 0,
        [2] = 10000
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [1029] = ProtobufI("SpecialAttrInfo", {
    index = 2127103,
    maxLevel = 25,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 0,
        [2] = 10000
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [1030] = ProtobufI("SpecialAttrInfo", {
    index = 2127104,
    maxLevel = 25,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 0,
        [2] = 10000
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [1031] = ProtobufI("SpecialAttrInfo", {
    index = 2127105,
    maxLevel = 25,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 0,
        [2] = 10000
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [1032] = ProtobufI("SpecialAttrInfo", {
    index = 2127201,
    maxLevel = 25,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      linkProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [1033] = ProtobufI("SpecialAttrInfo", {
    index = 2127202,
    maxLevel = 25,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      linkProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [1034] = ProtobufI("SpecialAttrInfo", {
    index = 2127203,
    maxLevel = 25,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      linkProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [1035] = ProtobufI("SpecialAttrInfo", {
    index = 2127204,
    maxLevel = 25,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      linkProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [1036] = ProtobufI("SpecialAttrInfo", {
    index = 2127205,
    maxLevel = 25,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      linkProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [1037] = ProtobufI("SpecialAttrInfo", {
    index = 2128011,
    maxLevel = 1,
    timing = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 0,
        [2] = 10000
      }
    }),
    conditions = {}
  }),
  [1038] = ProtobufI("SpecialAttrInfo", {
    index = 2128101,
    maxLevel = 1,
    timing = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      cardNumProbability = {
        [1] = 10000,
        [2] = 0
      }
    }),
    conditions = {}
  }),
  [1039] = ProtobufI("SpecialAttrInfo", {
    index = 2133211,
    maxLevel = 11,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      linkProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 1
        },
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [1040] = ProtobufI("SpecialAttrInfo", {
    index = 7008411,
    maxLevel = 20,
    timing = 8,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 13,
        sourceIdentityCategory = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 2
        },
        operation = 4,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [1041] = ProtobufI("SpecialAttrInfo", {
    index = 7008412,
    maxLevel = 20,
    timing = 8,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 13,
        sourceIdentityCategory = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 2
        },
        operation = 4,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [1042] = ProtobufI("SpecialAttrInfo", {
    index = 7008413,
    maxLevel = 20,
    timing = 8,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 13,
        sourceIdentityCategory = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 2
        },
        operation = 4,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [1043] = ProtobufI("SpecialAttrInfo", {
    index = 7008414,
    maxLevel = 20,
    timing = 8,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 13,
        sourceIdentityCategory = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 2
        },
        operation = 4,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [1044] = ProtobufI("SpecialAttrInfo", {
    index = 7008415,
    maxLevel = 20,
    timing = 8,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 13,
        sourceIdentityCategory = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 2
        },
        operation = 4,
        sourceOperation = {},
        sourceOperand = {}
      })
    },
    score = 5,
    scoreMax = 100
  }),
  [1045] = ProtobufI("SpecialAttrInfo", {
    index = 2113001,
    maxLevel = 1,
    timing = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [1046] = ProtobufI("SpecialAttrInfo", {
    index = 2113002,
    maxLevel = 1,
    timing = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [1047] = ProtobufI("SpecialAttrInfo", {
    index = 2113003,
    maxLevel = 1,
    timing = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [1048] = ProtobufI("SpecialAttrInfo", {
    index = 2113004,
    maxLevel = 1,
    timing = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [1049] = ProtobufI("SpecialAttrInfo", {
    index = 2113005,
    maxLevel = 1,
    timing = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      checkOnceOrEach = true,
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {},
    score = 5,
    scoreMax = 100
  }),
  [1050] = ProtobufI("SpecialAttrInfo", {
    index = 300101,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 300103
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [1051] = ProtobufI("SpecialAttrInfo", {
    index = 300102,
    maxLevel = 1,
    timing = 13,
    targetIdentityCategory = 3,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {}
  }),
  [1052] = ProtobufI("SpecialAttrInfo", {
    index = 300103,
    maxLevel = 1,
    timing = 6,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 51
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [1053] = ProtobufI("SpecialAttrInfo", {
    index = 300111,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 300113
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [1054] = ProtobufI("SpecialAttrInfo", {
    index = 300112,
    maxLevel = 1,
    timing = 13,
    targetIdentityCategory = 3,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {}
  }),
  [1055] = ProtobufI("SpecialAttrInfo", {
    index = 300113,
    maxLevel = 1,
    timing = 6,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 51
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [1056] = ProtobufI("SpecialAttrInfo", {
    index = 300121,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 300123
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [1057] = ProtobufI("SpecialAttrInfo", {
    index = 300122,
    maxLevel = 1,
    timing = 13,
    targetIdentityCategory = 3,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {}
  }),
  [1058] = ProtobufI("SpecialAttrInfo", {
    index = 300123,
    maxLevel = 1,
    timing = 6,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 51
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [1059] = ProtobufI("SpecialAttrInfo", {
    index = 300131,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 300133
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [1060] = ProtobufI("SpecialAttrInfo", {
    index = 300132,
    maxLevel = 1,
    timing = 13,
    targetIdentityCategory = 3,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {}
  }),
  [1061] = ProtobufI("SpecialAttrInfo", {
    index = 300133,
    maxLevel = 1,
    timing = 6,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 51
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [1062] = ProtobufI("SpecialAttrInfo", {
    index = 300141,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 300143
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [1063] = ProtobufI("SpecialAttrInfo", {
    index = 300142,
    maxLevel = 1,
    timing = 13,
    targetIdentityCategory = 3,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {}
  }),
  [1064] = ProtobufI("SpecialAttrInfo", {
    index = 300143,
    maxLevel = 1,
    timing = 6,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 51
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [1065] = ProtobufI("SpecialAttrInfo", {
    index = 300151,
    maxLevel = 1,
    timing = 5,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 300153
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 2,
        sourceExtraParam = {},
        targetValue = 1,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [1066] = ProtobufI("SpecialAttrInfo", {
    index = 300152,
    maxLevel = 1,
    timing = 13,
    targetIdentityCategory = 3,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {}
  }),
  [1067] = ProtobufI("SpecialAttrInfo", {
    index = 300153,
    maxLevel = 1,
    timing = 6,
    ownerIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 51
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [1068] = ProtobufI("SpecialAttrInfo", {
    index = 300201,
    maxLevel = 1,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 300202,
      [2] = 300203,
      [3] = 300204
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 21
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [1069] = ProtobufI("SpecialAttrInfo", {
    index = 300202,
    maxLevel = 1,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 22
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [1070] = ProtobufI("SpecialAttrInfo", {
    index = 300203,
    maxLevel = 1,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 7000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 300201
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 300204
        },
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [1071] = ProtobufI("SpecialAttrInfo", {
    index = 300204,
    maxLevel = 1,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1072] = ProtobufI("SpecialAttrInfo", {
    index = 300211,
    maxLevel = 1,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 300212,
      [2] = 300213,
      [3] = 300214
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 21
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [1073] = ProtobufI("SpecialAttrInfo", {
    index = 300212,
    maxLevel = 1,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 22
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [1074] = ProtobufI("SpecialAttrInfo", {
    index = 300213,
    maxLevel = 1,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 7000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 300211
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 300214
        },
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [1075] = ProtobufI("SpecialAttrInfo", {
    index = 300214,
    maxLevel = 1,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1076] = ProtobufI("SpecialAttrInfo", {
    index = 300221,
    maxLevel = 1,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 300222,
      [2] = 300223,
      [3] = 300224
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 21
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [1077] = ProtobufI("SpecialAttrInfo", {
    index = 300222,
    maxLevel = 1,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 22
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [1078] = ProtobufI("SpecialAttrInfo", {
    index = 300223,
    maxLevel = 1,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 8500,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 300221
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 300224
        },
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [1079] = ProtobufI("SpecialAttrInfo", {
    index = 300224,
    maxLevel = 1,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1080] = ProtobufI("SpecialAttrInfo", {
    index = 300231,
    maxLevel = 1,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 300232,
      [2] = 300233,
      [3] = 300234
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 21
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [1081] = ProtobufI("SpecialAttrInfo", {
    index = 300232,
    maxLevel = 1,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 22
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [1082] = ProtobufI("SpecialAttrInfo", {
    index = 300233,
    maxLevel = 1,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 8500,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 300231
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 300234
        },
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [1083] = ProtobufI("SpecialAttrInfo", {
    index = 300234,
    maxLevel = 1,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1084] = ProtobufI("SpecialAttrInfo", {
    index = 300241,
    maxLevel = 1,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 300242,
      [2] = 300243,
      [3] = 300244
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 21
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [1085] = ProtobufI("SpecialAttrInfo", {
    index = 300242,
    maxLevel = 1,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 22
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [1086] = ProtobufI("SpecialAttrInfo", {
    index = 300243,
    maxLevel = 1,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 8500,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 300241
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 300244
        },
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [1087] = ProtobufI("SpecialAttrInfo", {
    index = 300244,
    maxLevel = 1,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1088] = ProtobufI("SpecialAttrInfo", {
    index = 300251,
    maxLevel = 1,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 300252,
      [2] = 300253,
      [3] = 300254
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 21
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [1089] = ProtobufI("SpecialAttrInfo", {
    index = 300252,
    maxLevel = 1,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 22
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [1090] = ProtobufI("SpecialAttrInfo", {
    index = 300253,
    maxLevel = 1,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 300251
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 300254
        },
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [1091] = ProtobufI("SpecialAttrInfo", {
    index = 300254,
    maxLevel = 1,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1092] = ProtobufI("SpecialAttrInfo", {
    index = 300301,
    maxLevel = 1,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 300302
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 7000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 132
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 300302
        },
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [1093] = ProtobufI("SpecialAttrInfo", {
    index = 300302,
    maxLevel = 1,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1094] = ProtobufI("SpecialAttrInfo", {
    index = 300311,
    maxLevel = 1,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 300312
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 7000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 132
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 300312
        },
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [1095] = ProtobufI("SpecialAttrInfo", {
    index = 300312,
    maxLevel = 1,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1096] = ProtobufI("SpecialAttrInfo", {
    index = 300321,
    maxLevel = 1,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 300322
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 8500,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 132
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 300322
        },
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [1097] = ProtobufI("SpecialAttrInfo", {
    index = 300322,
    maxLevel = 1,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1098] = ProtobufI("SpecialAttrInfo", {
    index = 300331,
    maxLevel = 1,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 300332
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 8500,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 132
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 300332
        },
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [1099] = ProtobufI("SpecialAttrInfo", {
    index = 300332,
    maxLevel = 1,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1100] = ProtobufI("SpecialAttrInfo", {
    index = 300341,
    maxLevel = 1,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 300342
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 8500,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 132
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 300342
        },
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [1101] = ProtobufI("SpecialAttrInfo", {
    index = 300342,
    maxLevel = 1,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1102] = ProtobufI("SpecialAttrInfo", {
    index = 300351,
    maxLevel = 1,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 300352
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 132
        },
        targetValue = 1,
        operation = 5,
        sourceOperation = {},
        sourceOperand = {}
      }),
      [2] = ProtobufI("SpecialAttrInfo.Condition", {
        type = 1,
        sourceIdentityCategory = 2,
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {
          [1] = 0,
          [2] = 300352
        },
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [1103] = ProtobufI("SpecialAttrInfo", {
    index = 300352,
    maxLevel = 1,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1104] = ProtobufI("SpecialAttrInfo", {
    index = 300401,
    maxLevel = 1,
    timing = 2,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 300402
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1105] = ProtobufI("SpecialAttrInfo", {
    index = 300402,
    maxLevel = 1,
    timing = 2,
    targetIdentityCategory = 7,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1106] = ProtobufI("SpecialAttrInfo", {
    index = 300411,
    maxLevel = 1,
    timing = 2,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 300412
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1107] = ProtobufI("SpecialAttrInfo", {
    index = 300412,
    maxLevel = 1,
    timing = 2,
    targetIdentityCategory = 7,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1108] = ProtobufI("SpecialAttrInfo", {
    index = 300421,
    maxLevel = 1,
    timing = 2,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 300422
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1109] = ProtobufI("SpecialAttrInfo", {
    index = 300422,
    maxLevel = 1,
    timing = 2,
    targetIdentityCategory = 7,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1110] = ProtobufI("SpecialAttrInfo", {
    index = 300431,
    maxLevel = 1,
    timing = 2,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 300432
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1111] = ProtobufI("SpecialAttrInfo", {
    index = 300432,
    maxLevel = 1,
    timing = 2,
    targetIdentityCategory = 7,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1112] = ProtobufI("SpecialAttrInfo", {
    index = 300441,
    maxLevel = 1,
    timing = 2,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 300442
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1113] = ProtobufI("SpecialAttrInfo", {
    index = 300442,
    maxLevel = 1,
    timing = 2,
    targetIdentityCategory = 7,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1114] = ProtobufI("SpecialAttrInfo", {
    index = 300451,
    maxLevel = 1,
    timing = 2,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 300452
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1115] = ProtobufI("SpecialAttrInfo", {
    index = 300452,
    maxLevel = 1,
    timing = 2,
    targetIdentityCategory = 7,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1116] = ProtobufI("SpecialAttrInfo", {
    index = 300501,
    maxLevel = 1,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1117] = ProtobufI("SpecialAttrInfo", {
    index = 300511,
    maxLevel = 1,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1118] = ProtobufI("SpecialAttrInfo", {
    index = 300521,
    maxLevel = 1,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1119] = ProtobufI("SpecialAttrInfo", {
    index = 300531,
    maxLevel = 1,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1120] = ProtobufI("SpecialAttrInfo", {
    index = 300541,
    maxLevel = 1,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1121] = ProtobufI("SpecialAttrInfo", {
    index = 300551,
    maxLevel = 1,
    timing = 3,
    targetIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1122] = ProtobufI("SpecialAttrInfo", {
    index = 300601,
    maxLevel = 1,
    timing = 2,
    targetIdentityCategory = 7,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1123] = ProtobufI("SpecialAttrInfo", {
    index = 300603,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      bigSkillProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {}
  }),
  [1124] = ProtobufI("SpecialAttrInfo", {
    index = 300604,
    maxLevel = 1,
    timing = 13,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {}
  }),
  [1125] = ProtobufI("SpecialAttrInfo", {
    index = 300611,
    maxLevel = 1,
    timing = 2,
    targetIdentityCategory = 7,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1126] = ProtobufI("SpecialAttrInfo", {
    index = 300613,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      bigSkillProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {}
  }),
  [1127] = ProtobufI("SpecialAttrInfo", {
    index = 300614,
    maxLevel = 1,
    timing = 13,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {}
  }),
  [1128] = ProtobufI("SpecialAttrInfo", {
    index = 300621,
    maxLevel = 1,
    timing = 2,
    targetIdentityCategory = 7,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1129] = ProtobufI("SpecialAttrInfo", {
    index = 300623,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      bigSkillProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {}
  }),
  [1130] = ProtobufI("SpecialAttrInfo", {
    index = 300624,
    maxLevel = 1,
    timing = 13,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {}
  }),
  [1131] = ProtobufI("SpecialAttrInfo", {
    index = 300631,
    maxLevel = 1,
    timing = 2,
    targetIdentityCategory = 7,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1132] = ProtobufI("SpecialAttrInfo", {
    index = 300633,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      bigSkillProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {}
  }),
  [1133] = ProtobufI("SpecialAttrInfo", {
    index = 300634,
    maxLevel = 1,
    timing = 13,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {}
  }),
  [1134] = ProtobufI("SpecialAttrInfo", {
    index = 300641,
    maxLevel = 1,
    timing = 2,
    targetIdentityCategory = 7,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1135] = ProtobufI("SpecialAttrInfo", {
    index = 300643,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      bigSkillProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {}
  }),
  [1136] = ProtobufI("SpecialAttrInfo", {
    index = 300644,
    maxLevel = 1,
    timing = 13,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {}
  }),
  [1137] = ProtobufI("SpecialAttrInfo", {
    index = 300651,
    maxLevel = 1,
    timing = 2,
    targetIdentityCategory = 7,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1138] = ProtobufI("SpecialAttrInfo", {
    index = 300653,
    maxLevel = 1,
    timing = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      bigSkillProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {}
  }),
  [1139] = ProtobufI("SpecialAttrInfo", {
    index = 300654,
    maxLevel = 1,
    timing = 13,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {
        [1] = 0,
        [2] = 0
      }
    }),
    conditions = {}
  }),
  [1140] = ProtobufI("SpecialAttrInfo", {
    index = 400101,
    maxLevel = 1,
    timing = 2,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 400102
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1141] = ProtobufI("SpecialAttrInfo", {
    index = 400102,
    maxLevel = 1,
    timing = 2,
    targetIdentityCategory = 7,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1142] = ProtobufI("SpecialAttrInfo", {
    index = 400104,
    maxLevel = 1,
    timing = 13,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1143] = ProtobufI("SpecialAttrInfo", {
    index = 400105,
    maxLevel = 1,
    timing = 13,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1144] = ProtobufI("SpecialAttrInfo", {
    index = 400111,
    maxLevel = 1,
    timing = 2,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 400112
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1145] = ProtobufI("SpecialAttrInfo", {
    index = 400112,
    maxLevel = 1,
    timing = 2,
    targetIdentityCategory = 7,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1146] = ProtobufI("SpecialAttrInfo", {
    index = 400114,
    maxLevel = 1,
    timing = 13,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1147] = ProtobufI("SpecialAttrInfo", {
    index = 400115,
    maxLevel = 1,
    timing = 13,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1148] = ProtobufI("SpecialAttrInfo", {
    index = 400121,
    maxLevel = 1,
    timing = 2,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 400122
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1149] = ProtobufI("SpecialAttrInfo", {
    index = 400122,
    maxLevel = 1,
    timing = 2,
    targetIdentityCategory = 7,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1150] = ProtobufI("SpecialAttrInfo", {
    index = 400124,
    maxLevel = 1,
    timing = 13,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1151] = ProtobufI("SpecialAttrInfo", {
    index = 400125,
    maxLevel = 1,
    timing = 13,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1152] = ProtobufI("SpecialAttrInfo", {
    index = 400131,
    maxLevel = 1,
    timing = 2,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 400132
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1153] = ProtobufI("SpecialAttrInfo", {
    index = 400132,
    maxLevel = 1,
    timing = 2,
    targetIdentityCategory = 7,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1154] = ProtobufI("SpecialAttrInfo", {
    index = 400134,
    maxLevel = 1,
    timing = 13,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1155] = ProtobufI("SpecialAttrInfo", {
    index = 400135,
    maxLevel = 1,
    timing = 13,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1156] = ProtobufI("SpecialAttrInfo", {
    index = 400141,
    maxLevel = 1,
    timing = 2,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 400142
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1157] = ProtobufI("SpecialAttrInfo", {
    index = 400142,
    maxLevel = 1,
    timing = 2,
    targetIdentityCategory = 7,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1158] = ProtobufI("SpecialAttrInfo", {
    index = 400144,
    maxLevel = 1,
    timing = 13,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1159] = ProtobufI("SpecialAttrInfo", {
    index = 400145,
    maxLevel = 1,
    timing = 13,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1160] = ProtobufI("SpecialAttrInfo", {
    index = 400151,
    maxLevel = 1,
    timing = 2,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 400152
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1161] = ProtobufI("SpecialAttrInfo", {
    index = 400152,
    maxLevel = 1,
    timing = 2,
    targetIdentityCategory = 7,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1162] = ProtobufI("SpecialAttrInfo", {
    index = 400154,
    maxLevel = 1,
    timing = 13,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1163] = ProtobufI("SpecialAttrInfo", {
    index = 400155,
    maxLevel = 1,
    timing = 13,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1164] = ProtobufI("SpecialAttrInfo", {
    index = 400201,
    maxLevel = 1,
    timing = 2,
    ownerIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 5000,
        operation = 2,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [1165] = ProtobufI("SpecialAttrInfo", {
    index = 400211,
    maxLevel = 1,
    timing = 2,
    ownerIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 5000,
        operation = 2,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [1166] = ProtobufI("SpecialAttrInfo", {
    index = 400221,
    maxLevel = 1,
    timing = 2,
    ownerIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 6000,
        operation = 2,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [1167] = ProtobufI("SpecialAttrInfo", {
    index = 400231,
    maxLevel = 1,
    timing = 2,
    ownerIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 6000,
        operation = 2,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [1168] = ProtobufI("SpecialAttrInfo", {
    index = 400241,
    maxLevel = 1,
    timing = 2,
    ownerIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 6000,
        operation = 2,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [1169] = ProtobufI("SpecialAttrInfo", {
    index = 400251,
    maxLevel = 1,
    timing = 2,
    ownerIdentityCategory = 2,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {
      [1] = ProtobufI("SpecialAttrInfo.Condition", {
        sourceAttackType = 1,
        sourceIsAllOrOne = true,
        sourceExtraParam = {},
        targetValue = 7000,
        operation = 2,
        sourceOperation = {},
        sourceOperand = {}
      })
    }
  }),
  [1170] = ProtobufI("SpecialAttrInfo", {
    index = 400301,
    maxLevel = 1,
    timing = 2,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 400304
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1171] = ProtobufI("SpecialAttrInfo", {
    index = 400304,
    maxLevel = 1,
    timing = 2,
    targetIdentityCategory = 3,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1172] = ProtobufI("SpecialAttrInfo", {
    index = 400311,
    maxLevel = 1,
    timing = 2,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 400314
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1173] = ProtobufI("SpecialAttrInfo", {
    index = 400314,
    maxLevel = 1,
    timing = 2,
    targetIdentityCategory = 3,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1174] = ProtobufI("SpecialAttrInfo", {
    index = 400321,
    maxLevel = 1,
    timing = 2,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 400324
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1175] = ProtobufI("SpecialAttrInfo", {
    index = 400324,
    maxLevel = 1,
    timing = 2,
    targetIdentityCategory = 3,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1176] = ProtobufI("SpecialAttrInfo", {
    index = 400331,
    maxLevel = 1,
    timing = 2,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 400334
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1177] = ProtobufI("SpecialAttrInfo", {
    index = 400334,
    maxLevel = 1,
    timing = 2,
    targetIdentityCategory = 3,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1178] = ProtobufI("SpecialAttrInfo", {
    index = 400341,
    maxLevel = 1,
    timing = 2,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 400344
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1179] = ProtobufI("SpecialAttrInfo", {
    index = 400344,
    maxLevel = 1,
    timing = 2,
    targetIdentityCategory = 3,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1180] = ProtobufI("SpecialAttrInfo", {
    index = 400351,
    maxLevel = 1,
    timing = 2,
    targetIdentityCategory = 1,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {
      [1] = 400354
    },
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  }),
  [1181] = ProtobufI("SpecialAttrInfo", {
    index = 400354,
    maxLevel = 1,
    timing = 2,
    targetIdentityCategory = 3,
    targetAttackType = 1,
    targetIsAllOrOne = true,
    childSpecialAttrInfoId = {},
    probabilityInfo = ProtobufI("SpecialAttrInfo.ProbabilityInfo", {
      isStaticOrBaseOnCardInfo = true,
      staticProbability = 10000,
      cardNumProbability = {}
    }),
    conditions = {}
  })
}
local indexed = {
  [2] = 578,
  [7] = 579,
  [9] = 580,
  [10] = 581,
  [13] = 582,
  [14] = 583,
  [101] = 590,
  [103] = 593,
  [105] = 584,
  [106] = 585,
  [201] = 591,
  [203] = 594,
  [205] = 586,
  [206] = 587,
  [301] = 592,
  [303] = 595,
  [305] = 588,
  [306] = 589,
  [900] = 596,
  [901] = 597,
  [902] = 598,
  [903] = 599,
  [8001] = 521,
  [8002] = 522,
  [8003] = 523,
  [12200] = 606,
  [12201] = 608,
  [12202] = 610,
  [12400] = 607,
  [12401] = 609,
  [12402] = 611,
  [13200] = 600,
  [13201] = 602,
  [13202] = 604,
  [13400] = 601,
  [13401] = 603,
  [13402] = 605,
  [22200] = 614,
  [22201] = 618,
  [22202] = 622,
  [22203] = 626,
  [22204] = 630,
  [22205] = 634,
  [22206] = 638,
  [22207] = 642,
  [22208] = 646,
  [22209] = 650,
  [22210] = 654,
  [22211] = 658,
  [22212] = 662,
  [22213] = 666,
  [22214] = 670,
  [22215] = 674,
  [22216] = 678,
  [22217] = 682,
  [22218] = 686,
  [22219] = 690,
  [22220] = 694,
  [22221] = 698,
  [22222] = 702,
  [22223] = 706,
  [22224] = 710,
  [22225] = 714,
  [22226] = 722,
  [22227] = 726,
  [22228] = 730,
  [22229] = 734,
  [22230] = 738,
  [22231] = 742,
  [22232] = 746,
  [22233] = 750,
  [22234] = 754,
  [22400] = 615,
  [22401] = 619,
  [22402] = 623,
  [22403] = 627,
  [22404] = 631,
  [22405] = 635,
  [22406] = 639,
  [22407] = 643,
  [22408] = 647,
  [22409] = 651,
  [22410] = 655,
  [22411] = 659,
  [22412] = 663,
  [22413] = 667,
  [22414] = 671,
  [22415] = 675,
  [22416] = 679,
  [22417] = 683,
  [22418] = 687,
  [22419] = 691,
  [22420] = 695,
  [22421] = 699,
  [22422] = 703,
  [22423] = 707,
  [22424] = 711,
  [22425] = 715,
  [22426] = 723,
  [22427] = 727,
  [22428] = 731,
  [22429] = 735,
  [22430] = 739,
  [22431] = 743,
  [22432] = 747,
  [22433] = 751,
  [22434] = 755,
  [23200] = 612,
  [23201] = 616,
  [23202] = 620,
  [23203] = 624,
  [23204] = 628,
  [23205] = 632,
  [23206] = 636,
  [23207] = 640,
  [23208] = 644,
  [23209] = 648,
  [23210] = 652,
  [23211] = 656,
  [23212] = 660,
  [23213] = 664,
  [23214] = 668,
  [23215] = 672,
  [23216] = 676,
  [23217] = 680,
  [23218] = 684,
  [23219] = 688,
  [23220] = 692,
  [23221] = 696,
  [23222] = 700,
  [23223] = 704,
  [23224] = 708,
  [23225] = 712,
  [23226] = 720,
  [23227] = 724,
  [23228] = 728,
  [23229] = 732,
  [23230] = 736,
  [23231] = 740,
  [23232] = 744,
  [23233] = 748,
  [23234] = 752,
  [23400] = 613,
  [23401] = 617,
  [23402] = 621,
  [23403] = 625,
  [23404] = 629,
  [23405] = 633,
  [23406] = 637,
  [23407] = 641,
  [23408] = 645,
  [23409] = 649,
  [23410] = 653,
  [23411] = 657,
  [23412] = 661,
  [23413] = 665,
  [23414] = 669,
  [23415] = 673,
  [23416] = 677,
  [23417] = 681,
  [23418] = 685,
  [23419] = 689,
  [23420] = 693,
  [23421] = 697,
  [23422] = 701,
  [23423] = 705,
  [23424] = 709,
  [23425] = 713,
  [23426] = 721,
  [23427] = 725,
  [23428] = 729,
  [23429] = 733,
  [23430] = 737,
  [23431] = 741,
  [23432] = 745,
  [23433] = 749,
  [23434] = 753,
  [222250] = 718,
  [222340] = 758,
  [224250] = 719,
  [224340] = 759,
  [232250] = 716,
  [232340] = 756,
  [234250] = 717,
  [234340] = 757,
  [300101] = 1050,
  [300102] = 1051,
  [300103] = 1052,
  [300111] = 1053,
  [300112] = 1054,
  [300113] = 1055,
  [300121] = 1056,
  [300122] = 1057,
  [300123] = 1058,
  [300131] = 1059,
  [300132] = 1060,
  [300133] = 1061,
  [300141] = 1062,
  [300142] = 1063,
  [300143] = 1064,
  [300151] = 1065,
  [300152] = 1066,
  [300153] = 1067,
  [300201] = 1068,
  [300202] = 1069,
  [300203] = 1070,
  [300204] = 1071,
  [300211] = 1072,
  [300212] = 1073,
  [300213] = 1074,
  [300214] = 1075,
  [300221] = 1076,
  [300222] = 1077,
  [300223] = 1078,
  [300224] = 1079,
  [300231] = 1080,
  [300232] = 1081,
  [300233] = 1082,
  [300234] = 1083,
  [300241] = 1084,
  [300242] = 1085,
  [300243] = 1086,
  [300244] = 1087,
  [300251] = 1088,
  [300252] = 1089,
  [300253] = 1090,
  [300254] = 1091,
  [300301] = 1092,
  [300302] = 1093,
  [300311] = 1094,
  [300312] = 1095,
  [300321] = 1096,
  [300322] = 1097,
  [300331] = 1098,
  [300332] = 1099,
  [300341] = 1100,
  [300342] = 1101,
  [300351] = 1102,
  [300352] = 1103,
  [300401] = 1104,
  [300402] = 1105,
  [300411] = 1106,
  [300412] = 1107,
  [300421] = 1108,
  [300422] = 1109,
  [300431] = 1110,
  [300432] = 1111,
  [300441] = 1112,
  [300442] = 1113,
  [300451] = 1114,
  [300452] = 1115,
  [300501] = 1116,
  [300511] = 1117,
  [300521] = 1118,
  [300531] = 1119,
  [300541] = 1120,
  [300551] = 1121,
  [300601] = 1122,
  [300603] = 1123,
  [300604] = 1124,
  [300611] = 1125,
  [300613] = 1126,
  [300614] = 1127,
  [300621] = 1128,
  [300623] = 1129,
  [300624] = 1130,
  [300631] = 1131,
  [300633] = 1132,
  [300634] = 1133,
  [300641] = 1134,
  [300643] = 1135,
  [300644] = 1136,
  [300651] = 1137,
  [300653] = 1138,
  [300654] = 1139,
  [400101] = 1140,
  [400102] = 1141,
  [400104] = 1142,
  [400105] = 1143,
  [400111] = 1144,
  [400112] = 1145,
  [400114] = 1146,
  [400115] = 1147,
  [400121] = 1148,
  [400122] = 1149,
  [400124] = 1150,
  [400125] = 1151,
  [400131] = 1152,
  [400132] = 1153,
  [400134] = 1154,
  [400135] = 1155,
  [400141] = 1156,
  [400142] = 1157,
  [400144] = 1158,
  [400145] = 1159,
  [400151] = 1160,
  [400152] = 1161,
  [400154] = 1162,
  [400155] = 1163,
  [400201] = 1164,
  [400211] = 1165,
  [400221] = 1166,
  [400231] = 1167,
  [400241] = 1168,
  [400251] = 1169,
  [400301] = 1170,
  [400304] = 1171,
  [400311] = 1172,
  [400314] = 1173,
  [400321] = 1174,
  [400324] = 1175,
  [400331] = 1176,
  [400334] = 1177,
  [400341] = 1178,
  [400344] = 1179,
  [400351] = 1180,
  [400354] = 1181,
  [992001] = 1,
  [992002] = 2,
  [992011] = 3,
  [992021] = 4,
  [992023] = 5,
  [992024] = 6,
  [992025] = 7,
  [992031] = 8,
  [992032] = 9,
  [992041] = 10,
  [992043] = 11,
  [992045] = 12,
  [992052] = 13,
  [993011] = 14,
  [993021] = 15,
  [993031] = 16,
  [993041] = 17,
  [993051] = 18,
  [993061] = 19,
  [993071] = 20,
  [993081] = 21,
  [993091] = 22,
  [993101] = 23,
  [993111] = 24,
  [993121] = 25,
  [993131] = 26,
  [993134] = 27,
  [993141] = 28,
  [993142] = 29,
  [993151] = 30,
  [993152] = 31,
  [993153] = 32,
  [993161] = 33,
  [993162] = 34,
  [993163] = 35,
  [993171] = 36,
  [993172] = 37,
  [993181] = 38,
  [993191] = 39,
  [993201] = 40,
  [993401] = 41,
  [993402] = 42,
  [993411] = 43,
  [993412] = 44,
  [993421] = 45,
  [993501] = 46,
  [993511] = 47,
  [993521] = 48,
  [993531] = 49,
  [993532] = 50,
  [993541] = 51,
  [993542] = 52,
  [993551] = 53,
  [993561] = 54,
  [993571] = 55,
  [993581] = 56,
  [993591] = 57,
  [993601] = 58,
  [993611] = 59,
  [993621] = 60,
  [993631] = 61,
  [993641] = 62,
  [993651] = 63,
  [993661] = 64,
  [993671] = 65,
  [993681] = 66,
  [994001] = 67,
  [994002] = 68,
  [994004] = 69,
  [994005] = 70,
  [994011] = 71,
  [994021] = 72,
  [994031] = 73,
  [994041] = 74,
  [994051] = 75,
  [994061] = 76,
  [994062] = 77,
  [994063] = 78,
  [994071] = 79,
  [994081] = 80,
  [994082] = 81,
  [994083] = 82,
  [994084] = 83,
  [994085] = 84,
  [994911] = 85,
  [994913] = 86,
  [994921] = 87,
  [994922] = 88,
  [994931] = 89,
  [994933] = 90,
  [994941] = 91,
  [995000] = 92,
  [995003] = 93,
  [995007] = 94,
  [996000] = 95,
  [996001] = 96,
  [996002] = 97,
  [996003] = 98,
  [996004] = 99,
  [996006] = 100,
  [996007] = 101,
  [996008] = 102,
  [996009] = 103,
  [996010] = 104,
  [996011] = 105,
  [996012] = 106,
  [996013] = 107,
  [996014] = 108,
  [996015] = 109,
  [996016] = 110,
  [996017] = 111,
  [996018] = 112,
  [996019] = 113,
  [996020] = 114,
  [996021] = 115,
  [996022] = 116,
  [996023] = 117,
  [996025] = 118,
  [996027] = 119,
  [996029] = 120,
  [996031] = 121,
  [996032] = 122,
  [996033] = 123,
  [996034] = 124,
  [996035] = 125,
  [996036] = 126,
  [996037] = 127,
  [996038] = 128,
  [996039] = 129,
  [996040] = 130,
  [996042] = 131,
  [996043] = 132,
  [996044] = 133,
  [996045] = 134,
  [996046] = 135,
  [996047] = 136,
  [996048] = 137,
  [996049] = 138,
  [996052] = 139,
  [996053] = 140,
  [996054] = 141,
  [996055] = 142,
  [996056] = 143,
  [996057] = 144,
  [996058] = 145,
  [996059] = 146,
  [996060] = 147,
  [996061] = 148,
  [996062] = 149,
  [996063] = 150,
  [996064] = 151,
  [996065] = 152,
  [996066] = 153,
  [996067] = 154,
  [996068] = 155,
  [996069] = 156,
  [996070] = 157,
  [996071] = 158,
  [996072] = 159,
  [996073] = 160,
  [996074] = 161,
  [996075] = 162,
  [996078] = 163,
  [996079] = 164,
  [996080] = 165,
  [996081] = 166,
  [996082] = 167,
  [996083] = 168,
  [996084] = 169,
  [996085] = 170,
  [996086] = 171,
  [996087] = 172,
  [996088] = 173,
  [996089] = 174,
  [996090] = 175,
  [996091] = 176,
  [996092] = 177,
  [996093] = 178,
  [996094] = 179,
  [996095] = 180,
  [996096] = 181,
  [996097] = 182,
  [996098] = 183,
  [996099] = 184,
  [996100] = 185,
  [996101] = 186,
  [996102] = 187,
  [996103] = 188,
  [996104] = 189,
  [996105] = 190,
  [996106] = 191,
  [996107] = 192,
  [996108] = 193,
  [996109] = 194,
  [996110] = 195,
  [996111] = 196,
  [996112] = 197,
  [996113] = 198,
  [996114] = 199,
  [996115] = 200,
  [996116] = 201,
  [996117] = 202,
  [996118] = 203,
  [996119] = 204,
  [996120] = 205,
  [996121] = 206,
  [996122] = 207,
  [996123] = 208,
  [996124] = 209,
  [996125] = 210,
  [996126] = 211,
  [996127] = 212,
  [996128] = 213,
  [996130] = 214,
  [996131] = 215,
  [996132] = 216,
  [996133] = 217,
  [996134] = 218,
  [996135] = 219,
  [996138] = 220,
  [996139] = 221,
  [996140] = 222,
  [996141] = 223,
  [996143] = 224,
  [996144] = 225,
  [996145] = 226,
  [996146] = 227,
  [996147] = 228,
  [996148] = 229,
  [996149] = 230,
  [996150] = 231,
  [996151] = 232,
  [996152] = 233,
  [996153] = 234,
  [996154] = 235,
  [996155] = 236,
  [996156] = 237,
  [996157] = 238,
  [996158] = 239,
  [996159] = 240,
  [996160] = 241,
  [996161] = 242,
  [997000] = 243,
  [997001] = 244,
  [997002] = 245,
  [997003] = 246,
  [997004] = 247,
  [997005] = 248,
  [997006] = 249,
  [997007] = 250,
  [997008] = 251,
  [997009] = 252,
  [997010] = 253,
  [997011] = 254,
  [997012] = 255,
  [997013] = 256,
  [997014] = 257,
  [997015] = 259,
  [997016] = 258,
  [997017] = 260,
  [997018] = 261,
  [997021] = 262,
  [997022] = 263,
  [997023] = 264,
  [997024] = 265,
  [997025] = 266,
  [997026] = 267,
  [997030] = 268,
  [997031] = 269,
  [997032] = 270,
  [997033] = 271,
  [997034] = 272,
  [997035] = 273,
  [997036] = 274,
  [997037] = 275,
  [997040] = 276,
  [997041] = 277,
  [997050] = 278,
  [997051] = 279,
  [997052] = 280,
  [997053] = 281,
  [997054] = 282,
  [997055] = 283,
  [997056] = 284,
  [997057] = 285,
  [997061] = 286,
  [997062] = 287,
  [997063] = 288,
  [997071] = 289,
  [997072] = 290,
  [997073] = 291,
  [997074] = 292,
  [997075] = 293,
  [997076] = 294,
  [997081] = 295,
  [997082] = 296,
  [997083] = 297,
  [997084] = 298,
  [997085] = 299,
  [997086] = 300,
  [997087] = 301,
  [997091] = 302,
  [997095] = 303,
  [997101] = 304,
  [997111] = 305,
  [997112] = 306,
  [997121] = 307,
  [997131] = 308,
  [997135] = 309,
  [997137] = 310,
  [997138] = 311,
  [997139] = 312,
  [997201] = 313,
  [997202] = 314,
  [997203] = 315,
  [997204] = 316,
  [997205] = 317,
  [997206] = 318,
  [997207] = 319,
  [997211] = 320,
  [997213] = 321,
  [997221] = 322,
  [997222] = 323,
  [997223] = 324,
  [997224] = 325,
  [997225] = 326,
  [997226] = 327,
  [997227] = 328,
  [997228] = 329,
  [997229] = 330,
  [997230] = 331,
  [997231] = 332,
  [997232] = 333,
  [997233] = 334,
  [997234] = 335,
  [997235] = 336,
  [997236] = 337,
  [997237] = 338,
  [997238] = 339,
  [997239] = 340,
  [997240] = 341,
  [997241] = 342,
  [997301] = 343,
  [997311] = 344,
  [997312] = 345,
  [997315] = 346,
  [997316] = 347,
  [997317] = 348,
  [997318] = 349,
  [997319] = 350,
  [997320] = 351,
  [997321] = 352,
  [997341] = 353,
  [997343] = 354,
  [997348] = 355,
  [997350] = 356,
  [997351] = 357,
  [997352] = 358,
  [997353] = 359,
  [997354] = 360,
  [997355] = 361,
  [997356] = 362,
  [997357] = 363,
  [997358] = 364,
  [997359] = 365,
  [997360] = 366,
  [997361] = 367,
  [997362] = 368,
  [997371] = 369,
  [997373] = 370,
  [997401] = 371,
  [997403] = 372,
  [997405] = 373,
  [997406] = 374,
  [997407] = 375,
  [997408] = 376,
  [997409] = 377,
  [997410] = 378,
  [997411] = 379,
  [997412] = 380,
  [997413] = 381,
  [997415] = 382,
  [998001] = 383,
  [998002] = 384,
  [998003] = 385,
  [998007] = 386,
  [998008] = 387,
  [998009] = 388,
  [998010] = 389,
  [998011] = 390,
  [998012] = 391,
  [998013] = 392,
  [998101] = 401,
  [998102] = 402,
  [998103] = 403,
  [998104] = 404,
  [998105] = 405,
  [998106] = 406,
  [998107] = 407,
  [998108] = 408,
  [998109] = 409,
  [998201] = 410,
  [998202] = 411,
  [998203] = 412,
  [998301] = 413,
  [998302] = 414,
  [998303] = 415,
  [998304] = 416,
  [998305] = 417,
  [998306] = 418,
  [998307] = 419,
  [998401] = 420,
  [998402] = 421,
  [998403] = 422,
  [998405] = 423,
  [998407] = 424,
  [998501] = 425,
  [998502] = 426,
  [998503] = 427,
  [998504] = 428,
  [998511] = 429,
  [998514] = 430,
  [998515] = 431,
  [998516] = 432,
  [998517] = 433,
  [999101] = 393,
  [999102] = 394,
  [999103] = 395,
  [999201] = 396,
  [999202] = 397,
  [999203] = 398,
  [999301] = 399,
  [999302] = 400,
  [1000000] = 524,
  [1000010] = 525,
  [1000020] = 526,
  [1000030] = 527,
  [1000040] = 528,
  [1000050] = 529,
  [1000060] = 530,
  [1000070] = 531,
  [1000080] = 532,
  [1000090] = 533,
  [1000100] = 534,
  [1000110] = 535,
  [1000120] = 536,
  [1000130] = 537,
  [1000140] = 538,
  [1000150] = 539,
  [1000160] = 540,
  [1000170] = 541,
  [1000171] = 542,
  [1000172] = 543,
  [1000173] = 544,
  [1000174] = 545,
  [1000175] = 546,
  [1000176] = 547,
  [1000180] = 548,
  [1000181] = 549,
  [1000190] = 550,
  [1000191] = 551,
  [1000200] = 552,
  [1000201] = 553,
  [1000202] = 554,
  [1000203] = 555,
  [1000204] = 556,
  [1000205] = 557,
  [1000206] = 558,
  [1000210] = 559,
  [1000220] = 560,
  [1000221] = 561,
  [1000230] = 562,
  [1000231] = 563,
  [1000280] = 564,
  [1000290] = 565,
  [1000291] = 566,
  [1000300] = 567,
  [1000991] = 568,
  [1000992] = 569,
  [1000993] = 570,
  [1000994] = 571,
  [1000995] = 572,
  [1000996] = 573,
  [1000999] = 574,
  [1001131] = 760,
  [1001151] = 814,
  [1001161] = 859,
  [1001201] = 575,
  [1001301] = 576,
  [1001401] = 577,
  [1002131] = 761,
  [1002151] = 815,
  [1002161] = 860,
  [1003131] = 762,
  [1003151] = 816,
  [1003161] = 861,
  [1004131] = 763,
  [1004151] = 817,
  [1004161] = 862,
  [1005131] = 764,
  [1005151] = 818,
  [1005161] = 863,
  [1006131] = 765,
  [1006132] = 766,
  [1006133] = 767,
  [1006151] = 819,
  [1006152] = 820,
  [1006153] = 821,
  [1006161] = 864,
  [1006162] = 865,
  [1006163] = 866,
  [1007131] = 768,
  [1007151] = 822,
  [1007161] = 867,
  [1008131] = 769,
  [1008151] = 823,
  [1008161] = 868,
  [1009131] = 770,
  [1009151] = 824,
  [1009161] = 869,
  [1010131] = 771,
  [1010151] = 825,
  [1010161] = 870,
  [1011131] = 772,
  [1011151] = 826,
  [1011161] = 871,
  [1012131] = 773,
  [1012151] = 827,
  [1012161] = 872,
  [1013131] = 774,
  [1013151] = 828,
  [1013161] = 873,
  [1014131] = 775,
  [1014151] = 829,
  [1014161] = 874,
  [1015131] = 776,
  [1015132] = 777,
  [1015151] = 830,
  [1015152] = 831,
  [1015161] = 875,
  [1015162] = 876,
  [1016131] = 778,
  [1016132] = 779,
  [1016151] = 832,
  [1016161] = 877,
  [1017131] = 780,
  [1017151] = 833,
  [1017161] = 878,
  [1018131] = 781,
  [1018151] = 834,
  [1018161] = 879,
  [1019131] = 782,
  [1019151] = 835,
  [1019161] = 880,
  [1101031] = 904,
  [1101041] = 905,
  [1101131] = 783,
  [1101151] = 836,
  [1101161] = 881,
  [1106131] = 784,
  [1106151] = 837,
  [1106161] = 882,
  [1107131] = 785,
  [1107151] = 838,
  [1107161] = 883,
  [1112131] = 786,
  [1112151] = 839,
  [1112161] = 884,
  [1113131] = 787,
  [1113151] = 840,
  [1113161] = 885,
  [1115131] = 788,
  [1115132] = 789,
  [1115151] = 841,
  [1115152] = 842,
  [1115161] = 886,
  [1115162] = 887,
  [1115211] = 906,
  [1301001] = 907,
  [1301002] = 908,
  [1301011] = 909,
  [1301012] = 910,
  [1301013] = 911,
  [1301021] = 912,
  [1301022] = 913,
  [1301023] = 914,
  [1301024] = 915,
  [1301025] = 916,
  [1301026] = 917,
  [1301027] = 918,
  [1301028] = 919,
  [1301131] = 790,
  [1301132] = 791,
  [1301133] = 792,
  [1301134] = 793,
  [1301135] = 794,
  [1301136] = 795,
  [1401131] = 796,
  [1401151] = 843,
  [1401161] = 888,
  [1409131] = 797,
  [1409151] = 844,
  [1409161] = 889,
  [1501131] = 798,
  [1501151] = 845,
  [1501161] = 890,
  [1502131] = 799,
  [1502151] = 846,
  [1502161] = 891,
  [1504131] = 800,
  [1504151] = 847,
  [1504161] = 892,
  [1505011] = 920,
  [1505012] = 921,
  [1505013] = 922,
  [1505014] = 923,
  [1505015] = 924,
  [1505131] = 801,
  [1505151] = 848,
  [1505161] = 893,
  [1508001] = 925,
  [1508011] = 926,
  [1508021] = 927,
  [1508131] = 802,
  [1508132] = 803,
  [1508151] = 849,
  [1508152] = 850,
  [1508161] = 894,
  [1508162] = 895,
  [1508201] = 928,
  [1508211] = 929,
  [1509131] = 804,
  [1509151] = 851,
  [1509161] = 896,
  [1511001] = 930,
  [1511002] = 931,
  [1511003] = 932,
  [1511004] = 933,
  [1511005] = 934,
  [1511011] = 935,
  [1511012] = 936,
  [1511013] = 937,
  [1511014] = 938,
  [1511015] = 939,
  [1511031] = 945,
  [1511032] = 946,
  [1511033] = 947,
  [1511034] = 948,
  [1511035] = 949,
  [1511111] = 940,
  [1511112] = 941,
  [1511113] = 942,
  [1511114] = 943,
  [1511115] = 944,
  [1511131] = 805,
  [1511132] = 806,
  [1511151] = 852,
  [1511152] = 853,
  [1511161] = 897,
  [1511162] = 898,
  [1514001] = 950,
  [1514002] = 951,
  [1514003] = 952,
  [1514004] = 953,
  [1514005] = 954,
  [1514101] = 955,
  [1514102] = 956,
  [1514103] = 957,
  [1514104] = 958,
  [1514105] = 959,
  [1514131] = 807,
  [1514132] = 808,
  [1514133] = 809,
  [1514151] = 854,
  [1514152] = 855,
  [1514161] = 899,
  [1514162] = 900,
  [1514201] = 960,
  [1514202] = 961,
  [1514203] = 962,
  [1514204] = 963,
  [1514205] = 964,
  [1514301] = 965,
  [1514302] = 966,
  [1514303] = 967,
  [1514304] = 968,
  [1514305] = 969,
  [1514411] = 970,
  [1514412] = 971,
  [1514413] = 972,
  [1514414] = 973,
  [1514415] = 974,
  [1515001] = 975,
  [1515002] = 976,
  [1515011] = 977,
  [1515012] = 978,
  [1515021] = 979,
  [1515131] = 810,
  [1515132] = 811,
  [1515133] = 812,
  [1515151] = 856,
  [1515152] = 857,
  [1515161] = 901,
  [1515162] = 902,
  [1515201] = 980,
  [1515211] = 981,
  [1517131] = 813,
  [1517151] = 858,
  [1517161] = 903,
  [2007001] = 1002,
  [2007002] = 1003,
  [2007003] = 1004,
  [2007004] = 1005,
  [2007005] = 1006,
  [2107001] = 1007,
  [2107002] = 1008,
  [2107003] = 1009,
  [2107004] = 1010,
  [2107005] = 1011,
  [2107011] = 1012,
  [2107012] = 1013,
  [2107013] = 1014,
  [2107014] = 1015,
  [2107015] = 1016,
  [2107021] = 1017,
  [2107022] = 1018,
  [2107023] = 1019,
  [2107024] = 1020,
  [2107025] = 1021,
  [2113001] = 1045,
  [2113002] = 1046,
  [2113003] = 1047,
  [2113004] = 1048,
  [2113005] = 1049,
  [2114401] = 982,
  [2114402] = 983,
  [2114403] = 984,
  [2114404] = 985,
  [2114405] = 986,
  [2115001] = 987,
  [2115002] = 988,
  [2115003] = 989,
  [2115004] = 990,
  [2115005] = 991,
  [2115101] = 992,
  [2115102] = 993,
  [2115103] = 994,
  [2115104] = 995,
  [2115105] = 996,
  [2119401] = 997,
  [2119402] = 998,
  [2119403] = 999,
  [2119404] = 1000,
  [2119405] = 1001,
  [2123401] = 1022,
  [2123402] = 1023,
  [2123403] = 1024,
  [2123404] = 1025,
  [2123405] = 1026,
  [2127101] = 1027,
  [2127102] = 1028,
  [2127103] = 1029,
  [2127104] = 1030,
  [2127105] = 1031,
  [2127201] = 1032,
  [2127202] = 1033,
  [2127203] = 1034,
  [2127204] = 1035,
  [2127205] = 1036,
  [2128011] = 1037,
  [2128101] = 1038,
  [2133211] = 1039,
  [7008411] = 1040,
  [7008412] = 1041,
  [7008413] = 1042,
  [7008414] = 1043,
  [7008415] = 1044,
  [34010101] = 434,
  [34010201] = 435,
  [34010301] = 436,
  [34010302] = 437,
  [34010401] = 438,
  [34010402] = 439,
  [34010403] = 440,
  [34020101] = 441,
  [34020201] = 442,
  [34020301] = 443,
  [34020302] = 444,
  [34020303] = 445,
  [34020304] = 446,
  [34020305] = 447,
  [34020306] = 448,
  [34030101] = 449,
  [34030102] = 450,
  [34030201] = 451,
  [34030202] = 452,
  [34030301] = 453,
  [34040101] = 454,
  [34040102] = 455,
  [34040201] = 456,
  [34040202] = 457,
  [34040301] = 458,
  [34050101] = 459,
  [34050201] = 460,
  [34050202] = 461,
  [34050301] = 462,
  [34060101] = 463,
  [34060201] = 464,
  [34060301] = 465,
  [34060302] = 466,
  [34060303] = 467,
  [34070101] = 468,
  [34070201] = 469,
  [34070301] = 470,
  [34080101] = 471,
  [34080201] = 472,
  [34080301] = 473,
  [34090101] = 474,
  [34090201] = 475,
  [34090301] = 476,
  [34100101] = 477,
  [34100201] = 478,
  [34100301] = 479,
  [34100401] = 480,
  [34100501] = 481,
  [34110101] = 482,
  [35010101] = 483,
  [35010201] = 484,
  [35010202] = 485,
  [35010203] = 486,
  [35010204] = 487,
  [35010205] = 488,
  [35010206] = 489,
  [35010207] = 490,
  [35010208] = 491,
  [35010209] = 492,
  [35010210] = 493,
  [35010301] = 494,
  [35010401] = 495,
  [35010501] = 496,
  [35010601] = 497,
  [35010701] = 498,
  [35010801] = 499,
  [35010802] = 500,
  [35010803] = 501,
  [35010804] = 502,
  [35010805] = 503,
  [35010806] = 504,
  [35010807] = 505,
  [35010808] = 506,
  [35010809] = 507,
  [35010810] = 508,
  [35020101] = 509,
  [35020201] = 510,
  [35020301] = 511,
  [35020401] = 512,
  [35020501] = 513,
  [35020601] = 514,
  [35020701] = 515,
  [35020801] = 516,
  [35020901] = 517,
  [35030101] = 518,
  [35030301] = 519,
  [35030601] = 520
}
return {raw, indexed}
