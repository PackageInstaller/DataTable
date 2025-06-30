-- chunkname: @IQIGame\\Config\\CfgMazeQTETable.lua

local CfgMazeQTETable = {
	[40101002] = {
		QTEType = 1,
		ButtonCount = 5,
		Id = 40101002,
		TitleBefore = getI18NValue(180083465),
		Describe = getI18NValue(180083463),
		TitleAfter = getI18NValue(180083464),
		SuccessService = {
			140104000,
			40101003
		},
		FailService = {
			140104000,
			40101004
		},
		ButtonDelay = {
			0.2,
			0.4,
			0.6,
			0.8,
			0
		},
		ButtonTime = {
			2,
			2,
			2,
			2,
			0
		}
	},
	[50540000] = {
		QTEType = 1,
		ButtonCount = 5,
		Id = 50540000,
		TitleBefore = getI18NValue(180083468),
		Describe = getI18NValue(180083466),
		TitleAfter = getI18NValue(180083467),
		SuccessService = {
			140104000,
			140101000
		},
		FailService = {
			50540001,
			140106000
		},
		ButtonDelay = {
			0.2,
			0.4,
			0.6,
			0.8,
			1
		},
		ButtonTime = {
			3,
			3,
			3,
			3,
			3
		}
	},
	[50540100] = {
		ButtonCount = 3,
		Id = 50540100,
		QTEType = 1,
		TitleBefore = getI18NValue(180083471),
		Describe = getI18NValue(180083469),
		TitleAfter = getI18NValue(180083470),
		ButtonDelay = {
			0.2,
			0.4,
			0.6,
			0,
			0
		},
		ButtonTime = {
			3,
			3,
			3,
			0,
			0
		}
	},
	[50540200] = {
		ButtonCount = 3,
		Id = 50540200,
		QTEType = 1,
		TitleBefore = getI18NValue(180083474),
		Describe = getI18NValue(180083472),
		TitleAfter = getI18NValue(180083473),
		ButtonDelay = {
			0.2,
			0.4,
			0.6,
			0,
			0
		},
		ButtonTime = {
			2,
			2,
			2,
			0,
			0
		}
	},
	[50540300] = {
		ButtonCount = 4,
		Id = 50540300,
		QTEType = 1,
		TitleBefore = getI18NValue(180083477),
		Describe = getI18NValue(180083475),
		TitleAfter = getI18NValue(180083476),
		ButtonDelay = {
			0.2,
			0.4,
			0.6,
			0.8,
			0
		},
		ButtonTime = {
			3,
			3,
			3,
			3,
			0
		}
	},
	[50540400] = {
		ButtonCount = 4,
		Id = 50540400,
		QTEType = 1,
		TitleBefore = getI18NValue(180083480),
		Describe = getI18NValue(180083478),
		TitleAfter = getI18NValue(180083479),
		ButtonDelay = {
			0.2,
			0.4,
			0.6,
			0.8,
			0
		},
		ButtonTime = {
			2,
			2,
			2,
			2,
			0
		}
	},
	[50540500] = {
		ButtonCount = 5,
		Id = 50540500,
		QTEType = 1,
		TitleBefore = getI18NValue(180083483),
		Describe = getI18NValue(180083481),
		TitleAfter = getI18NValue(180083482),
		ButtonDelay = {
			0.2,
			0.4,
			0.6,
			0.8,
			1
		},
		ButtonTime = {
			3,
			3,
			3,
			3,
			3
		}
	},
	[50540600] = {
		ButtonCount = 5,
		Id = 50540600,
		QTEType = 1,
		TitleBefore = getI18NValue(180083486),
		Describe = getI18NValue(180083484),
		TitleAfter = getI18NValue(180083485),
		ButtonDelay = {
			0.2,
			0.4,
			0.6,
			0.8,
			1
		},
		ButtonTime = {
			2,
			2,
			2,
			2,
			2
		}
	},
	[50540700] = {
		ButtonCount = 5,
		Id = 50540700,
		QTEType = 1,
		TitleBefore = getI18NValue(180083489),
		Describe = getI18NValue(180083487),
		TitleAfter = getI18NValue(180083488),
		ButtonDelay = {
			0.2,
			0.4,
			0.6,
			0.8,
			1
		},
		ButtonTime = {
			1,
			2,
			1,
			1,
			1
		}
	},
	[50540800] = {
		ButtonCount = 3,
		Id = 50540800,
		QTEType = 2,
		TitleBefore = getI18NValue(180083492),
		Describe = getI18NValue(180083490),
		TitleAfter = getI18NValue(180083491),
		ButtonDelay = {
			0.2,
			0.4,
			0.6,
			0,
			0
		},
		ButtonTime = {
			3,
			3,
			3,
			0,
			0
		}
	},
	[50540900] = {
		ButtonCount = 3,
		Id = 50540900,
		QTEType = 2,
		TitleBefore = getI18NValue(180083495),
		Describe = getI18NValue(180083493),
		TitleAfter = getI18NValue(180083494),
		ButtonDelay = {
			0.2,
			0.4,
			0.6,
			0,
			0
		},
		ButtonTime = {
			2,
			2,
			2,
			0,
			0
		}
	},
	[50541000] = {
		ButtonCount = 4,
		Id = 50541000,
		QTEType = 2,
		TitleBefore = getI18NValue(180083498),
		Describe = getI18NValue(180083496),
		TitleAfter = getI18NValue(180083497),
		ButtonDelay = {
			0.2,
			0.4,
			0.6,
			0.8,
			0
		},
		ButtonTime = {
			3,
			3,
			3,
			3,
			0
		}
	},
	[50541100] = {
		ButtonCount = 4,
		Id = 50541100,
		QTEType = 2,
		TitleBefore = getI18NValue(180083501),
		Describe = getI18NValue(180083499),
		TitleAfter = getI18NValue(180083500),
		ButtonDelay = {
			0.2,
			0.4,
			0.6,
			0.8,
			0
		},
		ButtonTime = {
			2,
			2,
			2,
			2,
			0
		}
	},
	[50541200] = {
		ButtonCount = 5,
		Id = 50541200,
		QTEType = 2,
		TitleBefore = getI18NValue(180083504),
		Describe = getI18NValue(180083502),
		TitleAfter = getI18NValue(180083503),
		ButtonDelay = {
			0.2,
			0.4,
			0.6,
			0.8,
			1
		},
		ButtonTime = {
			3,
			3,
			3,
			3,
			3
		}
	},
	[50541300] = {
		ButtonCount = 5,
		Id = 50541300,
		QTEType = 2,
		TitleBefore = getI18NValue(180083507),
		Describe = getI18NValue(180083505),
		TitleAfter = getI18NValue(180083506),
		ButtonDelay = {
			0.2,
			0.4,
			0.6,
			0.8,
			1
		},
		ButtonTime = {
			2,
			2,
			2,
			2,
			2
		}
	},
	[50541400] = {
		ButtonCount = 5,
		Id = 50541400,
		QTEType = 2,
		TitleBefore = getI18NValue(180083510),
		Describe = getI18NValue(180083508),
		TitleAfter = getI18NValue(180083509),
		ButtonDelay = {
			0.2,
			0.4,
			0.6,
			0.8,
			1
		},
		ButtonTime = {
			2,
			2,
			2,
			2,
			1
		}
	},
	[52151200] = {
		QTEType = 1,
		ButtonCount = 5,
		Id = 52151200,
		TitleBefore = getI18NValue(180083513),
		Describe = getI18NValue(180083511),
		TitleAfter = getI18NValue(180083512),
		SuccessService = {
			52151202
		},
		FailService = {
			52151203
		},
		ButtonDelay = {
			0.2,
			0.4,
			0.6,
			0.8,
			1
		},
		ButtonTime = {
			2,
			2,
			2,
			2,
			2
		}
	},
	[53053400] = {
		QTEType = 1,
		ButtonCount = 5,
		Id = 53053400,
		TitleBefore = getI18NValue(180083516),
		Describe = getI18NValue(180083514),
		TitleAfter = getI18NValue(180083515),
		SuccessService = {
			140104000,
			140101000
		},
		FailService = {
			50540001,
			53053401,
			140104000,
			140101000
		},
		ButtonDelay = {
			0.2,
			0.4,
			0.6,
			0.8,
			1
		},
		ButtonTime = {
			2,
			2,
			2,
			2,
			1
		}
	},
	[53053500] = {
		QTEType = 2,
		ButtonCount = 5,
		Id = 53053500,
		TitleBefore = getI18NValue(180083519),
		Describe = getI18NValue(180083517),
		TitleAfter = getI18NValue(180083518),
		SuccessService = {
			140104000,
			140101000
		},
		FailService = {
			50540001,
			53053501,
			140104000,
			140101000
		},
		ButtonDelay = {
			0.2,
			0.4,
			0.6,
			0.8,
			1
		},
		ButtonTime = {
			2,
			2,
			2,
			2,
			1
		}
	},
	[53221800] = {
		QTEType = 1,
		ButtonCount = 5,
		Id = 53221800,
		TitleBefore = getI18NValue(180083522),
		Describe = getI18NValue(180083520),
		TitleAfter = getI18NValue(180083521),
		SuccessService = {
			53221802,
			53221803,
			53221804,
			53221805,
			53221812
		},
		FailService = {
			53221802,
			53221803,
			53221806,
			53221812
		},
		ButtonDelay = {
			0.2,
			0.4,
			0.6,
			0.8,
			1
		},
		ButtonTime = {
			3,
			3,
			3,
			3,
			3
		}
	},
	[53221900] = {
		QTEType = 1,
		ButtonCount = 5,
		Id = 53221900,
		TitleBefore = getI18NValue(180083525),
		Describe = getI18NValue(180083523),
		TitleAfter = getI18NValue(180083524),
		SuccessService = {
			53221902,
			53221903,
			53221904,
			53221905,
			53221912
		},
		FailService = {
			53221902,
			53221903,
			53221906,
			53221912
		},
		ButtonDelay = {
			0.2,
			0.4,
			0.6,
			0.8,
			1
		},
		ButtonTime = {
			3,
			3,
			3,
			3,
			3
		}
	},
	[53222000] = {
		QTEType = 1,
		ButtonCount = 5,
		Id = 53222000,
		TitleBefore = getI18NValue(180083528),
		Describe = getI18NValue(180083526),
		TitleAfter = getI18NValue(180083527),
		SuccessService = {
			53222002,
			53222003,
			53222004,
			53222005,
			53222012
		},
		FailService = {
			53222002,
			53222003,
			53222006,
			53222012
		},
		ButtonDelay = {
			0.2,
			0.4,
			0.6,
			0.8,
			1
		},
		ButtonTime = {
			3,
			3,
			3,
			3,
			3
		}
	},
	[53222100] = {
		QTEType = 1,
		ButtonCount = 5,
		Id = 53222100,
		TitleBefore = getI18NValue(180083531),
		Describe = getI18NValue(180083529),
		TitleAfter = getI18NValue(180083530),
		SuccessService = {
			53222102,
			53222103,
			53222104,
			53222105,
			53222112
		},
		FailService = {
			53222102,
			53222103,
			53222106,
			53222112
		},
		ButtonDelay = {
			0.2,
			0.4,
			0.6,
			0.8,
			1
		},
		ButtonTime = {
			3,
			3,
			3,
			3,
			3
		}
	},
	[53261800] = {
		QTEType = 1,
		ButtonCount = 5,
		Id = 53261800,
		TitleBefore = getI18NValue(180083534),
		Describe = getI18NValue(180083532),
		TitleAfter = getI18NValue(180083533),
		SuccessService = {
			53261804,
			53261805,
			53261802
		},
		FailService = {
			53261803
		},
		ButtonDelay = {
			0.2,
			0.4,
			0.6,
			0.8,
			1
		},
		ButtonTime = {
			2,
			2,
			2,
			2,
			2
		}
	},
	[53261900] = {
		QTEType = 2,
		ButtonCount = 5,
		Id = 53261900,
		TitleBefore = getI18NValue(180083537),
		Describe = getI18NValue(180083535),
		TitleAfter = getI18NValue(180083536),
		SuccessService = {
			53261904,
			53261905,
			53261902
		},
		FailService = {
			53261903
		},
		ButtonDelay = {
			0.2,
			0.4,
			0.6,
			0.8,
			1
		},
		ButtonTime = {
			3,
			3,
			3,
			3,
			3
		}
	},
	[53262000] = {
		QTEType = 2,
		ButtonCount = 5,
		Id = 53262000,
		TitleBefore = getI18NValue(180083540),
		Describe = getI18NValue(180083538),
		TitleAfter = getI18NValue(180083539),
		SuccessService = {
			53262004,
			53262005,
			53262002
		},
		FailService = {
			53262003
		},
		ButtonDelay = {
			0.2,
			0.4,
			0.6,
			0.8,
			1
		},
		ButtonTime = {
			2,
			2,
			2,
			2,
			2
		}
	},
	[54130200] = {
		QTEType = 2,
		ButtonCount = 5,
		Id = 54130200,
		TitleBefore = getI18NValue(180083543),
		Describe = getI18NValue(180083541),
		TitleAfter = getI18NValue(180083542),
		SuccessService = {
			54130203
		},
		FailService = {
			54130202
		},
		ButtonDelay = {
			0.2,
			0.7,
			1.2,
			1.7,
			2.2
		},
		ButtonTime = {
			1,
			1,
			1,
			1,
			1
		}
	},
	[54130300] = {
		QTEType = 2,
		ButtonCount = 5,
		Id = 54130300,
		TitleBefore = getI18NValue(180083546),
		Describe = getI18NValue(180083544),
		TitleAfter = getI18NValue(180083545),
		SuccessService = {
			54130303,
			54130304,
			140107000,
			54130305,
			54130306
		},
		FailService = {
			54130302
		},
		ButtonDelay = {
			0.2,
			0.7,
			1.2,
			1.7,
			2.2
		},
		ButtonTime = {
			1,
			1,
			1,
			1,
			1
		}
	},
	[54162600] = {
		QTEType = 1,
		ButtonCount = 5,
		Id = 54162600,
		TitleBefore = getI18NValue(180083549),
		Describe = getI18NValue(180083547),
		TitleAfter = getI18NValue(180083548),
		SuccessService = {
			140107000,
			140104000,
			140101000,
			140100000
		},
		FailService = {
			140107000,
			140106000
		},
		ButtonDelay = {
			0.2,
			0.4,
			0.6,
			0.8,
			1
		},
		ButtonTime = {
			2,
			2,
			2,
			2,
			2
		}
	},
	[54162700] = {
		QTEType = 2,
		ButtonCount = 5,
		Id = 54162700,
		TitleBefore = getI18NValue(180083552),
		Describe = getI18NValue(180083550),
		TitleAfter = getI18NValue(180083551),
		SuccessService = {
			140107000,
			140104000,
			140101000,
			140100000
		},
		FailService = {
			140107000,
			140106000
		},
		ButtonDelay = {
			0.2,
			0.4,
			0.6,
			0.8,
			1
		},
		ButtonTime = {
			3,
			3,
			3,
			3,
			3
		}
	},
	[54162800] = {
		QTEType = 2,
		ButtonCount = 5,
		Id = 54162800,
		TitleBefore = getI18NValue(180083555),
		Describe = getI18NValue(180083553),
		TitleAfter = getI18NValue(180083554),
		SuccessService = {
			140107000,
			140104000,
			140101000,
			140100000
		},
		FailService = {
			140107000,
			140106000
		},
		ButtonDelay = {
			0.2,
			0.4,
			0.6,
			0.8,
			1
		},
		ButtonTime = {
			2,
			2,
			2,
			2,
			2
		}
	},
	[54210500] = {
		QTEType = 1,
		ButtonCount = 5,
		Id = 54210500,
		TitleBefore = getI18NValue(180145078),
		Describe = getI18NValue(180145076),
		TitleAfter = getI18NValue(180145077),
		SuccessService = {
			54210504
		},
		FailService = {
			54210503
		},
		ButtonDelay = {
			0.2,
			0.4,
			0.6,
			0.8,
			1
		},
		ButtonTime = {
			2,
			2,
			2,
			2,
			2
		}
	},
	[54210800] = {
		QTEType = 2,
		ButtonCount = 5,
		Id = 54210800,
		TitleBefore = getI18NValue(180145081),
		Describe = getI18NValue(180145079),
		TitleAfter = getI18NValue(180145080),
		SuccessService = {
			54210804
		},
		FailService = {
			54210803
		},
		ButtonDelay = {
			0.2,
			0.4,
			0.6,
			0.8,
			1
		},
		ButtonTime = {
			2,
			2,
			2,
			2,
			2
		}
	},
	[54221350] = {
		QTEType = 2,
		ButtonCount = 5,
		Id = 54221350,
		TitleBefore = getI18NValue(180145084),
		Describe = getI18NValue(180145082),
		TitleAfter = getI18NValue(180145083),
		SuccessService = {
			54221353
		},
		FailService = {
			54221352
		},
		ButtonDelay = {
			0.2,
			0.4,
			0.6,
			0.8,
			1
		},
		ButtonTime = {
			2,
			2,
			2,
			2,
			2
		}
	},
	[55062100] = {
		QTEType = 2,
		ButtonCount = 5,
		Id = 55062100,
		TitleBefore = getI18NValue(180258475),
		Describe = getI18NValue(180258473),
		TitleAfter = getI18NValue(180258474),
		SuccessService = {
			55062102
		},
		FailService = {
			55062103
		},
		ButtonDelay = {
			0.2,
			0.4,
			0.6,
			0.8,
			1
		},
		ButtonTime = {
			2,
			2,
			2,
			2,
			2
		}
	},
	[56012600] = {
		QTEType = 2,
		ButtonCount = 5,
		Id = 56012600,
		TitleBefore = getI18NValue(180470150),
		Describe = getI18NValue(180470148),
		TitleAfter = getI18NValue(180470149),
		SuccessService = {
			56012604
		},
		FailService = {
			56012603
		},
		ButtonDelay = {
			0.2,
			0.4,
			0.6,
			0.8,
			1
		},
		ButtonTime = {
			2,
			2,
			2,
			2,
			2
		}
	},
	[56050201] = {
		QTEType = 2,
		ButtonCount = 5,
		Id = 56050201,
		TitleBefore = getI18NValue(180470864),
		Describe = getI18NValue(180470862),
		TitleAfter = getI18NValue(180470863),
		SuccessService = {
			140107000,
			56050203
		},
		FailService = {
			56050202
		},
		ButtonDelay = {
			0.2,
			0.4,
			0.6,
			0.8,
			1
		},
		ButtonTime = {
			2,
			2,
			2,
			2,
			2
		}
	},
	[56160302] = {
		QTEType = 1,
		ButtonCount = 5,
		Id = 56160302,
		TitleBefore = getI18NValue(180518164),
		Describe = getI18NValue(180518162),
		TitleAfter = getI18NValue(180518163),
		SuccessService = {
			56160303,
			140107000,
			56160305,
			140104000,
			140101000
		},
		FailService = {
			56160304,
			56160302
		},
		ButtonDelay = {
			0.2,
			0.4,
			0.6,
			0.8,
			1
		},
		ButtonTime = {
			2,
			2,
			2,
			2,
			2
		}
	},
	[56160604] = {
		QTEType = 1,
		ButtonCount = 5,
		Id = 56160604,
		TitleBefore = getI18NValue(180518167),
		Describe = getI18NValue(180518165),
		TitleAfter = getI18NValue(180518166),
		SuccessService = {
			56160606,
			140107000,
			140104000,
			140101000
		},
		FailService = {
			56160607,
			56160605
		},
		ButtonDelay = {
			0.2,
			0.4,
			0.6,
			0.8,
			1
		},
		ButtonTime = {
			2,
			2,
			2,
			2,
			2
		}
	},
	[56212101] = {
		QTEType = 1,
		ButtonCount = 5,
		Id = 56212101,
		TitleBefore = getI18NValue(180545119),
		Describe = getI18NValue(180545117),
		TitleAfter = getI18NValue(180545118),
		SuccessService = {
			56212102,
			140107000,
			140104000
		},
		FailService = {
			56212101
		},
		ButtonDelay = {
			0.2,
			0.4,
			0.6,
			0.8,
			1
		},
		ButtonTime = {
			3,
			3,
			3,
			3,
			3
		}
	},
	[56212201] = {
		QTEType = 1,
		ButtonCount = 5,
		Id = 56212201,
		TitleBefore = getI18NValue(180545122),
		Describe = getI18NValue(180545120),
		TitleAfter = getI18NValue(180545121),
		SuccessService = {
			56212202,
			140107000,
			140104000
		},
		FailService = {
			56212201
		},
		ButtonDelay = {
			0.2,
			0.4,
			0.6,
			0.8,
			1
		},
		ButtonTime = {
			3,
			3,
			3,
			3,
			3
		}
	},
	[56212301] = {
		QTEType = 1,
		ButtonCount = 5,
		Id = 56212301,
		TitleBefore = getI18NValue(180545125),
		Describe = getI18NValue(180545123),
		TitleAfter = getI18NValue(180545124),
		SuccessService = {
			56212302,
			140107000,
			140104000
		},
		FailService = {
			56212301
		},
		ButtonDelay = {
			0.2,
			0.4,
			0.6,
			0.8,
			1
		},
		ButtonTime = {
			3,
			3,
			3,
			3,
			3
		}
	},
	[56212401] = {
		QTEType = 1,
		ButtonCount = 5,
		Id = 56212401,
		TitleBefore = getI18NValue(180545128),
		Describe = getI18NValue(180545126),
		TitleAfter = getI18NValue(180545127),
		SuccessService = {
			56212402,
			140107000,
			140104000
		},
		FailService = {
			56212401
		},
		ButtonDelay = {
			0.2,
			0.4,
			0.6,
			0.8,
			1
		},
		ButtonTime = {
			3,
			3,
			3,
			3,
			3
		}
	},
	[56221200] = {
		QTEType = 1,
		ButtonCount = 5,
		Id = 56221200,
		TitleBefore = getI18NValue(180545134),
		Describe = getI18NValue(180545132),
		TitleAfter = getI18NValue(180545133),
		SuccessService = {
			56221212,
			56221120,
			56221220,
			56221320,
			140107000,
			140104000
		},
		FailService = {
			56221130,
			140107000,
			140104000
		},
		ButtonDelay = {
			0.2,
			0.4,
			0.6,
			0.8,
			1
		},
		ButtonTime = {
			3,
			3,
			3,
			3,
			3
		}
	},
	[56221201] = {
		QTEType = 1,
		ButtonCount = 5,
		Id = 56221201,
		TitleBefore = getI18NValue(180556332),
		Describe = getI18NValue(180556330),
		TitleAfter = getI18NValue(180556331),
		SuccessService = {
			56221212,
			56221420,
			56221520,
			56221620,
			140107000,
			140104000
		},
		FailService = {
			56221130,
			140107000,
			140104000
		},
		ButtonDelay = {
			0.2,
			0.4,
			0.6,
			0.8,
			1
		},
		ButtonTime = {
			3,
			3,
			3,
			3,
			3
		}
	},
	[56221202] = {
		QTEType = 1,
		ButtonCount = 5,
		Id = 56221202,
		TitleBefore = getI18NValue(180556335),
		Describe = getI18NValue(180556333),
		TitleAfter = getI18NValue(180556334),
		SuccessService = {
			56221212,
			56221720,
			56221820,
			56221920,
			140107000,
			140104000
		},
		FailService = {
			56221130,
			140107000,
			140104000
		},
		ButtonDelay = {
			0.2,
			0.4,
			0.6,
			0.8,
			1
		},
		ButtonTime = {
			3,
			3,
			3,
			3,
			3
		}
	},
	[56221203] = {
		QTEType = 1,
		ButtonCount = 5,
		Id = 56221203,
		TitleBefore = getI18NValue(180556338),
		Describe = getI18NValue(180556336),
		TitleAfter = getI18NValue(180556337),
		SuccessService = {
			56221212,
			56222020,
			56222120,
			56222220,
			140107000,
			140104000
		},
		FailService = {
			56221130,
			140107000,
			140104000
		},
		ButtonDelay = {
			0.2,
			0.4,
			0.6,
			0.8,
			1
		},
		ButtonTime = {
			3,
			3,
			3,
			3,
			3
		}
	},
	[56240409] = {
		QTEType = 2,
		ButtonCount = 5,
		Id = 56240409,
		TitleBefore = getI18NValue(180547309),
		Describe = getI18NValue(180547307),
		TitleAfter = getI18NValue(180547308),
		SuccessService = {
			56240411,
			140107000,
			56240412
		},
		FailService = {
			56240411,
			56240410
		},
		ButtonDelay = {
			0.2,
			0.7,
			1.2,
			1.7,
			2.2
		},
		ButtonTime = {
			1,
			1,
			1,
			1,
			1
		}
	},
	[57010601] = {
		QTEType = 2,
		ButtonCount = 5,
		Id = 57010601,
		TitleBefore = getI18NValue(180782550),
		Describe = getI18NValue(180782548),
		TitleAfter = getI18NValue(180782549),
		SuccessService = {
			57010103,
			140101000,
			140104000,
			140107000
		},
		FailService = {
			57010602
		},
		ButtonDelay = {
			0.2,
			0.7,
			1.2,
			1.7,
			2.2
		},
		ButtonTime = {
			1,
			1,
			1,
			1,
			1
		}
	},
	[57033002] = {
		QTEType = 2,
		ButtonCount = 5,
		Id = 57033002,
		TitleBefore = getI18NValue(180815922),
		Describe = getI18NValue(180815920),
		TitleAfter = getI18NValue(180815921),
		SuccessService = {
			140107000,
			140104000,
			57033004,
			57050104
		},
		FailService = {
			57033003
		},
		ButtonDelay = {
			0.2,
			0.7,
			1.2,
			1.7,
			2.2
		},
		ButtonTime = {
			1,
			1,
			1,
			1,
			1
		}
	},
	[57033102] = {
		QTEType = 2,
		ButtonCount = 5,
		Id = 57033102,
		TitleBefore = getI18NValue(180815925),
		Describe = getI18NValue(180815923),
		TitleAfter = getI18NValue(180815924),
		SuccessService = {
			140107000,
			140104000,
			57033104,
			57050104,
			57033101
		},
		FailService = {
			57033103
		},
		ButtonDelay = {
			0.2,
			0.7,
			1.2,
			1.7,
			2.2
		},
		ButtonTime = {
			1,
			1,
			1,
			1,
			1
		}
	},
	[57033302] = {
		QTEType = 2,
		ButtonCount = 5,
		Id = 57033302,
		TitleBefore = getI18NValue(180818555),
		Describe = getI18NValue(180818553),
		TitleAfter = getI18NValue(180818554),
		SuccessService = {
			140107000,
			140104000,
			57033304,
			57050104,
			57033301
		},
		FailService = {
			57033303
		},
		ButtonDelay = {
			0.2,
			0.7,
			1.2,
			1.7,
			2.2
		},
		ButtonTime = {
			1,
			1,
			1,
			1,
			1
		}
	},
	[57150502] = {
		QTEType = 2,
		ButtonCount = 5,
		Id = 57150502,
		TitleBefore = getI18NValue(180831453),
		Describe = getI18NValue(180831451),
		TitleAfter = getI18NValue(180831452),
		SuccessService = {
			57150504,
			57150506
		},
		FailService = {
			57150505
		},
		ButtonDelay = {
			0.2,
			0.7,
			1.2,
			1.7,
			2.2
		},
		ButtonTime = {
			1,
			1,
			1,
			1,
			1
		}
	},
	[57160101] = {
		QTEType = 2,
		ButtonCount = 5,
		Id = 57160101,
		TitleBefore = getI18NValue(180831456),
		Describe = getI18NValue(180831454),
		TitleAfter = getI18NValue(180831455),
		SuccessService = {
			57160103
		},
		FailService = {
			57160104
		},
		ButtonDelay = {
			0.2,
			0.7,
			1.2,
			1.7,
			2.2
		},
		ButtonTime = {
			1,
			1,
			1,
			1,
			1
		}
	},
	[83111200] = {
		QTEType = 2,
		ButtonCount = 5,
		Id = 83111200,
		TitleBefore = getI18NValue(180083558),
		Describe = getI18NValue(180083556),
		TitleAfter = getI18NValue(180083557),
		SuccessService = {
			83111204,
			83111206,
			83111210,
			83111208,
			83111207
		},
		FailService = {
			83111205,
			83111209
		},
		ButtonDelay = {
			0.2,
			0.4,
			0.6,
			0.8,
			1
		},
		ButtonTime = {
			2,
			2,
			2,
			2,
			2
		}
	},
	[83221600] = {
		QTEType = 2,
		ButtonCount = 5,
		Id = 83221600,
		TitleBefore = getI18NValue(180083561),
		Describe = getI18NValue(180083559),
		TitleAfter = getI18NValue(180083560),
		SuccessService = {
			83221615
		},
		FailService = {
			83221607
		},
		ButtonDelay = {
			0.2,
			0.4,
			0.6,
			0.8,
			1
		},
		ButtonTime = {
			1,
			1,
			1,
			1,
			1
		}
	},
	[84310500] = {
		QTEType = 2,
		ButtonCount = 5,
		Id = 84310500,
		TitleBefore = getI18NValue(180277122),
		Describe = getI18NValue(180277120),
		TitleAfter = getI18NValue(180277121),
		SuccessService = {
			84310507
		},
		FailService = {
			84310508
		},
		ButtonDelay = {
			0.2,
			0.4,
			0.6,
			0.8,
			1
		},
		ButtonTime = {
			2,
			2,
			2,
			2,
			2
		}
	},
	[86050100] = {
		QTEType = 2,
		ButtonCount = 5,
		Id = 86050100,
		TitleBefore = getI18NValue(180507788),
		Describe = getI18NValue(180507786),
		TitleAfter = getI18NValue(180507787),
		SuccessService = {
			86050103
		},
		FailService = {
			140107000,
			86050600
		},
		ButtonDelay = {
			0.2,
			0.4,
			0.6,
			0.8,
			1
		},
		ButtonTime = {
			2,
			2,
			2,
			2,
			2
		}
	},
	[85320600] = {
		QTEType = 2,
		ButtonCount = 5,
		Id = 85320600,
		TitleBefore = getI18NValue(180436282),
		Describe = getI18NValue(180436280),
		TitleAfter = getI18NValue(180436281),
		SuccessService = {
			85320610
		},
		FailService = {
			85320609
		},
		ButtonDelay = {
			0.2,
			0.4,
			0.6,
			0.8,
			1
		},
		ButtonTime = {
			2,
			2,
			2,
			2,
			2
		}
	},
	[85361300] = {
		QTEType = 1,
		ButtonCount = 5,
		Id = 85361300,
		TitleBefore = getI18NValue(180441133),
		Describe = getI18NValue(180441131),
		TitleAfter = getI18NValue(180441132),
		SuccessService = {
			85361316
		},
		FailService = {
			85361324
		},
		ButtonDelay = {
			0.2,
			0.7,
			1.2,
			1.7,
			2.2
		},
		ButtonTime = {
			1,
			1,
			1,
			1,
			1
		}
	},
	[85361301] = {
		QTEType = 2,
		ButtonCount = 5,
		Id = 85361301,
		TitleBefore = getI18NValue(180441136),
		Describe = getI18NValue(180441134),
		TitleAfter = getI18NValue(180441135),
		SuccessService = {
			85361317
		},
		FailService = {
			85361325
		},
		ButtonDelay = {
			0.2,
			0.7,
			1.2,
			1.7,
			2.2
		},
		ButtonTime = {
			1,
			1,
			1,
			1,
			1
		}
	},
	[85361302] = {
		QTEType = 2,
		ButtonCount = 5,
		Id = 85361302,
		TitleBefore = getI18NValue(180441139),
		Describe = getI18NValue(180441137),
		TitleAfter = getI18NValue(180441138),
		SuccessService = {
			85361318
		},
		FailService = {
			85361326
		},
		ButtonDelay = {
			0.2,
			0.4,
			0.6,
			0.8,
			1
		},
		ButtonTime = {
			2,
			2,
			2,
			2,
			2
		}
	},
	[87025540] = {
		QTEType = 2,
		ButtonCount = 5,
		Id = 87025540,
		TitleBefore = getI18NValue(180551840),
		Describe = getI18NValue(180551838),
		TitleAfter = getI18NValue(180551839),
		SuccessService = {
			87025542
		},
		FailService = {
			87025541
		},
		ButtonDelay = {
			0.2,
			0.4,
			0.6,
			0.8,
			1
		},
		ButtonTime = {
			2,
			2,
			2,
			2,
			2
		}
	}
}

setmetatable(CfgMazeQTETable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgMazeQTETable]")
	end
})

local defaultMetaTable = {
	__index = {
		QTEType = 0,
		TitleBefore = "",
		ButtonCount = 0,
		TitleAfter = "",
		Describe = "",
		ButtonDelay = {
			0,
			0,
			0,
			0,
			0
		},
		SuccessService = {},
		FailService = {},
		ButtonTime = {
			0,
			0,
			0,
			0,
			0
		}
	}
}

for i, data in pairs(CfgMazeQTETable) do
	setmetatable(data, defaultMetaTable)
end

return CfgMazeQTETable
