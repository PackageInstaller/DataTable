-- chunkname: @IQIGame\\Config\\CfgDatingEventsTable.lua

local CfgDatingEventsTable = {
	[1001001] = {
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Church/InChurch.png",
		UnlockLevel = 2,
		DatingType = 1,
		DatingTypeShow = 1,
		Dialog = 1110200000,
		Id = 1001001,
		Level = 1,
		SoulId = 20010001,
		Name = getI18NValue(180007518),
		Describe = getI18NValue(180007517),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10601,
			100,
			20201,
			6
		}
	},
	[1001002] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BusinessStreet/BusinessStreet_day_sunny.png",
		NeedDownDatingId = 1001001,
		UnlockLevel = 5,
		Dialog = 1110200100,
		Id = 1001002,
		Level = 2,
		SoulId = 20010001,
		Name = getI18NValue(180007520),
		Describe = getI18NValue(180007519),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10601,
			100,
			20201,
			6
		}
	},
	[1001003] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Restaurant/Restaurant_night.png",
		NeedDownDatingId = 1001002,
		UnlockLevel = 10,
		Dialog = 1110200250,
		Id = 1001003,
		Level = 3,
		SoulId = 20010001,
		Name = getI18NValue(180007522),
		Describe = getI18NValue(180007521),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10601,
			250,
			20201,
			12
		}
	},
	[1001004] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Restaurant/Restaurant_night.png",
		NeedDownDatingId = 1001003,
		UnlockLevel = 15,
		Dialog = 1110194400,
		Id = 1001004,
		Level = 4,
		SoulId = 20010001,
		Name = getI18NValue(180007524),
		Describe = getI18NValue(180007523),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10601,
			250,
			20201,
			12
		}
	},
	[1001005] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_CenterSquare/CenterSquare_night_sunny.png",
		NeedDownDatingId = 1001004,
		UnlockLevel = 20,
		Dialog = 1110194500,
		Id = 1001005,
		Level = 5,
		SoulId = 20010001,
		Name = getI18NValue(180007526),
		Describe = getI18NValue(180007525),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10601,
			400,
			20201,
			20
		}
	},
	[1001006] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Restaurant/Restaurant_1.png",
		NeedDownDatingId = 1001005,
		UnlockLevel = 25,
		Dialog = 1110194570,
		Id = 1001006,
		Level = 6,
		SoulId = 20010001,
		Name = getI18NValue(180007528),
		Describe = getI18NValue(180007527),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10601,
			400,
			20201,
			20
		}
	},
	[1001007] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Villa/Villa.png",
		NeedDownDatingId = 1001006,
		UnlockLevel = 30,
		Dialog = 1711117840,
		Id = 1001007,
		Level = 7,
		SoulId = 20010001,
		Name = getI18NValue(180007530),
		Describe = getI18NValue(180007529),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10601,
			600,
			20201,
			25
		}
	},
	[1001008] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BusinessStreet/ClothingShop.png",
		NeedDownDatingId = 1001007,
		UnlockLevel = 35,
		Dialog = 1711117930,
		Id = 1001008,
		Level = 8,
		SoulId = 20010001,
		Name = getI18NValue(180007532),
		Describe = getI18NValue(180007531),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10601,
			600,
			20201,
			25
		}
	},
	[1001009] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Ruins/Ruins_stone_sunny.png",
		NeedDownDatingId = 1001008,
		UnlockLevel = 40,
		Dialog = 1711118030,
		Id = 1001009,
		Level = 9,
		SoulId = 20010001,
		Name = getI18NValue(180007534),
		Describe = getI18NValue(180007533),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10601,
			800,
			20201,
			30
		}
	},
	[1001010] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Surburb/Surburb_night_sunny.png",
		NeedDownDatingId = 1001009,
		UnlockLevel = 43,
		Dialog = 1110202800,
		Id = 1001010,
		Level = 10,
		SoulId = 20010001,
		Name = getI18NValue(180256101),
		Describe = getI18NValue(180256100),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10601,
			800,
			20201,
			30
		}
	},
	[1001011] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Uptown/Uptown_night_sunny.png",
		NeedDownDatingId = 1001010,
		UnlockLevel = 46,
		Dialog = 1110203100,
		Id = 1001011,
		Level = 11,
		SoulId = 20010001,
		Name = getI18NValue(180256103),
		Describe = getI18NValue(180256102),
		ReturnGiftNum = {
			300,
			700
		},
		Cost = {
			10901,
			20
		},
		Reward = {
			10601,
			1000,
			20201,
			40
		}
	},
	[2001001] = {
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BusinessStreet/BusinessStreet_day_sunny.png",
		UnlockLevel = 2,
		DatingType = 1,
		DatingTypeShow = 1,
		Dialog = 121111000,
		Id = 2001001,
		Level = 1,
		SoulId = 20010002,
		Name = getI18NValue(180007536),
		Describe = getI18NValue(180007535),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10602,
			100,
			20201,
			6
		}
	},
	[2001002] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_DiningRoom/DiningRoom_day.png",
		NeedDownDatingId = 2001001,
		UnlockLevel = 5,
		Dialog = 121111100,
		Id = 2001002,
		Level = 2,
		SoulId = 20010002,
		Name = getI18NValue(180007538),
		Describe = getI18NValue(180007537),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10602,
			100,
			20201,
			6
		}
	},
	[2001003] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BusinessStreet/BusinessStreet_day_sunny.png",
		NeedDownDatingId = 2001002,
		UnlockLevel = 10,
		Dialog = 121111200,
		Id = 2001003,
		Level = 3,
		SoulId = 20010002,
		Name = getI18NValue(180007540),
		Describe = getI18NValue(180007539),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10602,
			250,
			20201,
			12
		}
	},
	[2001004] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Lane/Lane_night_sunny.png",
		NeedDownDatingId = 2001003,
		UnlockLevel = 15,
		Dialog = 121111320,
		Id = 2001004,
		Level = 4,
		SoulId = 20010002,
		Name = getI18NValue(180007542),
		Describe = getI18NValue(180007541),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10602,
			250,
			20201,
			12
		}
	},
	[2001005] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Lane/Lane.png",
		NeedDownDatingId = 2001004,
		UnlockLevel = 20,
		Dialog = 121111420,
		Id = 2001005,
		Level = 5,
		SoulId = 20010002,
		Name = getI18NValue(180007544),
		Describe = getI18NValue(180007543),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10602,
			400,
			20201,
			20
		}
	},
	[2001006] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Theater/Theater_on.png",
		NeedDownDatingId = 2001005,
		UnlockLevel = 25,
		Dialog = 121111550,
		Id = 2001006,
		Level = 6,
		SoulId = 20010002,
		Name = getI18NValue(180007546),
		Describe = getI18NValue(180007545),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10602,
			400,
			20201,
			20
		}
	},
	[2001007] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Museum/Museum_day.png",
		NeedDownDatingId = 2001006,
		UnlockLevel = 30,
		Dialog = 121111650,
		Id = 2001007,
		Level = 7,
		SoulId = 20010002,
		Name = getI18NValue(180007548),
		Describe = getI18NValue(180007547),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10602,
			600,
			20201,
			25
		}
	},
	[2001008] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_HomePrivateRoom/GirlRoom_day.png",
		NeedDownDatingId = 2001007,
		UnlockLevel = 35,
		Dialog = 121111800,
		Id = 2001008,
		Level = 8,
		SoulId = 20010002,
		Name = getI18NValue(180007550),
		Describe = getI18NValue(180007549),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10602,
			600,
			20201,
			25
		}
	},
	[2001009] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Restaurant/Restaurant_1.png",
		NeedDownDatingId = 2001008,
		UnlockLevel = 40,
		Dialog = 121111950,
		Id = 2001009,
		Level = 9,
		SoulId = 20010002,
		Name = getI18NValue(180007552),
		Describe = getI18NValue(180007551),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10602,
			800,
			20201,
			30
		}
	},
	[2001010] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Balcony/Balcony_night_sunny.png",
		NeedDownDatingId = 2001009,
		UnlockLevel = 43,
		Dialog = 121112150,
		Id = 2001010,
		Level = 10,
		SoulId = 20010002,
		Name = getI18NValue(180256105),
		Describe = getI18NValue(180256104),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10602,
			800,
			20201,
			30
		}
	},
	[2001011] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_HomePrivateRoom/PlayerRoom_day.png",
		NeedDownDatingId = 2001010,
		UnlockLevel = 46,
		Dialog = 121112250,
		Id = 2001011,
		Level = 11,
		SoulId = 20010002,
		Name = getI18NValue(180256107),
		Describe = getI18NValue(180256106),
		ReturnGiftNum = {
			300,
			700
		},
		Cost = {
			10901,
			20
		},
		Reward = {
			10602,
			1000,
			20201,
			40
		}
	},
	[3001001] = {
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Surburb/Surburb_day_sunny.png",
		UnlockLevel = 2,
		DatingType = 1,
		DatingTypeShow = 1,
		Dialog = 1313110000,
		Id = 3001001,
		Level = 1,
		SoulId = 20010003,
		Name = getI18NValue(180007554),
		Describe = getI18NValue(180007553),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10603,
			100,
			20201,
			6
		}
	},
	[3001002] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Restaurant/Restaurant.png",
		NeedDownDatingId = 3001001,
		UnlockLevel = 5,
		Dialog = 1313120000,
		Id = 3001002,
		Level = 2,
		SoulId = 20010003,
		Name = getI18NValue(180007556),
		Describe = getI18NValue(180007555),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10603,
			100,
			20201,
			6
		}
	},
	[3001003] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Surburb/Surburb_day_sunny.png",
		NeedDownDatingId = 3001002,
		UnlockLevel = 10,
		Dialog = 1313130000,
		Id = 3001003,
		Level = 3,
		SoulId = 20010003,
		Name = getI18NValue(180007558),
		Describe = getI18NValue(180007557),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10603,
			250,
			20201,
			12
		}
	},
	[3001004] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_CenterSquare/CenterSquare_day_sunny.png",
		NeedDownDatingId = 3001003,
		UnlockLevel = 15,
		Dialog = 1110194660,
		Id = 3001004,
		Level = 4,
		SoulId = 20010003,
		Name = getI18NValue(180007560),
		Describe = getI18NValue(180007559),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10603,
			250,
			20201,
			12
		}
	},
	[3001005] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Surburb/Surburb_day_sunny.png",
		NeedDownDatingId = 3001004,
		UnlockLevel = 20,
		Dialog = 1110194740,
		Id = 3001005,
		Level = 5,
		SoulId = 20010003,
		Name = getI18NValue(180007562),
		Describe = getI18NValue(180007561),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10603,
			400,
			20201,
			20
		}
	},
	[3001006] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_CenterSquare/CenterSquare_day_sunny.png",
		NeedDownDatingId = 3001005,
		UnlockLevel = 25,
		Dialog = 1110194830,
		Id = 3001006,
		Level = 6,
		SoulId = 20010003,
		Name = getI18NValue(180007564),
		Describe = getI18NValue(180007563),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10603,
			400,
			20201,
			20
		}
	},
	[3001007] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BusinessStreet/BusinessStreet_day_sunny.png",
		NeedDownDatingId = 3001006,
		UnlockLevel = 30,
		Dialog = 1711118120,
		Id = 3001007,
		Level = 7,
		SoulId = 20010003,
		Name = getI18NValue(180007566),
		Describe = getI18NValue(180007565),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10603,
			600,
			20201,
			25
		}
	},
	[3001008] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Church/ChurchStage.png",
		NeedDownDatingId = 3001007,
		UnlockLevel = 35,
		Dialog = 1711118195,
		Id = 3001008,
		Level = 8,
		SoulId = 20010003,
		Name = getI18NValue(180007568),
		Describe = getI18NValue(180007567),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10603,
			600,
			20201,
			25
		}
	},
	[3001009] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Surburb/Surburb_night_sunny.png",
		NeedDownDatingId = 3001008,
		UnlockLevel = 40,
		Dialog = 1711118280,
		Id = 3001009,
		Level = 9,
		SoulId = 20010003,
		Name = getI18NValue(180007570),
		Describe = getI18NValue(180007569),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10603,
			800,
			20201,
			30
		}
	},
	[3001010] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_DiningRoom/DiningRoom_night.png",
		NeedDownDatingId = 3001009,
		UnlockLevel = 43,
		Dialog = 1315131800,
		Id = 3001010,
		Level = 10,
		SoulId = 20010003,
		Name = getI18NValue(180256109),
		Describe = getI18NValue(180256108),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10603,
			800,
			20201,
			30
		}
	},
	[3001011] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Balcony/Balcony_night_sunny.png",
		NeedDownDatingId = 3001010,
		UnlockLevel = 46,
		Dialog = 1315132000,
		Id = 3001011,
		Level = 11,
		SoulId = 20010003,
		Name = getI18NValue(180256111),
		Describe = getI18NValue(180256110),
		ReturnGiftNum = {
			300,
			700
		},
		Cost = {
			10901,
			20
		},
		Reward = {
			10603,
			1000,
			20201,
			40
		}
	},
	[4001001] = {
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Restaurant/Restaurant_1.png",
		UnlockLevel = 2,
		DatingType = 1,
		DatingTypeShow = 1,
		Dialog = 1413110000,
		Id = 4001001,
		Level = 1,
		SoulId = 20010004,
		Name = getI18NValue(180007572),
		Describe = getI18NValue(180007571),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10604,
			100,
			20201,
			6
		}
	},
	[4001002] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Fields/Fields_sunny.png",
		NeedDownDatingId = 4001001,
		UnlockLevel = 5,
		Dialog = 1413120000,
		Id = 4001002,
		Level = 2,
		SoulId = 20010004,
		Name = getI18NValue(180007574),
		Describe = getI18NValue(180007573),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10604,
			100,
			20201,
			6
		}
	},
	[4001003] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Museum/Museum_day.png",
		NeedDownDatingId = 4001002,
		UnlockLevel = 10,
		Dialog = 1413130000,
		Id = 4001003,
		Level = 3,
		SoulId = 20010004,
		Name = getI18NValue(180007576),
		Describe = getI18NValue(180007575),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10604,
			250,
			20201,
			12
		}
	},
	[4001004] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Livingroom/LivingRoom_day.png",
		NeedDownDatingId = 4001003,
		UnlockLevel = 15,
		Dialog = 1110194910,
		Id = 4001004,
		Level = 4,
		SoulId = 20010004,
		Name = getI18NValue(180007578),
		Describe = getI18NValue(180007577),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10604,
			250,
			20201,
			12
		}
	},
	[4001005] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Sky/Sky_day_sunny.png",
		NeedDownDatingId = 4001004,
		UnlockLevel = 20,
		Dialog = 1110195090,
		Id = 4001005,
		Level = 5,
		SoulId = 20010004,
		Name = getI18NValue(180007580),
		Describe = getI18NValue(180007579),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10604,
			400,
			20201,
			20
		}
	},
	[4001006] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Villa/Villa.png",
		NeedDownDatingId = 4001005,
		UnlockLevel = 25,
		Dialog = 1110195000,
		Id = 4001006,
		Level = 6,
		SoulId = 20010004,
		Name = getI18NValue(180007582),
		Describe = getI18NValue(180007581),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10604,
			400,
			20201,
			20
		}
	},
	[4001007] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Funroom/Funroom.png",
		NeedDownDatingId = 4001006,
		UnlockLevel = 30,
		Dialog = 1711118385,
		Id = 4001007,
		Level = 7,
		SoulId = 20010004,
		Name = getI18NValue(180007584),
		Describe = getI18NValue(180007583),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10604,
			600,
			20201,
			25
		}
	},
	[4001008] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Restaurant/Restaurant.png",
		NeedDownDatingId = 4001007,
		UnlockLevel = 35,
		Dialog = 1711118470,
		Id = 4001008,
		Level = 8,
		SoulId = 20010004,
		Name = getI18NValue(180007586),
		Describe = getI18NValue(180007585),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10604,
			600,
			20201,
			25
		}
	},
	[4001009] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Lane/Lane.png",
		NeedDownDatingId = 4001008,
		UnlockLevel = 40,
		Dialog = 1711118565,
		Id = 4001009,
		Level = 9,
		SoulId = 20010004,
		Name = getI18NValue(180007588),
		Describe = getI18NValue(180007587),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10604,
			800,
			20201,
			30
		}
	},
	[4001010] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Theater/Theater_on.png",
		NeedDownDatingId = 4001009,
		UnlockLevel = 43,
		Dialog = 1415130700,
		Id = 4001010,
		Level = 10,
		SoulId = 20010004,
		Name = getI18NValue(180256113),
		Describe = getI18NValue(180256112),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10604,
			800,
			20201,
			30
		}
	},
	[4001011] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Kitchen/Kitchen_day.png",
		NeedDownDatingId = 4001010,
		UnlockLevel = 46,
		Dialog = 1415130900,
		Id = 4001011,
		Level = 11,
		SoulId = 20010004,
		Name = getI18NValue(180256115),
		Describe = getI18NValue(180256114),
		ReturnGiftNum = {
			300,
			700
		},
		Cost = {
			10901,
			20
		},
		Reward = {
			10604,
			1000,
			20201,
			40
		}
	},
	[5001001] = {
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Uptown/Uptown_day_sunny.png",
		UnlockLevel = 2,
		DatingType = 1,
		DatingTypeShow = 1,
		Dialog = 1525130100,
		Id = 5001001,
		Level = 1,
		SoulId = 20010005,
		Name = getI18NValue(180007590),
		Describe = getI18NValue(180007589),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10605,
			100,
			20201,
			6
		}
	},
	[5001002] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Museum/Museum_day.png",
		NeedDownDatingId = 5001001,
		UnlockLevel = 5,
		Dialog = 1525130200,
		Id = 5001002,
		Level = 2,
		SoulId = 20010005,
		Name = getI18NValue(180007592),
		Describe = getI18NValue(180007591),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10605,
			100,
			20201,
			6
		}
	},
	[5001003] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_CenterSquare/CenterSquare_day_sunny.png",
		NeedDownDatingId = 5001002,
		UnlockLevel = 10,
		Dialog = 1525130300,
		Id = 5001003,
		Level = 3,
		SoulId = 20010005,
		Name = getI18NValue(180007594),
		Describe = getI18NValue(180007593),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10605,
			250,
			20201,
			12
		}
	},
	[5001004] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Carriage/Carriage.png",
		NeedDownDatingId = 5001003,
		UnlockLevel = 15,
		Dialog = 1110195190,
		Id = 5001004,
		Level = 4,
		SoulId = 20010005,
		Name = getI18NValue(180007596),
		Describe = getI18NValue(180007595),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10605,
			250,
			20201,
			12
		}
	},
	[5001005] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Livingroom/LivingRoom_night.png",
		NeedDownDatingId = 5001004,
		UnlockLevel = 20,
		Dialog = 1110195280,
		Id = 5001005,
		Level = 5,
		SoulId = 20010005,
		Name = getI18NValue(180007598),
		Describe = getI18NValue(180007597),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10605,
			400,
			20201,
			20
		}
	},
	[5001006] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Lane/Lane.png",
		NeedDownDatingId = 5001005,
		UnlockLevel = 25,
		Dialog = 1110195360,
		Id = 5001006,
		Level = 6,
		SoulId = 20010005,
		Name = getI18NValue(180007600),
		Describe = getI18NValue(180007599),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10605,
			400,
			20201,
			20
		}
	},
	[5001007] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_SpecialScenes/Graveyard.png",
		NeedDownDatingId = 5001006,
		UnlockLevel = 30,
		Dialog = 1711118665,
		Id = 5001007,
		Level = 7,
		SoulId = 20010005,
		Name = getI18NValue(180007602),
		Describe = getI18NValue(180007601),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10605,
			600,
			20201,
			25
		}
	},
	[5001008] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_HomePrivateRoom/GirlRoom_day.png",
		NeedDownDatingId = 5001007,
		UnlockLevel = 35,
		Dialog = 1711118770,
		Id = 5001008,
		Level = 8,
		SoulId = 20010005,
		Name = getI18NValue(180007604),
		Describe = getI18NValue(180007603),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10605,
			600,
			20201,
			25
		}
	},
	[5001009] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_CenterSquare/CenterSquare_day_sunny.png",
		NeedDownDatingId = 5001008,
		UnlockLevel = 40,
		Dialog = 1711118865,
		Id = 5001009,
		Level = 9,
		SoulId = 20010005,
		Name = getI18NValue(180007606),
		Describe = getI18NValue(180007605),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10605,
			800,
			20201,
			30
		}
	},
	[5001010] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BusinessStreet/BusinessStreet_day_sunny.png",
		NeedDownDatingId = 5001009,
		UnlockLevel = 43,
		Dialog = 1512400100,
		Id = 5001010,
		Level = 10,
		SoulId = 20010005,
		Name = getI18NValue(180256117),
		Describe = getI18NValue(180256116),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10605,
			800,
			20201,
			30
		}
	},
	[5001011] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Garden/Garden_day_sunny.png",
		NeedDownDatingId = 5001010,
		UnlockLevel = 46,
		Dialog = 1512400250,
		Id = 5001011,
		Level = 11,
		SoulId = 20010005,
		Name = getI18NValue(180256119),
		Describe = getI18NValue(180256118),
		ReturnGiftNum = {
			300,
			700
		},
		Cost = {
			10901,
			20
		},
		Reward = {
			10605,
			1000,
			20201,
			40
		}
	},
	[6001001] = {
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Livingroom/LivingRoom_day.png",
		UnlockLevel = 2,
		DatingType = 1,
		DatingTypeShow = 1,
		Dialog = 1613110000,
		Id = 6001001,
		Level = 1,
		SoulId = 20010006,
		Name = getI18NValue(180007608),
		Describe = getI18NValue(180007607),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10606,
			100,
			20201,
			6
		}
	},
	[6001002] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Lane/Lane.png",
		NeedDownDatingId = 6001001,
		UnlockLevel = 5,
		Dialog = 1613110100,
		Id = 6001002,
		Level = 2,
		SoulId = 20010006,
		Name = getI18NValue(180007610),
		Describe = getI18NValue(180007609),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10606,
			100,
			20201,
			6
		}
	},
	[6001003] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Downtown/Downtown_day_rainy.png",
		NeedDownDatingId = 6001002,
		UnlockLevel = 10,
		Dialog = 1613110200,
		Id = 6001003,
		Level = 3,
		SoulId = 20010006,
		Name = getI18NValue(180007612),
		Describe = getI18NValue(180007611),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10606,
			250,
			20201,
			12
		}
	},
	[6001004] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Restaurant/Restaurant_1.png",
		NeedDownDatingId = 6001003,
		UnlockLevel = 15,
		Dialog = 1110195450,
		Id = 6001004,
		Level = 4,
		SoulId = 20010006,
		Name = getI18NValue(180007614),
		Describe = getI18NValue(180007613),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10606,
			250,
			20201,
			12
		}
	},
	[6001005] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Museum/Museum_day.png",
		NeedDownDatingId = 6001004,
		UnlockLevel = 20,
		Dialog = 1110195680,
		Id = 6001005,
		Level = 5,
		SoulId = 20010006,
		Name = getI18NValue(180007616),
		Describe = getI18NValue(180007615),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10606,
			400,
			20201,
			20
		}
	},
	[6001006] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Port/Port_day_rainy.png",
		NeedDownDatingId = 6001005,
		UnlockLevel = 25,
		Dialog = 1110195580,
		Id = 6001006,
		Level = 6,
		SoulId = 20010006,
		Name = getI18NValue(180007618),
		Describe = getI18NValue(180007617),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10606,
			400,
			20201,
			20
		}
	},
	[6001007] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Restaurant/Restaurant_1.png",
		NeedDownDatingId = 6001006,
		UnlockLevel = 30,
		Dialog = 1711119830,
		Id = 6001007,
		Level = 7,
		SoulId = 20010006,
		Name = getI18NValue(180007620),
		Describe = getI18NValue(180007619),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10606,
			600,
			20201,
			25
		}
	},
	[6001008] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Church/ChurchStage.png",
		NeedDownDatingId = 6001007,
		UnlockLevel = 35,
		Dialog = 1711119935,
		Id = 6001008,
		Level = 8,
		SoulId = 20010006,
		Name = getI18NValue(180007622),
		Describe = getI18NValue(180007621),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10606,
			600,
			20201,
			25
		}
	},
	[6001009] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Funroom/Funroom2.png",
		NeedDownDatingId = 6001008,
		UnlockLevel = 40,
		Dialog = 1711120030,
		Id = 6001009,
		Level = 9,
		SoulId = 20010006,
		Name = getI18NValue(180007624),
		Describe = getI18NValue(180007623),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10606,
			800,
			20201,
			30
		}
	},
	[6001010] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BlackStreet/BlackStreet_night_sunny.png",
		NeedDownDatingId = 6001009,
		UnlockLevel = 43,
		Dialog = 1615131800,
		Id = 6001010,
		Level = 10,
		SoulId = 20010006,
		Name = getI18NValue(180256121),
		Describe = getI18NValue(180256120),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10606,
			800,
			20201,
			30
		}
	},
	[6001011] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_CenterSquare/CenterSquare_day_sunny.png",
		NeedDownDatingId = 6001010,
		UnlockLevel = 46,
		Dialog = 1615132000,
		Id = 6001011,
		Level = 11,
		SoulId = 20010006,
		Name = getI18NValue(180256123),
		Describe = getI18NValue(180256122),
		ReturnGiftNum = {
			300,
			700
		},
		Cost = {
			10901,
			20
		},
		Reward = {
			10606,
			1000,
			20201,
			40
		}
	},
	[7001001] = {
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Port/Port_night_sunny.png",
		UnlockLevel = 2,
		DatingType = 1,
		DatingTypeShow = 1,
		Dialog = 1711110000,
		Id = 7001001,
		Level = 1,
		SoulId = 20010007,
		Name = getI18NValue(180007626),
		Describe = getI18NValue(180007625),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10607,
			100,
			20201,
			6
		}
	},
	[7001002] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Ruins/Ruins_night_sunny.png",
		NeedDownDatingId = 7001001,
		UnlockLevel = 5,
		Dialog = 1711110100,
		Id = 7001002,
		Level = 2,
		SoulId = 20010007,
		Name = getI18NValue(180007628),
		Describe = getI18NValue(180007627),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10607,
			100,
			20201,
			6
		}
	},
	[7001003] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Church/Church_night_sunny.png",
		NeedDownDatingId = 7001002,
		UnlockLevel = 10,
		Dialog = 1711110200,
		Id = 7001003,
		Level = 3,
		SoulId = 20010007,
		Name = getI18NValue(180007630),
		Describe = getI18NValue(180007629),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10607,
			250,
			20201,
			12
		}
	},
	[7001004] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Uptown/Uptown_day_rainy.png",
		NeedDownDatingId = 7001003,
		UnlockLevel = 15,
		Dialog = 1110198575,
		Id = 7001004,
		Level = 4,
		SoulId = 20010007,
		Name = getI18NValue(180007632),
		Describe = getI18NValue(180007631),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10607,
			250,
			20201,
			12
		}
	},
	[7001005] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_HomePrivateRoom/Library.png",
		NeedDownDatingId = 7001004,
		UnlockLevel = 20,
		Dialog = 1110198670,
		Id = 7001005,
		Level = 5,
		SoulId = 20010007,
		Name = getI18NValue(180007634),
		Describe = getI18NValue(180007633),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10607,
			400,
			20201,
			20
		}
	},
	[7001006] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Sky/Sky_night_sunny_hole.png",
		NeedDownDatingId = 7001005,
		UnlockLevel = 25,
		Dialog = 1110198770,
		Id = 7001006,
		Level = 6,
		SoulId = 20010007,
		Name = getI18NValue(180007636),
		Describe = getI18NValue(180007635),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10607,
			400,
			20201,
			20
		}
	},
	[7001007] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BusinessStreet/BusinessStreet_night_sunny.png",
		NeedDownDatingId = 7001006,
		UnlockLevel = 30,
		Dialog = 1711116930,
		Id = 7001007,
		Level = 7,
		SoulId = 20010007,
		Name = getI18NValue(180007638),
		Describe = getI18NValue(180007637),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10607,
			600,
			20201,
			25
		}
	},
	[7001008] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Funroom/Funroom2.png",
		NeedDownDatingId = 7001007,
		UnlockLevel = 35,
		Dialog = 1711117030,
		Id = 7001008,
		Level = 8,
		SoulId = 20010007,
		Name = getI18NValue(180007640),
		Describe = getI18NValue(180007639),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10607,
			600,
			20201,
			25
		}
	},
	[7001009] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Ruins/Ruins_night_sunny.png",
		NeedDownDatingId = 7001008,
		UnlockLevel = 40,
		Dialog = 1711117130,
		Id = 7001009,
		Level = 9,
		SoulId = 20010007,
		Name = getI18NValue(180007642),
		Describe = getI18NValue(180007641),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10607,
			800,
			20201,
			30
		}
	},
	[7001010] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Carriage/Carriage.png",
		NeedDownDatingId = 7001009,
		UnlockLevel = 43,
		Dialog = 1711112800,
		Id = 7001010,
		Level = 10,
		SoulId = 20010007,
		Name = getI18NValue(180256125),
		Describe = getI18NValue(180256124),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10607,
			800,
			20201,
			30
		}
	},
	[7001011] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_DiningRoom/DiningRoom_day.png",
		NeedDownDatingId = 7001010,
		UnlockLevel = 46,
		Dialog = 1711113000,
		Id = 7001011,
		Level = 11,
		SoulId = 20010007,
		Name = getI18NValue(180256127),
		Describe = getI18NValue(180256126),
		ReturnGiftNum = {
			300,
			700
		},
		Cost = {
			10901,
			20
		},
		Reward = {
			10607,
			1000,
			20201,
			40
		}
	},
	[8001001] = {
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Museum/Museum_night.png",
		UnlockLevel = 2,
		DatingType = 1,
		DatingTypeShow = 1,
		Dialog = 1812110000,
		Id = 8001001,
		Level = 1,
		SoulId = 20010008,
		Name = getI18NValue(180007644),
		Describe = getI18NValue(180007643),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10608,
			100,
			20201,
			6
		}
	},
	[8001002] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Restaurant/Restaurant.png",
		NeedDownDatingId = 8001001,
		UnlockLevel = 5,
		Dialog = 1812120000,
		Id = 8001002,
		Level = 2,
		SoulId = 20010008,
		Name = getI18NValue(180007646),
		Describe = getI18NValue(180007645),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10608,
			100,
			20201,
			6
		}
	},
	[8001003] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Downtown/Downtown_day_sunny.png",
		NeedDownDatingId = 8001002,
		UnlockLevel = 10,
		Dialog = 1812120100,
		Id = 8001003,
		Level = 3,
		SoulId = 20010008,
		Name = getI18NValue(180007648),
		Describe = getI18NValue(180007647),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10608,
			250,
			20201,
			12
		}
	},
	[8001004] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Church/Church_day_sunny.png",
		NeedDownDatingId = 8001003,
		UnlockLevel = 15,
		Dialog = 1110198270,
		Id = 8001004,
		Level = 4,
		SoulId = 20010008,
		Name = getI18NValue(180007650),
		Describe = getI18NValue(180007649),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10608,
			250,
			20201,
			12
		}
	},
	[8001005] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Sea/LoopBg_Seaside.png",
		NeedDownDatingId = 8001004,
		UnlockLevel = 20,
		Dialog = 1110198370,
		Id = 8001005,
		Level = 5,
		SoulId = 20010008,
		Name = getI18NValue(180007652),
		Describe = getI18NValue(180007651),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10608,
			400,
			20201,
			20
		}
	},
	[8001006] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Surburb/Surburb_day_sunny.png",
		NeedDownDatingId = 8001005,
		UnlockLevel = 25,
		Dialog = 1110198470,
		Id = 8001006,
		Level = 6,
		SoulId = 20010008,
		Name = getI18NValue(180007654),
		Describe = getI18NValue(180007653),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10608,
			400,
			20201,
			20
		}
	},
	[8001007] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Sky/Sky_night_sunny_hole.png",
		NeedDownDatingId = 8001006,
		UnlockLevel = 30,
		Dialog = 1711117230,
		Id = 8001007,
		Level = 7,
		SoulId = 20010008,
		Name = getI18NValue(180007656),
		Describe = getI18NValue(180007655),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10608,
			600,
			20201,
			25
		}
	},
	[8001008] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Restaurant/Restaurant_night.png",
		NeedDownDatingId = 8001007,
		UnlockLevel = 35,
		Dialog = 1711117340,
		Id = 8001008,
		Level = 8,
		SoulId = 20010008,
		Name = getI18NValue(180007658),
		Describe = getI18NValue(180007657),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10608,
			600,
			20201,
			25
		}
	},
	[8001009] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Ruins/Ruins_stone_sunny.png",
		NeedDownDatingId = 8001008,
		UnlockLevel = 40,
		Dialog = 1711117440,
		Id = 8001009,
		Level = 9,
		SoulId = 20010008,
		Name = getI18NValue(180007660),
		Describe = getI18NValue(180007659),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10608,
			800,
			20201,
			30
		}
	},
	[8001010] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Balcony/Balcony_night_sunny.png",
		NeedDownDatingId = 8001009,
		UnlockLevel = 43,
		Dialog = 1815131800,
		Id = 8001010,
		Level = 10,
		SoulId = 20010008,
		Name = getI18NValue(180256129),
		Describe = getI18NValue(180256128),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10608,
			800,
			20201,
			30
		}
	},
	[8001011] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_HomePrivateRoom/GirlRoom_day.png",
		NeedDownDatingId = 8001010,
		UnlockLevel = 46,
		Dialog = 1815132000,
		Id = 8001011,
		Level = 11,
		SoulId = 20010008,
		Name = getI18NValue(180256131),
		Describe = getI18NValue(180256130),
		ReturnGiftNum = {
			300,
			700
		},
		Cost = {
			10901,
			20
		},
		Reward = {
			10608,
			1000,
			20201,
			40
		}
	},
	[9001001] = {
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Restaurant/Restaurant_1.png",
		UnlockLevel = 2,
		DatingType = 1,
		DatingTypeShow = 1,
		Dialog = 1910110000,
		Id = 9001001,
		Level = 1,
		SoulId = 20010009,
		Name = getI18NValue(180007662),
		Describe = getI18NValue(180007661),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10609,
			100,
			20201,
			6
		}
	},
	[9001002] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Corridor/Corridor_day.png",
		NeedDownDatingId = 9001001,
		UnlockLevel = 5,
		Dialog = 1910110100,
		Id = 9001002,
		Level = 2,
		SoulId = 20010009,
		Name = getI18NValue(180007664),
		Describe = getI18NValue(180007663),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10609,
			100,
			20201,
			6
		}
	},
	[9001003] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Church/ChurchStage.png",
		NeedDownDatingId = 9001002,
		UnlockLevel = 10,
		Dialog = 1910110200,
		Id = 9001003,
		Level = 3,
		SoulId = 20010009,
		Name = getI18NValue(180007666),
		Describe = getI18NValue(180007665),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10609,
			250,
			20201,
			12
		}
	},
	[9001004] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Balcony/Balcony_day_rainy.png",
		NeedDownDatingId = 9001003,
		UnlockLevel = 15,
		Dialog = 1110196840,
		Id = 9001004,
		Level = 4,
		SoulId = 20010009,
		Name = getI18NValue(180007668),
		Describe = getI18NValue(180007667),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10609,
			250,
			20201,
			12
		}
	},
	[9001005] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Livingroom/LivingRoom_day.png",
		NeedDownDatingId = 9001004,
		UnlockLevel = 20,
		Dialog = 1110196930,
		Id = 9001005,
		Level = 5,
		SoulId = 20010009,
		Name = getI18NValue(180007670),
		Describe = getI18NValue(180007669),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10609,
			400,
			20201,
			20
		}
	},
	[9001006] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_HomePrivateRoom/Library.png",
		NeedDownDatingId = 9001005,
		UnlockLevel = 25,
		Dialog = 1110197020,
		Id = 9001006,
		Level = 6,
		SoulId = 20010009,
		Name = getI18NValue(180007672),
		Describe = getI18NValue(180007671),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10609,
			400,
			20201,
			20
		}
	},
	[9001007] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_SpecialScenes/Cabin.png",
		NeedDownDatingId = 9001006,
		UnlockLevel = 30,
		Dialog = 1711120150,
		Id = 9001007,
		Level = 7,
		SoulId = 20010009,
		Name = getI18NValue(180007674),
		Describe = getI18NValue(180007673),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10609,
			600,
			20201,
			25
		}
	},
	[9001008] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_DiningRoom/DiningRoom_day.png",
		NeedDownDatingId = 9001007,
		UnlockLevel = 35,
		Dialog = 1711120240,
		Id = 9001008,
		Level = 8,
		SoulId = 20010009,
		Name = getI18NValue(180007676),
		Describe = getI18NValue(180007675),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10609,
			600,
			20201,
			25
		}
	},
	[9001009] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Balcony/Balcony_day_sunny.png",
		NeedDownDatingId = 9001008,
		UnlockLevel = 40,
		Dialog = 1711120380,
		Id = 9001009,
		Level = 9,
		SoulId = 20010009,
		Name = getI18NValue(180007678),
		Describe = getI18NValue(180007677),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10609,
			800,
			20201,
			30
		}
	},
	[9001010] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_HomePrivateRoom/PlayerRoom_day.png",
		NeedDownDatingId = 9001009,
		UnlockLevel = 43,
		Dialog = 1910112800,
		Id = 9001010,
		Level = 10,
		SoulId = 20010009,
		Name = getI18NValue(180256133),
		Describe = getI18NValue(180256132),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10609,
			800,
			20201,
			30
		}
	},
	[9001011] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_HomePrivateRoom/GirlRoom_night.png",
		NeedDownDatingId = 9001010,
		UnlockLevel = 46,
		Dialog = 1910113000,
		Id = 9001011,
		Level = 11,
		SoulId = 20010009,
		Name = getI18NValue(180256135),
		Describe = getI18NValue(180256134),
		ReturnGiftNum = {
			300,
			700
		},
		Cost = {
			10901,
			20
		},
		Reward = {
			10609,
			1000,
			20201,
			40
		}
	},
	[10001001] = {
		ImageBg = "/Girl/GirlDatingBackground/GDBG_CenterSquare/CenterSquare_day_sunny.png",
		UnlockLevel = 2,
		DatingType = 1,
		DatingTypeShow = 1,
		Dialog = 201110000,
		Id = 10001001,
		Level = 1,
		SoulId = 20010010,
		Name = getI18NValue(180007680),
		Describe = getI18NValue(180007679),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10610,
			100,
			20201,
			6
		}
	},
	[10001002] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Restaurant/Restaurant.png",
		NeedDownDatingId = 10001001,
		UnlockLevel = 5,
		Dialog = 201110100,
		Id = 10001002,
		Level = 2,
		SoulId = 20010010,
		Name = getI18NValue(180007682),
		Describe = getI18NValue(180007681),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10610,
			100,
			20201,
			6
		}
	},
	[10001003] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Sea/LoopBg_Seaside.png",
		NeedDownDatingId = 10001002,
		UnlockLevel = 10,
		Dialog = 201110200,
		Id = 10001003,
		Level = 3,
		SoulId = 20010010,
		Name = getI18NValue(180007684),
		Describe = getI18NValue(180007683),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10610,
			250,
			20201,
			12
		}
	},
	[10001004] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Lane/Lane.png",
		NeedDownDatingId = 10001003,
		UnlockLevel = 15,
		Dialog = 1110199170,
		Id = 10001004,
		Level = 4,
		SoulId = 20010010,
		Name = getI18NValue(180007686),
		Describe = getI18NValue(180007685),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10610,
			250,
			20201,
			12
		}
	},
	[10001005] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Restaurant/Restaurant_night.png",
		NeedDownDatingId = 10001004,
		UnlockLevel = 20,
		Dialog = 1110199265,
		Id = 10001005,
		Level = 5,
		SoulId = 20010010,
		Name = getI18NValue(180007688),
		Describe = getI18NValue(180007687),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10610,
			400,
			20201,
			20
		}
	},
	[10001006] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Kitchen/Kitchen_day.png",
		NeedDownDatingId = 10001005,
		UnlockLevel = 25,
		Dialog = 1110199370,
		Id = 10001006,
		Level = 6,
		SoulId = 20010010,
		Name = getI18NValue(180007690),
		Describe = getI18NValue(180007689),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10610,
			400,
			20201,
			20
		}
	},
	[10001007] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Surburb/Surburb_day_sunny.png",
		NeedDownDatingId = 10001006,
		UnlockLevel = 30,
		Dialog = 1711118965,
		Id = 10001007,
		Level = 7,
		SoulId = 20010010,
		Name = getI18NValue(180007692),
		Describe = getI18NValue(180007691),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10610,
			600,
			20201,
			25
		}
	},
	[10001008] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Church/Church_night_sunny.png",
		NeedDownDatingId = 10001007,
		UnlockLevel = 35,
		Dialog = 1711119065,
		Id = 10001008,
		Level = 8,
		SoulId = 20010010,
		Name = getI18NValue(180007694),
		Describe = getI18NValue(180007693),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10610,
			600,
			20201,
			25
		}
	},
	[10001009] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Lane/Lane_night_sunny.png",
		NeedDownDatingId = 10001008,
		UnlockLevel = 40,
		Dialog = 1711119160,
		Id = 10001009,
		Level = 9,
		SoulId = 20010010,
		Name = getI18NValue(180007696),
		Describe = getI18NValue(180007695),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10610,
			800,
			20201,
			30
		}
	},
	[10001010] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Garden/Garden_day_sunny.png",
		NeedDownDatingId = 10001009,
		UnlockLevel = 43,
		Dialog = 201130900,
		Id = 10001010,
		Level = 10,
		SoulId = 20010010,
		Name = getI18NValue(180256137),
		Describe = getI18NValue(180256136),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10610,
			800,
			20201,
			30
		}
	},
	[10001011] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Carriage/Carriage.png",
		NeedDownDatingId = 10001010,
		UnlockLevel = 46,
		Dialog = 201131050,
		Id = 10001011,
		Level = 11,
		SoulId = 20010010,
		Name = getI18NValue(180256139),
		Describe = getI18NValue(180256138),
		ReturnGiftNum = {
			300,
			700
		},
		Cost = {
			10901,
			20
		},
		Reward = {
			10610,
			1000,
			20201,
			40
		}
	},
	[11001001] = {
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Theater/Theater_on.png",
		UnlockLevel = 2,
		DatingType = 1,
		DatingTypeShow = 1,
		Dialog = 211110000,
		Id = 11001001,
		Level = 1,
		SoulId = 20010011,
		Name = getI18NValue(180007698),
		Describe = getI18NValue(180007697),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10611,
			100,
			20201,
			6
		}
	},
	[11001002] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Surburb/Surburb_day_sunny.png",
		NeedDownDatingId = 11001001,
		UnlockLevel = 5,
		Dialog = 211110200,
		Id = 11001002,
		Level = 2,
		SoulId = 20010011,
		Name = getI18NValue(180007700),
		Describe = getI18NValue(180007699),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10611,
			100,
			20201,
			6
		}
	},
	[11001003] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_HomePrivateRoom/Alchemy.png",
		NeedDownDatingId = 11001002,
		UnlockLevel = 10,
		Dialog = 211110300,
		Id = 11001003,
		Level = 3,
		SoulId = 20010011,
		Name = getI18NValue(180007702),
		Describe = getI18NValue(180007701),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10611,
			250,
			20201,
			12
		}
	},
	[11001004] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_HomePrivateRoom/Library.png",
		NeedDownDatingId = 11001003,
		UnlockLevel = 15,
		Dialog = 1110199470,
		Id = 11001004,
		Level = 4,
		SoulId = 20010011,
		Name = getI18NValue(180007704),
		Describe = getI18NValue(180007703),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10611,
			250,
			20201,
			12
		}
	},
	[11001005] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_DiningRoom/DiningRoom_day.png",
		NeedDownDatingId = 11001004,
		UnlockLevel = 20,
		Dialog = 1110199540,
		Id = 11001005,
		Level = 5,
		SoulId = 20010011,
		Name = getI18NValue(180007706),
		Describe = getI18NValue(180007705),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10611,
			400,
			20201,
			20
		}
	},
	[11001006] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Garden/Garden_day_sunny.png",
		NeedDownDatingId = 11001005,
		UnlockLevel = 25,
		Dialog = 1110199630,
		Id = 11001006,
		Level = 6,
		SoulId = 20010011,
		Name = getI18NValue(180007708),
		Describe = getI18NValue(180007707),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10611,
			400,
			20201,
			20
		}
	},
	[11001007] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Port/Port_day_sunny.png",
		NeedDownDatingId = 11001006,
		UnlockLevel = 30,
		Dialog = 1711119260,
		Id = 11001007,
		Level = 7,
		SoulId = 20010011,
		Name = getI18NValue(180007710),
		Describe = getI18NValue(180007709),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10611,
			600,
			20201,
			25
		}
	},
	[11001008] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_HomePrivateRoom/Alchemy.png",
		NeedDownDatingId = 11001007,
		UnlockLevel = 35,
		Dialog = 1711119360,
		Id = 11001008,
		Level = 8,
		SoulId = 20010011,
		Name = getI18NValue(180007712),
		Describe = getI18NValue(180007711),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10611,
			600,
			20201,
			25
		}
	},
	[11001009] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BusinessStreet/BusinessStreet_day_sunny.png",
		NeedDownDatingId = 11001008,
		UnlockLevel = 40,
		Dialog = 1711119460,
		Id = 11001009,
		Level = 9,
		SoulId = 20010011,
		Name = getI18NValue(180007714),
		Describe = getI18NValue(180007713),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10611,
			800,
			20201,
			30
		}
	},
	[11001010] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Livingroom/LivingRoom_day.png",
		NeedDownDatingId = 11001009,
		UnlockLevel = 43,
		Dialog = 211130900,
		Id = 11001010,
		Level = 10,
		SoulId = 20010011,
		Name = getI18NValue(180256141),
		Describe = getI18NValue(180256140),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10611,
			800,
			20201,
			30
		}
	},
	[11001011] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_HomePrivateRoom/PlayerRoom_night.png",
		NeedDownDatingId = 11001010,
		UnlockLevel = 46,
		Dialog = 211131000,
		Id = 11001011,
		Level = 11,
		SoulId = 20010011,
		Name = getI18NValue(180256143),
		Describe = getI18NValue(180256142),
		ReturnGiftNum = {
			300,
			700
		},
		Cost = {
			10901,
			20
		},
		Reward = {
			10611,
			1000,
			20201,
			40
		}
	},
	[12001001] = {
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Funroom/Funroom.png",
		UnlockLevel = 2,
		DatingType = 1,
		DatingTypeShow = 1,
		Dialog = 1110000000,
		Id = 12001001,
		Level = 1,
		SoulId = 20010012,
		Name = getI18NValue(180007716),
		Describe = getI18NValue(180007715),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10612,
			100,
			20201,
			6
		}
	},
	[12001002] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Restaurant/Restaurant.png",
		NeedDownDatingId = 12001001,
		UnlockLevel = 5,
		Dialog = 1110000200,
		Id = 12001002,
		Level = 2,
		SoulId = 20010012,
		Name = getI18NValue(180007718),
		Describe = getI18NValue(180007717),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10612,
			100,
			20201,
			6
		}
	},
	[12001003] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Museum/Museum_day.png",
		NeedDownDatingId = 12001002,
		UnlockLevel = 10,
		Dialog = 1110000400,
		Id = 12001003,
		Level = 3,
		SoulId = 20010012,
		Name = getI18NValue(180007720),
		Describe = getI18NValue(180007719),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10612,
			250,
			20201,
			12
		}
	},
	[12001004] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Downtown/Downtown_day_sunny.png",
		NeedDownDatingId = 12001003,
		UnlockLevel = 15,
		Dialog = 1110197715,
		Id = 12001004,
		Level = 4,
		SoulId = 20010012,
		Name = getI18NValue(180007722),
		Describe = getI18NValue(180007721),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10612,
			250,
			20201,
			12
		}
	},
	[12001005] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_CenterSquare/CenterSquare_day_sunny.png",
		NeedDownDatingId = 12001004,
		UnlockLevel = 20,
		Dialog = 1110197790,
		Id = 12001005,
		Level = 5,
		SoulId = 20010012,
		Name = getI18NValue(180007724),
		Describe = getI18NValue(180007723),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10612,
			400,
			20201,
			20
		}
	},
	[12001006] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Balcony/Balcony_night_sunny.png",
		NeedDownDatingId = 12001005,
		UnlockLevel = 25,
		Dialog = 1110197870,
		Id = 12001006,
		Level = 6,
		SoulId = 20010012,
		Name = getI18NValue(180007726),
		Describe = getI18NValue(180007725),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10612,
			400,
			20201,
			20
		}
	},
	[12001007] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Theater/Theater_off.png",
		NeedDownDatingId = 12001006,
		UnlockLevel = 30,
		Dialog = 1711120480,
		Id = 12001007,
		Level = 7,
		SoulId = 20010012,
		Name = getI18NValue(180007728),
		Describe = getI18NValue(180007727),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10612,
			600,
			20201,
			25
		}
	},
	[12001008] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_CenterSquare/CenterSquare_night_sunny.png",
		NeedDownDatingId = 12001007,
		UnlockLevel = 35,
		Dialog = 1711120560,
		Id = 12001008,
		Level = 8,
		SoulId = 20010012,
		Name = getI18NValue(180007730),
		Describe = getI18NValue(180007729),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10612,
			600,
			20201,
			25
		}
	},
	[12001009] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_HomePrivateRoom/PlayerRoom_day.png",
		NeedDownDatingId = 12001008,
		UnlockLevel = 40,
		Dialog = 1711120640,
		Id = 12001009,
		Level = 9,
		SoulId = 20010012,
		Name = getI18NValue(180007732),
		Describe = getI18NValue(180007731),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10612,
			800,
			20201,
			30
		}
	},
	[12001010] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_HomePrivateRoom/PlayerRoom_day.png",
		NeedDownDatingId = 12001009,
		UnlockLevel = 43,
		Dialog = 1110002800,
		Id = 12001010,
		Level = 10,
		SoulId = 20010012,
		Name = getI18NValue(180256145),
		Describe = getI18NValue(180256144),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10612,
			800,
			20201,
			30
		}
	},
	[12001011] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_HomePrivateRoom/PlayerRoom_day.png",
		NeedDownDatingId = 12001010,
		UnlockLevel = 46,
		Dialog = 1110003000,
		Id = 12001011,
		Level = 11,
		SoulId = 20010012,
		Name = getI18NValue(180256147),
		Describe = getI18NValue(180256146),
		ReturnGiftNum = {
			300,
			700
		},
		Cost = {
			10901,
			20
		},
		Reward = {
			10612,
			1000,
			20201,
			40
		}
	},
	[13001001] = {
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Ruins/Ruins_day_sunny.png",
		UnlockLevel = 2,
		DatingType = 1,
		DatingTypeShow = 1,
		Dialog = 1300010000,
		Id = 13001001,
		Level = 1,
		SoulId = 20010013,
		Name = getI18NValue(180007734),
		Describe = getI18NValue(180007733),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10613,
			100,
			20201,
			6
		}
	},
	[13001002] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Restaurant/Restaurant_1.png",
		NeedDownDatingId = 13001001,
		UnlockLevel = 5,
		Dialog = 1300010100,
		Id = 13001002,
		Level = 2,
		SoulId = 20010013,
		Name = getI18NValue(180007736),
		Describe = getI18NValue(180007735),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10613,
			100,
			20201,
			6
		}
	},
	[13001003] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Downtown/Downtown_day_sunny.png",
		NeedDownDatingId = 13001002,
		UnlockLevel = 10,
		Dialog = 1300010200,
		Id = 13001003,
		Level = 3,
		SoulId = 20010013,
		Name = getI18NValue(180007738),
		Describe = getI18NValue(180007737),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10613,
			250,
			20201,
			12
		}
	},
	[13001004] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Port/Port_day_rainy.png",
		NeedDownDatingId = 13001003,
		UnlockLevel = 15,
		Dialog = 1110198875,
		Id = 13001004,
		Level = 4,
		SoulId = 20010013,
		Name = getI18NValue(180007740),
		Describe = getI18NValue(180007739),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10613,
			250,
			20201,
			12
		}
	},
	[13001005] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Theater/Theater_off.png",
		NeedDownDatingId = 13001004,
		UnlockLevel = 20,
		Dialog = 1110198980,
		Id = 13001005,
		Level = 5,
		SoulId = 20010013,
		Name = getI18NValue(180007742),
		Describe = getI18NValue(180007741),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10613,
			400,
			20201,
			20
		}
	},
	[13001006] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BusinessStreet/BusinessStreet_sunset.png",
		NeedDownDatingId = 13001005,
		UnlockLevel = 25,
		Dialog = 1110199070,
		Id = 13001006,
		Level = 6,
		SoulId = 20010013,
		Name = getI18NValue(180007744),
		Describe = getI18NValue(180007743),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10613,
			400,
			20201,
			20
		}
	},
	[13001007] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Livingroom/LivingRoom_night.png",
		NeedDownDatingId = 13001006,
		UnlockLevel = 30,
		Dialog = 1711117550,
		Id = 13001007,
		Level = 7,
		SoulId = 20010013,
		Name = getI18NValue(180007746),
		Describe = getI18NValue(180007745),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10613,
			600,
			20201,
			25
		}
	},
	[13001008] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Fields/Fields_sunny.png",
		NeedDownDatingId = 13001007,
		UnlockLevel = 35,
		Dialog = 1711117650,
		Id = 13001008,
		Level = 8,
		SoulId = 20010013,
		Name = getI18NValue(180007748),
		Describe = getI18NValue(180007747),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10613,
			600,
			20201,
			25
		}
	},
	[13001009] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Ruins/Ruins_night_sunny.png",
		NeedDownDatingId = 13001008,
		UnlockLevel = 40,
		Dialog = 1711117750,
		Id = 13001009,
		Level = 9,
		SoulId = 20010013,
		Name = getI18NValue(180007750),
		Describe = getI18NValue(180007749),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10613,
			800,
			20201,
			30
		}
	},
	[13001010] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_HomePrivateRoom/PlayerRoom_day.png",
		NeedDownDatingId = 13001009,
		UnlockLevel = 43,
		Dialog = 1300111900,
		Id = 13001010,
		Level = 10,
		SoulId = 20010013,
		Name = getI18NValue(180256149),
		Describe = getI18NValue(180256148),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10613,
			800,
			20201,
			30
		}
	},
	[13001011] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Balcony/Balcony_day_sunny.png",
		NeedDownDatingId = 13001010,
		UnlockLevel = 46,
		Dialog = 1300112000,
		Id = 13001011,
		Level = 11,
		SoulId = 20010013,
		Name = getI18NValue(180256151),
		Describe = getI18NValue(180256150),
		ReturnGiftNum = {
			300,
			700
		},
		Cost = {
			10901,
			20
		},
		Reward = {
			10613,
			1000,
			20201,
			40
		}
	},
	[14001001] = {
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Funroom/Funroom.png",
		UnlockLevel = 2,
		DatingType = 1,
		DatingTypeShow = 1,
		Dialog = 1400010000,
		Id = 14001001,
		Level = 1,
		SoulId = 20010014,
		Name = getI18NValue(180007752),
		Describe = getI18NValue(180007751),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10614,
			100,
			20201,
			6
		}
	},
	[14001002] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Restaurant/Restaurant_1.png",
		NeedDownDatingId = 14001001,
		UnlockLevel = 5,
		Dialog = 1400010110,
		Id = 14001002,
		Level = 2,
		SoulId = 20010014,
		Name = getI18NValue(180007754),
		Describe = getI18NValue(180007753),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10614,
			100,
			20201,
			6
		}
	},
	[14001003] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_CenterSquare/CenterSquare_day_sunny.png",
		NeedDownDatingId = 14001002,
		UnlockLevel = 10,
		Dialog = 1400010250,
		Id = 14001003,
		Level = 3,
		SoulId = 20010014,
		Name = getI18NValue(180007756),
		Describe = getI18NValue(180007755),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10614,
			250,
			20201,
			12
		}
	},
	[14001004] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BlackStreet/BlackStreet_night_rainy.png",
		NeedDownDatingId = 14001003,
		UnlockLevel = 15,
		Dialog = 1110199700,
		Id = 14001004,
		Level = 4,
		SoulId = 20010014,
		Name = getI18NValue(180007758),
		Describe = getI18NValue(180007757),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10614,
			250,
			20201,
			12
		}
	},
	[14001005] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Museum/Museum_day.png",
		NeedDownDatingId = 14001004,
		UnlockLevel = 20,
		Dialog = 1110199790,
		Id = 14001005,
		Level = 5,
		SoulId = 20010014,
		Name = getI18NValue(180007760),
		Describe = getI18NValue(180007759),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10614,
			400,
			20201,
			20
		}
	},
	[14001006] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_CenterSquare/CenterSquare_night_sunny.png",
		NeedDownDatingId = 14001005,
		UnlockLevel = 25,
		Dialog = 1110199870,
		Id = 14001006,
		Level = 6,
		SoulId = 20010014,
		Name = getI18NValue(180007762),
		Describe = getI18NValue(180007761),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10614,
			400,
			20201,
			20
		}
	},
	[14001007] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BusinessStreet/BusinessStreet_day_sunny.png",
		NeedDownDatingId = 14001006,
		UnlockLevel = 30,
		Dialog = 1711119540,
		Id = 14001007,
		Level = 7,
		SoulId = 20010014,
		Name = getI18NValue(180007764),
		Describe = getI18NValue(180007763),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10614,
			600,
			20201,
			25
		}
	},
	[14001008] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Theater/Theater_on.png",
		NeedDownDatingId = 14001007,
		UnlockLevel = 35,
		Dialog = 1711119640,
		Id = 14001008,
		Level = 8,
		SoulId = 20010014,
		Name = getI18NValue(180007766),
		Describe = getI18NValue(180007765),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10614,
			600,
			20201,
			25
		}
	},
	[14001009] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Sea/LoopBg_Seaside.png",
		NeedDownDatingId = 14001008,
		UnlockLevel = 40,
		Dialog = 1711119730,
		Id = 14001009,
		Level = 9,
		SoulId = 20010014,
		Name = getI18NValue(180007768),
		Describe = getI18NValue(180007767),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10614,
			800,
			20201,
			30
		}
	},
	[14001010] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_HomePrivateRoom/PlayerRoom_day.png",
		NeedDownDatingId = 14001009,
		UnlockLevel = 43,
		Dialog = 1400111900,
		Id = 14001010,
		Level = 10,
		SoulId = 20010014,
		Name = getI18NValue(180256153),
		Describe = getI18NValue(180256152),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10614,
			800,
			20201,
			30
		}
	},
	[14001011] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Balcony/Balcony_day_sunny.png",
		NeedDownDatingId = 14001010,
		UnlockLevel = 46,
		Dialog = 1400112050,
		Id = 14001011,
		Level = 11,
		SoulId = 20010014,
		Name = getI18NValue(180256155),
		Describe = getI18NValue(180256154),
		ReturnGiftNum = {
			300,
			700
		},
		Cost = {
			10901,
			20
		},
		Reward = {
			10614,
			1000,
			20201,
			40
		}
	},
	[15001001] = {
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Church/Church_day_sunny.png",
		UnlockLevel = 2,
		DatingType = 1,
		DatingTypeShow = 1,
		Dialog = 1500112200,
		Id = 15001001,
		Level = 1,
		SoulId = 20010015,
		Name = getI18NValue(180007770),
		Describe = getI18NValue(180007769),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10615,
			100,
			20201,
			6
		}
	},
	[15001002] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BusinessStreet/BusinessStreet_day_sunny.png",
		NeedDownDatingId = 15001001,
		UnlockLevel = 5,
		Dialog = 1500112320,
		Id = 15001002,
		Level = 2,
		SoulId = 20010015,
		Name = getI18NValue(180007772),
		Describe = getI18NValue(180007771),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10615,
			100,
			20201,
			6
		}
	},
	[15001003] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Restaurant/Restaurant_1.png",
		NeedDownDatingId = 15001002,
		UnlockLevel = 10,
		Dialog = 1500112420,
		Id = 15001003,
		Level = 3,
		SoulId = 20010015,
		Name = getI18NValue(180007774),
		Describe = getI18NValue(180007773),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10615,
			250,
			20201,
			12
		}
	},
	[15001004] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_CenterSquare/CenterSquare_day_sunny.png",
		NeedDownDatingId = 15001003,
		UnlockLevel = 15,
		Dialog = 1711120750,
		Id = 15001004,
		Level = 4,
		SoulId = 20010015,
		Name = getI18NValue(180007776),
		Describe = getI18NValue(180007775),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10615,
			250,
			20201,
			12
		}
	},
	[15001005] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Funroom/Funroom.png",
		NeedDownDatingId = 15001004,
		UnlockLevel = 20,
		Dialog = 1711120843,
		Id = 15001005,
		Level = 5,
		SoulId = 20010015,
		Name = getI18NValue(180007778),
		Describe = getI18NValue(180007777),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10615,
			400,
			20201,
			20
		}
	},
	[15001006] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Fields/Fields_sunny.png",
		NeedDownDatingId = 15001005,
		UnlockLevel = 25,
		Dialog = 1711120931,
		Id = 15001006,
		Level = 6,
		SoulId = 20010015,
		Name = getI18NValue(180007780),
		Describe = getI18NValue(180007779),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10615,
			400,
			20201,
			20
		}
	},
	[15001007] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_DiningRoom/DiningRoom_night.png",
		NeedDownDatingId = 15001006,
		UnlockLevel = 30,
		Dialog = 1711121050,
		Id = 15001007,
		Level = 7,
		SoulId = 20010015,
		Name = getI18NValue(180136268),
		Describe = getI18NValue(180136267),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10615,
			600,
			20201,
			25
		}
	},
	[15001008] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_SpecialScenes/Cabin.png",
		NeedDownDatingId = 15001007,
		UnlockLevel = 35,
		Dialog = 1711121200,
		Id = 15001008,
		Level = 8,
		SoulId = 20010015,
		Name = getI18NValue(180136270),
		Describe = getI18NValue(180136269),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10615,
			600,
			20201,
			25
		}
	},
	[15001009] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BlackStreet/BlackStreet_day_sunny.png",
		NeedDownDatingId = 15001008,
		UnlockLevel = 40,
		Dialog = 1711121350,
		Id = 15001009,
		Level = 9,
		SoulId = 20010015,
		Name = getI18NValue(180136272),
		Describe = getI18NValue(180136271),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10615,
			800,
			20201,
			30
		}
	},
	[15001010] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Balcony/Balcony_day_sunny.png",
		NeedDownDatingId = 15001009,
		UnlockLevel = 43,
		Dialog = 1500111900,
		Id = 15001010,
		Level = 10,
		SoulId = 20010015,
		Name = getI18NValue(180256157),
		Describe = getI18NValue(180256156),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10615,
			800,
			20201,
			30
		}
	},
	[15001011] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BlackStreet/BlackStreet_day_sunny.png",
		NeedDownDatingId = 15001010,
		UnlockLevel = 46,
		Dialog = 1500112050,
		Id = 15001011,
		Level = 11,
		SoulId = 20010015,
		Name = getI18NValue(180256159),
		Describe = getI18NValue(180256158),
		ReturnGiftNum = {
			300,
			700
		},
		Cost = {
			10901,
			20
		},
		Reward = {
			10615,
			1000,
			20201,
			40
		}
	},
	[16001001] = {
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BusinessStreet/BusinessStreet_day_sunny.png",
		UnlockLevel = 2,
		DatingType = 1,
		DatingTypeShow = 1,
		Dialog = 1611511600,
		Id = 16001001,
		Level = 1,
		SoulId = 20010016,
		Name = getI18NValue(180007782),
		Describe = getI18NValue(180007781),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10616,
			100,
			20201,
			6
		}
	},
	[16001002] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Lane/Lane.png",
		NeedDownDatingId = 16001001,
		UnlockLevel = 5,
		Dialog = 1611511700,
		Id = 16001002,
		Level = 2,
		SoulId = 20010016,
		Name = getI18NValue(180007784),
		Describe = getI18NValue(180007783),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10616,
			100,
			20201,
			6
		}
	},
	[16001003] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Fields/Fields_sunny.png",
		NeedDownDatingId = 16001002,
		UnlockLevel = 10,
		Dialog = 1611511800,
		Id = 16001003,
		Level = 3,
		SoulId = 20010016,
		Name = getI18NValue(180007786),
		Describe = getI18NValue(180007785),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10616,
			250,
			20201,
			12
		}
	},
	[16001004] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Carriage/Sea-Carriage.png",
		NeedDownDatingId = 16001003,
		UnlockLevel = 15,
		Dialog = 1611511900,
		Id = 16001004,
		Level = 4,
		SoulId = 20010016,
		Name = getI18NValue(180136274),
		Describe = getI18NValue(180136273),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10616,
			250,
			20201,
			12
		}
	},
	[16001005] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Surburb/Surburb_day_sunny.png",
		NeedDownDatingId = 16001004,
		UnlockLevel = 20,
		Dialog = 1611512000,
		Id = 16001005,
		Level = 5,
		SoulId = 20010016,
		Name = getI18NValue(180136276),
		Describe = getI18NValue(180136275),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10616,
			400,
			20201,
			20
		}
	},
	[16001006] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Balcony/Balcony_day_sunny.png",
		NeedDownDatingId = 16001005,
		UnlockLevel = 25,
		Dialog = 1611512150,
		Id = 16001006,
		Level = 6,
		SoulId = 20010016,
		Name = getI18NValue(180136278),
		Describe = getI18NValue(180136277),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10616,
			400,
			20201,
			20
		}
	},
	[16001007] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Ruins/Cavern_Centralpart_1.png",
		NeedDownDatingId = 16001006,
		UnlockLevel = 30,
		Dialog = 1611512300,
		Id = 16001007,
		Level = 7,
		SoulId = 20010016,
		Name = getI18NValue(180144604),
		Describe = getI18NValue(180144603),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10616,
			600,
			20201,
			25
		}
	},
	[16001008] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Sea/LoopBg_Seaside.png",
		NeedDownDatingId = 16001007,
		UnlockLevel = 35,
		Dialog = 1611512450,
		Id = 16001008,
		Level = 8,
		SoulId = 20010016,
		Name = getI18NValue(180144606),
		Describe = getI18NValue(180144605),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10616,
			600,
			20201,
			25
		}
	},
	[16001009] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BusinessStreet/BusinessStreet_day_sunny.png",
		NeedDownDatingId = 16001008,
		UnlockLevel = 40,
		Dialog = 1611512550,
		Id = 16001009,
		Level = 9,
		SoulId = 20010016,
		Name = getI18NValue(180144608),
		Describe = getI18NValue(180144607),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10616,
			800,
			20201,
			30
		}
	},
	[16001010] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Surburb/Surburb_day_sunny.png",
		NeedDownDatingId = 16001009,
		UnlockLevel = 43,
		Dialog = 1611512700,
		Id = 16001010,
		Level = 10,
		SoulId = 20010016,
		Name = getI18NValue(180256161),
		Describe = getI18NValue(180256160),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10616,
			800,
			20201,
			30
		}
	},
	[16001011] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Surburb/Surburb_day_sunny.png",
		NeedDownDatingId = 16001010,
		UnlockLevel = 46,
		Dialog = 1611512850,
		Id = 16001011,
		Level = 11,
		SoulId = 20010016,
		Name = getI18NValue(180256163),
		Describe = getI18NValue(180256162),
		ReturnGiftNum = {
			300,
			700
		},
		Cost = {
			10901,
			20
		},
		Reward = {
			10616,
			1000,
			20201,
			40
		}
	},
	[17001001] = {
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Restaurant/Restaurant_1.png",
		UnlockLevel = 2,
		DatingType = 1,
		DatingTypeShow = 1,
		Dialog = 1110193770,
		Id = 17001001,
		Level = 1,
		SoulId = 20010017,
		Name = getI18NValue(180007788),
		Describe = getI18NValue(180007787),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10617,
			100,
			20201,
			6
		}
	},
	[17001002] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Museum/Museum_day.png",
		NeedDownDatingId = 17001001,
		UnlockLevel = 5,
		Dialog = 1110193890,
		Id = 17001002,
		Level = 2,
		SoulId = 20010017,
		Name = getI18NValue(180007790),
		Describe = getI18NValue(180007789),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10617,
			100,
			20201,
			6
		}
	},
	[17001003] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Theater/Theater_on.png",
		NeedDownDatingId = 17001002,
		UnlockLevel = 10,
		Dialog = 1110193990,
		Id = 17001003,
		Level = 3,
		SoulId = 20010017,
		Name = getI18NValue(180007792),
		Describe = getI18NValue(180007791),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10617,
			250,
			20201,
			12
		}
	},
	[17001004] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BusinessStreet/ClothingShop.png",
		NeedDownDatingId = 17001003,
		UnlockLevel = 15,
		Dialog = 1110194100,
		Id = 17001004,
		Level = 4,
		SoulId = 20010017,
		Name = getI18NValue(180007794),
		Describe = getI18NValue(180007793),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10617,
			250,
			20201,
			12
		}
	},
	[17001005] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Sea/LoopBg_Seaside.png",
		NeedDownDatingId = 17001004,
		UnlockLevel = 20,
		Dialog = 1110194200,
		Id = 17001005,
		Level = 5,
		SoulId = 20010017,
		Name = getI18NValue(180007796),
		Describe = getI18NValue(180007795),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10617,
			400,
			20201,
			20
		}
	},
	[17001006] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Fields/Fields_sunny.png",
		NeedDownDatingId = 17001005,
		UnlockLevel = 25,
		Dialog = 1110194300,
		Id = 17001006,
		Level = 6,
		SoulId = 20010017,
		Name = getI18NValue(180007798),
		Describe = getI18NValue(180007797),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10617,
			400,
			20201,
			20
		}
	},
	[17001007] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Port/Port_day_sunny.png",
		NeedDownDatingId = 17001006,
		UnlockLevel = 30,
		Dialog = 1711115350,
		Id = 17001007,
		Level = 7,
		SoulId = 20010017,
		Name = getI18NValue(180007800),
		Describe = getI18NValue(180007799),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10617,
			600,
			20201,
			25
		}
	},
	[17001008] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_HomePrivateRoom/GirlRoom_day.png",
		NeedDownDatingId = 17001007,
		UnlockLevel = 35,
		Dialog = 1711115450,
		Id = 17001008,
		Level = 8,
		SoulId = 20010017,
		Name = getI18NValue(180007802),
		Describe = getI18NValue(180007801),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10617,
			600,
			20201,
			25
		}
	},
	[17001009] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BusinessStreet/BusinessStreet_night_sunny.png",
		NeedDownDatingId = 17001008,
		UnlockLevel = 40,
		Dialog = 1711115550,
		Id = 17001009,
		Level = 9,
		SoulId = 20010017,
		Name = getI18NValue(180007804),
		Describe = getI18NValue(180007803),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10617,
			800,
			20201,
			30
		}
	},
	[17001010] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Surburb/Surburb_night_sunny.png",
		NeedDownDatingId = 17001009,
		UnlockLevel = 43,
		Dialog = 1711121500,
		Id = 17001010,
		Level = 10,
		SoulId = 20010017,
		Name = getI18NValue(180256165),
		Describe = getI18NValue(180256164),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10617,
			800,
			20201,
			30
		}
	},
	[17001011] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_HomePrivateRoom/Library.png",
		NeedDownDatingId = 17001010,
		UnlockLevel = 46,
		Dialog = 1711121700,
		Id = 17001011,
		Level = 11,
		SoulId = 20010017,
		Name = getI18NValue(180256167),
		Describe = getI18NValue(180256166),
		ReturnGiftNum = {
			300,
			700
		},
		Cost = {
			10901,
			20
		},
		Reward = {
			10617,
			1000,
			20201,
			40
		}
	},
	[18001001] = {
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Church/Church_day_sunny.png",
		UnlockLevel = 2,
		DatingType = 1,
		DatingTypeShow = 1,
		Dialog = 1800010000,
		Id = 18001001,
		Level = 1,
		SoulId = 20010018,
		Name = getI18NValue(180007806),
		Describe = getI18NValue(180007805),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10618,
			100,
			20201,
			6
		}
	},
	[18001002] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Restaurant/Restaurant_1.png",
		NeedDownDatingId = 18001001,
		UnlockLevel = 5,
		Dialog = 1800010200,
		Id = 18001002,
		Level = 2,
		SoulId = 20010018,
		Name = getI18NValue(180007808),
		Describe = getI18NValue(180007807),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10618,
			100,
			20201,
			6
		}
	},
	[18001003] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BlackStreet/BlackStreet_day_sunny.png",
		NeedDownDatingId = 18001002,
		UnlockLevel = 10,
		Dialog = 1800010400,
		Id = 18001003,
		Level = 3,
		SoulId = 20010018,
		Name = getI18NValue(180007810),
		Describe = getI18NValue(180007809),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10618,
			250,
			20201,
			12
		}
	},
	[18001004] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Funroom/Funroom.png",
		NeedDownDatingId = 18001003,
		UnlockLevel = 15,
		Dialog = 1110196520,
		Id = 18001004,
		Level = 4,
		SoulId = 20010018,
		Name = getI18NValue(180007812),
		Describe = getI18NValue(180007811),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10618,
			250,
			20201,
			12
		}
	},
	[18001005] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_CenterSquare/CenterSquare_night_sunny.png",
		NeedDownDatingId = 18001004,
		UnlockLevel = 20,
		Dialog = 1110196630,
		Id = 18001005,
		Level = 5,
		SoulId = 20010018,
		Name = getI18NValue(180007814),
		Describe = getI18NValue(180007813),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10618,
			400,
			20201,
			20
		}
	},
	[18001006] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Port/Port_day_sunny.png",
		NeedDownDatingId = 18001005,
		UnlockLevel = 25,
		Dialog = 1110196730,
		Id = 18001006,
		Level = 6,
		SoulId = 20010018,
		Name = getI18NValue(180007816),
		Describe = getI18NValue(180007815),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10618,
			400,
			20201,
			20
		}
	},
	[18001007] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Surburb/Surburb_day_sunny.png",
		NeedDownDatingId = 18001006,
		UnlockLevel = 30,
		Dialog = 1711115000,
		Id = 18001007,
		Level = 7,
		SoulId = 20010018,
		Name = getI18NValue(180007818),
		Describe = getI18NValue(180007817),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10618,
			600,
			20201,
			25
		}
	},
	[18001008] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_HomePrivateRoom/PlayerRoom_day.png",
		NeedDownDatingId = 18001007,
		UnlockLevel = 35,
		Dialog = 1711115150,
		Id = 18001008,
		Level = 8,
		SoulId = 20010018,
		Name = getI18NValue(180007820),
		Describe = getI18NValue(180007819),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10618,
			600,
			20201,
			25
		}
	},
	[18001009] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Theater/Theater_on.png",
		NeedDownDatingId = 18001008,
		UnlockLevel = 40,
		Dialog = 1711115250,
		Id = 18001009,
		Level = 9,
		SoulId = 20010018,
		Name = getI18NValue(180007822),
		Describe = getI18NValue(180007821),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10618,
			800,
			20201,
			30
		}
	},
	[18001010] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Surburb/Surburb_night_sunny.png",
		NeedDownDatingId = 18001009,
		UnlockLevel = 43,
		Dialog = 1711122250,
		Id = 18001010,
		Level = 10,
		SoulId = 20010018,
		Name = getI18NValue(180256169),
		Describe = getI18NValue(180256168),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10618,
			800,
			20201,
			30
		}
	},
	[18001011] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_DiningRoom/DiningRoom_day.png",
		NeedDownDatingId = 18001010,
		UnlockLevel = 46,
		Dialog = 1711122350,
		Id = 18001011,
		Level = 11,
		SoulId = 20010018,
		Name = getI18NValue(180256171),
		Describe = getI18NValue(180256170),
		ReturnGiftNum = {
			300,
			700
		},
		Cost = {
			10901,
			20
		},
		Reward = {
			10618,
			1000,
			20201,
			40
		}
	},
	[19001001] = {
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BusinessStreet/BusinessStreet_day_sunny.png",
		UnlockLevel = 2,
		DatingType = 1,
		DatingTypeShow = 1,
		Dialog = 1110193210,
		Id = 19001001,
		Level = 1,
		SoulId = 20010019,
		Name = getI18NValue(180007824),
		Describe = getI18NValue(180007823),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10619,
			100,
			20201,
			6
		}
	},
	[19001002] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_HomePrivateRoom/Library.png",
		NeedDownDatingId = 19001001,
		UnlockLevel = 5,
		Dialog = 1110193300,
		Id = 19001002,
		Level = 2,
		SoulId = 20010019,
		Name = getI18NValue(180007826),
		Describe = getI18NValue(180007825),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10619,
			100,
			20201,
			6
		}
	},
	[19001003] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Sea/LoopBg_Seaside.png",
		NeedDownDatingId = 19001002,
		UnlockLevel = 10,
		Dialog = 1110193380,
		Id = 19001003,
		Level = 3,
		SoulId = 20010019,
		Name = getI18NValue(180007828),
		Describe = getI18NValue(180007827),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10619,
			250,
			20201,
			12
		}
	},
	[19001004] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BusinessStreet/BusinessStreet_day_rainy.png",
		NeedDownDatingId = 19001003,
		UnlockLevel = 15,
		Dialog = 1110196070,
		Id = 19001004,
		Level = 4,
		SoulId = 20010019,
		Name = getI18NValue(180007830),
		Describe = getI18NValue(180007829),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10619,
			250,
			20201,
			12
		}
	},
	[19001005] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_SpecialScenes/Common_Battle_01.png",
		NeedDownDatingId = 19001004,
		UnlockLevel = 20,
		Dialog = 1110196170,
		Id = 19001005,
		Level = 5,
		SoulId = 20010019,
		Name = getI18NValue(180007832),
		Describe = getI18NValue(180007831),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10619,
			400,
			20201,
			20
		}
	},
	[19001006] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Livingroom/LivingRoom_day.png",
		NeedDownDatingId = 19001005,
		UnlockLevel = 25,
		Dialog = 1110196290,
		Id = 19001006,
		Level = 6,
		SoulId = 20010019,
		Name = getI18NValue(180007834),
		Describe = getI18NValue(180007833),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10619,
			400,
			20201,
			20
		}
	},
	[19001007] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Uptown/Uptown_day_sunny.png",
		NeedDownDatingId = 19001006,
		UnlockLevel = 30,
		Dialog = 1711115660,
		Id = 19001007,
		Level = 7,
		SoulId = 20010019,
		Name = getI18NValue(180007836),
		Describe = getI18NValue(180007835),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10619,
			600,
			20201,
			25
		}
	},
	[19001008] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BlackStreet/BlackStreet_night_sunny.png",
		NeedDownDatingId = 19001007,
		UnlockLevel = 35,
		Dialog = 1711115780,
		Id = 19001008,
		Level = 8,
		SoulId = 20010019,
		Name = getI18NValue(180007838),
		Describe = getI18NValue(180007837),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10619,
			600,
			20201,
			25
		}
	},
	[19001009] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_DiningRoom/DiningRoom_day.png",
		NeedDownDatingId = 19001008,
		UnlockLevel = 40,
		Dialog = 1711115890,
		Id = 19001009,
		Level = 9,
		SoulId = 20010019,
		Name = getI18NValue(180007840),
		Describe = getI18NValue(180007839),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10619,
			800,
			20201,
			30
		}
	},
	[19001010] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_DiningRoom/DiningRoom_day.png",
		NeedDownDatingId = 19001009,
		UnlockLevel = 43,
		Dialog = 1931200200,
		Id = 19001010,
		Level = 10,
		SoulId = 20010019,
		Name = getI18NValue(180256173),
		Describe = getI18NValue(180256172),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10619,
			800,
			20201,
			30
		}
	},
	[19001011] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_DiningRoom/DiningRoom_day.png",
		NeedDownDatingId = 19001010,
		UnlockLevel = 46,
		Dialog = 1931200350,
		Id = 19001011,
		Level = 11,
		SoulId = 20010019,
		Name = getI18NValue(180256175),
		Describe = getI18NValue(180256174),
		ReturnGiftNum = {
			300,
			700
		},
		Cost = {
			10901,
			20
		},
		Reward = {
			10619,
			1000,
			20201,
			40
		}
	},
	[20001001] = {
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Restaurant/Restaurant_night.png",
		UnlockLevel = 2,
		DatingType = 1,
		DatingTypeShow = 1,
		Dialog = 1110195760,
		Id = 20001001,
		Level = 1,
		SoulId = 20010020,
		Name = getI18NValue(180007842),
		Describe = getI18NValue(180007841),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10620,
			100,
			20201,
			6
		}
	},
	[20001002] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_CenterSquare/CenterSquare_day_sunny.png",
		NeedDownDatingId = 20001001,
		UnlockLevel = 5,
		Dialog = 1110195860,
		Id = 20001002,
		Level = 2,
		SoulId = 20010020,
		Name = getI18NValue(180007844),
		Describe = getI18NValue(180007843),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10620,
			100,
			20201,
			6
		}
	},
	[20001003] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_HomePrivateRoom/Library.png",
		NeedDownDatingId = 20001002,
		UnlockLevel = 10,
		Dialog = 1110195970,
		Id = 20001003,
		Level = 3,
		SoulId = 20010020,
		Name = getI18NValue(180007846),
		Describe = getI18NValue(180007845),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10620,
			250,
			20201,
			12
		}
	},
	[20001004] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Restaurant/Restaurant_1.png",
		NeedDownDatingId = 20001003,
		UnlockLevel = 15,
		Dialog = 1110197400,
		Id = 20001004,
		Level = 4,
		SoulId = 20010020,
		Name = getI18NValue(180007848),
		Describe = getI18NValue(180007847),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10620,
			250,
			20201,
			12
		}
	},
	[20001005] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BlackStreet/BlackStreet_day_rainy.png",
		NeedDownDatingId = 20001004,
		UnlockLevel = 20,
		Dialog = 1110197510,
		Id = 20001005,
		Level = 5,
		SoulId = 20010020,
		Name = getI18NValue(180007850),
		Describe = getI18NValue(180007849),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10620,
			400,
			20201,
			20
		}
	},
	[20001006] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Ruins/Ruins_day_sunny.png",
		NeedDownDatingId = 20001005,
		UnlockLevel = 25,
		Dialog = 1110197610,
		Id = 20001006,
		Level = 6,
		SoulId = 20010020,
		Name = getI18NValue(180007852),
		Describe = getI18NValue(180007851),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10620,
			400,
			20201,
			20
		}
	},
	[20001007] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Port/Port_day_sunny.png",
		NeedDownDatingId = 20001006,
		UnlockLevel = 30,
		Dialog = 1711116000,
		Id = 20001007,
		Level = 7,
		SoulId = 20010020,
		Name = getI18NValue(180007854),
		Describe = getI18NValue(180007853),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10620,
			600,
			20201,
			25
		}
	},
	[20001008] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BusinessStreet/BusinessStreet_day_sunny.png",
		NeedDownDatingId = 20001007,
		UnlockLevel = 35,
		Dialog = 1711116100,
		Id = 20001008,
		Level = 8,
		SoulId = 20010020,
		Name = getI18NValue(180007856),
		Describe = getI18NValue(180007855),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10620,
			600,
			20201,
			25
		}
	},
	[20001009] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Church/InChurch.png",
		NeedDownDatingId = 20001008,
		UnlockLevel = 40,
		Dialog = 1711116200,
		Id = 20001009,
		Level = 9,
		SoulId = 20010020,
		Name = getI18NValue(180007858),
		Describe = getI18NValue(180007857),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10620,
			800,
			20201,
			30
		}
	},
	[20001010] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_HomePrivateRoom/GirlRoom_day.png",
		NeedDownDatingId = 20001009,
		UnlockLevel = 43,
		Dialog = 1711121850,
		Id = 20001010,
		Level = 10,
		SoulId = 20010020,
		Name = getI18NValue(180256177),
		Describe = getI18NValue(180256176),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10620,
			800,
			20201,
			30
		}
	},
	[20001011] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Sea/Sealevel.png",
		NeedDownDatingId = 20001010,
		UnlockLevel = 46,
		Dialog = 1711122100,
		Id = 20001011,
		Level = 11,
		SoulId = 20010020,
		Name = getI18NValue(180256179),
		Describe = getI18NValue(180256178),
		ReturnGiftNum = {
			300,
			700
		},
		Cost = {
			10901,
			20
		},
		Reward = {
			10620,
			1000,
			20201,
			40
		}
	},
	[21001001] = {
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Restaurant/Diner.png",
		UnlockLevel = 2,
		DatingType = 1,
		DatingTypeShow = 1,
		Dialog = 311101300,
		Id = 21001001,
		Level = 1,
		SoulId = 20010021,
		Name = getI18NValue(180007860),
		Describe = getI18NValue(180007859),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10621,
			100,
			20201,
			6
		}
	},
	[21001002] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BusinessStreet/BusinessStreet_day_sunny.png",
		NeedDownDatingId = 21001001,
		UnlockLevel = 5,
		Dialog = 311101400,
		Id = 21001002,
		Level = 2,
		SoulId = 20010021,
		Name = getI18NValue(180007862),
		Describe = getI18NValue(180007861),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10621,
			100,
			20201,
			6
		}
	},
	[21001003] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BlackStreet/BlackStreet_day_sunny.png",
		NeedDownDatingId = 21001002,
		UnlockLevel = 10,
		Dialog = 311101500,
		Id = 21001003,
		Level = 3,
		SoulId = 20010021,
		Name = getI18NValue(180007864),
		Describe = getI18NValue(180007863),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10621,
			250,
			20201,
			12
		}
	},
	[21001004] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Museum/Museum_day.png",
		NeedDownDatingId = 21001003,
		UnlockLevel = 15,
		Dialog = 1110197960,
		Id = 21001004,
		Level = 4,
		SoulId = 20010021,
		Name = getI18NValue(180007866),
		Describe = getI18NValue(180007865),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10621,
			250,
			20201,
			12
		}
	},
	[21001005] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_HomePrivateRoom/Library.png",
		NeedDownDatingId = 21001004,
		UnlockLevel = 20,
		Dialog = 1110198060,
		Id = 21001005,
		Level = 5,
		SoulId = 20010021,
		Name = getI18NValue(180007868),
		Describe = getI18NValue(180007867),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10621,
			400,
			20201,
			20
		}
	},
	[21001006] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Port/Port_day_sunny.png",
		NeedDownDatingId = 21001005,
		UnlockLevel = 25,
		Dialog = 1110198160,
		Id = 21001006,
		Level = 6,
		SoulId = 20010021,
		Name = getI18NValue(180007870),
		Describe = getI18NValue(180007869),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10621,
			400,
			20201,
			20
		}
	},
	[21001007] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Church/InChurch.png",
		NeedDownDatingId = 21001006,
		UnlockLevel = 30,
		Dialog = 1711116300,
		Id = 21001007,
		Level = 7,
		SoulId = 20010021,
		Name = getI18NValue(180007872),
		Describe = getI18NValue(180007871),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10621,
			600,
			20201,
			25
		}
	},
	[21001008] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BlackStreet/BlackStreet_night_sunny.png",
		NeedDownDatingId = 21001007,
		UnlockLevel = 35,
		Dialog = 1711116400,
		Id = 21001008,
		Level = 8,
		SoulId = 20010021,
		Name = getI18NValue(180007874),
		Describe = getI18NValue(180007873),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10621,
			600,
			20201,
			25
		}
	},
	[21001009] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Villa/Villa.png",
		NeedDownDatingId = 21001008,
		UnlockLevel = 40,
		Dialog = 1711116500,
		Id = 21001009,
		Level = 9,
		SoulId = 20010021,
		Name = getI18NValue(180007876),
		Describe = getI18NValue(180007875),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10621,
			800,
			20201,
			30
		}
	},
	[21001010] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BusinessStreet/BusinessStreet_day_sunny.png",
		NeedDownDatingId = 21001009,
		UnlockLevel = 43,
		Dialog = 311101800,
		Id = 21001010,
		Level = 10,
		SoulId = 20010021,
		Name = getI18NValue(180256181),
		Describe = getI18NValue(180256180),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10621,
			800,
			20201,
			30
		}
	},
	[21001011] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Surburb/Surburb_day_rainy.png",
		NeedDownDatingId = 21001010,
		UnlockLevel = 46,
		Dialog = 311101950,
		Id = 21001011,
		Level = 11,
		SoulId = 20010021,
		Name = getI18NValue(180256183),
		Describe = getI18NValue(180256182),
		ReturnGiftNum = {
			300,
			700
		},
		Cost = {
			10901,
			20
		},
		Reward = {
			10621,
			1000,
			20201,
			40
		}
	},
	[22001001] = {
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Restaurant/Restaurant_1.png",
		UnlockLevel = 2,
		DatingType = 1,
		DatingTypeShow = 1,
		Dialog = 1110193470,
		Id = 22001001,
		Level = 1,
		SoulId = 20010022,
		Name = getI18NValue(180007878),
		Describe = getI18NValue(180007877),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10622,
			100,
			20201,
			6
		}
	},
	[22001002] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Fields/Fields_sunny.png",
		NeedDownDatingId = 22001001,
		UnlockLevel = 5,
		Dialog = 1110193570,
		Id = 22001002,
		Level = 2,
		SoulId = 20010022,
		Name = getI18NValue(180007880),
		Describe = getI18NValue(180007879),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10622,
			100,
			20201,
			6
		}
	},
	[22001003] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Carriage/Carriage.png",
		NeedDownDatingId = 22001002,
		UnlockLevel = 10,
		Dialog = 1110193670,
		Id = 22001003,
		Level = 3,
		SoulId = 20010022,
		Name = getI18NValue(180007882),
		Describe = getI18NValue(180007881),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10622,
			250,
			20201,
			12
		}
	},
	[22001004] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Carriage/Sea-Carriage.png",
		NeedDownDatingId = 22001003,
		UnlockLevel = 15,
		Dialog = 1110197100,
		Id = 22001004,
		Level = 4,
		SoulId = 20010022,
		Name = getI18NValue(180007884),
		Describe = getI18NValue(180007883),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10622,
			250,
			20201,
			12
		}
	},
	[22001005] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Funroom/Funroom.png",
		NeedDownDatingId = 22001004,
		UnlockLevel = 20,
		Dialog = 1110197200,
		Id = 22001005,
		Level = 5,
		SoulId = 20010022,
		Name = getI18NValue(180007886),
		Describe = getI18NValue(180007885),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10622,
			400,
			20201,
			20
		}
	},
	[22001006] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_HomePrivateRoom/GirlRoom_day.png",
		NeedDownDatingId = 22001005,
		UnlockLevel = 25,
		Dialog = 1110197300,
		Id = 22001006,
		Level = 6,
		SoulId = 20010022,
		Name = getI18NValue(180007888),
		Describe = getI18NValue(180007887),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10622,
			400,
			20201,
			20
		}
	},
	[22001007] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BusinessStreet/ClothingShop.png",
		NeedDownDatingId = 22001006,
		UnlockLevel = 30,
		Dialog = 1711116600,
		Id = 22001007,
		Level = 7,
		SoulId = 20010022,
		Name = getI18NValue(180007890),
		Describe = getI18NValue(180007889),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10622,
			600,
			20201,
			25
		}
	},
	[22001008] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Balcony/Balcony_day_sunny.png",
		NeedDownDatingId = 22001007,
		UnlockLevel = 35,
		Dialog = 1711116700,
		Id = 22001008,
		Level = 8,
		SoulId = 20010022,
		Name = getI18NValue(180007892),
		Describe = getI18NValue(180007891),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10622,
			600,
			20201,
			25
		}
	},
	[22001009] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_DiningRoom/DiningRoom_day.png",
		NeedDownDatingId = 22001008,
		UnlockLevel = 40,
		Dialog = 1711116800,
		Id = 22001009,
		Level = 9,
		SoulId = 20010022,
		Name = getI18NValue(180007894),
		Describe = getI18NValue(180007893),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10622,
			800,
			20201,
			30
		}
	},
	[22001010] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_HomePrivateRoom/GirlRoom_night.png",
		NeedDownDatingId = 22001009,
		UnlockLevel = 43,
		Dialog = 231102400,
		Id = 22001010,
		Level = 10,
		SoulId = 20010022,
		Name = getI18NValue(180256185),
		Describe = getI18NValue(180256184),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10622,
			800,
			20201,
			30
		}
	},
	[22001011] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Surburb/Surburb_day_sunny.png",
		NeedDownDatingId = 22001010,
		UnlockLevel = 46,
		Dialog = 231102550,
		Id = 22001011,
		Level = 11,
		SoulId = 20010022,
		Name = getI18NValue(180256187),
		Describe = getI18NValue(180256186),
		ReturnGiftNum = {
			300,
			700
		},
		Cost = {
			10901,
			20
		},
		Reward = {
			10622,
			1000,
			20201,
			40
		}
	},
	[23001001] = {
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Church/Church_day_sunny.png",
		UnlockLevel = 2,
		DatingType = 1,
		DatingTypeShow = 1,
		Dialog = 231101000,
		Id = 23001001,
		Level = 1,
		SoulId = 20010023,
		Name = getI18NValue(180137785),
		Describe = getI18NValue(180137784),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10623,
			100,
			20201,
			6
		}
	},
	[23001002] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Lane/Lane_night_sunny.png",
		NeedDownDatingId = 23001001,
		UnlockLevel = 5,
		Dialog = 231101100,
		Id = 23001002,
		Level = 2,
		SoulId = 20010023,
		Name = getI18NValue(180137787),
		Describe = getI18NValue(180137786),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10623,
			100,
			20201,
			6
		}
	},
	[23001003] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Port/Port_night_sunny.png",
		NeedDownDatingId = 23001002,
		UnlockLevel = 10,
		Dialog = 231101200,
		Id = 23001003,
		Level = 3,
		SoulId = 20010023,
		Name = getI18NValue(180137789),
		Describe = getI18NValue(180137788),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10623,
			250,
			20201,
			12
		}
	},
	[23001004] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BusinessStreet/BusinessStreet_day_sunny.png",
		NeedDownDatingId = 23001003,
		UnlockLevel = 15,
		Dialog = 231101300,
		Id = 23001004,
		Level = 4,
		SoulId = 20010023,
		Name = getI18NValue(180137791),
		Describe = getI18NValue(180137790),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10623,
			250,
			20201,
			12
		}
	},
	[23001005] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Uptown/Uptown_day_sunny.png",
		NeedDownDatingId = 23001004,
		UnlockLevel = 20,
		Dialog = 231101400,
		Id = 23001005,
		Level = 5,
		SoulId = 20010023,
		Name = getI18NValue(180137793),
		Describe = getI18NValue(180137792),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10623,
			400,
			20201,
			20
		}
	},
	[23001006] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_HomePrivateRoom/PlayerRoom_day.png",
		NeedDownDatingId = 23001005,
		UnlockLevel = 25,
		Dialog = 231101500,
		Id = 23001006,
		Level = 6,
		SoulId = 20010023,
		Name = getI18NValue(180137795),
		Describe = getI18NValue(180137794),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10623,
			400,
			20201,
			20
		}
	},
	[23001007] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Theater/Theater_off.png",
		NeedDownDatingId = 23001006,
		UnlockLevel = 30,
		Dialog = 231101650,
		Id = 23001007,
		Level = 7,
		SoulId = 20010023,
		Name = getI18NValue(180137797),
		Describe = getI18NValue(180137796),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10623,
			600,
			20201,
			25
		}
	},
	[23001008] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Sea/LoopBg_Seaside.png",
		NeedDownDatingId = 23001007,
		UnlockLevel = 35,
		Dialog = 231101800,
		Id = 23001008,
		Level = 8,
		SoulId = 20010023,
		Name = getI18NValue(180137799),
		Describe = getI18NValue(180137798),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10623,
			600,
			20201,
			25
		}
	},
	[23001009] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Balcony/Balcony_day_sunny.png",
		NeedDownDatingId = 23001008,
		UnlockLevel = 40,
		Dialog = 231101900,
		Id = 23001009,
		Level = 9,
		SoulId = 20010023,
		Name = getI18NValue(180137801),
		Describe = getI18NValue(180137800),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10623,
			800,
			20201,
			30
		}
	},
	[23001010] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Surburb/Surburb_day_sunny.png",
		NeedDownDatingId = 23001009,
		UnlockLevel = 43,
		Dialog = 231102150,
		Id = 23001010,
		Level = 10,
		SoulId = 20010023,
		Name = getI18NValue(180256189),
		Describe = getI18NValue(180256188),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10623,
			800,
			20201,
			30
		}
	},
	[23001011] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_HomePrivateRoom/GirlRoom_day.png",
		NeedDownDatingId = 23001010,
		UnlockLevel = 46,
		Dialog = 231102250,
		Id = 23001011,
		Level = 11,
		SoulId = 20010023,
		Name = getI18NValue(180256191),
		Describe = getI18NValue(180256190),
		ReturnGiftNum = {
			300,
			700
		},
		Cost = {
			10901,
			20
		},
		Reward = {
			10623,
			1000,
			20201,
			40
		}
	},
	[24001001] = {
		ImageBg = "/Girl/GirlDatingBackground/GDBG_CenterSquare/CenterSquare_day_sunny.png",
		UnlockLevel = 2,
		DatingType = 1,
		DatingTypeShow = 1,
		Dialog = 241102000,
		Id = 24001001,
		Level = 1,
		SoulId = 20010024,
		Name = getI18NValue(180137803),
		Describe = getI18NValue(180137802),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10624,
			100,
			20201,
			6
		}
	},
	[24001002] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Surburb/Surburb_day_sunny.png",
		NeedDownDatingId = 24001001,
		UnlockLevel = 5,
		Dialog = 241102150,
		Id = 24001002,
		Level = 2,
		SoulId = 20010024,
		Name = getI18NValue(180137805),
		Describe = getI18NValue(180137804),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10624,
			100,
			20201,
			6
		}
	},
	[24001003] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Carriage/Carriage.png",
		NeedDownDatingId = 24001002,
		UnlockLevel = 10,
		Dialog = 241102300,
		Id = 24001003,
		Level = 3,
		SoulId = 20010024,
		Name = getI18NValue(180137807),
		Describe = getI18NValue(180137806),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10624,
			250,
			20201,
			12
		}
	},
	[24001004] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_HomePrivateRoom/GirlRoom_day.png",
		NeedDownDatingId = 24001003,
		UnlockLevel = 15,
		Dialog = 241102400,
		Id = 24001004,
		Level = 4,
		SoulId = 20010024,
		Name = getI18NValue(180137809),
		Describe = getI18NValue(180137808),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10624,
			250,
			20201,
			12
		}
	},
	[24001005] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Surburb/Surburb_day_sunny.png",
		NeedDownDatingId = 24001004,
		UnlockLevel = 20,
		Dialog = 241102550,
		Id = 24001005,
		Level = 5,
		SoulId = 20010024,
		Name = getI18NValue(180137811),
		Describe = getI18NValue(180137810),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10624,
			400,
			20201,
			20
		}
	},
	[24001006] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Garden/Garden_day_sunny.png",
		NeedDownDatingId = 24001005,
		UnlockLevel = 25,
		Dialog = 241102670,
		Id = 24001006,
		Level = 6,
		SoulId = 20010024,
		Name = getI18NValue(180137813),
		Describe = getI18NValue(180137812),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10624,
			400,
			20201,
			20
		}
	},
	[24001007] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Fields/Fields_sunny.png",
		NeedDownDatingId = 24001006,
		UnlockLevel = 30,
		Dialog = 241102820,
		Id = 24001007,
		Level = 7,
		SoulId = 20010024,
		Name = getI18NValue(180137815),
		Describe = getI18NValue(180137814),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10624,
			600,
			20201,
			25
		}
	},
	[24001008] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Surburb/Surburb_night_sunny.png",
		NeedDownDatingId = 24001007,
		UnlockLevel = 35,
		Dialog = 241103000,
		Id = 24001008,
		Level = 8,
		SoulId = 20010024,
		Name = getI18NValue(180137817),
		Describe = getI18NValue(180137816),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10624,
			600,
			20201,
			25
		}
	},
	[24001009] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Garden1/Garden1_night_sunny.png",
		NeedDownDatingId = 24001008,
		UnlockLevel = 40,
		Dialog = 241103120,
		Id = 24001009,
		Level = 9,
		SoulId = 20010024,
		Name = getI18NValue(180137819),
		Describe = getI18NValue(180137818),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10624,
			800,
			20201,
			30
		}
	},
	[24001010] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BusinessStreet/BusinessStreet_day_sunny.png",
		NeedDownDatingId = 24001009,
		UnlockLevel = 43,
		Dialog = 241103450,
		Id = 24001010,
		Level = 10,
		SoulId = 20010024,
		Name = getI18NValue(180256193),
		Describe = getI18NValue(180256192),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10624,
			800,
			20201,
			30
		}
	},
	[24001011] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_DiningRoom/DiningRoom_day.png",
		NeedDownDatingId = 24001010,
		UnlockLevel = 46,
		Dialog = 241103600,
		Id = 24001011,
		Level = 11,
		SoulId = 20010024,
		Name = getI18NValue(180256195),
		Describe = getI18NValue(180256194),
		ReturnGiftNum = {
			300,
			700
		},
		Cost = {
			10901,
			20
		},
		Reward = {
			10624,
			1000,
			20201,
			40
		}
	},
	[25001001] = {
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Balcony/Balcony_day_sunny.png",
		UnlockLevel = 2,
		DatingType = 1,
		DatingTypeShow = 1,
		Dialog = 251101800,
		Id = 25001001,
		Level = 1,
		SoulId = 20010025,
		Name = getI18NValue(180137821),
		Describe = getI18NValue(180137820),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10625,
			100,
			20201,
			6
		}
	},
	[25001002] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Ruins/Cavern_Centralpart_1.png",
		NeedDownDatingId = 25001001,
		UnlockLevel = 5,
		Dialog = 251101950,
		Id = 25001002,
		Level = 2,
		SoulId = 20010025,
		Name = getI18NValue(180137823),
		Describe = getI18NValue(180137822),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10625,
			100,
			20201,
			6
		}
	},
	[25001003] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Restaurant/Restaurant_1.png",
		NeedDownDatingId = 25001002,
		UnlockLevel = 10,
		Dialog = 251102150,
		Id = 25001003,
		Level = 3,
		SoulId = 20010025,
		Name = getI18NValue(180137825),
		Describe = getI18NValue(180137824),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10625,
			250,
			20201,
			12
		}
	},
	[25001004] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BusinessStreet/BusinessStreet_day_sunny.png",
		NeedDownDatingId = 25001003,
		UnlockLevel = 15,
		Dialog = 251102300,
		Id = 25001004,
		Level = 4,
		SoulId = 20010025,
		Name = getI18NValue(180149187),
		Describe = getI18NValue(180149186),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10625,
			250,
			20201,
			12
		}
	},
	[25001005] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Theater/Theater_off.png",
		NeedDownDatingId = 25001004,
		UnlockLevel = 20,
		Dialog = 251102450,
		Id = 25001005,
		Level = 5,
		SoulId = 20010025,
		Name = getI18NValue(180149189),
		Describe = getI18NValue(180149188),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10625,
			400,
			20201,
			20
		}
	},
	[25001006] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BusinessStreet/BusinessStreet_day_sunny.png",
		NeedDownDatingId = 25001005,
		UnlockLevel = 25,
		Dialog = 251102600,
		Id = 25001006,
		Level = 6,
		SoulId = 20010025,
		Name = getI18NValue(180149191),
		Describe = getI18NValue(180149190),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10625,
			400,
			20201,
			20
		}
	},
	[25001007] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Sea/LoopBg_Seaside.png",
		NeedDownDatingId = 25001006,
		UnlockLevel = 30,
		Dialog = 251102720,
		Id = 25001007,
		Level = 7,
		SoulId = 20010025,
		Name = getI18NValue(180238048),
		Describe = getI18NValue(180238047),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10625,
			600,
			20201,
			25
		}
	},
	[25001008] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Livingroom/LivingRoom_day.png",
		NeedDownDatingId = 25001007,
		UnlockLevel = 35,
		Dialog = 251102850,
		Id = 25001008,
		Level = 8,
		SoulId = 20010025,
		Name = getI18NValue(180238050),
		Describe = getI18NValue(180238049),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10625,
			600,
			20201,
			25
		}
	},
	[25001009] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_CenterSquare/CenterSquare_night_sunny.png",
		NeedDownDatingId = 25001008,
		UnlockLevel = 40,
		Dialog = 251103000,
		Id = 25001009,
		Level = 9,
		SoulId = 20010025,
		Name = getI18NValue(180238052),
		Describe = getI18NValue(180238051),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10625,
			800,
			20201,
			30
		}
	},
	[25001010] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Surburb/Surburb_day_sunny.png",
		NeedDownDatingId = 25001009,
		UnlockLevel = 43,
		Dialog = 251103150,
		Id = 25001010,
		Level = 10,
		SoulId = 20010025,
		Name = getI18NValue(180256197),
		Describe = getI18NValue(180256196),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10625,
			800,
			20201,
			30
		}
	},
	[25001011] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Sky/Sky_night_sunny.png",
		NeedDownDatingId = 25001010,
		UnlockLevel = 46,
		Dialog = 251103250,
		Id = 25001011,
		Level = 11,
		SoulId = 20010025,
		Name = getI18NValue(180256199),
		Describe = getI18NValue(180256198),
		ReturnGiftNum = {
			300,
			700
		},
		Cost = {
			10901,
			20
		},
		Reward = {
			10625,
			1000,
			20201,
			40
		}
	},
	[26001001] = {
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Restaurant/Restaurant_1.png",
		UnlockLevel = 2,
		DatingType = 1,
		DatingTypeShow = 1,
		Dialog = 1110193470,
		Id = 26001001,
		Level = 1,
		SoulId = 20010026,
		Name = getI18NValue(180137839),
		Describe = getI18NValue(180137838),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10626,
			100,
			20201,
			6
		}
	},
	[26001002] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Fields/Fields_sunny.png",
		NeedDownDatingId = 26001001,
		UnlockLevel = 5,
		Dialog = 1110193570,
		Id = 26001002,
		Level = 2,
		SoulId = 20010026,
		Name = getI18NValue(180137841),
		Describe = getI18NValue(180137840),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10626,
			100,
			20201,
			6
		}
	},
	[26001003] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Carriage/Carriage.png",
		NeedDownDatingId = 26001002,
		UnlockLevel = 10,
		Dialog = 1110193670,
		Id = 26001003,
		Level = 3,
		SoulId = 20010026,
		Name = getI18NValue(180137843),
		Describe = getI18NValue(180137842),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10626,
			250,
			20201,
			12
		}
	},
	[27001001] = {
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Livingroom/LivingRoom_day.png",
		UnlockLevel = 2,
		DatingType = 1,
		DatingTypeShow = 1,
		Dialog = 271101500,
		Id = 27001001,
		Level = 1,
		SoulId = 20010027,
		Name = getI18NValue(180260427),
		Describe = getI18NValue(180260426),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10627,
			100,
			20201,
			6
		}
	},
	[27001002] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_DiningRoom/DiningRoom_day.png",
		NeedDownDatingId = 27001001,
		UnlockLevel = 5,
		Dialog = 271101650,
		Id = 27001002,
		Level = 2,
		SoulId = 20010027,
		Name = getI18NValue(180260429),
		Describe = getI18NValue(180260428),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10627,
			100,
			20201,
			6
		}
	},
	[27001003] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Uptown/Uptown_day_sunny.png",
		NeedDownDatingId = 27001002,
		UnlockLevel = 10,
		Dialog = 271101800,
		Id = 27001003,
		Level = 3,
		SoulId = 20010027,
		Name = getI18NValue(180260431),
		Describe = getI18NValue(180260430),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10627,
			250,
			20201,
			12
		}
	},
	[27001004] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Sea/Sealevel.png",
		NeedDownDatingId = 27001003,
		UnlockLevel = 15,
		Dialog = 271102850,
		Id = 27001004,
		Level = 4,
		SoulId = 20010027,
		Name = getI18NValue(180274806),
		Describe = getI18NValue(180274805),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10627,
			250,
			20201,
			12
		}
	},
	[27001005] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Church/InChurch.png",
		NeedDownDatingId = 27001004,
		UnlockLevel = 20,
		Dialog = 271103050,
		Id = 27001005,
		Level = 5,
		SoulId = 20010027,
		Name = getI18NValue(180274808),
		Describe = getI18NValue(180274807),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10627,
			400,
			20201,
			20
		}
	},
	[27001006] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Restaurant/Restaurant_1.png",
		NeedDownDatingId = 27001005,
		UnlockLevel = 25,
		Dialog = 271103200,
		Id = 27001006,
		Level = 6,
		SoulId = 20010027,
		Name = getI18NValue(180274810),
		Describe = getI18NValue(180274809),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10627,
			400,
			20201,
			20
		}
	},
	[27001007] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Museum/Museum_day.png",
		NeedDownDatingId = 27001006,
		UnlockLevel = 30,
		Dialog = 271103300,
		Id = 27001007,
		Level = 7,
		SoulId = 20010027,
		Name = getI18NValue(180289515),
		Describe = getI18NValue(180289514),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10627,
			600,
			20201,
			25
		}
	},
	[27001008] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BusinessStreet/BusinessStreet_day_sunny.png",
		NeedDownDatingId = 27001007,
		UnlockLevel = 35,
		Dialog = 271103400,
		Id = 27001008,
		Level = 8,
		SoulId = 20010027,
		Name = getI18NValue(180289517),
		Describe = getI18NValue(180289516),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10627,
			600,
			20201,
			25
		}
	},
	[27001009] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Restaurant/Restaurant_night.png",
		NeedDownDatingId = 27001008,
		UnlockLevel = 40,
		Dialog = 271103550,
		Id = 27001009,
		Level = 9,
		SoulId = 20010027,
		Name = getI18NValue(180289519),
		Describe = getI18NValue(180289518),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10627,
			800,
			20201,
			30
		}
	},
	[27001010] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BusinessStreet/BusinessStreet_day_sunny.png",
		NeedDownDatingId = 27001009,
		UnlockLevel = 43,
		Dialog = 271103900,
		Id = 27001010,
		Level = 10,
		SoulId = 20010027,
		Name = getI18NValue(180453844),
		Describe = getI18NValue(180453843),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10627,
			800,
			20201,
			30
		}
	},
	[27001011] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_HomePrivateRoom/PlayerRoom_night.png",
		NeedDownDatingId = 27001010,
		UnlockLevel = 46,
		Dialog = 271103700,
		Id = 27001011,
		Level = 11,
		SoulId = 20010027,
		Name = getI18NValue(180453846),
		Describe = getI18NValue(180453845),
		ReturnGiftNum = {
			300,
			700
		},
		Cost = {
			10901,
			20
		},
		Reward = {
			10627,
			1000,
			20201,
			40
		}
	},
	[28001001] = {
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Restaurant/Diner.png",
		UnlockLevel = 2,
		DatingType = 1,
		DatingTypeShow = 1,
		Dialog = 281101250,
		Id = 28001001,
		Level = 1,
		SoulId = 20010028,
		Name = getI18NValue(180260433),
		Describe = getI18NValue(180260432),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10628,
			100,
			20201,
			6
		}
	},
	[28001002] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Ruins/Cavern_Centralpart_1.png",
		NeedDownDatingId = 28001001,
		UnlockLevel = 5,
		Dialog = 281101350,
		Id = 28001002,
		Level = 2,
		SoulId = 20010028,
		Name = getI18NValue(180260435),
		Describe = getI18NValue(180260434),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10628,
			100,
			20201,
			6
		}
	},
	[28001003] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Ruins/Ruins_day_sunny.png",
		NeedDownDatingId = 28001002,
		UnlockLevel = 10,
		Dialog = 281101500,
		Id = 28001003,
		Level = 3,
		SoulId = 20010028,
		Name = getI18NValue(180260437),
		Describe = getI18NValue(180260436),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10628,
			250,
			20201,
			12
		}
	},
	[28001004] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Restaurant/Restaurant.png",
		NeedDownDatingId = 28001003,
		UnlockLevel = 15,
		Dialog = 281102000,
		Id = 28001004,
		Level = 4,
		SoulId = 20010028,
		Name = getI18NValue(180304372),
		Describe = getI18NValue(180304371),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10628,
			250,
			20201,
			12
		}
	},
	[28001005] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BlackStreet/BlackStreet_day_sunny.png",
		NeedDownDatingId = 28001004,
		UnlockLevel = 20,
		Dialog = 281102150,
		Id = 28001005,
		Level = 5,
		SoulId = 20010028,
		Name = getI18NValue(180304374),
		Describe = getI18NValue(180304373),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10628,
			400,
			20201,
			20
		}
	},
	[28001006] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Fields/Fields_sunny.png",
		NeedDownDatingId = 28001005,
		UnlockLevel = 25,
		Dialog = 281102250,
		Id = 28001006,
		Level = 6,
		SoulId = 20010028,
		Name = getI18NValue(180304376),
		Describe = getI18NValue(180304375),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10628,
			400,
			20201,
			20
		}
	},
	[28001007] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Surburb/Surburb_day_sunny.png",
		NeedDownDatingId = 28001006,
		UnlockLevel = 30,
		Dialog = 281102350,
		Id = 28001007,
		Level = 7,
		SoulId = 20010028,
		Name = getI18NValue(180451814),
		Describe = getI18NValue(180451813),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10628,
			600,
			20201,
			25
		}
	},
	[28001008] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Fields/Fields_sunny.png",
		NeedDownDatingId = 28001007,
		UnlockLevel = 35,
		Dialog = 281102450,
		Id = 28001008,
		Level = 8,
		SoulId = 20010028,
		Name = getI18NValue(180451816),
		Describe = getI18NValue(180451815),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10628,
			600,
			20201,
			25
		}
	},
	[28001009] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Church/Church_night_sunny.png",
		NeedDownDatingId = 28001008,
		UnlockLevel = 40,
		Dialog = 281102550,
		Id = 28001009,
		Level = 9,
		SoulId = 20010028,
		Name = getI18NValue(180451818),
		Describe = getI18NValue(180451817),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10628,
			800,
			20201,
			30
		}
	},
	[28001010] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Church/Church_day_sunny.png",
		NeedDownDatingId = 28001009,
		UnlockLevel = 43,
		Dialog = 281102700,
		Id = 28001010,
		Level = 10,
		SoulId = 20010028,
		Name = getI18NValue(180469294),
		Describe = getI18NValue(180469293),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10628,
			800,
			20201,
			30
		}
	},
	[28001011] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_HomePrivateRoom/PlayerRoom_night.png",
		NeedDownDatingId = 28001010,
		UnlockLevel = 46,
		Dialog = 281102850,
		Id = 28001011,
		Level = 11,
		SoulId = 20010028,
		Name = getI18NValue(180469296),
		Describe = getI18NValue(180469295),
		ReturnGiftNum = {
			300,
			700
		},
		Cost = {
			10901,
			20
		},
		Reward = {
			10628,
			1000,
			20201,
			40
		}
	},
	[29001001] = {
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Ruins/Ruins_day_sunny.png",
		UnlockLevel = 2,
		DatingType = 1,
		DatingTypeShow = 1,
		Dialog = 291101100,
		Id = 29001001,
		Level = 1,
		SoulId = 20010029,
		Name = getI18NValue(180260439),
		Describe = getI18NValue(180260438),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10629,
			100,
			20201,
			6
		}
	},
	[29001002] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Balcony/Balcony_night_sunny.png",
		NeedDownDatingId = 29001001,
		UnlockLevel = 5,
		Dialog = 291101250,
		Id = 29001002,
		Level = 2,
		SoulId = 20010029,
		Name = getI18NValue(180260441),
		Describe = getI18NValue(180260440),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10629,
			100,
			20201,
			6
		}
	},
	[29001003] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Church/Church_day_sunny.png",
		NeedDownDatingId = 29001002,
		UnlockLevel = 10,
		Dialog = 291101350,
		Id = 29001003,
		Level = 3,
		SoulId = 20010029,
		Name = getI18NValue(180260443),
		Describe = getI18NValue(180260442),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10629,
			250,
			20201,
			12
		}
	},
	[29001004] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BusinessStreet/BusinessStreet_day_sunny.png",
		NeedDownDatingId = 29001003,
		UnlockLevel = 15,
		Dialog = 291101550,
		Id = 29001004,
		Level = 4,
		SoulId = 20010029,
		Name = getI18NValue(180455845),
		Describe = getI18NValue(180455844),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10629,
			250,
			20201,
			12
		}
	},
	[29001005] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Port/Port_day_sunny.png",
		NeedDownDatingId = 29001004,
		UnlockLevel = 20,
		Dialog = 291101700,
		Id = 29001005,
		Level = 5,
		SoulId = 20010029,
		Name = getI18NValue(180455847),
		Describe = getI18NValue(180455846),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10629,
			400,
			20201,
			20
		}
	},
	[29001006] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Church/InChurch.png",
		NeedDownDatingId = 29001005,
		UnlockLevel = 25,
		Dialog = 291101800,
		Id = 29001006,
		Level = 6,
		SoulId = 20010029,
		Name = getI18NValue(180455849),
		Describe = getI18NValue(180455848),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10629,
			400,
			20201,
			20
		}
	},
	[29001007] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BusinessStreet/BusinessStreet_day_sunny.png",
		NeedDownDatingId = 29001006,
		UnlockLevel = 30,
		Dialog = 291101900,
		Id = 29001007,
		Level = 7,
		SoulId = 20010029,
		Name = getI18NValue(180466218),
		Describe = getI18NValue(180466217),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10629,
			600,
			20201,
			25
		}
	},
	[29001008] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Uptown/Uptown_night_sunny.png",
		NeedDownDatingId = 29001007,
		UnlockLevel = 35,
		Dialog = 291102100,
		Id = 29001008,
		Level = 8,
		SoulId = 20010029,
		Name = getI18NValue(180466220),
		Describe = getI18NValue(180466219),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10629,
			600,
			20201,
			25
		}
	},
	[29001009] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Restaurant/Restaurant_1.png",
		NeedDownDatingId = 29001008,
		UnlockLevel = 40,
		Dialog = 291102000,
		Id = 29001009,
		Level = 9,
		SoulId = 20010029,
		Name = getI18NValue(180466222),
		Describe = getI18NValue(180466221),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10629,
			800,
			20201,
			30
		}
	},
	[29001010] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Church/Church_day_sunny.png",
		NeedDownDatingId = 29001009,
		UnlockLevel = 43,
		Dialog = 291102200,
		Id = 29001010,
		Level = 10,
		SoulId = 20010029,
		Name = getI18NValue(180513794),
		Describe = getI18NValue(180513793),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10629,
			800,
			20201,
			30
		}
	},
	[29001011] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Sea/Sea.png",
		NeedDownDatingId = 29001010,
		UnlockLevel = 46,
		Dialog = 291102300,
		Id = 29001011,
		Level = 11,
		SoulId = 20010029,
		Name = getI18NValue(180513796),
		Describe = getI18NValue(180513795),
		ReturnGiftNum = {
			300,
			700
		},
		Cost = {
			10901,
			20
		},
		Reward = {
			10629,
			1000,
			20201,
			40
		}
	},
	[30001001] = {
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BusinessStreet/BusinessStreet_day_sunny.png",
		UnlockLevel = 2,
		DatingType = 1,
		DatingTypeShow = 1,
		Dialog = 301101150,
		Id = 30001001,
		Level = 1,
		SoulId = 20010030,
		Name = getI18NValue(180260445),
		Describe = getI18NValue(180260444),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10630,
			100,
			20201,
			6
		}
	},
	[30001002] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_HomePrivateRoom/PlayerRoom_night.png",
		NeedDownDatingId = 30001001,
		UnlockLevel = 5,
		Dialog = 301101300,
		Id = 30001002,
		Level = 2,
		SoulId = 20010030,
		Name = getI18NValue(180260447),
		Describe = getI18NValue(180260446),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10630,
			100,
			20201,
			6
		}
	},
	[30001003] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_HomePrivateRoom/PlayerRoom_night.png",
		NeedDownDatingId = 30001002,
		UnlockLevel = 10,
		Dialog = 301101450,
		Id = 30001003,
		Level = 3,
		SoulId = 20010030,
		Name = getI18NValue(180260449),
		Describe = getI18NValue(180260448),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10630,
			250,
			20201,
			12
		}
	},
	[30001004] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Surburb/Surburb_day_rainy.png",
		NeedDownDatingId = 30001003,
		UnlockLevel = 15,
		Dialog = 301101700,
		Id = 30001004,
		Level = 4,
		SoulId = 20010030,
		Name = getI18NValue(180472334),
		Describe = getI18NValue(180472333),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10630,
			250,
			20201,
			12
		}
	},
	[30001005] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Sea/Sealevel.png",
		NeedDownDatingId = 30001004,
		UnlockLevel = 20,
		Dialog = 301101900,
		Id = 30001005,
		Level = 5,
		SoulId = 20010030,
		Name = getI18NValue(180472336),
		Describe = getI18NValue(180472335),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10630,
			400,
			20201,
			20
		}
	},
	[30001006] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BusinessStreet/BusinessStreet_night_sunny.png",
		NeedDownDatingId = 30001005,
		UnlockLevel = 25,
		Dialog = 301102100,
		Id = 30001006,
		Level = 6,
		SoulId = 20010030,
		Name = getI18NValue(180472338),
		Describe = getI18NValue(180472337),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10630,
			400,
			20201,
			20
		}
	},
	[30001007] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Garden/Garden_day_sunny.png",
		NeedDownDatingId = 30001006,
		UnlockLevel = 30,
		Dialog = 301102300,
		Id = 30001007,
		Level = 7,
		SoulId = 20010030,
		Name = getI18NValue(180504536),
		Describe = getI18NValue(180504535),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10630,
			600,
			20201,
			25
		}
	},
	[30001008] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BusinessStreet/BusinessStreet_night_sunny.png",
		NeedDownDatingId = 30001007,
		UnlockLevel = 35,
		Dialog = 301102500,
		Id = 30001008,
		Level = 8,
		SoulId = 20010030,
		Name = getI18NValue(180504538),
		Describe = getI18NValue(180504537),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10630,
			600,
			20201,
			25
		}
	},
	[30001009] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BusinessStreet/ClothingShop.png",
		NeedDownDatingId = 30001008,
		UnlockLevel = 40,
		Dialog = 301102700,
		Id = 30001009,
		Level = 9,
		SoulId = 20010030,
		Name = getI18NValue(180504540),
		Describe = getI18NValue(180504539),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10630,
			800,
			20201,
			30
		}
	},
	[30001010] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Livingroom/LivingRoom_night.png",
		NeedDownDatingId = 30001009,
		UnlockLevel = 43,
		Dialog = 301102850,
		Id = 30001010,
		Level = 10,
		SoulId = 20010030,
		Name = getI18NValue(180538621),
		Describe = getI18NValue(180538620),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10630,
			800,
			20201,
			30
		}
	},
	[30001011] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Garden/Garden_day_sunny.png",
		NeedDownDatingId = 30001010,
		UnlockLevel = 46,
		Dialog = 301103000,
		Id = 30001011,
		Level = 11,
		SoulId = 20010030,
		Name = getI18NValue(180538623),
		Describe = getI18NValue(180538622),
		ReturnGiftNum = {
			300,
			700
		},
		Cost = {
			10901,
			20
		},
		Reward = {
			10630,
			1000,
			20201,
			40
		}
	},
	[31001001] = {
		ImageBg = "/Girl/GirlDatingBackground/GDBG_DiningRoom/DiningRoom_night.png",
		UnlockLevel = 2,
		DatingType = 1,
		DatingTypeShow = 1,
		Dialog = 331101750,
		Id = 31001001,
		Level = 1,
		SoulId = 20010031,
		Name = getI18NValue(180260451),
		Describe = getI18NValue(180260450),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10631,
			100,
			20201,
			6
		}
	},
	[31001002] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_HomePrivateRoom/Library.png",
		NeedDownDatingId = 31001001,
		UnlockLevel = 5,
		Dialog = 331101950,
		Id = 31001002,
		Level = 2,
		SoulId = 20010031,
		Name = getI18NValue(180260453),
		Describe = getI18NValue(180260452),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10631,
			100,
			20201,
			6
		}
	},
	[31001003] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BusinessStreet/BusinessStreet_night_sunny.png",
		NeedDownDatingId = 31001002,
		UnlockLevel = 10,
		Dialog = 331102100,
		Id = 31001003,
		Level = 3,
		SoulId = 20010031,
		Name = getI18NValue(180260455),
		Describe = getI18NValue(180260454),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10631,
			250,
			20201,
			12
		}
	},
	[31001004] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_HomePrivateRoom/Library.png",
		NeedDownDatingId = 31001003,
		UnlockLevel = 15,
		Dialog = 331102400,
		Id = 31001004,
		Level = 4,
		SoulId = 20010031,
		Name = getI18NValue(180511679),
		Describe = getI18NValue(180511678),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10631,
			250,
			20201,
			12
		}
	},
	[31001005] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Livingroom/LivingRoom_day.png",
		NeedDownDatingId = 31001004,
		UnlockLevel = 20,
		Dialog = 331102550,
		Id = 31001005,
		Level = 5,
		SoulId = 20010031,
		Name = getI18NValue(180511681),
		Describe = getI18NValue(180511680),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10631,
			400,
			20201,
			20
		}
	},
	[31001006] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Surburb/Surburb_day_sunny.png",
		NeedDownDatingId = 31001005,
		UnlockLevel = 25,
		Dialog = 331102700,
		Id = 31001006,
		Level = 6,
		SoulId = 20010031,
		Name = getI18NValue(180511683),
		Describe = getI18NValue(180511682),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10631,
			400,
			20201,
			20
		}
	},
	[31001007] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BusinessStreet/BusinessStreet_day_sunny.png",
		NeedDownDatingId = 31001006,
		UnlockLevel = 30,
		Dialog = 331102850,
		Id = 31001007,
		Level = 7,
		SoulId = 20010031,
		Name = getI18NValue(180533115),
		Describe = getI18NValue(180533114),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10631,
			600,
			20201,
			25
		}
	},
	[31001008] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Livingroom/LivingRoom_day.png",
		NeedDownDatingId = 31001007,
		UnlockLevel = 35,
		Dialog = 331103000,
		Id = 31001008,
		Level = 8,
		SoulId = 20010031,
		Name = getI18NValue(180533117),
		Describe = getI18NValue(180533116),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10631,
			600,
			20201,
			25
		}
	},
	[31001009] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Theater/Theater_on.png",
		NeedDownDatingId = 31001008,
		UnlockLevel = 40,
		Dialog = 331103150,
		Id = 31001009,
		Level = 9,
		SoulId = 20010031,
		Name = getI18NValue(180533119),
		Describe = getI18NValue(180533118),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10631,
			800,
			20201,
			30
		}
	},
	[31001010] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Surburb/Surburb_night_sunny.png",
		NeedDownDatingId = 31001009,
		UnlockLevel = 43,
		Dialog = 331103300,
		Id = 31001010,
		Level = 10,
		SoulId = 20010031,
		Name = getI18NValue(180538992),
		Describe = getI18NValue(180538991),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10631,
			800,
			20201,
			30
		}
	},
	[31001011] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_HomePrivateRoom/Library.png",
		NeedDownDatingId = 31001010,
		UnlockLevel = 46,
		Dialog = 331103450,
		Id = 31001011,
		Level = 11,
		SoulId = 20010031,
		Name = getI18NValue(180538994),
		Describe = getI18NValue(180538993),
		ReturnGiftNum = {
			300,
			700
		},
		Cost = {
			10901,
			20
		},
		Reward = {
			10631,
			1000,
			20201,
			40
		}
	},
	[32001001] = {
		ImageBg = "/Girl/GirlDatingBackground/GDBG_DiningRoom/DiningRoom_night.png",
		UnlockLevel = 2,
		DatingType = 1,
		DatingTypeShow = 1,
		Dialog = 321101100,
		Id = 32001001,
		Level = 1,
		SoulId = 20010032,
		Name = getI18NValue(180260457),
		Describe = getI18NValue(180260456),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10632,
			100,
			20201,
			6
		}
	},
	[32001002] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Livingroom/LivingRoom_day.png",
		NeedDownDatingId = 32001001,
		UnlockLevel = 5,
		Dialog = 321101250,
		Id = 32001002,
		Level = 2,
		SoulId = 20010032,
		Name = getI18NValue(180260459),
		Describe = getI18NValue(180260458),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10632,
			100,
			20201,
			6
		}
	},
	[32001003] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_DiningRoom/DiningRoom_day.png",
		NeedDownDatingId = 32001002,
		UnlockLevel = 10,
		Dialog = 321101400,
		Id = 32001003,
		Level = 3,
		SoulId = 20010032,
		Name = getI18NValue(180260461),
		Describe = getI18NValue(180260460),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10632,
			250,
			20201,
			12
		}
	},
	[32001004] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_MSky/MSky_night_sunny.png",
		NeedDownDatingId = 32001003,
		UnlockLevel = 15,
		Dialog = 321102150,
		Id = 32001004,
		Level = 4,
		SoulId = 20010032,
		Name = getI18NValue(180517150),
		Describe = getI18NValue(180517149),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10632,
			250,
			20201,
			12
		}
	},
	[32001005] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_MSky/MSky_night_sunny.png",
		NeedDownDatingId = 32001004,
		UnlockLevel = 20,
		Dialog = 321102300,
		Id = 32001005,
		Level = 5,
		SoulId = 20010032,
		Name = getI18NValue(180517152),
		Describe = getI18NValue(180517151),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10632,
			400,
			20201,
			20
		}
	},
	[32001006] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BusinessStreet/BusinessStreet_day_sunny.png",
		NeedDownDatingId = 32001005,
		UnlockLevel = 25,
		Dialog = 321102450,
		Id = 32001006,
		Level = 6,
		SoulId = 20010032,
		Name = getI18NValue(180517154),
		Describe = getI18NValue(180517153),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10632,
			400,
			20201,
			20
		}
	},
	[32001007] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BusinessStreet/BusinessStreet_sunset.png",
		NeedDownDatingId = 32001006,
		UnlockLevel = 30,
		Dialog = 321101750,
		Id = 32001007,
		Level = 7,
		SoulId = 20010032,
		Name = getI18NValue(180520010),
		Describe = getI18NValue(180520009),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10632,
			600,
			20201,
			25
		}
	},
	[32001008] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Dreaming/Dreaming.png",
		NeedDownDatingId = 32001007,
		UnlockLevel = 35,
		Dialog = 321101900,
		Id = 32001008,
		Level = 8,
		SoulId = 20010032,
		Name = getI18NValue(180520012),
		Describe = getI18NValue(180520011),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10632,
			600,
			20201,
			25
		}
	},
	[32001009] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Livingroom/LivingRoom_day.png",
		NeedDownDatingId = 32001008,
		UnlockLevel = 40,
		Dialog = 321102050,
		Id = 32001009,
		Level = 9,
		SoulId = 20010032,
		Name = getI18NValue(180520014),
		Describe = getI18NValue(180520013),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10632,
			800,
			20201,
			30
		}
	},
	[32001010] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Fields/Fields_sunny.png",
		NeedDownDatingId = 32001009,
		UnlockLevel = 43,
		Dialog = 321102600,
		Id = 32001010,
		Level = 10,
		SoulId = 20010032,
		Name = getI18NValue(180520016),
		Describe = getI18NValue(180520015),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10632,
			800,
			20201,
			30
		}
	},
	[32001011] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBg/CentralPlaza.png",
		NeedDownDatingId = 32001010,
		UnlockLevel = 46,
		Dialog = 321102750,
		Id = 32001011,
		Level = 11,
		SoulId = 20010032,
		Name = getI18NValue(180520018),
		Describe = getI18NValue(180520017),
		ReturnGiftNum = {
			300,
			700
		},
		Cost = {
			10901,
			20
		},
		Reward = {
			10632,
			1000,
			20201,
			40
		}
	},
	[33001001] = {
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Livingroom/LivingRoom_day.png",
		UnlockLevel = 2,
		DatingType = 1,
		DatingTypeShow = 1,
		Dialog = 333101750,
		Id = 33001001,
		Level = 1,
		SoulId = 20010033,
		Name = getI18NValue(180484386),
		Describe = getI18NValue(180484385),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10633,
			100,
			20201,
			6
		}
	},
	[33001002] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Garden/Garden_day_sunny.png",
		NeedDownDatingId = 33001001,
		UnlockLevel = 5,
		Dialog = 333102000,
		Id = 33001002,
		Level = 2,
		SoulId = 20010033,
		Name = getI18NValue(180484388),
		Describe = getI18NValue(180484387),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10633,
			100,
			20201,
			6
		}
	},
	[33001003] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BusinessStreet/BusinessStreet_day_sunny.png",
		NeedDownDatingId = 33001002,
		UnlockLevel = 10,
		Dialog = 333102200,
		Id = 33001003,
		Level = 3,
		SoulId = 20010033,
		Name = getI18NValue(180484390),
		Describe = getI18NValue(180484389),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10633,
			250,
			20201,
			12
		}
	},
	[33001004] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_HomePrivateRoom/Alchemy.png",
		NeedDownDatingId = 33001003,
		UnlockLevel = 15,
		Dialog = 333102450,
		Id = 33001004,
		Level = 4,
		SoulId = 20010033,
		Name = getI18NValue(180539977),
		Describe = getI18NValue(180539976),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10633,
			250,
			20201,
			12
		}
	},
	[33001005] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Museum/Museum_day.png",
		NeedDownDatingId = 33001004,
		UnlockLevel = 20,
		Dialog = 333102600,
		Id = 33001005,
		Level = 5,
		SoulId = 20010033,
		Name = getI18NValue(180539979),
		Describe = getI18NValue(180539978),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10633,
			400,
			20201,
			20
		}
	},
	[33001006] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BusinessStreet/BusinessStreet_day_sunny.png",
		NeedDownDatingId = 33001005,
		UnlockLevel = 25,
		Dialog = 333102800,
		Id = 33001006,
		Level = 6,
		SoulId = 20010033,
		Name = getI18NValue(180539981),
		Describe = getI18NValue(180539980),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10633,
			400,
			20201,
			20
		}
	},
	[33001007] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BlackStreet/BlackStreet_night_rainy.png",
		NeedDownDatingId = 33001006,
		UnlockLevel = 30,
		Dialog = 333103200,
		Id = 33001007,
		Level = 7,
		SoulId = 20010033,
		Name = getI18NValue(180556566),
		Describe = getI18NValue(180556565),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10633,
			600,
			20201,
			25
		}
	},
	[33001008] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BusinessStreet/BusinessStreet_day_sunny.png",
		NeedDownDatingId = 33001007,
		UnlockLevel = 35,
		Dialog = 333103400,
		Id = 33001008,
		Level = 8,
		SoulId = 20010033,
		Name = getI18NValue(180556568),
		Describe = getI18NValue(180556567),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10633,
			600,
			20201,
			25
		}
	},
	[33001009] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Sea/Sealevel.png",
		NeedDownDatingId = 33001008,
		UnlockLevel = 40,
		Dialog = 333103600,
		Id = 33001009,
		Level = 9,
		SoulId = 20010033,
		Name = getI18NValue(180556570),
		Describe = getI18NValue(180556569),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10633,
			800,
			20201,
			30
		}
	},
	[33001010] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BusinessStreet/BusinessStreet_day_sunny.png",
		NeedDownDatingId = 33001009,
		UnlockLevel = 43,
		Dialog = 333103800,
		Id = 33001010,
		Level = 10,
		SoulId = 20010033,
		Name = getI18NValue(180764760),
		Describe = getI18NValue(180764759),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10633,
			800,
			20201,
			30
		}
	},
	[33001011] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Port/Port_day_rainy.png",
		NeedDownDatingId = 33001010,
		UnlockLevel = 46,
		Dialog = 333104000,
		Id = 33001011,
		Level = 11,
		SoulId = 20010033,
		Name = getI18NValue(180764762),
		Describe = getI18NValue(180764761),
		ReturnGiftNum = {
			300,
			700
		},
		Cost = {
			10901,
			20
		},
		Reward = {
			10633,
			1000,
			20201,
			40
		}
	},
	[34001001] = {
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Livingroom/LivingRoom_day.png",
		UnlockLevel = 2,
		DatingType = 1,
		DatingTypeShow = 1,
		Dialog = 343101400,
		Id = 34001001,
		Level = 1,
		SoulId = 20010034,
		Name = getI18NValue(180484392),
		Describe = getI18NValue(180544272),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10634,
			100,
			20201,
			6
		}
	},
	[34001002] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Balcony/Balcony_day_sunny.png",
		NeedDownDatingId = 34001001,
		UnlockLevel = 5,
		Dialog = 343101500,
		Id = 34001002,
		Level = 2,
		SoulId = 20010034,
		Name = getI18NValue(180484394),
		Describe = getI18NValue(180544273),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10634,
			100,
			20201,
			6
		}
	},
	[34001003] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Balcony/Balcony_day_sunny.png",
		NeedDownDatingId = 34001002,
		UnlockLevel = 10,
		Dialog = 343101650,
		Id = 34001003,
		Level = 3,
		SoulId = 20010034,
		Name = getI18NValue(180484396),
		Describe = getI18NValue(180544274),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10634,
			250,
			20201,
			12
		}
	},
	[34001004] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Livingroom/LivingRoom_night.png",
		NeedDownDatingId = 34001003,
		UnlockLevel = 15,
		Dialog = 343103500,
		Id = 34001004,
		Level = 4,
		SoulId = 20010034,
		Name = getI18NValue(180555998),
		Describe = getI18NValue(180555997),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10634,
			250,
			20201,
			12
		}
	},
	[34001005] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Surburb/Surburb_night_sunny.png",
		NeedDownDatingId = 34001004,
		UnlockLevel = 20,
		Dialog = 343103600,
		Id = 34001005,
		Level = 5,
		SoulId = 20010034,
		Name = getI18NValue(180556000),
		Describe = getI18NValue(180555999),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10634,
			400,
			20201,
			20
		}
	},
	[34001006] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Livingroom/LivingRoom_day.png",
		NeedDownDatingId = 34001005,
		UnlockLevel = 25,
		Dialog = 343103700,
		Id = 34001006,
		Level = 6,
		SoulId = 20010034,
		Name = getI18NValue(180556002),
		Describe = getI18NValue(180556001),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10634,
			400,
			20201,
			20
		}
	},
	[34001007] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Livingroom/LivingRoom_day.png",
		NeedDownDatingId = 34001006,
		UnlockLevel = 30,
		Dialog = 343103800,
		Id = 34001007,
		Level = 7,
		SoulId = 20010034,
		Name = getI18NValue(180766097),
		Describe = getI18NValue(180766096),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10634,
			600,
			20201,
			25
		}
	},
	[34001008] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Livingroom/LivingRoom_day.png",
		NeedDownDatingId = 34001007,
		UnlockLevel = 35,
		Dialog = 343103900,
		Id = 34001008,
		Level = 8,
		SoulId = 20010034,
		Name = getI18NValue(180766099),
		Describe = getI18NValue(180766098),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10634,
			600,
			20201,
			25
		}
	},
	[34001009] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Livingroom/LivingRoom_day.png",
		NeedDownDatingId = 34001008,
		UnlockLevel = 40,
		Dialog = 343104000,
		Id = 34001009,
		Level = 9,
		SoulId = 20010034,
		Name = getI18NValue(180766101),
		Describe = getI18NValue(180766100),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10634,
			800,
			20201,
			30
		}
	},
	[34001010] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Church/Church_night_sunny.png",
		NeedDownDatingId = 34001009,
		UnlockLevel = 43,
		Dialog = 343104150,
		Id = 34001010,
		Level = 10,
		SoulId = 20010034,
		Name = getI18NValue(180823429),
		Describe = getI18NValue(180823428),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10634,
			800,
			20201,
			30
		}
	},
	[34001011] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Livingroom/LivingRoom_day.png",
		NeedDownDatingId = 34001010,
		UnlockLevel = 46,
		Dialog = 343104300,
		Id = 34001011,
		Level = 11,
		SoulId = 20010034,
		Name = getI18NValue(180823431),
		Describe = getI18NValue(180823430),
		ReturnGiftNum = {
			300,
			700
		},
		Cost = {
			10901,
			20
		},
		Reward = {
			10634,
			1000,
			20201,
			40
		}
	},
	[35001001] = {
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Livingroom/LivingRoom_day.png",
		UnlockLevel = 2,
		DatingType = 1,
		DatingTypeShow = 1,
		Dialog = 353101050,
		Id = 35001001,
		Level = 1,
		SoulId = 20010035,
		Name = getI18NValue(180484398),
		Describe = getI18NValue(180762999),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10635,
			100,
			20201,
			6
		}
	},
	[35001002] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Livingroom/LivingRoom_day.png",
		NeedDownDatingId = 35001001,
		UnlockLevel = 5,
		Dialog = 353101200,
		Id = 35001002,
		Level = 2,
		SoulId = 20010035,
		Name = getI18NValue(180484400),
		Describe = getI18NValue(180763000),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10635,
			100,
			20201,
			6
		}
	},
	[35001003] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Surburb/Surburb_day_sunny.png",
		NeedDownDatingId = 35001002,
		UnlockLevel = 10,
		Dialog = 353101300,
		Id = 35001003,
		Level = 3,
		SoulId = 20010035,
		Name = getI18NValue(180484402),
		Describe = getI18NValue(180763001),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10635,
			250,
			20201,
			12
		}
	},
	[35001004] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Livingroom/LivingRoom_day.png",
		NeedDownDatingId = 35001003,
		UnlockLevel = 15,
		Dialog = 353101600,
		Id = 35001004,
		Level = 4,
		SoulId = 20010035,
		Name = getI18NValue(180782719),
		Describe = getI18NValue(180782718),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10635,
			250,
			20201,
			12
		}
	},
	[35001005] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_HomePrivateRoom/GirlRoom_night.png",
		NeedDownDatingId = 35001004,
		UnlockLevel = 20,
		Dialog = 353101750,
		Id = 35001005,
		Level = 5,
		SoulId = 20010035,
		Name = getI18NValue(180782721),
		Describe = getI18NValue(180782720),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10635,
			400,
			20201,
			20
		}
	},
	[35001006] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Balcony/Balcony_night_sunny.png",
		NeedDownDatingId = 35001005,
		UnlockLevel = 25,
		Dialog = 353101900,
		Id = 35001006,
		Level = 6,
		SoulId = 20010035,
		Name = getI18NValue(180782723),
		Describe = getI18NValue(180782722),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10635,
			400,
			20201,
			20
		}
	},
	[35001007] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Livingroom/LivingRoom_day.png",
		NeedDownDatingId = 35001006,
		UnlockLevel = 30,
		Dialog = 353102000,
		Id = 35001007,
		Level = 7,
		SoulId = 20010035,
		Name = getI18NValue(180824860),
		Describe = getI18NValue(180824859),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10635,
			600,
			20201,
			25
		}
	},
	[35001008] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Surburb/Surburb_day_sunny.png",
		NeedDownDatingId = 35001007,
		UnlockLevel = 35,
		Dialog = 353102150,
		Id = 35001008,
		Level = 8,
		SoulId = 20010035,
		Name = getI18NValue(180824862),
		Describe = getI18NValue(180824861),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10635,
			600,
			20201,
			25
		}
	},
	[35001009] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_HomePrivateRoom/PlayerRoom_day.png",
		NeedDownDatingId = 35001008,
		UnlockLevel = 40,
		Dialog = 353102250,
		Id = 35001009,
		Level = 9,
		SoulId = 20010035,
		Name = getI18NValue(180824864),
		Describe = getI18NValue(180824863),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10635,
			800,
			20201,
			30
		}
	},
	[35001010] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_HomePrivateRoom/GirlRoom_night.png",
		NeedDownDatingId = 35001009,
		UnlockLevel = 43,
		Dialog = 353102350,
		Id = 35001010,
		Level = 10,
		SoulId = 20010035,
		Name = getI18NValue(180837540),
		Describe = getI18NValue(180837539),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10635,
			800,
			20201,
			30
		}
	},
	[35001011] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BusinessStreet/BusinessStreet_day_sunny.png",
		NeedDownDatingId = 35001010,
		UnlockLevel = 46,
		Dialog = 353102500,
		Id = 35001011,
		Level = 11,
		SoulId = 20010035,
		Name = getI18NValue(180837542),
		Describe = getI18NValue(180837541),
		ReturnGiftNum = {
			300,
			700
		},
		Cost = {
			10901,
			20
		},
		Reward = {
			10635,
			1000,
			20201,
			40
		}
	},
	[36001001] = {
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Livingroom/LivingRoom_day.png",
		UnlockLevel = 2,
		DatingType = 1,
		DatingTypeShow = 1,
		Dialog = 363101100,
		Id = 36001001,
		Level = 1,
		SoulId = 20010036,
		Name = getI18NValue(180484404),
		Describe = getI18NValue(180763002),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10636,
			100,
			20201,
			6
		}
	},
	[36001002] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BusinessStreet/BusinessStreet_day_sunny.png",
		NeedDownDatingId = 36001001,
		UnlockLevel = 5,
		Dialog = 363101230,
		Id = 36001002,
		Level = 2,
		SoulId = 20010036,
		Name = getI18NValue(180484406),
		Describe = getI18NValue(180763003),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10636,
			100,
			20201,
			6
		}
	},
	[36001003] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Livingroom/LivingRoom_night.png",
		NeedDownDatingId = 36001002,
		UnlockLevel = 10,
		Dialog = 363101350,
		Id = 36001003,
		Level = 3,
		SoulId = 20010036,
		Name = getI18NValue(180484408),
		Describe = getI18NValue(180763004),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10636,
			250,
			20201,
			12
		}
	},
	[36001004] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_DiningRoom/DiningRoom_day.png",
		NeedDownDatingId = 36001003,
		UnlockLevel = 15,
		Dialog = 363101700,
		Id = 36001004,
		Level = 4,
		SoulId = 20010036,
		Name = getI18NValue(180775698),
		Describe = getI18NValue(180775697),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10636,
			250,
			20201,
			12
		}
	},
	[36001005] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Balcony/Balcony_day_sunny.png",
		NeedDownDatingId = 36001004,
		UnlockLevel = 20,
		Dialog = 363101850,
		Id = 36001005,
		Level = 5,
		SoulId = 20010036,
		Name = getI18NValue(180775700),
		Describe = getI18NValue(180775699),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10636,
			400,
			20201,
			20
		}
	},
	[36001006] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Livingroom/LivingRoom_day.png",
		NeedDownDatingId = 36001005,
		UnlockLevel = 25,
		Dialog = 363102000,
		Id = 36001006,
		Level = 6,
		SoulId = 20010036,
		Name = getI18NValue(180775702),
		Describe = getI18NValue(180775701),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10636,
			400,
			20201,
			20
		}
	},
	[36001007] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Livingroom/LivingRoom_day.png",
		NeedDownDatingId = 36001006,
		UnlockLevel = 30,
		Dialog = 363102100,
		Id = 36001007,
		Level = 7,
		SoulId = 20010036,
		Name = getI18NValue(180824255),
		Describe = getI18NValue(180824254),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10636,
			600,
			20201,
			25
		}
	},
	[36001008] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Livingroom/LivingRoom_night.png",
		NeedDownDatingId = 36001007,
		UnlockLevel = 35,
		Dialog = 363102200,
		Id = 36001008,
		Level = 8,
		SoulId = 20010036,
		Name = getI18NValue(180824257),
		Describe = getI18NValue(180824256),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10636,
			600,
			20201,
			25
		}
	},
	[36001009] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Livingroom/LivingRoom_day.png",
		NeedDownDatingId = 36001008,
		UnlockLevel = 40,
		Dialog = 363102300,
		Id = 36001009,
		Level = 9,
		SoulId = 20010036,
		Name = getI18NValue(180824259),
		Describe = getI18NValue(180824258),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10636,
			800,
			20201,
			30
		}
	},
	[36001010] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Surburb/Surburb_day_sunny.png",
		NeedDownDatingId = 36001009,
		UnlockLevel = 43,
		Dialog = 363102400,
		Id = 36001010,
		Level = 10,
		SoulId = 20010036,
		Name = getI18NValue(180829722),
		Describe = getI18NValue(180829721),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10636,
			800,
			20201,
			30
		}
	},
	[36001011] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Livingroom/LivingRoom_day.png",
		NeedDownDatingId = 36001010,
		UnlockLevel = 46,
		Dialog = 363102500,
		Id = 36001011,
		Level = 11,
		SoulId = 20010036,
		Name = getI18NValue(180829724),
		Describe = getI18NValue(180829723),
		ReturnGiftNum = {
			300,
			700
		},
		Cost = {
			10901,
			20
		},
		Reward = {
			10636,
			1000,
			20201,
			40
		}
	},
	[37001001] = {
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Restaurant/Restaurant_1.png",
		UnlockLevel = 2,
		DatingType = 1,
		DatingTypeShow = 1,
		Dialog = 373101300,
		Id = 37001001,
		Level = 1,
		SoulId = 20010037,
		Name = getI18NValue(180484410),
		Describe = getI18NValue(180484409),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10637,
			100,
			20201,
			6
		}
	},
	[37001002] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Fields/Fields_sunny.png",
		NeedDownDatingId = 37001001,
		UnlockLevel = 5,
		Dialog = 373101450,
		Id = 37001002,
		Level = 2,
		SoulId = 20010037,
		Name = getI18NValue(180484412),
		Describe = getI18NValue(180484411),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10637,
			100,
			20201,
			6
		}
	},
	[37001003] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Carriage/Carriage.png",
		NeedDownDatingId = 37001002,
		UnlockLevel = 10,
		Dialog = 373101600,
		Id = 37001003,
		Level = 3,
		SoulId = 20010037,
		Name = getI18NValue(180484414),
		Describe = getI18NValue(180484413),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10637,
			250,
			20201,
			12
		}
	},
	[37001004] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_HomePrivateRoom/PlayerRoom_day.png",
		NeedDownDatingId = 37001003,
		UnlockLevel = 15,
		Dialog = 373101900,
		Id = 37001004,
		Level = 4,
		SoulId = 20010037,
		Name = getI18NValue(180823719),
		Describe = getI18NValue(180823718),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10637,
			250,
			20201,
			12
		}
	},
	[37001005] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_HomePrivateRoom/PlayerRoom_day.png",
		NeedDownDatingId = 37001004,
		UnlockLevel = 20,
		Dialog = 373102050,
		Id = 37001005,
		Level = 5,
		SoulId = 20010037,
		Name = getI18NValue(180823721),
		Describe = getI18NValue(180823720),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10637,
			400,
			20201,
			20
		}
	},
	[37001006] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Livingroom/LivingRoom_day.png",
		NeedDownDatingId = 37001005,
		UnlockLevel = 25,
		Dialog = 373102200,
		Id = 37001006,
		Level = 6,
		SoulId = 20010037,
		Name = getI18NValue(180823723),
		Describe = getI18NValue(180823722),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10637,
			400,
			20201,
			20
		}
	},
	[37001007] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Carriage/Carriage.png",
		NeedDownDatingId = 37001006,
		UnlockLevel = 30,
		Dialog = 373102350,
		Id = 37001007,
		Level = 7,
		SoulId = 20010037,
		Name = getI18NValue(180846323),
		Describe = getI18NValue(180846322),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10637,
			600,
			20201,
			25
		}
	},
	[37001008] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Sky/Sky_night_sunny.png",
		NeedDownDatingId = 37001007,
		UnlockLevel = 35,
		Dialog = 373102480,
		Id = 37001008,
		Level = 8,
		SoulId = 20010037,
		Name = getI18NValue(180846325),
		Describe = getI18NValue(180846324),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10637,
			600,
			20201,
			25
		}
	},
	[37001009] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Surburb/Surburb_day_sunny.png",
		NeedDownDatingId = 37001008,
		UnlockLevel = 40,
		Dialog = 373102640,
		Id = 37001009,
		Level = 9,
		SoulId = 20010037,
		Name = getI18NValue(180846327),
		Describe = getI18NValue(180846326),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10637,
			800,
			20201,
			30
		}
	},
	[37001010] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Livingroom/LivingRoom_day.png",
		NeedDownDatingId = 37001009,
		UnlockLevel = 43,
		Dialog = 373102760,
		Id = 37001010,
		Level = 10,
		SoulId = 20010037,
		Name = getI18NValue(180874009),
		Describe = getI18NValue(180874008),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10637,
			800,
			20201,
			30
		}
	},
	[37001011] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Corridor/Corridor_day.png",
		NeedDownDatingId = 37001010,
		UnlockLevel = 46,
		Dialog = 373102890,
		Id = 37001011,
		Level = 11,
		SoulId = 20010037,
		Name = getI18NValue(180874011),
		Describe = getI18NValue(180874010),
		ReturnGiftNum = {
			300,
			700
		},
		Cost = {
			10901,
			20
		},
		Reward = {
			10637,
			1000,
			20201,
			40
		}
	},
	[38001001] = {
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Livingroom/LivingRoom_day.png",
		UnlockLevel = 2,
		DatingType = 1,
		DatingTypeShow = 1,
		Dialog = 383101250,
		Id = 38001001,
		Level = 1,
		SoulId = 20010038,
		Name = getI18NValue(180484416),
		Describe = getI18NValue(180484415),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10638,
			100,
			20201,
			6
		}
	},
	[38001002] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BusinessStreet/BusinessStreet_day_sunny.png",
		NeedDownDatingId = 38001001,
		UnlockLevel = 5,
		Dialog = 383101350,
		Id = 38001002,
		Level = 2,
		SoulId = 20010038,
		Name = getI18NValue(180484418),
		Describe = getI18NValue(180484417),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10638,
			100,
			20201,
			6
		}
	},
	[38001003] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Livingroom/LivingRoom_day.png",
		NeedDownDatingId = 38001002,
		UnlockLevel = 10,
		Dialog = 383101450,
		Id = 38001003,
		Level = 3,
		SoulId = 20010038,
		Name = getI18NValue(180484420),
		Describe = getI18NValue(180484419),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10638,
			250,
			20201,
			12
		}
	},
	[38001004] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BusinessStreet/BusinessStreet_day_sunny.png",
		NeedDownDatingId = 38001003,
		UnlockLevel = 15,
		Dialog = 383101800,
		Id = 38001004,
		Level = 4,
		SoulId = 20010038,
		Name = getI18NValue(180828569),
		Describe = getI18NValue(180828568),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10638,
			250,
			20201,
			12
		}
	},
	[38001005] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Livingroom/LivingRoom_day.png",
		NeedDownDatingId = 38001004,
		UnlockLevel = 20,
		Dialog = 383101950,
		Id = 38001005,
		Level = 5,
		SoulId = 20010038,
		Name = getI18NValue(180828571),
		Describe = getI18NValue(180828570),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10638,
			400,
			20201,
			20
		}
	},
	[38001006] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Livingroom/LivingRoom_day.png",
		NeedDownDatingId = 38001005,
		UnlockLevel = 25,
		Dialog = 383102100,
		Id = 38001006,
		Level = 6,
		SoulId = 20010038,
		Name = getI18NValue(180828573),
		Describe = getI18NValue(180828572),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10638,
			400,
			20201,
			20
		}
	},
	[38001007] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Sea/Sea.png",
		NeedDownDatingId = 38001006,
		UnlockLevel = 30,
		Dialog = 383102250,
		Id = 38001007,
		Level = 7,
		SoulId = 20010038,
		Name = getI18NValue(180845229),
		Describe = getI18NValue(180845228),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10638,
			600,
			20201,
			25
		}
	},
	[38001008] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Livingroom/LivingRoom_day.png",
		NeedDownDatingId = 38001007,
		UnlockLevel = 35,
		Dialog = 383102350,
		Id = 38001008,
		Level = 8,
		SoulId = 20010038,
		Name = getI18NValue(180845231),
		Describe = getI18NValue(180845230),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10638,
			600,
			20201,
			25
		}
	},
	[38001009] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_HomePrivateRoom/GirlRoom_day.png",
		NeedDownDatingId = 38001008,
		UnlockLevel = 40,
		Dialog = 383102450,
		Id = 38001009,
		Level = 9,
		SoulId = 20010038,
		Name = getI18NValue(180845233),
		Describe = getI18NValue(180845232),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10638,
			800,
			20201,
			30
		}
	},
	[38001010] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Balcony/Balcony_day_sunny.png",
		NeedDownDatingId = 38001009,
		UnlockLevel = 43,
		Dialog = 383102600,
		Id = 38001010,
		Level = 10,
		SoulId = 20010038,
		Name = getI18NValue(180881415),
		Describe = getI18NValue(180881414),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10638,
			800,
			20201,
			30
		}
	},
	[38001011] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Port/Port_day_sunny.png",
		NeedDownDatingId = 38001010,
		UnlockLevel = 46,
		Dialog = 383102720,
		Id = 38001011,
		Level = 11,
		SoulId = 20010038,
		Name = getI18NValue(180881417),
		Describe = getI18NValue(180881416),
		ReturnGiftNum = {
			300,
			700
		},
		Cost = {
			10901,
			20
		},
		Reward = {
			10638,
			1000,
			20201,
			40
		}
	},
	[39001001] = {
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Livingroom/LivingRoom_day.png",
		UnlockLevel = 2,
		DatingType = 1,
		DatingTypeShow = 1,
		Dialog = 393101350,
		Id = 39001001,
		Level = 1,
		SoulId = 20010039,
		Name = getI18NValue(180484422),
		Describe = getI18NValue(180484421),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10639,
			100,
			20201,
			6
		}
	},
	[39001002] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Livingroom/LivingRoom_day.png",
		NeedDownDatingId = 39001001,
		UnlockLevel = 5,
		Dialog = 393101500,
		Id = 39001002,
		Level = 2,
		SoulId = 20010039,
		Name = getI18NValue(180484424),
		Describe = getI18NValue(180484423),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10639,
			100,
			20201,
			6
		}
	},
	[39001003] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Surburb/Surburb_day_sunny.png",
		NeedDownDatingId = 39001002,
		UnlockLevel = 10,
		Dialog = 393101600,
		Id = 39001003,
		Level = 3,
		SoulId = 20010039,
		Name = getI18NValue(180484426),
		Describe = getI18NValue(180484425),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10639,
			250,
			20201,
			12
		}
	},
	[39001004] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Livingroom/LivingRoom_day.png",
		NeedDownDatingId = 39001003,
		UnlockLevel = 15,
		Dialog = 393101750,
		Id = 39001004,
		Level = 4,
		SoulId = 20010039,
		Name = getI18NValue(180833293),
		Describe = getI18NValue(180833292),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10639,
			250,
			20201,
			12
		}
	},
	[39001005] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_HomePrivateRoom/PlayerRoom_day.png",
		NeedDownDatingId = 39001004,
		UnlockLevel = 20,
		Dialog = 393101900,
		Id = 39001005,
		Level = 5,
		SoulId = 20010039,
		Name = getI18NValue(180833295),
		Describe = getI18NValue(180833294),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10639,
			400,
			20201,
			20
		}
	},
	[39001006] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Livingroom/LivingRoom_day.png",
		NeedDownDatingId = 39001005,
		UnlockLevel = 25,
		Dialog = 393102050,
		Id = 39001006,
		Level = 6,
		SoulId = 20010039,
		Name = getI18NValue(180833297),
		Describe = getI18NValue(180833296),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10639,
			400,
			20201,
			20
		}
	},
	[39001007] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BlackStreet/BlackStreet_night_sunny.png",
		NeedDownDatingId = 39001006,
		UnlockLevel = 30,
		Dialog = 403103220,
		Id = 39001007,
		Level = 7,
		SoulId = 20010039,
		Name = getI18NValue(180868593),
		Describe = getI18NValue(180868592),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10639,
			600,
			20201,
			25
		}
	},
	[39001008] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Livingroom/LivingRoom_day.png",
		NeedDownDatingId = 39001007,
		UnlockLevel = 35,
		Dialog = 403103330,
		Id = 39001008,
		Level = 8,
		SoulId = 20010039,
		Name = getI18NValue(180868595),
		Describe = getI18NValue(180868594),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10639,
			600,
			20201,
			25
		}
	},
	[39001009] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BlackStreet/BlackStreet_day_sunny.png",
		NeedDownDatingId = 39001008,
		UnlockLevel = 40,
		Dialog = 403103440,
		Id = 39001009,
		Level = 9,
		SoulId = 20010039,
		Name = getI18NValue(180868597),
		Describe = getI18NValue(180868596),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10639,
			800,
			20201,
			30
		}
	},
	[39001010] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Church/InChurch.png",
		NeedDownDatingId = 39001009,
		UnlockLevel = 43,
		Dialog = 393102500,
		Id = 39001010,
		Level = 10,
		SoulId = 20010039,
		Name = getI18NValue(180882193),
		Describe = getI18NValue(180882192),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10639,
			800,
			20201,
			30
		}
	},
	[39001011] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Livingroom/LivingRoom_day.png",
		NeedDownDatingId = 39001010,
		UnlockLevel = 46,
		Dialog = 393102600,
		Id = 39001011,
		Level = 11,
		SoulId = 20010039,
		Name = getI18NValue(180882195),
		Describe = getI18NValue(180882194),
		ReturnGiftNum = {
			300,
			700
		},
		Cost = {
			10901,
			20
		},
		Reward = {
			10639,
			1000,
			20201,
			40
		}
	},
	[40001001] = {
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Church/ChurchStage.png",
		UnlockLevel = 2,
		DatingType = 1,
		DatingTypeShow = 1,
		Dialog = 403101200,
		Id = 40001001,
		Level = 1,
		SoulId = 20010040,
		Name = getI18NValue(180484428),
		Describe = getI18NValue(180484427),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10640,
			100,
			20201,
			6
		}
	},
	[40001002] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Sea/LoopBg_Seaside.png",
		NeedDownDatingId = 40001001,
		UnlockLevel = 5,
		Dialog = 403101350,
		Id = 40001002,
		Level = 2,
		SoulId = 20010040,
		Name = getI18NValue(180484430),
		Describe = getI18NValue(180484429),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10640,
			100,
			20201,
			6
		}
	},
	[40001003] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Surburb/Surburb_night_sunny.png",
		NeedDownDatingId = 40001002,
		UnlockLevel = 10,
		Dialog = 403101550,
		Id = 40001003,
		Level = 3,
		SoulId = 20010040,
		Name = getI18NValue(180484432),
		Describe = getI18NValue(180484431),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10640,
			250,
			20201,
			12
		}
	},
	[40001004] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Sea/LoopBg_Seaside.png",
		NeedDownDatingId = 40001003,
		UnlockLevel = 15,
		Dialog = 403103560,
		Id = 40001004,
		Level = 4,
		SoulId = 20010040,
		Name = getI18NValue(180897285),
		Describe = getI18NValue(180897284),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10640,
			250,
			20201,
			12
		}
	},
	[40001005] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BusinessStreet/BusinessStreet_day_sunny.png",
		NeedDownDatingId = 40001004,
		UnlockLevel = 20,
		Dialog = 403103700,
		Id = 40001005,
		Level = 5,
		SoulId = 20010040,
		Name = getI18NValue(180897287),
		Describe = getI18NValue(180897286),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10640,
			400,
			20201,
			20
		}
	},
	[40001006] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Fields/Fields_sunny.png",
		NeedDownDatingId = 40001005,
		UnlockLevel = 25,
		Dialog = 403103820,
		Id = 40001006,
		Level = 6,
		SoulId = 20010040,
		Name = getI18NValue(180897289),
		Describe = getI18NValue(180897288),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10640,
			400,
			20201,
			20
		}
	},
	[40001007] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Garden/Garden_day_sunny.png",
		NeedDownDatingId = 40001006,
		UnlockLevel = 30,
		Dialog = 403104200,
		Id = 40001007,
		Level = 7,
		SoulId = 20010040,
		Name = getI18NValue(180909717),
		Describe = getI18NValue(180909716),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10640,
			600,
			20201,
			25
		}
	},
	[40001008] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Sea/Sea.png",
		NeedDownDatingId = 40001007,
		UnlockLevel = 35,
		Dialog = 403104320,
		Id = 40001008,
		Level = 8,
		SoulId = 20010040,
		Name = getI18NValue(180909719),
		Describe = getI18NValue(180909718),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10640,
			600,
			20201,
			25
		}
	},
	[40001009] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_HomePrivateRoom/PlayerRoom_day.png",
		NeedDownDatingId = 40001008,
		UnlockLevel = 40,
		Dialog = 403104450,
		Id = 40001009,
		Level = 9,
		SoulId = 20010040,
		Name = getI18NValue(180909721),
		Describe = getI18NValue(180909720),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10640,
			800,
			20201,
			30
		}
	},
	[40001010] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_HomePrivateRoom/PlayerRoom_night.png",
		NeedDownDatingId = 40001009,
		UnlockLevel = 43,
		Dialog = 403104570,
		Id = 40001010,
		Level = 10,
		SoulId = 20010040,
		Name = getI18NValue(180917742),
		Describe = getI18NValue(180917741),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10640,
			800,
			20201,
			30
		}
	},
	[40001011] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Balcony/Balcony_day_sunny.png",
		NeedDownDatingId = 40001010,
		UnlockLevel = 46,
		Dialog = 403104700,
		Id = 40001011,
		Level = 11,
		SoulId = 20010040,
		Name = getI18NValue(180917744),
		Describe = getI18NValue(180917743),
		ReturnGiftNum = {
			300,
			700
		},
		Cost = {
			10901,
			20
		},
		Reward = {
			10640,
			1000,
			20201,
			40
		}
	},
	[41001001] = {
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Balcony/Balcony_day_sunny.png",
		UnlockLevel = 2,
		DatingType = 1,
		DatingTypeShow = 1,
		Dialog = 413101350,
		Id = 41001001,
		Level = 1,
		SoulId = 20010041,
		Name = getI18NValue(180484434),
		Describe = getI18NValue(180484433),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10641,
			100,
			20201,
			6
		}
	},
	[41001002] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Livingroom/LivingRoom_day.png",
		NeedDownDatingId = 41001001,
		UnlockLevel = 5,
		Dialog = 413101500,
		Id = 41001002,
		Level = 2,
		SoulId = 20010041,
		Name = getI18NValue(180484436),
		Describe = getI18NValue(180484435),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10641,
			100,
			20201,
			6
		}
	},
	[41001003] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Livingroom/LivingRoom_day.png",
		NeedDownDatingId = 41001002,
		UnlockLevel = 10,
		Dialog = 413101600,
		Id = 41001003,
		Level = 3,
		SoulId = 20010041,
		Name = getI18NValue(180484438),
		Describe = getI18NValue(180484437),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10641,
			250,
			20201,
			12
		}
	},
	[41001004] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Museum/Museum_day.png",
		NeedDownDatingId = 41001003,
		UnlockLevel = 15,
		Dialog = 413101900,
		Id = 41001004,
		Level = 4,
		SoulId = 20010041,
		Name = getI18NValue(180845489),
		Describe = getI18NValue(180845488),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10641,
			250,
			20201,
			12
		}
	},
	[41001005] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Livingroom/LivingRoom_night.png",
		NeedDownDatingId = 41001004,
		UnlockLevel = 20,
		Dialog = 413102050,
		Id = 41001005,
		Level = 5,
		SoulId = 20010041,
		Name = getI18NValue(180845491),
		Describe = getI18NValue(180845490),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10641,
			400,
			20201,
			20
		}
	},
	[41001006] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Livingroom/LivingRoom_day.png",
		NeedDownDatingId = 41001005,
		UnlockLevel = 25,
		Dialog = 413102200,
		Id = 41001006,
		Level = 6,
		SoulId = 20010041,
		Name = getI18NValue(180845493),
		Describe = getI18NValue(180845492),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10641,
			400,
			20201,
			20
		}
	},
	[41001007] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Surburb/Surburb_day_sunny.png",
		NeedDownDatingId = 41001006,
		UnlockLevel = 30,
		Dialog = 413102300,
		Id = 41001007,
		Level = 7,
		SoulId = 20010041,
		Name = getI18NValue(180898074),
		Describe = getI18NValue(180898073),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10641,
			600,
			20201,
			25
		}
	},
	[41001008] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Surburb/Surburb_night_sunny.png",
		NeedDownDatingId = 41001007,
		UnlockLevel = 35,
		Dialog = 413102400,
		Id = 41001008,
		Level = 8,
		SoulId = 20010041,
		Name = getI18NValue(180898076),
		Describe = getI18NValue(180898075),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10641,
			600,
			20201,
			25
		}
	},
	[41001009] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Sea/Sealevel.png",
		NeedDownDatingId = 41001008,
		UnlockLevel = 40,
		Dialog = 413102500,
		Id = 41001009,
		Level = 9,
		SoulId = 20010041,
		Name = getI18NValue(180898078),
		Describe = getI18NValue(180898077),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10641,
			800,
			20201,
			30
		}
	},
	[41001010] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Livingroom/LivingRoom_day.png",
		NeedDownDatingId = 41001009,
		UnlockLevel = 43,
		Dialog = 413102630,
		Id = 41001010,
		Level = 10,
		SoulId = 20010041,
		Name = getI18NValue(180905426),
		Describe = getI18NValue(180905425),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10641,
			800,
			20201,
			30
		}
	},
	[41001011] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Fields/Fields_sunny.png",
		NeedDownDatingId = 41001010,
		UnlockLevel = 46,
		Dialog = 413102750,
		Id = 41001011,
		Level = 11,
		SoulId = 20010041,
		Name = getI18NValue(180905428),
		Describe = getI18NValue(180905427),
		ReturnGiftNum = {
			300,
			700
		},
		Cost = {
			10901,
			20
		},
		Reward = {
			10641,
			1000,
			20201,
			40
		}
	},
	[42001001] = {
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Dreaming/Dreaming.png",
		UnlockLevel = 2,
		DatingType = 1,
		DatingTypeShow = 1,
		Dialog = 403102850,
		Id = 42001001,
		Level = 1,
		SoulId = 20010042,
		Name = getI18NValue(180484440),
		Describe = getI18NValue(180484439),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10642,
			100,
			20201,
			6
		}
	},
	[42001002] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Surburb/Surburb_day_sunny.png",
		NeedDownDatingId = 42001001,
		UnlockLevel = 5,
		Dialog = 403103000,
		Id = 42001002,
		Level = 2,
		SoulId = 20010042,
		Name = getI18NValue(180484442),
		Describe = getI18NValue(180484441),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10642,
			100,
			20201,
			6
		}
	},
	[42001003] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Surburb/Surburb_night_sunny.png",
		NeedDownDatingId = 42001002,
		UnlockLevel = 10,
		Dialog = 403103100,
		Id = 42001003,
		Level = 3,
		SoulId = 20010042,
		Name = getI18NValue(180484444),
		Describe = getI18NValue(180484443),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10642,
			250,
			20201,
			12
		}
	},
	[42001004] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Kitchen/Kitchen_day.png",
		NeedDownDatingId = 42001003,
		UnlockLevel = 15,
		Dialog = 423103400,
		Id = 42001004,
		Level = 4,
		SoulId = 20010042,
		Name = getI18NValue(180898904),
		Describe = getI18NValue(180898903),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10642,
			250,
			20201,
			12
		}
	},
	[42001005] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Museum/Museum_day.png",
		NeedDownDatingId = 42001004,
		UnlockLevel = 20,
		Dialog = 423103600,
		Id = 42001005,
		Level = 5,
		SoulId = 20010042,
		Name = getI18NValue(180898906),
		Describe = getI18NValue(180898905),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10642,
			400,
			20201,
			20
		}
	},
	[42001006] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_HomePrivateRoom/GirlRoom_day.png",
		NeedDownDatingId = 42001005,
		UnlockLevel = 25,
		Dialog = 423103700,
		Id = 42001006,
		Level = 6,
		SoulId = 20010042,
		Name = getI18NValue(180898908),
		Describe = getI18NValue(180898907),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10642,
			400,
			20201,
			20
		}
	},
	[42001007] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Carriage/Carriage.png",
		NeedDownDatingId = 42001006,
		UnlockLevel = 30,
		Dialog = 423103830,
		Id = 42001007,
		Level = 7,
		SoulId = 20010042,
		Name = getI18NValue(180917500),
		Describe = getI18NValue(180917499),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10642,
			600,
			20201,
			25
		}
	},
	[42001008] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Surburb/Surburb_day_sunny.png",
		NeedDownDatingId = 42001007,
		UnlockLevel = 35,
		Dialog = 423103950,
		Id = 42001008,
		Level = 8,
		SoulId = 20010042,
		Name = getI18NValue(180917502),
		Describe = getI18NValue(180917501),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10642,
			600,
			20201,
			25
		}
	},
	[42001009] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Church/Church_day_sunny.png",
		NeedDownDatingId = 42001008,
		UnlockLevel = 40,
		Dialog = 423104080,
		Id = 42001009,
		Level = 9,
		SoulId = 20010042,
		Name = getI18NValue(180917504),
		Describe = getI18NValue(180917503),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10642,
			800,
			20201,
			30
		}
	},
	[42001010] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Fields/Fields_sunny.png",
		NeedDownDatingId = 42001009,
		UnlockLevel = 43,
		Dialog = 423104200,
		Id = 42001010,
		Level = 10,
		SoulId = 20010042,
		Name = getI18NValue(180918054),
		Describe = getI18NValue(180918053),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10642,
			800,
			20201,
			30
		}
	},
	[42001011] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_HomePrivateRoom/Alchemy.png",
		NeedDownDatingId = 42001010,
		UnlockLevel = 46,
		Dialog = 423104310,
		Id = 42001011,
		Level = 11,
		SoulId = 20010042,
		Name = getI18NValue(180918056),
		Describe = getI18NValue(180918055),
		ReturnGiftNum = {
			300,
			700
		},
		Cost = {
			10901,
			20
		},
		Reward = {
			10642,
			1000,
			20201,
			40
		}
	},
	[43001001] = {
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BusinessStreet/BusinessStreet_day_sunny.png",
		UnlockLevel = 2,
		DatingType = 1,
		DatingTypeShow = 1,
		Dialog = 433101470,
		Id = 43001001,
		Level = 1,
		SoulId = 20010043,
		Name = getI18NValue(180484446),
		Describe = getI18NValue(180484445),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10643,
			100,
			20201,
			6
		}
	},
	[43001002] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Restaurant/Restaurant.png",
		NeedDownDatingId = 43001001,
		UnlockLevel = 5,
		Dialog = 433101630,
		Id = 43001002,
		Level = 2,
		SoulId = 20010043,
		Name = getI18NValue(180484448),
		Describe = getI18NValue(180484447),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10643,
			100,
			20201,
			6
		}
	},
	[43001003] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Livingroom/LivingRoom_day.png",
		NeedDownDatingId = 43001002,
		UnlockLevel = 10,
		Dialog = 433101750,
		Id = 43001003,
		Level = 3,
		SoulId = 20010043,
		Name = getI18NValue(180484450),
		Describe = getI18NValue(180484449),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10643,
			250,
			20201,
			12
		}
	},
	[43001004] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Livingroom/LivingRoom_night.png",
		NeedDownDatingId = 43001003,
		UnlockLevel = 15,
		Dialog = 433101900,
		Id = 43001004,
		Level = 4,
		SoulId = 20010043,
		Name = getI18NValue(180904558),
		Describe = getI18NValue(180904557),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10643,
			250,
			20201,
			12
		}
	},
	[43001005] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Funroom/Funroom.png",
		NeedDownDatingId = 43001004,
		UnlockLevel = 20,
		Dialog = 433102020,
		Id = 43001005,
		Level = 5,
		SoulId = 20010043,
		Name = getI18NValue(180904560),
		Describe = getI18NValue(180904559),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10643,
			400,
			20201,
			20
		}
	},
	[43001006] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_HomePrivateRoom/Library.png",
		NeedDownDatingId = 43001005,
		UnlockLevel = 25,
		Dialog = 433102150,
		Id = 43001006,
		Level = 6,
		SoulId = 20010043,
		Name = getI18NValue(180904562),
		Describe = getI18NValue(180904561),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10643,
			400,
			20201,
			20
		}
	},
	[43001007] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Livingroom/LivingRoom_day.png",
		NeedDownDatingId = 43001006,
		UnlockLevel = 30,
		Dialog = 433102500,
		Id = 43001007,
		Level = 7,
		SoulId = 20010043,
		Name = getI18NValue(180917506),
		Describe = getI18NValue(180917505),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10643,
			600,
			20201,
			25
		}
	},
	[43001008] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Balcony/Balcony_night_sunny.png",
		NeedDownDatingId = 43001007,
		UnlockLevel = 35,
		Dialog = 433102630,
		Id = 43001008,
		Level = 8,
		SoulId = 20010043,
		Name = getI18NValue(180917508),
		Describe = getI18NValue(180917507),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10643,
			600,
			20201,
			25
		}
	},
	[43001009] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Livingroom/LivingRoom_day.png",
		NeedDownDatingId = 43001008,
		UnlockLevel = 40,
		Dialog = 433102750,
		Id = 43001009,
		Level = 9,
		SoulId = 20010043,
		Name = getI18NValue(180917510),
		Describe = getI18NValue(180917509),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10643,
			800,
			20201,
			30
		}
	},
	[43001010] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Dreaming/Dreaming.png",
		NeedDownDatingId = 43001009,
		UnlockLevel = 43,
		Dialog = 433102900,
		Id = 43001010,
		Level = 10,
		SoulId = 20010043,
		Name = getI18NValue(181199098),
		Describe = getI18NValue(181199097),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10643,
			800,
			20201,
			30
		}
	},
	[43001011] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Dreaming/Dreaming.png",
		NeedDownDatingId = 43001010,
		UnlockLevel = 46,
		Dialog = 433103050,
		Id = 43001011,
		Level = 11,
		SoulId = 20010043,
		Name = getI18NValue(181199100),
		Describe = getI18NValue(181199099),
		ReturnGiftNum = {
			300,
			700
		},
		Cost = {
			10901,
			20
		},
		Reward = {
			10643,
			1000,
			20201,
			40
		}
	},
	[44001001] = {
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Livingroom/LivingRoom_day.png",
		UnlockLevel = 2,
		DatingType = 1,
		DatingTypeShow = 1,
		Dialog = 443101250,
		Id = 44001001,
		Level = 1,
		SoulId = 20010044,
		Name = getI18NValue(180484452),
		Describe = getI18NValue(180484451),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10644,
			100,
			20201,
			6
		}
	},
	[44001002] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Livingroom/LivingRoom_day.png",
		NeedDownDatingId = 44001001,
		UnlockLevel = 5,
		Dialog = 443101380,
		Id = 44001002,
		Level = 2,
		SoulId = 20010044,
		Name = getI18NValue(180484454),
		Describe = getI18NValue(180484453),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10644,
			100,
			20201,
			6
		}
	},
	[44001003] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Livingroom/LivingRoom_day.png",
		NeedDownDatingId = 44001002,
		UnlockLevel = 10,
		Dialog = 443101510,
		Id = 44001003,
		Level = 3,
		SoulId = 20010044,
		Name = getI18NValue(180484456),
		Describe = getI18NValue(180484455),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10644,
			250,
			20201,
			12
		}
	},
	[44001004] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Livingroom/LivingRoom_day.png",
		NeedDownDatingId = 44001003,
		UnlockLevel = 15,
		Dialog = 443101640,
		Id = 44001004,
		Level = 4,
		SoulId = 20010044,
		Name = getI18NValue(180905430),
		Describe = getI18NValue(180905429),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10644,
			250,
			20201,
			12
		}
	},
	[44001005] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Sea/LoopBg_Seaside.png",
		NeedDownDatingId = 44001004,
		UnlockLevel = 20,
		Dialog = 443101760,
		Id = 44001005,
		Level = 5,
		SoulId = 20010044,
		Name = getI18NValue(180905432),
		Describe = getI18NValue(180905431),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10644,
			400,
			20201,
			20
		}
	},
	[44001006] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BusinessStreet/ClothingShop.png",
		NeedDownDatingId = 44001005,
		UnlockLevel = 25,
		Dialog = 443101880,
		Id = 44001006,
		Level = 6,
		SoulId = 20010044,
		Name = getI18NValue(180905434),
		Describe = getI18NValue(180905433),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10644,
			400,
			20201,
			20
		}
	},
	[44001007] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Fields/Fields_sunny.png",
		NeedDownDatingId = 44001006,
		UnlockLevel = 30,
		Dialog = 443102000,
		Id = 44001007,
		Level = 7,
		SoulId = 20010044,
		Name = getI18NValue(180913151),
		Describe = getI18NValue(180913150),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10644,
			600,
			20201,
			25
		}
	},
	[44001008] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_CenterSquare/CenterSquare_night_sunny.png",
		NeedDownDatingId = 44001007,
		UnlockLevel = 35,
		Dialog = 443102120,
		Id = 44001008,
		Level = 8,
		SoulId = 20010044,
		Name = getI18NValue(180913153),
		Describe = getI18NValue(180913152),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10644,
			600,
			20201,
			25
		}
	},
	[44001009] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Church/InChurch.png",
		NeedDownDatingId = 44001008,
		UnlockLevel = 40,
		Dialog = 443102240,
		Id = 44001009,
		Level = 9,
		SoulId = 20010044,
		Name = getI18NValue(180913155),
		Describe = getI18NValue(180913154),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10644,
			800,
			20201,
			30
		}
	},
	[44001010] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_HomePrivateRoom/PlayerRoom_day.png",
		NeedDownDatingId = 44001009,
		UnlockLevel = 43,
		Dialog = 443102570,
		Id = 44001010,
		Level = 10,
		SoulId = 20010044,
		Name = getI18NValue(180923477),
		Describe = getI18NValue(180923476),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10644,
			800,
			20201,
			30
		}
	},
	[44001011] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_HomePrivateRoom/PlayerRoom_night.png",
		NeedDownDatingId = 44001010,
		UnlockLevel = 46,
		Dialog = 443102700,
		Id = 44001011,
		Level = 11,
		SoulId = 20010044,
		Name = getI18NValue(180923479),
		Describe = getI18NValue(180923478),
		ReturnGiftNum = {
			300,
			700
		},
		Cost = {
			10901,
			20
		},
		Reward = {
			10644,
			1000,
			20201,
			40
		}
	},
	[45001001] = {
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Livingroom/LivingRoom_day.png",
		UnlockLevel = 2,
		DatingType = 1,
		DatingTypeShow = 1,
		Dialog = 453101260,
		Id = 45001001,
		Level = 1,
		SoulId = 20010045,
		Name = getI18NValue(180484458),
		Describe = getI18NValue(180484457),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10645,
			100,
			20201,
			6
		}
	},
	[45001002] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BlackStreet/BlackStreet_day_sunny.png",
		NeedDownDatingId = 45001001,
		UnlockLevel = 5,
		Dialog = 453101380,
		Id = 45001002,
		Level = 2,
		SoulId = 20010045,
		Name = getI18NValue(180484460),
		Describe = getI18NValue(180484459),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10645,
			100,
			20201,
			6
		}
	},
	[45001003] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Funroom/Funroom.png",
		NeedDownDatingId = 45001002,
		UnlockLevel = 10,
		Dialog = 453101520,
		Id = 45001003,
		Level = 3,
		SoulId = 20010045,
		Name = getI18NValue(180484462),
		Describe = getI18NValue(180484461),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10645,
			250,
			20201,
			12
		}
	},
	[45001004] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Sea/Sea.png",
		NeedDownDatingId = 45001003,
		UnlockLevel = 15,
		Dialog = 453101900,
		Id = 45001004,
		Level = 4,
		SoulId = 20010045,
		Name = getI18NValue(180945793),
		Describe = getI18NValue(180945792),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10645,
			250,
			20201,
			12
		}
	},
	[45001005] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BusinessStreet/BusinessStreet_day_sunny.png",
		NeedDownDatingId = 45001004,
		UnlockLevel = 20,
		Dialog = 453102050,
		Id = 45001005,
		Level = 5,
		SoulId = 20010045,
		Name = getI18NValue(180945795),
		Describe = getI18NValue(180945794),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10645,
			400,
			20201,
			20
		}
	},
	[45001006] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Sea/Sea.png",
		NeedDownDatingId = 45001005,
		UnlockLevel = 25,
		Dialog = 453102200,
		Id = 45001006,
		Level = 6,
		SoulId = 20010045,
		Name = getI18NValue(180945797),
		Describe = getI18NValue(180945796),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10645,
			400,
			20201,
			20
		}
	},
	[45001007] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BlackStreet/BlackStreet_day_sunny.png",
		NeedDownDatingId = 45001006,
		UnlockLevel = 30,
		Dialog = 453102350,
		Id = 45001007,
		Level = 7,
		SoulId = 20010045,
		Name = getI18NValue(180950073),
		Describe = getI18NValue(180950072),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10645,
			600,
			20201,
			25
		}
	},
	[45001008] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BlackStreet/BlackStreet_night_rainy.png",
		NeedDownDatingId = 45001007,
		UnlockLevel = 35,
		Dialog = 453102500,
		Id = 45001008,
		Level = 8,
		SoulId = 20010045,
		Name = getI18NValue(180950075),
		Describe = getI18NValue(180950074),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10645,
			600,
			20201,
			25
		}
	},
	[45001009] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Church/Church_night_sunny.png",
		NeedDownDatingId = 45001008,
		UnlockLevel = 40,
		Dialog = 453102650,
		Id = 45001009,
		Level = 9,
		SoulId = 20010045,
		Name = getI18NValue(180950077),
		Describe = getI18NValue(180950076),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10645,
			800,
			20201,
			30
		}
	},
	[45001010] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Livingroom/LivingRoom_day.png",
		NeedDownDatingId = 45001009,
		UnlockLevel = 43,
		Dialog = 453102800,
		Id = 45001010,
		Level = 10,
		SoulId = 20010045,
		Name = getI18NValue(181196292),
		Describe = getI18NValue(181196291),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10645,
			800,
			20201,
			30
		}
	},
	[45001011] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Sea/LoopBg_Seaside.png",
		NeedDownDatingId = 45001010,
		UnlockLevel = 46,
		Dialog = 453102950,
		Id = 45001011,
		Level = 11,
		SoulId = 20010045,
		Name = getI18NValue(181196294),
		Describe = getI18NValue(181196293),
		ReturnGiftNum = {
			300,
			700
		},
		Cost = {
			10901,
			20
		},
		Reward = {
			10645,
			1000,
			20201,
			40
		}
	},
	[46001001] = {
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BusinessStreet/BusinessStreet_day_sunny.png",
		UnlockLevel = 2,
		DatingType = 1,
		DatingTypeShow = 1,
		Dialog = 463101180,
		Id = 46001001,
		Level = 1,
		SoulId = 20010046,
		Name = getI18NValue(180885662),
		Describe = getI18NValue(180885661),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10646,
			100,
			20201,
			6
		}
	},
	[46001002] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Garden1/Garden1_day_sunny.png",
		NeedDownDatingId = 46001001,
		UnlockLevel = 5,
		Dialog = 463101290,
		Id = 46001002,
		Level = 2,
		SoulId = 20010046,
		Name = getI18NValue(180885664),
		Describe = getI18NValue(180885663),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10646,
			100,
			20201,
			6
		}
	},
	[46001003] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Surburb/Surburb_day_rainy.png",
		NeedDownDatingId = 46001002,
		UnlockLevel = 10,
		Dialog = 463101410,
		Id = 46001003,
		Level = 3,
		SoulId = 20010046,
		Name = getI18NValue(180885666),
		Describe = getI18NValue(180885665),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10646,
			250,
			20201,
			12
		}
	},
	[46001004] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Fields/Fields_sunny.png",
		NeedDownDatingId = 46001003,
		UnlockLevel = 15,
		Dialog = 463101650,
		Id = 46001004,
		Level = 4,
		SoulId = 20010046,
		Name = getI18NValue(180930445),
		Describe = getI18NValue(180930444),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10646,
			250,
			20201,
			12
		}
	},
	[46001005] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Fields/Fields_sunny.png",
		NeedDownDatingId = 46001004,
		UnlockLevel = 20,
		Dialog = 463101750,
		Id = 46001005,
		Level = 5,
		SoulId = 20010046,
		Name = getI18NValue(180930447),
		Describe = getI18NValue(180930446),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10646,
			400,
			20201,
			20
		}
	},
	[46001006] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BlackStreet/BlackStreet_Theater.png",
		NeedDownDatingId = 46001005,
		UnlockLevel = 25,
		Dialog = 463101870,
		Id = 46001006,
		Level = 6,
		SoulId = 20010046,
		Name = getI18NValue(180930449),
		Describe = getI18NValue(180930448),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10646,
			400,
			20201,
			20
		}
	},
	[46001007] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BusinessStreet/BusinessStreet_night_sunny.png",
		NeedDownDatingId = 46001006,
		UnlockLevel = 30,
		Dialog = 463102000,
		Id = 46001007,
		Level = 7,
		SoulId = 20010046,
		Name = getI18NValue(181194323),
		Describe = getI18NValue(181194322),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10646,
			600,
			20201,
			25
		}
	},
	[46001008] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Funroom/Funroom2.png",
		NeedDownDatingId = 46001007,
		UnlockLevel = 35,
		Dialog = 463102150,
		Id = 46001008,
		Level = 8,
		SoulId = 20010046,
		Name = getI18NValue(181194325),
		Describe = getI18NValue(181194324),
		ReturnGiftNum = {
			180,
			420
		},
		Cost = {
			10901,
			12
		},
		Reward = {
			10646,
			600,
			20201,
			25
		}
	},
	[46001009] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Dreaming/Dreaming.png",
		NeedDownDatingId = 46001008,
		UnlockLevel = 40,
		Dialog = 463102250,
		Id = 46001009,
		Level = 9,
		SoulId = 20010046,
		Name = getI18NValue(181194327),
		Describe = getI18NValue(181194326),
		ReturnGiftNum = {
			240,
			560
		},
		Cost = {
			10901,
			16
		},
		Reward = {
			10646,
			800,
			20201,
			30
		}
	},
	[47001001] = {
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Livingroom/LivingRoom_day.png",
		UnlockLevel = 2,
		DatingType = 1,
		DatingTypeShow = 1,
		Dialog = 473101070,
		Id = 47001001,
		Level = 1,
		SoulId = 20010047,
		Name = getI18NValue(180885668),
		Describe = getI18NValue(180885667),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10647,
			100,
			20201,
			6
		}
	},
	[47001002] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Sea/Sealevel.png",
		NeedDownDatingId = 47001001,
		UnlockLevel = 5,
		Dialog = 473101190,
		Id = 47001002,
		Level = 2,
		SoulId = 20010047,
		Name = getI18NValue(180885670),
		Describe = getI18NValue(180885669),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10647,
			100,
			20201,
			6
		}
	},
	[47001003] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BusinessStreet/BusinessStreet_day_sunny.png",
		NeedDownDatingId = 47001002,
		UnlockLevel = 10,
		Dialog = 473101300,
		Id = 47001003,
		Level = 3,
		SoulId = 20010047,
		Name = getI18NValue(180885672),
		Describe = getI18NValue(180885671),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10647,
			250,
			20201,
			12
		}
	},
	[47001004] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Garden/Garden_day_sunny.png",
		NeedDownDatingId = 47001003,
		UnlockLevel = 15,
		Dialog = 473101650,
		Id = 47001004,
		Level = 4,
		SoulId = 20010047,
		Name = getI18NValue(181199669),
		Describe = getI18NValue(181199668),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10647,
			250,
			20201,
			12
		}
	},
	[47001005] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BusinessStreet/BusinessStreet_day_sunny.png",
		NeedDownDatingId = 47001004,
		UnlockLevel = 20,
		Dialog = 473101800,
		Id = 47001005,
		Level = 5,
		SoulId = 20010047,
		Name = getI18NValue(181199671),
		Describe = getI18NValue(181199670),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10647,
			400,
			20201,
			20
		}
	},
	[47001006] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Surburb/Surburb_day_sunny.png",
		NeedDownDatingId = 47001005,
		UnlockLevel = 25,
		Dialog = 473101950,
		Id = 47001006,
		Level = 6,
		SoulId = 20010047,
		Name = getI18NValue(181199673),
		Describe = getI18NValue(181199672),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10647,
			400,
			20201,
			20
		}
	},
	[48001001] = {
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BusinessStreet/BusinessStreet_day_rainy.png",
		UnlockLevel = 2,
		DatingType = 1,
		DatingTypeShow = 1,
		Dialog = 483101000,
		Id = 48001001,
		Level = 1,
		SoulId = 20010048,
		Name = getI18NValue(180885674),
		Describe = getI18NValue(180885673),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10648,
			100,
			20201,
			6
		}
	},
	[48001002] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BlackStreet/BlackStreet_day_sunny.png",
		NeedDownDatingId = 48001001,
		UnlockLevel = 5,
		Dialog = 483101110,
		Id = 48001002,
		Level = 2,
		SoulId = 20010048,
		Name = getI18NValue(180885676),
		Describe = getI18NValue(180885675),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10648,
			100,
			20201,
			6
		}
	},
	[48001003] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Museum/Museum_day.png",
		NeedDownDatingId = 48001002,
		UnlockLevel = 10,
		Dialog = 483101220,
		Id = 48001003,
		Level = 3,
		SoulId = 20010048,
		Name = getI18NValue(180885678),
		Describe = getI18NValue(180885677),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10648,
			250,
			20201,
			12
		}
	},
	[48001004] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Fields/Fields_sunny.png",
		NeedDownDatingId = 48001003,
		UnlockLevel = 15,
		Dialog = 483101350,
		Id = 48001004,
		Level = 4,
		SoulId = 20010048,
		Name = getI18NValue(181196004),
		Describe = getI18NValue(181196003),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10648,
			250,
			20201,
			12
		}
	},
	[48001005] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_HomePrivateRoom/PlayerRoom_day.png",
		NeedDownDatingId = 48001004,
		UnlockLevel = 20,
		Dialog = 483101500,
		Id = 48001005,
		Level = 5,
		SoulId = 20010048,
		Name = getI18NValue(181196006),
		Describe = getI18NValue(181196005),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10648,
			400,
			20201,
			20
		}
	},
	[48001006] = {
		DatingType = 1,
		DatingTypeShow = -1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Sky/Sky_day_glow.png",
		NeedDownDatingId = 48001005,
		UnlockLevel = 25,
		Dialog = 483101650,
		Id = 48001006,
		Level = 6,
		SoulId = 20010048,
		Name = getI18NValue(181196008),
		Describe = getI18NValue(181196007),
		ReturnGiftNum = {
			120,
			280
		},
		Cost = {
			10901,
			8
		},
		Reward = {
			10648,
			400,
			20201,
			20
		}
	},
	[49001001] = {
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BusinessStreet/BusinessStreet_day_sunny.png",
		UnlockLevel = 2,
		DatingType = 1,
		DatingTypeShow = 1,
		Dialog = 493101200,
		Id = 49001001,
		Level = 1,
		SoulId = 20010049,
		Name = getI18NValue(180885680),
		Describe = getI18NValue(180885679),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10649,
			100,
			20201,
			6
		}
	},
	[49001002] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Livingroom/LivingRoom_day.png",
		NeedDownDatingId = 49001001,
		UnlockLevel = 5,
		Dialog = 493101350,
		Id = 49001002,
		Level = 2,
		SoulId = 20010049,
		Name = getI18NValue(180885682),
		Describe = getI18NValue(180885681),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10649,
			100,
			20201,
			6
		}
	},
	[49001003] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Garden/Garden_day_sunny.png",
		NeedDownDatingId = 49001002,
		UnlockLevel = 10,
		Dialog = 493101500,
		Id = 49001003,
		Level = 3,
		SoulId = 20010049,
		Name = getI18NValue(180885684),
		Describe = getI18NValue(180885683),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10649,
			250,
			20201,
			12
		}
	},
	[50001001] = {
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Sea/Sealevel.png",
		UnlockLevel = 2,
		DatingType = 1,
		DatingTypeShow = 1,
		Dialog = 503101350,
		Id = 50001001,
		Level = 1,
		SoulId = 20010050,
		Name = getI18NValue(180885686),
		Describe = getI18NValue(180885685),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10650,
			100,
			20201,
			6
		}
	},
	[50001002] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Port/Port_night_rainy.png",
		NeedDownDatingId = 50001001,
		UnlockLevel = 5,
		Dialog = 503101450,
		Id = 50001002,
		Level = 2,
		SoulId = 20010050,
		Name = getI18NValue(180885688),
		Describe = getI18NValue(180885687),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10650,
			100,
			20201,
			6
		}
	},
	[50001003] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BusinessStreet/BusinessStreet_day_sunny.png",
		NeedDownDatingId = 50001002,
		UnlockLevel = 10,
		Dialog = 503101550,
		Id = 50001003,
		Level = 3,
		SoulId = 20010050,
		Name = getI18NValue(180885690),
		Describe = getI18NValue(180885689),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10650,
			250,
			20201,
			12
		}
	},
	[51001001] = {
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BusinessStreet/BusinessStreet_day_sunny.png",
		UnlockLevel = 2,
		DatingType = 1,
		DatingTypeShow = 1,
		Dialog = 513101700,
		Id = 51001001,
		Level = 1,
		SoulId = 20010051,
		Name = getI18NValue(180885692),
		Describe = getI18NValue(180885691),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10651,
			100,
			20201,
			6
		}
	},
	[51001002] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Surburb/Surburb_night_rainy.png",
		NeedDownDatingId = 51001001,
		UnlockLevel = 5,
		Dialog = 513101850,
		Id = 51001002,
		Level = 2,
		SoulId = 20010051,
		Name = getI18NValue(180885694),
		Describe = getI18NValue(180885693),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10651,
			100,
			20201,
			6
		}
	},
	[51001003] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_BusinessStreet/BusinessStreet_day_sunny.png",
		NeedDownDatingId = 51001002,
		UnlockLevel = 10,
		Dialog = 513102000,
		Id = 51001003,
		Level = 3,
		SoulId = 20010051,
		Name = getI18NValue(180885696),
		Describe = getI18NValue(180885695),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10651,
			250,
			20201,
			12
		}
	},
	[52001001] = {
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Restaurant/Restaurant_1.png",
		UnlockLevel = 2,
		DatingType = 1,
		DatingTypeShow = 1,
		Dialog = 1110193470,
		Id = 52001001,
		Level = 1,
		SoulId = 20010052,
		Name = getI18NValue(180885698),
		Describe = getI18NValue(180885697),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10652,
			100,
			20201,
			6
		}
	},
	[52001002] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Fields/Fields_sunny.png",
		NeedDownDatingId = 52001001,
		UnlockLevel = 5,
		Dialog = 1110193570,
		Id = 52001002,
		Level = 2,
		SoulId = 20010052,
		Name = getI18NValue(180885700),
		Describe = getI18NValue(180885699),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10652,
			100,
			20201,
			6
		}
	},
	[52001003] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Carriage/Carriage.png",
		NeedDownDatingId = 52001002,
		UnlockLevel = 10,
		Dialog = 1110193670,
		Id = 52001003,
		Level = 3,
		SoulId = 20010052,
		Name = getI18NValue(180885702),
		Describe = getI18NValue(180885701),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10652,
			250,
			20201,
			12
		}
	},
	[53001001] = {
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Restaurant/Restaurant_1.png",
		UnlockLevel = 2,
		DatingType = 1,
		DatingTypeShow = 1,
		Dialog = 1110193470,
		Id = 53001001,
		Level = 1,
		SoulId = 20010053,
		Name = getI18NValue(180885704),
		Describe = getI18NValue(180885703),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10653,
			100,
			20201,
			6
		}
	},
	[53001002] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Fields/Fields_sunny.png",
		NeedDownDatingId = 53001001,
		UnlockLevel = 5,
		Dialog = 1110193570,
		Id = 53001002,
		Level = 2,
		SoulId = 20010053,
		Name = getI18NValue(180885706),
		Describe = getI18NValue(180885705),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10653,
			100,
			20201,
			6
		}
	},
	[53001003] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Carriage/Carriage.png",
		NeedDownDatingId = 53001002,
		UnlockLevel = 10,
		Dialog = 1110193670,
		Id = 53001003,
		Level = 3,
		SoulId = 20010053,
		Name = getI18NValue(180885708),
		Describe = getI18NValue(180885707),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10653,
			250,
			20201,
			12
		}
	},
	[54001001] = {
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Restaurant/Restaurant_1.png",
		UnlockLevel = 2,
		DatingType = 1,
		DatingTypeShow = 1,
		Dialog = 1110193470,
		Id = 54001001,
		Level = 1,
		SoulId = 20010054,
		Name = getI18NValue(180885710),
		Describe = getI18NValue(180885709),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10654,
			100,
			20201,
			6
		}
	},
	[54001002] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Fields/Fields_sunny.png",
		NeedDownDatingId = 54001001,
		UnlockLevel = 5,
		Dialog = 1110193570,
		Id = 54001002,
		Level = 2,
		SoulId = 20010054,
		Name = getI18NValue(180885712),
		Describe = getI18NValue(180885711),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10654,
			100,
			20201,
			6
		}
	},
	[54001003] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Carriage/Carriage.png",
		NeedDownDatingId = 54001002,
		UnlockLevel = 10,
		Dialog = 1110193670,
		Id = 54001003,
		Level = 3,
		SoulId = 20010054,
		Name = getI18NValue(180885714),
		Describe = getI18NValue(180885713),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10654,
			250,
			20201,
			12
		}
	},
	[55001001] = {
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Restaurant/Restaurant_1.png",
		UnlockLevel = 2,
		DatingType = 1,
		DatingTypeShow = 1,
		Dialog = 1110193470,
		Id = 55001001,
		Level = 1,
		SoulId = 20010055,
		Name = getI18NValue(180885716),
		Describe = getI18NValue(180885715),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10655,
			100,
			20201,
			6
		}
	},
	[55001002] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Fields/Fields_sunny.png",
		NeedDownDatingId = 55001001,
		UnlockLevel = 5,
		Dialog = 1110193570,
		Id = 55001002,
		Level = 2,
		SoulId = 20010055,
		Name = getI18NValue(180885718),
		Describe = getI18NValue(180885717),
		ReturnGiftNum = {
			30,
			70
		},
		Cost = {
			10901,
			2
		},
		Reward = {
			10655,
			100,
			20201,
			6
		}
	},
	[55001003] = {
		DatingType = 1,
		DatingTypeShow = 1,
		ImageBg = "/Girl/GirlDatingBackground/GDBG_Carriage/Carriage.png",
		NeedDownDatingId = 55001002,
		UnlockLevel = 10,
		Dialog = 1110193670,
		Id = 55001003,
		Level = 3,
		SoulId = 20010055,
		Name = getI18NValue(180885720),
		Describe = getI18NValue(180885719),
		ReturnGiftNum = {
			75,
			175
		},
		Cost = {
			10901,
			5
		},
		Reward = {
			10655,
			250,
			20201,
			12
		}
	}
}

setmetatable(CfgDatingEventsTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgDatingEventsTable]")
	end
})

local defaultMetaTable = {
	__index = {
		ImageBg = "",
		Describe = "",
		NeedDownDatingId = 0,
		DatingType = 0,
		UnlockLevel = 0,
		DatingTypeShow = 0,
		Name = "",
		Dialog = 0,
		Level = 0,
		SoulId = 0,
		Cost = {},
		ReturnGiftNum = {},
		Reward = {}
	}
}

for i, data in pairs(CfgDatingEventsTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgDatingEventsTable
