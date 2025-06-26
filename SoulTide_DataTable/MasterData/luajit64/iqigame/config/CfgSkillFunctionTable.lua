-- chunkname: @IQIGame\\Config\\CfgSkillFunctionTable.lua

local CfgSkillFunctionTable = {
	[97] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 97,
		DamageType = 1,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				0.01
			},
			{}
		}
	},
	[98] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "K*(0.02+A1/1000)",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 98,
		DamageType = 1,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				0.01
			},
			{}
		},
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1334113"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[99] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 99,
		DamageType = 1,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				0.1
			},
			{}
		}
	},
	[101] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "(A1-A2)*0.005",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = true,
		MinDamage = 97,
		Id = 101,
		MaxFunctionRPN = 1101,
		DamageType = 4,
		DynamicArgType = {
			303,
			303,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{
				"2",
				"11"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[102] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 102,
		DamageType = 1,
		TargetAtt = {
			9,
			0
		},
		TargetAttVal = {
			{
				0.01
			},
			{}
		}
	},
	[103] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		DynamicRPNExp = "K*(1+0.01*A1)*(1-A2+A3*0.01)*(0.02+A4/1000+(A5/1000*A6)/A7)",
		IsIgnoreSheild = true,
		MinDamage = 98,
		Id = 103,
		DamageType = 4,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		TargetAtt = {
			11,
			0
		},
		TargetAttVal = {
			{
				-1
			},
			{}
		},
		DynamicArgType = {
			103,
			102,
			103,
			103,
			103,
			103,
			103,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"3",
				"11061"
			},
			{
				"2",
				"1",
				"1120"
			},
			{
				"2",
				"1",
				"1120"
			},
			{
				"2",
				"1",
				"1334113"
			},
			{
				"2",
				"1",
				"1075207"
			},
			{
				"2",
				"1",
				"1075205"
			},
			{
				"2",
				"1",
				"1106"
			},
			{}
		}
	},
	[107] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		BasicDamage = 999999,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 107,
		DamageType = 3
	},
	[198] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*5",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 198,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"300"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[300] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 300,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"300"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[800] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 800,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"800"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[801] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 801,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"801"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[802] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 802,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"802"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[803] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 803,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"803"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[900] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 900,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"7"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[901] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 901,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"11"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[999] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		MinDamage = 99,
		IsIgnoreSheild = false,
		Id = 999,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false
	},
	[1001] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1001,
		DamageType = 1,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		TargetAtt = {
			11,
			0
		},
		TargetAttVal = {
			{
				-1
			},
			{}
		}
	},
	[1002] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1002,
		DamageType = 1,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		TargetAtt = {
			11,
			0
		},
		TargetAttVal = {
			{
				-1
			},
			{}
		}
	},
	[1003] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1003,
		DamageType = 3,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[1004] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1004,
		DamageType = 1,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[1005] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1005,
		DamageType = 1,
		SelfAtt = {
			11,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		TargetAtt = {
			11,
			0
		},
		TargetAttVal = {
			{
				-1
			},
			{}
		}
	},
	[1006] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1006,
		DamageType = 5,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1007] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1007,
		DamageType = 1,
		SelfAtt = {
			9,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		TargetAtt = {
			11,
			0
		},
		TargetAttVal = {
			{
				-1
			},
			{}
		}
	},
	[1008] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*1+K",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1008,
		DamageType = 1,
		TargetAtt = {
			11,
			0
		},
		TargetAttVal = {
			{
				-1
			},
			{}
		},
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1009] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1009,
		DamageType = 3,
		SelfAtt = {
			9,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[1010] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1010,
		DamageType = 3,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[1011] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1011,
		DamageType = 1,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		TargetAtt = {
			11,
			0
		},
		TargetAttVal = {
			{
				-1
			},
			{}
		}
	},
	[1012] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*1+K",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1012,
		DamageType = 1,
		TargetAtt = {
			11,
			0
		},
		TargetAttVal = {
			{
				-1
			},
			{}
		},
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"7"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1013] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1013,
		DamageType = 1,
		TargetAtt = {
			9,
			11
		},
		TargetAttVal = {
			{
				1
			},
			{
				-1
			}
		}
	},
	[1014] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*1+K",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1014,
		DamageType = 1,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1015] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1015,
		DamageType = 1,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1016] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1016,
		DamageType = 1,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"7"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1017] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1017,
		DamageType = 1,
		SelfAtt = {
			9,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[1018] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1018,
		DamageType = 1,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[1019] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1019,
		DamageType = 1,
		SelfAtt = {
			11,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[1020] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1020,
		DamageType = 5,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"13"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1021] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1-A2",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1021,
		DamageType = 1,
		DynamicArgType = {
			303,
			303,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{
				"2",
				"13"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1022] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = true,
		MinDamage = 99,
		Id = 1022,
		DamageType = 4,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		TargetAtt = {
			11,
			0
		},
		TargetAttVal = {
			{
				-1
			},
			{}
		}
	},
	[1023] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*1-K",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = true,
		MinDamage = 99,
		Id = 1023,
		DamageType = 4,
		TargetAtt = {
			11,
			0
		},
		TargetAttVal = {
			{
				-1
			},
			{}
		},
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1024] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = true,
		Id = 1024,
		DamageType = 2,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"13"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1025] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1025,
		DamageType = 6,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1026] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1-A2",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1026,
		DamageType = 3,
		DynamicArgType = {
			303,
			303,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{
				"2",
				"13"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1027] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1027,
		DamageType = 3,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"7"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1039] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "K*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = true,
		Id = 1039,
		DamageType = 2,
		TargetAtt = {
			13,
			0
		},
		TargetAttVal = {
			{
				1
			},
			{}
		}
	},
	[1040] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "K*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1040,
		DamageType = 3,
		TargetAtt = {
			9,
			0
		},
		TargetAttVal = {
			{
				1
			},
			{}
		}
	},
	[1041] = {
		IsBaseAttribute = false,
		IsIgnoreShare = false,
		MaxFunctionRPN = 1042,
		DynamicRPNExp = "K*A1*(0.7+A2*0.3)",
		IsIgnoreInverted = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1041,
		DamageType = 1,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				0.5
			},
			{}
		},
		TargetAtt = {
			11,
			0
		},
		TargetAttVal = {
			{
				-1
			},
			{}
		},
		DynamicArgType = {
			104,
			311,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1042] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "K*A1*1.9",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1042,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				0.5
			},
			{}
		},
		TargetAtt = {
			11,
			0
		},
		TargetAttVal = {
			{
				-1
			},
			{}
		},
		DynamicArgType = {
			104,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1043] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		DynamicRPNExp = "K",
		IsIgnoreSheild = false,
		Id = 1043,
		DamageType = 1,
		SelfAtt = {
			13,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		TargetAtt = {
			11,
			0
		},
		TargetAttVal = {
			{
				-1
			},
			{}
		}
	},
	[1101] = {
		DynamicRPNExp = "A1*0.15",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1101,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"4",
				"7"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1102] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1102,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1102"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1103] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		DynamicRPNExp = "K*(1+0.01*A1)",
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1103,
		DamageType = 1,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		TargetAtt = {
			11,
			0
		},
		TargetAttVal = {
			{
				-1
			},
			{}
		},
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"4406101"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1104] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "(A1-A2)*(0.5+A3*0.001)",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = true,
		MinDamage = 99,
		Id = 1104,
		DamageType = 4,
		DynamicArgType = {
			303,
			303,
			103,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"7"
			},
			{
				"2",
				"11"
			},
			{
				"1",
				"1",
				"1095102"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[2011] = {
		DynamicRPNExp = "(A1+A2*10000)*1000+(2-A3)*100+A4",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 2011,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			103,
			314,
			309,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"10"
			},
			{
				"2",
				"1",
				"2022"
			},
			{
				"2",
				"0"
			},
			{
				"2"
			},
			{},
			{},
			{},
			{}
		}
	},
	[2012] = {
		DynamicRPNExp = "A1+A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 2012,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			103,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"2015"
			},
			{
				"2",
				"1",
				"2016"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[2013] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 2013,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"2021"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[8001] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 8001,
		DamageType = 3,
		SelfAtt = {
			13,
			9
		},
		SelfAttVal = {
			{
				-1
			},
			{
				0.01
			}
		}
	},
	[8301] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 8301,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"8301"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[8302] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 8302,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"8302"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[8335] = {
		DynamicRPNExp = "A1*0.3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 8335,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[9153] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1-A2",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 9153,
		DamageType = 1,
		DynamicArgType = {
			303,
			303,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"4",
				"7"
			},
			{
				"2",
				"11"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[9166] = {
		DynamicRPNExp = "A1*0.1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 9166,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"11"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[9185] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "(A1-A2)*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 9185,
		DamageType = 1,
		DynamicArgType = {
			303,
			303,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"7"
			},
			{
				"2",
				"11"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[9245] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "40*(1+A1*0.05)",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 9245,
		DamageType = 2,
		DynamicArgType = {
			102,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"9247"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[9246] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "80*(1+A1*0.05)",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 9246,
		DamageType = 2,
		DynamicArgType = {
			102,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"9247"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[9253] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "80*(1+A1*0.1)",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 9253,
		DamageType = 2,
		DynamicArgType = {
			102,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"9255"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[9254] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "160*(1+A1*0.1)",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 9254,
		DamageType = 2,
		DynamicArgType = {
			102,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"9255"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[9261] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "120*(1+A1*0.15)",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 9261,
		DamageType = 2,
		DynamicArgType = {
			102,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"9263"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[9262] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "240*(1+A1*0.15)",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 9262,
		DamageType = 2,
		DynamicArgType = {
			102,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"9263"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[9269] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "160*(1+A1*0.2)",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 9269,
		DamageType = 2,
		DynamicArgType = {
			102,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"9271"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[9270] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "320*(1+A1*0.2)",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 9270,
		DamageType = 2,
		DynamicArgType = {
			102,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"9271"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[9277] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "200*(1+A1*0.25)",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 9277,
		DamageType = 2,
		DynamicArgType = {
			102,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"9279"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[9278] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "400*(1+A1*0.25)",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 9278,
		DamageType = 2,
		DynamicArgType = {
			102,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"9279"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[9285] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "20*(1+A1*0.01)",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 9285,
		DamageType = 2,
		DynamicArgType = {
			311,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[9286] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "40*(1+A1*0.01)",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 9286,
		DamageType = 2,
		DynamicArgType = {
			311,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[9292] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "40*(1+A1*0.02)",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 9292,
		DamageType = 2,
		DynamicArgType = {
			311,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[9293] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "80*(1+A1*0.02)",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 9293,
		DamageType = 2,
		DynamicArgType = {
			311,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[9299] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "60*(1+A1*0.03)",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 9299,
		DamageType = 2,
		DynamicArgType = {
			311,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[9300] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "120*(1+A1*0.03)",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 9300,
		DamageType = 2,
		DynamicArgType = {
			311,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[9306] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "80*(1+A1*0.04)",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 9306,
		DamageType = 2,
		DynamicArgType = {
			311,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[9307] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "160*(1+A1*0.04)",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 9307,
		DamageType = 2,
		DynamicArgType = {
			311,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[9313] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "100*(1+A1*0.05)",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 9313,
		DamageType = 2,
		DynamicArgType = {
			311,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[9314] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "200*(1+A1*0.05)",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 9314,
		DamageType = 2,
		DynamicArgType = {
			311,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[9483] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "K*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 9483,
		SelfAtt = {
			9,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[9662] = {
		DynamicRPNExp = "A1*0.3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 9662,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10001] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 10001,
		IsBaseAttribute = false,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				0.5
			},
			{}
		}
	},
	[10024] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*2",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 10024,
		IsBaseAttribute = false,
		DynamicArgType = {
			317,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10101] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10101,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10102] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 10102,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10103] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10103,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10104] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 10104,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10105] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10105,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"3"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10106] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 10106,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"3"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10107] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10107,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"4"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10108] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 10108,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"4"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10109] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10109,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"5"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10110] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 10110,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"5"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10130] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 10130,
		IsBaseAttribute = false,
		SelfAtt = {
			9,
			0
		},
		SelfAttVal = {
			{
				0.3
			},
			{}
		}
	},
	[10201] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "(A1-A2)*A3",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 10201,
		DamageType = 1,
		DynamicArgType = {
			303,
			303,
			104,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"7"
			},
			{
				"2",
				"11"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10202] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "(A1-A2)*A3",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = true,
		MinDamage = 99,
		Id = 10202,
		DamageType = 4,
		DynamicArgType = {
			303,
			303,
			104,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"7"
			},
			{
				"2",
				"11"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10205] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "(A1-A2)*A3",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 10205,
		DamageType = 1,
		DynamicArgType = {
			303,
			303,
			104,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"7"
			},
			{
				"2",
				"11"
			},
			{
				"3"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10208] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "(A1-A2)*A3",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = true,
		MinDamage = 99,
		Id = 10208,
		DamageType = 4,
		DynamicArgType = {
			303,
			303,
			104,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"7"
			},
			{
				"2",
				"11"
			},
			{
				"4"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10300] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10300,
		IsBaseAttribute = true,
		DynamicArgType = {
			318,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		}
	},
	[10301] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10301,
		IsBaseAttribute = true,
		DynamicArgType = {
			311,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10302] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10302,
		IsBaseAttribute = true,
		DynamicArgType = {
			311,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10303] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10303,
		IsBaseAttribute = true,
		DynamicArgType = {
			321,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"0"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10401] = {
		DynamicRPNExp = "A1*100",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10401,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10402] = {
		DynamicRPNExp = "A1*100",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10402,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10403] = {
		DynamicRPNExp = "A1*100",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10403,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"3"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10501] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10501,
		IsBaseAttribute = false,
		DynamicArgType = {
			317,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10701] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10701,
		IsBaseAttribute = true,
		DynamicArgType = {
			303,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"7"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10702] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 10702,
		IsBaseAttribute = true,
		DynamicArgType = {
			303,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"7"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10703] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10703,
		IsBaseAttribute = true,
		DynamicArgType = {
			303,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"7"
			},
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10705] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10705,
		IsBaseAttribute = true,
		DynamicArgType = {
			303,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"7"
			},
			{
				"3"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10707] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10707,
		IsBaseAttribute = true,
		DynamicArgType = {
			303,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"7"
			},
			{
				"4"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10711] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10711,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"7"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10712] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 10712,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"7"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10715] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10715,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"7"
			},
			{
				"3"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10718] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 10718,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"7"
			},
			{
				"4"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10721] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10721,
		IsBaseAttribute = true,
		DynamicArgType = {
			320,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"7"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10722] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 10722,
		IsBaseAttribute = true,
		DynamicArgType = {
			320,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"7"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10723] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10723,
		IsBaseAttribute = true,
		DynamicArgType = {
			320,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"7"
			},
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10724] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 10724,
		IsBaseAttribute = true,
		DynamicArgType = {
			320,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"7"
			},
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10725] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10725,
		IsBaseAttribute = true,
		DynamicArgType = {
			320,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"7"
			},
			{
				"3"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10751] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*A2",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10751,
		DamageType = 5,
		DynamicArgType = {
			303,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"7"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10752] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*A2",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10752,
		DamageType = 3,
		DynamicArgType = {
			303,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"7"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10753] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*A2",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10753,
		DamageType = 5,
		DynamicArgType = {
			303,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"7"
			},
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10754] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*A2",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10754,
		DamageType = 3,
		DynamicArgType = {
			303,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"7"
			},
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10755] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*A2",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10755,
		DamageType = 5,
		DynamicArgType = {
			303,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"7"
			},
			{
				"3"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10901] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10901,
		IsBaseAttribute = true,
		DynamicArgType = {
			303,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10902] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 10902,
		IsBaseAttribute = true,
		DynamicArgType = {
			303,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10903] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10903,
		IsBaseAttribute = true,
		DynamicArgType = {
			303,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10904] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 10904,
		IsBaseAttribute = true,
		DynamicArgType = {
			303,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10905] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10905,
		IsBaseAttribute = true,
		DynamicArgType = {
			303,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{
				"3"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10906] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 10906,
		IsBaseAttribute = true,
		DynamicArgType = {
			303,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{
				"3"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10907] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10907,
		IsBaseAttribute = true,
		DynamicArgType = {
			303,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{
				"4"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10911] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10911,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"9"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10913] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10913,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"9"
			},
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10915] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10915,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"9"
			},
			{
				"3"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10921] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10921,
		IsBaseAttribute = true,
		DynamicArgType = {
			320,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10922] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 10922,
		IsBaseAttribute = true,
		DynamicArgType = {
			320,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10924] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 10924,
		IsBaseAttribute = true,
		DynamicArgType = {
			320,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10927] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10927,
		IsBaseAttribute = true,
		DynamicArgType = {
			320,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{
				"4"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10942] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = true,
		DynamicRPNExp = "A1*A2",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10942,
		DamageType = 3,
		DynamicArgType = {
			303,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10946] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = true,
		DynamicRPNExp = "A1*A2",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10946,
		DamageType = 3,
		DynamicArgType = {
			303,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{
				"3"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10952] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = true,
		DynamicRPNExp = "A1*A2",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10952,
		DamageType = 3,
		DynamicArgType = {
			303,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"9"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10991] = {
		DynamicRPNExp = "A1/A2*10000",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10991,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			303,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"13"
			},
			{
				"2",
				"9"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10992] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A3-A1/10000*A2",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = true,
		Id = 10992,
		DamageType = 2,
		DynamicArgType = {
			103,
			303,
			303,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10992"
			},
			{
				"2",
				"9"
			},
			{
				"2",
				"13"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[11001] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 11001,
		IsBaseAttribute = true,
		DynamicArgType = {
			303,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"10"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[11002] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 11002,
		IsBaseAttribute = true,
		DynamicArgType = {
			303,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"10"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[11022] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 11022,
		IsBaseAttribute = true,
		DynamicArgType = {
			320,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"10"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[11101] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 11101,
		IsBaseAttribute = true,
		DynamicArgType = {
			303,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"11"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[11102] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 11102,
		IsBaseAttribute = true,
		DynamicArgType = {
			303,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"11"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[11103] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 11103,
		IsBaseAttribute = true,
		DynamicArgType = {
			303,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"11"
			},
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[11104] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 11104,
		IsBaseAttribute = true,
		DynamicArgType = {
			303,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"11"
			},
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[11111] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 11111,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"11"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[11113] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 11113,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"11"
			},
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[11121] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 11121,
		IsBaseAttribute = true,
		DynamicArgType = {
			320,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"11"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[11122] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 11122,
		IsBaseAttribute = true,
		DynamicArgType = {
			320,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"11"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[11123] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 11123,
		IsBaseAttribute = true,
		DynamicArgType = {
			320,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"11"
			},
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[11124] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 11124,
		IsBaseAttribute = true,
		DynamicArgType = {
			320,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"11"
			},
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[11125] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 11125,
		IsBaseAttribute = true,
		DynamicArgType = {
			320,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"11"
			},
			{
				"3"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[11126] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 11126,
		IsBaseAttribute = true,
		DynamicArgType = {
			320,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"11"
			},
			{
				"3"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[11128] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 11128,
		IsBaseAttribute = true,
		DynamicArgType = {
			320,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"11"
			},
			{
				"4"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[11311] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 11311,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"13"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[11315] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 11315,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"13"
			},
			{
				"3"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[11361] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 11361,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"13"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[11401] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 11401,
		IsBaseAttribute = true,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"14"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[11511] = {
		DynamicRPNExp = "(A1-A3)*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 11511,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			104,
			303,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"9"
			},
			{
				"1"
			},
			{
				"1",
				"13"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[20007] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 20007,
		DamageType = 5,
		TargetAtt = {
			9,
			0
		},
		TargetAttVal = {
			{
				0.05
			},
			{}
		}
	},
	[20307] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 20307,
		IsBaseAttribute = false,
		TargetAtt = {
			9,
			0
		},
		TargetAttVal = {
			{
				0.2
			},
			{}
		}
	},
	[21101] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 21101,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"3",
				"1101"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[21102] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 21102,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1102"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[21121] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 21121,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1101"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30810] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 30810,
		IsBaseAttribute = false,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				0.05
			},
			{}
		}
	},
	[31101] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1+A2",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 31101,
		MaxFunctionRPN = 31111,
		IsBaseAttribute = false,
		DynamicArgType = {
			310,
			312,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"3",
				"3",
				"1101"
			},
			{
				"3",
				"1",
				"1304112"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[31111] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsIgnoreSheild = false,
		IsBaseAttribute = false,
		Id = 31111,
		DynamicRPNExp = "10",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true
	},
	[31119] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 31119,
		IsBaseAttribute = false,
		DynamicArgType = {
			310,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1109"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[80231] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 80231,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"80231"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[80341] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 80341,
		DamageType = 1,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[82582] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = true,
		Id = 82582,
		DamageType = 2,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[82711] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 82711,
		DamageType = 3,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[82911] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = true,
		Id = 82911,
		DamageType = 2,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[83305] = {
		DynamicRPNExp = "A1*0.3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 83305,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[85423] = {
		DynamicRPNExp = "A1*4",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 85423,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[87202] = {
		DynamicRPNExp = "A1*0.4",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 87202,
		IsBaseAttribute = false,
		DynamicArgType = {
			320,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"7"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[87212] = {
		DynamicRPNExp = "A1*0.4",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 87212,
		IsBaseAttribute = false,
		DynamicArgType = {
			320,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"7"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[87222] = {
		DynamicRPNExp = "A1*0.4",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 87222,
		IsBaseAttribute = false,
		DynamicArgType = {
			320,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"7"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[87301] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		DynamicRPNExp = "K*(1+0.01*A1)",
		IsIgnoreSheild = true,
		MinDamage = 98,
		Id = 87301,
		DamageType = 4,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		TargetAtt = {
			11,
			0
		},
		TargetAttVal = {
			{
				-1
			},
			{}
		},
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"3",
				"11061"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[87500] = {
		DynamicRPNExp = "0.3+(A1*0.3)",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 87500,
		IsBaseAttribute = false,
		DynamicArgType = {
			102,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10022"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[87510] = {
		DynamicRPNExp = "0.5+(A1*0.5)",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 87510,
		IsBaseAttribute = false,
		DynamicArgType = {
			102,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10022"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[87520] = {
		DynamicRPNExp = "0.7+(A1*0.7)",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 87520,
		IsBaseAttribute = false,
		DynamicArgType = {
			102,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10022"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[87801] = {
		DynamicRPNExp = "((A2-A1)/A3)*100",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 87801,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			103,
			320,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"87801"
			},
			{
				"2",
				"1",
				"87804"
			},
			{
				"2",
				"11"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[87802] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 87802,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"87804"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[87811] = {
		DynamicRPNExp = "((A2-A1)/A3)*100",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 87811,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			103,
			320,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"87811"
			},
			{
				"2",
				"1",
				"87814"
			},
			{
				"2",
				"11"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[87812] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 87812,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"87814"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[87821] = {
		DynamicRPNExp = "((A2-A1)/A3)*100",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 87821,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			103,
			320,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"87821"
			},
			{
				"2",
				"1",
				"87824"
			},
			{
				"2",
				"11"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[87822] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 87822,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"87824"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[87905] = {
		DynamicRPNExp = "A1*0.3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 87905,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[88100] = {
		DynamicRPNExp = "0.3+0.3*A1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 88100,
		IsBaseAttribute = false,
		DynamicArgType = {
			310,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10022"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[88130] = {
		DynamicRPNExp = "0.4+0.4*A1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 88130,
		IsBaseAttribute = false,
		DynamicArgType = {
			310,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10022"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[88160] = {
		DynamicRPNExp = "0.5+0.5*A1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 88160,
		IsBaseAttribute = false,
		DynamicArgType = {
			310,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10022"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[90011] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 90011,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"9001"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[92601] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = true,
		DynamicRPNExp = "A1*A2*0.5",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 92601,
		DamageType = 1,
		DynamicArgType = {
			103,
			303,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"20604307"
			},
			{
				"1",
				"7"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[93301] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 93301,
		IsBaseAttribute = true,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"20604307"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[93601] = {
		DynamicRPNExp = "A1*0.05",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 93601,
		IsBaseAttribute = true,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"5",
				"26"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[93701] = {
		DynamicRPNExp = "A1*0.02",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 93701,
		IsBaseAttribute = true,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"20604307"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[93801] = {
		DynamicRPNExp = "0.2*(A1-A2)*(1+A3)",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 93801,
		IsBaseAttribute = true,
		DynamicArgType = {
			102,
			102,
			102,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"93804"
			},
			{
				"2",
				"1",
				"93805"
			},
			{
				"2",
				"1",
				"10022"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[94101] = {
		DynamicRPNExp = "A1*(100-A2)*0.015",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 94101,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			312,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{
				"3",
				"1",
				"20604307"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[94102] = {
		DynamicRPNExp = "0.2-0.04*(1-A1)",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 94102,
		IsBaseAttribute = false,
		DynamicArgType = {
			102,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"20604303"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[94501] = {
		DynamicRPNExp = "(A1+A2)*0.08*(1+A3)",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 94501,
		IsBaseAttribute = true,
		DynamicArgType = {
			103,
			103,
			102,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"94504"
			},
			{
				"1",
				"1",
				"94507"
			},
			{
				"2",
				"1",
				"10022"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[94601] = {
		DynamicRPNExp = "A1*2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 94601,
		IsBaseAttribute = true,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"94602"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[94701] = {
		DynamicRPNExp = "(1+A1)*(2-A2)",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 94701,
		IsBaseAttribute = true,
		DynamicArgType = {
			102,
			102,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"20605301"
			},
			{
				"2",
				"1",
				"1903"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[94702] = {
		DynamicRPNExp = "1+A1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 94702,
		IsBaseAttribute = true,
		DynamicArgType = {
			102,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"20605301"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[94801] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = true,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = true,
		MinDamage = 99,
		Id = 94801,
		DamageType = 4,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		TargetAtt = {
			11,
			0
		},
		TargetAttVal = {
			{
				-1
			},
			{}
		}
	},
	[95001] = {
		DynamicRPNExp = "0.15*A1-0.5",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 95001,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"95008"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[95002] = {
		DynamicRPNExp = "(0.5-A1*0.15)*(1+A2)",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 95002,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			102,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"95008"
			},
			{
				"2",
				"1",
				"10022"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[95101] = {
		DynamicRPNExp = "A1*0.05*(1+A2)",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 95101,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			102,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"95106"
			},
			{
				"2",
				"1",
				"10022"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[95201] = {
		DynamicRPNExp = "A1-A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 95201,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			103,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"5",
				"25"
			},
			{
				"2",
				"5",
				"16"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[95202] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 95202,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"95206"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[95212] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 95212,
		IsBaseAttribute = false,
		SelfAtt = {
			9,
			0
		},
		SelfAttVal = {
			{
				0.2
			},
			{}
		}
	},
	[95272] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 95272,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[95501] = {
		DynamicRPNExp = "A1*0.15",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 95501,
		IsBaseAttribute = true,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[95701] = {
		DynamicRPNExp = "A1*0.5",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 95701,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"7"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[95801] = {
		DynamicRPNExp = "0.05*A1*(A1+1)",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 95801,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"95803"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[96101] = {
		DynamicRPNExp = "(A1-A1%2)/2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 96101,
		IsBaseAttribute = true,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"96103"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[96901] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.01",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 96901,
		MaxFunctionRPN = 96902,
		IsBaseAttribute = true,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"20608309"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[96902] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsIgnoreSheild = false,
		IsBaseAttribute = true,
		Id = 96902,
		DynamicRPNExp = "0.3",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true
	},
	[96903] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.01*A2",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 96903,
		MaxFunctionRPN = 96904,
		IsBaseAttribute = true,
		DynamicArgType = {
			103,
			320,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"20608309"
			},
			{
				"2",
				"7"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[96904] = {
		DynamicRPNExp = "A1*0.15",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 96904,
		IsBaseAttribute = true,
		DynamicArgType = {
			320,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"7"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[97001] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 97001,
		IsBaseAttribute = true,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"97007"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[97201] = {
		DynamicRPNExp = "A1*0.01",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 97201,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"97208"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[101051] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 101051,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[101102] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = true,
		MinDamage = 99,
		Id = 101102,
		DamageType = 2,
		DynamicArgType = {
			322,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		}
	},
	[104003] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 104003,
		DamageType = 5,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				0.5
			},
			{}
		}
	},
	[105630] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 105630,
		IsBaseAttribute = false,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				0.1
			},
			{}
		}
	},
	[109221] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 109221,
		IsBaseAttribute = false,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				3
			},
			{}
		}
	},
	[109222] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 109222,
		DamageType = 1,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1.5
			},
			{}
		}
	},
	[109311] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 109311,
		DamageType = 3,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1.3
			},
			{}
		}
	},
	[110002] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 110002,
		IsBaseAttribute = false,
		TargetAtt = {
			9,
			0
		},
		TargetAttVal = {
			{
				0.5
			},
			{}
		}
	},
	[110201] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 110201,
		DamageType = 3,
		SelfAtt = {
			9,
			0
		},
		SelfAttVal = {
			{
				0.05
			},
			{}
		}
	},
	[148411] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		DynamicRPNExp = "K*(0.2+A1*0.2)",
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 148411,
		DamageType = 4,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		TargetAtt = {
			11,
			0
		},
		TargetAttVal = {
			{
				-1
			},
			{}
		},
		DynamicArgType = {
			310,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"3",
				"1",
				"1484197"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[200102] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 200102,
		IsBaseAttribute = false,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				0.1
			},
			{}
		}
	},
	[200106] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 200106,
		DamageType = 3,
		TargetAtt = {
			9,
			0
		},
		TargetAttVal = {
			{
				0.05
			},
			{}
		}
	},
	[200131] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 200131,
		IsBaseAttribute = false,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				0.02
			},
			{}
		}
	},
	[200506] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 200506,
		IsBaseAttribute = false,
		TargetAtt = {
			9,
			0
		},
		TargetAttVal = {
			{
				0.3
			},
			{}
		}
	},
	[200906] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 200906,
		IsBaseAttribute = false,
		TargetAtt = {
			9,
			0
		},
		TargetAttVal = {
			{
				0.2
			},
			{}
		}
	},
	[300001] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		BasicDamage = 999999,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 300001,
		DamageType = 1
	},
	[300002] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 300002,
		DamageType = 3,
		SelfAtt = {
			9,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[300121] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.013",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 300121,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[300171] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "K*0.08",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = true,
		Id = 300171,
		DamageType = 4,
		SelfAtt = {
			9,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[300281] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 300281,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[300282] = {
		DynamicRPNExp = "60+A1*10+A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 300282,
		IsBaseAttribute = false,
		DynamicArgType = {
			102,
			103,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"301271"
			},
			{
				"2",
				"1",
				"301932"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[300283] = {
		DynamicRPNExp = "40-A1*10-A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 300283,
		IsBaseAttribute = false,
		DynamicArgType = {
			102,
			103,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"301271"
			},
			{
				"2",
				"1",
				"301932"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[300284] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 300284,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"300282"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[300291] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*A2*0.02",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 300291,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			303,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"300292"
			},
			{
				"2",
				"9"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[300311] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 300311,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"300313"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[300401] = {
		DynamicRPNExp = "A1*0.3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 300401,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"7"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[300491] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "(A1-A2)/A1*0.4",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 300491,
		MaxFunctionRPN = 300492,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			303,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"9"
			},
			{
				"1",
				"13"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[300492] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "0.28",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 300492,
		IsBaseAttribute = false
	},
	[300551] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 300551,
		IsBaseAttribute = false,
		DynamicArgType = {
			311,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[300561] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.15",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 300561,
		MaxFunctionRPN = 300562,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"13"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[300562] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.4",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 300562,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"7"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[300651] = {
		DynamicRPNExp = "A1*0.1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 300651,
		IsBaseAttribute = false,
		DynamicArgType = {
			310,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"300652"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[300711] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "(A1-A2)*0.2",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 300711,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			303,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"9"
			},
			{
				"1",
				"13"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[300741] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "0.03*A1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 300741,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1106"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[300791] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "0.015*A1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 300791,
		MaxFunctionRPN = 300792,
		IsBaseAttribute = false,
		DynamicArgType = {
			312,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1109"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[300792] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsIgnoreSheild = false,
		IsBaseAttribute = false,
		Id = 300792,
		DynamicRPNExp = "0.15",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true
	},
	[300811] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = true,
		DynamicRPNExp = "A1*0.03*K",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 300811,
		SelfAtt = {
			11,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1109"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[300901] = {
		DynamicRPNExp = "0.05*A1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 300901,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1102"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[300911] = {
		DynamicRPNExp = "1*A1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 300911,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1102"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[300941] = {
		DynamicRPNExp = "A1*1+1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 300941,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"3",
				"1101"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[300961] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = true,
		DynamicRPNExp = "0.006*A1*K",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 300961,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"3",
				"1101"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[300971] = {
		DynamicRPNExp = "0.3-(0.05*A1)",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 300971,
		IsBaseAttribute = false,
		DynamicArgType = {
			311,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[301001] = {
		DynamicRPNExp = "0.3-(0.05*A1)",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 301001,
		IsBaseAttribute = false,
		DynamicArgType = {
			311,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[301101] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 301101,
		DamageType = 1,
		DynamicArgType = {
			318,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		}
	},
	[301132] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.08",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 301132,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[301152] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.25",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 301152,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"5",
				"12"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[301171] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		DynamicRPNExp = "(A1/30*0.01+0.05)*K*(1+A2*0.01)",
		IsIgnoreSheild = true,
		Id = 301171,
		DamageType = 4,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		TargetAtt = {
			11,
			0
		},
		TargetAttVal = {
			{
				-1
			},
			{}
		},
		DynamicArgType = {
			103,
			103,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1106"
			},
			{
				"2",
				"3",
				"11061"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[301215] = {
		DynamicRPNExp = "A1*0.025",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 301215,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"3",
				"1101"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[301221] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*0.4",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = true,
		Id = 301221,
		DamageType = 2,
		DynamicArgType = {
			318,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		}
	},
	[301231] = {
		DynamicRPNExp = "(6-A1)*0.05+0.05",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 301231,
		IsBaseAttribute = false,
		DynamicArgType = {
			311,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[301311] = {
		DynamicRPNExp = "6-A1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 301311,
		IsBaseAttribute = false,
		DynamicArgType = {
			311,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[301341] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "(A1-A2)*(0.25+0.3*A3)",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 301341,
		DamageType = 1,
		DynamicArgType = {
			303,
			303,
			102,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"7"
			},
			{
				"2",
				"11"
			},
			{
				"1",
				"1",
				"301992"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[301351] = {
		DynamicRPNExp = "A1/A2*0.25",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 301351,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			303,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"13"
			},
			{
				"1",
				"9"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[301362] = {
		DynamicRPNExp = "(A2-A1)*0.05",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 301362,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			303,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"13"
			},
			{
				"1",
				"9"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[301371] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		DynamicRPNExp = "K*(0.35+0.08*A1)",
		IsIgnoreSheild = true,
		MinDamage = 99,
		Id = 301371,
		DamageType = 4,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		TargetAtt = {
			11,
			0
		},
		TargetAttVal = {
			{
				-1
			},
			{}
		},
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1102"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[301401] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "(K-A2)*(2.75-(A1-1)*0.55)",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = true,
		Id = 301401,
		DamageType = 4,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		DynamicArgType = {
			311,
			303,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2"
			},
			{
				"2",
				"11"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[301431] = {
		DynamicRPNExp = "A1*0.05",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 301431,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"5",
				"26"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[301451] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*0.3",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = true,
		MinDamage = 99,
		Id = 301451,
		DamageType = 4,
		DynamicArgType = {
			318,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		}
	},
	[301481] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.04",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 301481,
		MaxFunctionRPN = 301482,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"13"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[301482] = {
		DynamicRPNExp = "A1*0.24",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 301482,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"7"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[301491] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.35",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 301491,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"7"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[301501] = {
		DynamicRPNExp = "A1*0.025",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 301501,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"7"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[301511] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*K*0.12",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = true,
		MinDamage = 98,
		Id = 301511,
		DamageType = 2,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"301512"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[301542] = {
		DynamicRPNExp = "A1*0.2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 301542,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"7"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[301551] = {
		DynamicRPNExp = "0.08+(A1-1)*0.02",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 301551,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"301553"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[301561] = {
		DynamicRPNExp = "0.16-(A1-1)*0.02",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 301561,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"301562"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[301582] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*0.08",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 301582,
		DamageType = 6,
		DynamicArgType = {
			318,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		}
	},
	[301591] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = true,
		MinDamage = 99,
		Id = 301591,
		DamageType = 2,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"7"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[301611] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 301611,
		IsBaseAttribute = true,
		DynamicArgType = {
			310,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"3",
				"1",
				"301603"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[301612] = {
		DynamicRPNExp = "A1*A2*0.01",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 301612,
		IsBaseAttribute = true,
		DynamicArgType = {
			320,
			103,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"7"
			},
			{
				"2",
				"1",
				"301614"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[301641] = {
		DynamicRPNExp = "A1*2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 301641,
		IsBaseAttribute = false,
		DynamicArgType = {
			310,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"3",
				"1",
				"301603"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[301661] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1/4*0.01",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 301661,
		MaxFunctionRPN = 301662,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"10"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[301662] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsIgnoreSheild = false,
		IsBaseAttribute = false,
		Id = 301662,
		DynamicRPNExp = "0.25*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true
	},
	[301671] = {
		DynamicRPNExp = "(A1-A1%5)/5",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 301671,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"10"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[301681] = {
		DynamicRPNExp = "(A1-A2)/A1/10",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 301681,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			303,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{
				"2",
				"13"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[301711] = {
		DynamicRPNExp = "A1*0.015",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 301711,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[301741] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "(A1-A2)/A1/6*K",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 301741,
		MaxFunctionRPN = 301742,
		IsBaseAttribute = true,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		DynamicArgType = {
			303,
			303,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{
				"2",
				"13"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[301742] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = true,
		DynamicRPNExp = "K*7/60",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 301742,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[301751] = {
		DynamicRPNExp = "A1*0.5",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 301751,
		IsBaseAttribute = true,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"13"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[301761] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 301761,
		IsBaseAttribute = false,
		DynamicArgType = {
			308,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[301781] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 301781,
		IsBaseAttribute = false,
		DynamicArgType = {
			308,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[301801] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 301801,
		IsBaseAttribute = false,
		DynamicArgType = {
			308,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"3"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[301831] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 301831,
		IsBaseAttribute = false,
		DynamicArgType = {
			308,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"4"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[301931] = {
		DynamicRPNExp = "(A1*5-A1*5%35)/35",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 301931,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"10"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[301941] = {
		DynamicRPNExp = "A1*0.3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 301941,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"7"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[302001] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*A2*0.15",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = true,
		Id = 302001,
		DamageType = 4,
		DynamicArgType = {
			303,
			103,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"7"
			},
			{
				"2",
				"1",
				"1102"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[302011] = {
		DynamicRPNExp = "(A2-A1)/A2/2.5",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 302011,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			303,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"13"
			},
			{
				"1",
				"9"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[302021] = {
		DynamicRPNExp = "A1*0.25",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 302021,
		IsBaseAttribute = true,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[302031] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*2",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 302031,
		MaxFunctionRPN = 302032,
		IsBaseAttribute = false,
		DynamicArgType = {
			308,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"4"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[302032] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsIgnoreSheild = false,
		IsBaseAttribute = false,
		Id = 302032,
		DynamicRPNExp = "40*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true
	},
	[302051] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.04",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 302051,
		IsBaseAttribute = false,
		DynamicArgType = {
			311,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[302101] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.05",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 302101,
		IsBaseAttribute = false,
		DynamicArgType = {
			312,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"3",
				"1",
				"302102"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[303121] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.08",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 303121,
		IsBaseAttribute = false,
		DynamicArgType = {
			311,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[304041] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.03",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 304041,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1102"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[304051] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.015",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 304051,
		IsBaseAttribute = false,
		DynamicArgType = {
			312,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"3",
				"1",
				"1102"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[304071] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 304071,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"1102"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[304081] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.02",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 304081,
		IsBaseAttribute = false,
		DynamicArgType = {
			312,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1102"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[304101] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.03",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 304101,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1102"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[305021] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 305021,
		DamageType = 3,
		TargetAtt = {
			9,
			0
		},
		TargetAttVal = {
			{
				0.03
			},
			{}
		}
	},
	[306061] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.15",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 306061,
		IsBaseAttribute = false,
		DynamicArgType = {
			312,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"3",
				"1",
				"1231"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[306101] = {
		MaxDamage = 306102,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 306101,
		DamageType = 1,
		TargetAtt = {
			9,
			0
		},
		TargetAttVal = {
			{
				1
			},
			{}
		}
	},
	[306102] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 306102,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1.5
			},
			{}
		}
	},
	[307011] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.01*K",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 307011,
		IsBaseAttribute = false,
		TargetAtt = {
			11,
			0
		},
		TargetAttVal = {
			{
				1
			},
			{}
		},
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1106"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[307021] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.005*K",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 307021,
		IsBaseAttribute = false,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		DynamicArgType = {
			312,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"3",
				"1",
				"1106"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[307101] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.01",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 307101,
		IsBaseAttribute = false,
		DynamicArgType = {
			312,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"3",
				"1",
				"1106"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[307121] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*A2*0.01",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 307121,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			303,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"1106"
			},
			{
				"2",
				"9"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[308081] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "K*0.1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 308081,
		IsBaseAttribute = false,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[391031] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 391031,
		DamageType = 3,
		SelfAtt = {
			9,
			13
		},
		SelfAttVal = {
			{
				0.2
			},
			{
				-1
			}
		}
	},
	[391061] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 391061,
		DamageType = 3,
		SelfAtt = {
			9,
			13
		},
		SelfAttVal = {
			{
				0.4
			},
			{
				-1
			}
		}
	},
	[391131] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "K*0.05",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 391131,
		IsBaseAttribute = false,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[391141] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "K*0.05",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 391141,
		IsBaseAttribute = false,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[391151] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "K*0.05",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 391151,
		IsBaseAttribute = false,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[391161] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "K*0.05",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 391161,
		IsBaseAttribute = false,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[391171] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "K*0.05",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 391171,
		IsBaseAttribute = false,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[391401] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.02",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 391401,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1106"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[391402] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.02",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 391402,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1106"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[391471] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 391471,
		IsBaseAttribute = false,
		DynamicArgType = {
			313,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"2",
				"401"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[391531] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 391531,
		IsBaseAttribute = false,
		DynamicArgType = {
			313,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"2",
				"402"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[430200] = {
		DynamicRPNExp = "(A1-A2)/A1/5",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 430200,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			303,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{
				"2",
				"13"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[456040] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "(A2-A1)*0.1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 456040,
		MaxFunctionRPN = 456041,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			303,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"13"
			},
			{
				"1",
				"9"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[456041] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*2",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 456041,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"7"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1013201] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 1013201,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1013203"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1014201] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		DynamicRPNExp = "K*(0.4+0.03*A1)",
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1014201,
		DamageType = 1,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		TargetAtt = {
			11,
			0
		},
		TargetAttVal = {
			{
				-1
			},
			{}
		},
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"3",
				"1",
				"1014298"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1014202] = {
		DynamicRPNExp = "A1*A2*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1014202,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			303,
			104,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"1014207"
			},
			{
				"2",
				"7"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1014203] = {
		DynamicRPNExp = "A1*A2*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1014203,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			320,
			104,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"1014207"
			},
			{
				"2",
				"7"
			},
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1015101] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1015101,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			103,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2"
			},
			{
				"2",
				"1",
				"1015101"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1016301] = {
		DynamicRPNExp = "A1*A2*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1016301,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			320,
			104,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"1016302"
			},
			{
				"2",
				"7"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1024101] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		DynamicRPNExp = "K*(1+0.01*A1)*A2",
		IsIgnoreSheild = false,
		Id = 1024101,
		DamageType = 1,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		TargetAtt = {
			11,
			0
		},
		TargetAttVal = {
			{
				-1
			},
			{}
		},
		DynamicArgType = {
			103,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"4406101"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1025201] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*A2",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1025201,
		DamageType = 6,
		DynamicArgType = {
			303,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1034101] = {
		DynamicRPNExp = "A1*0.05",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1034101,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"3",
				"103310"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1034102] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1034102,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"3",
				"103310"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1034103] = {
		DynamicRPNExp = "(A1-A2-1.5)*0.25",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1034103,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			303,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"26"
			},
			{
				"1",
				"27"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1035101] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1+1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = true,
		Id = 1035101,
		MaxFunctionRPN = 1035102,
		IsBaseAttribute = false,
		DynamicArgType = {
			102,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1035111"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1035102] = {
		DynamicRPNExp = "A1-A2-A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = true,
		Id = 1035102,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			103,
			103,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"3"
			},
			{
				"2",
				"1",
				"1035103"
			},
			{
				"2",
				"1",
				"1035106"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1035103] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = true,
		Id = 1035103,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"3",
				"103310"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1035201] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		DynamicRPNExp = "K*(1+0.01*A1)*A3+K*(1+0.01*A1)*A2*A4",
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1035201,
		DamageType = 1,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		TargetAtt = {
			11,
			0
		},
		TargetAttVal = {
			{
				-1
			},
			{}
		},
		DynamicArgType = {
			103,
			103,
			104,
			104,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"4406101"
			},
			{
				"2",
				"1",
				"1035204"
			},
			{
				"2"
			},
			{
				"3"
			},
			{},
			{},
			{},
			{}
		}
	},
	[1035202] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		DynamicRPNExp = "K*(1+0.01*A1)*A2",
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1035202,
		DamageType = 1,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		TargetAtt = {
			11,
			0
		},
		TargetAttVal = {
			{
				-1
			},
			{}
		},
		DynamicArgType = {
			103,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"4406101"
			},
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1035203] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1035203,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1035217"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1043101] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*A2",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1043101,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			103,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2"
			},
			{
				"1",
				"1",
				"1043106"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1043102] = {
		DynamicRPNExp = "A1*1+10",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1043102,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1045102"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1043201] = {
		DynamicRPNExp = "A1*A2*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1043201,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			103,
			303,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"2",
				"3",
				"104320"
			},
			{
				"2",
				"7"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1044101] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "K*A2*(1+A1*0.1)",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1044101,
		SelfAtt = {
			11,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		DynamicArgType = {
			103,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"3",
				"104310"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1044102] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "K*(A1+A3*A2)",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1044102,
		SelfAtt = {
			11,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		DynamicArgType = {
			104,
			311,
			104,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"2"
			},
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1044103] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "K*(A1+A4*A2)*(1+A3*0.1)",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1044103,
		SelfAtt = {
			11,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		DynamicArgType = {
			104,
			311,
			103,
			104,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"2"
			},
			{
				"1",
				"3",
				"104310"
			},
			{
				"2"
			},
			{},
			{},
			{},
			{}
		}
	},
	[1044201] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1044201,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"3",
				"104320"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1044202] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1044202,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1044206"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1045101] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1045101,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1045201] = {
		DynamicRPNExp = "A1*A2*0.02",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1045201,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			303,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1045203"
			},
			{
				"2",
				"7"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1046301] = {
		DynamicRPNExp = "(A2-A1)/A2*100",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1046301,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			303,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"13"
			},
			{
				"2",
				"9"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1046302] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = true,
		DynamicRPNExp = "K*A1/5*A2",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1046302,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		DynamicArgType = {
			312,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1046303"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1053101] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		DynamicRPNExp = "K*A1/1000",
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1053101,
		DamageType = 1,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		TargetAtt = {
			11,
			0
		},
		TargetAttVal = {
			{
				-1
			},
			{}
		},
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"3",
				"1",
				"1053108"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1053102] = {
		DynamicRPNExp = "(A1+A2*A3)*1000",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1053102,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			104,
			103,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"2"
			},
			{
				"2",
				"1",
				"1053109"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1055201] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*(A2-A3)",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1055201,
		DamageType = 1,
		DynamicArgType = {
			104,
			303,
			303,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2"
			},
			{
				"1",
				"7"
			},
			{
				"2",
				"11"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1064101] = {
		DynamicRPNExp = "A1+1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1064101,
		IsBaseAttribute = true,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1064110"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1064201] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.02*K",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 1064201,
		MaxFunctionRPN = 1064202,
		IsBaseAttribute = true,
		TargetAtt = {
			11,
			0
		},
		TargetAttVal = {
			{
				1
			},
			{}
		},
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1106"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1064202] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		Id = 1064202,
		DynamicRPNExp = "0.3*K",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		IsBaseAttribute = true,
		TargetAtt = {
			11,
			0
		},
		TargetAttVal = {
			{
				1
			},
			{}
		}
	},
	[1064203] = {
		DynamicRPNExp = "A1*10",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1064203,
		IsBaseAttribute = true,
		DynamicArgType = {
			104,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1065101] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1065101,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			103,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2"
			},
			{
				"2",
				"1",
				"1065102"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1074101] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = true,
		DynamicRPNExp = "A1*(A2+(A3-A2)*A4)",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 1074101,
		DamageType = 2,
		DynamicArgType = {
			321,
			104,
			104,
			102,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1"
			},
			{
				"1"
			},
			{
				"2"
			},
			{
				"2",
				"1",
				"1074106"
			},
			{},
			{},
			{},
			{}
		}
	},
	[1074102] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 1074102,
		IsBaseAttribute = false,
		DynamicArgType = {
			310,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"3",
				"1",
				"1074108"
			},
			{
				"3"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1075201] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1075201,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1106"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1082201] = {
		DynamicRPNExp = "(A1-A1%2)/2+1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1082201,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"1102"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1083101] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1083101,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1083102"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1083201] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.02+A2",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1083201,
		MaxFunctionRPN = 1083202,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"1102"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1083202] = {
		DynamicRPNExp = "A1+0.4",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1083202,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1084101] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "(A3/4)*A1*A2",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1084101,
		MaxFunctionRPN = 1084102,
		IsBaseAttribute = false,
		DynamicArgType = {
			320,
			104,
			303,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"7"
			},
			{
				"2"
			},
			{
				"2",
				"14"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1084102] = {
		DynamicRPNExp = "7*A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1084102,
		IsBaseAttribute = false,
		DynamicArgType = {
			320,
			104,
			303,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"7"
			},
			{
				"2"
			},
			{
				"2",
				"14"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1084201] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.05",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1084201,
		MaxFunctionRPN = 1084202,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"9"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1084202] = {
		DynamicRPNExp = "A1*0.8",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1084202,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"7"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1084203] = {
		DynamicRPNExp = "A1-0.75+A2*A3*(A4-6)",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1084203,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			102,
			104,
			103,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"24"
			},
			{
				"2",
				"1",
				"1084207"
			},
			{
				"2"
			},
			{
				"1",
				"1",
				"1102"
			},
			{},
			{},
			{},
			{}
		}
	},
	[1084204] = {
		DynamicRPNExp = "A1-0.75+A2*0.75",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1084204,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			102,
			104,
			103,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"24"
			},
			{
				"2",
				"1",
				"1084207"
			},
			{
				"2"
			},
			{
				"1",
				"1",
				"1102"
			},
			{},
			{},
			{},
			{}
		}
	},
	[1094101] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "(A1-A2)*(0.2+A3*0.001)",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 1094101,
		DamageType = 4,
		DynamicArgType = {
			303,
			303,
			103,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"7"
			},
			{
				"2",
				"11"
			},
			{
				"1",
				"1",
				"1095102"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1094201] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1094201,
		IsBaseAttribute = false,
		DynamicArgType = {
			311,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1094202] = {
		DynamicRPNExp = "A1*0.05",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 1094202,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1094203"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1095101] = {
		DynamicRPNExp = "A2-A1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1095101,
		IsBaseAttribute = true,
		DynamicArgType = {
			103,
			103,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1102"
			},
			{
				"1",
				"1",
				"1095107"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1103101] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "5+5*A1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1103101,
		MaxFunctionRPN = 1103102,
		IsBaseAttribute = true,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1103117"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1103102] = {
		DynamicRPNExp = "30-A1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1103102,
		IsBaseAttribute = true,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1103108"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1103103] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*A2*0.01",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1103103,
		MaxFunctionRPN = 1103104,
		IsBaseAttribute = true,
		DynamicArgType = {
			320,
			103,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"7"
			},
			{
				"1",
				"1",
				"1106"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1103104] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1103104,
		IsBaseAttribute = true,
		DynamicArgType = {
			104,
			320,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"2",
				"7"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1104101] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "(A1-A2)*(A3+A4*A5)*(1+A6*0.01)",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = true,
		MinDamage = 99,
		Id = 1104101,
		MaxFunctionRPN = 1104102,
		DamageType = 4,
		TargetAttVal = {
			{
				0
			},
			{}
		},
		DynamicArgType = {
			303,
			303,
			104,
			103,
			104,
			103,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"7"
			},
			{
				"2",
				"11"
			},
			{
				"1"
			},
			{
				"2",
				"1",
				"1106"
			},
			{
				"2"
			},
			{
				"2",
				"3",
				"11061"
			},
			{},
			{}
		}
	},
	[1104102] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsIgnoreSheild = true,
		DynamicRPNExp = "(A1-A2)*(A3+A4*30)*(1+A5*0.01)",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		Id = 1104102,
		IsBaseAttribute = false,
		TargetAttVal = {
			{
				0
			},
			{}
		},
		DynamicArgType = {
			303,
			303,
			104,
			104,
			103,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"7"
			},
			{
				"2",
				"11"
			},
			{
				"1"
			},
			{
				"2"
			},
			{
				"2",
				"3",
				"11061"
			},
			{},
			{},
			{}
		}
	},
	[1104103] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "(A1-A2)*(A3+A4*(A5+A7))*(1+A6*0.01)",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = true,
		MinDamage = 99,
		Id = 1104103,
		MaxFunctionRPN = 1104104,
		DamageType = 4,
		TargetAttVal = {
			{
				0
			},
			{}
		},
		DynamicArgType = {
			303,
			303,
			104,
			103,
			104,
			103,
			104,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"7"
			},
			{
				"2",
				"11"
			},
			{
				"1"
			},
			{
				"2",
				"1",
				"1106"
			},
			{
				"2"
			},
			{
				"2",
				"3",
				"11061"
			},
			{
				"3"
			},
			{}
		}
	},
	[1104104] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsIgnoreSheild = true,
		DynamicRPNExp = "(A1-A2)*(A3+30*(A4+A5))*(1+A6*0.01)",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		Id = 1104104,
		IsBaseAttribute = false,
		TargetAttVal = {
			{
				0
			},
			{}
		},
		DynamicArgType = {
			303,
			303,
			104,
			104,
			104,
			103,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"7"
			},
			{
				"2",
				"11"
			},
			{
				"1"
			},
			{
				"2"
			},
			{
				"3"
			},
			{
				"2",
				"3",
				"11061"
			},
			{},
			{}
		}
	},
	[1104105] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*A2",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = true,
		Id = 1104105,
		MaxFunctionRPN = 1104106,
		IsBaseAttribute = false,
		TargetAttVal = {
			{
				0
			},
			{}
		},
		DynamicArgType = {
			104,
			103,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"4"
			},
			{
				"2",
				"1",
				"1106"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1104106] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsIgnoreSheild = true,
		DynamicRPNExp = "A1*50",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		Id = 1104106,
		IsBaseAttribute = false,
		TargetAttVal = {
			{
				0
			},
			{}
		},
		DynamicArgType = {
			104,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"4"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1104201] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		DynamicRPNExp = "K*A1*(1+A2)",
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1104201,
		DamageType = 1,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		TargetAtt = {
			11,
			0
		},
		TargetAttVal = {
			{
				-1
			},
			{}
		},
		DynamicArgType = {
			104,
			102,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"3",
				"1",
				"1601"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1104202] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "(A2/A1)*0.4*(1+A3)",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1104202,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			303,
			102,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"9"
			},
			{
				"1",
				"13"
			},
			{
				"2",
				"1",
				"1601"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1104203] = {
		DynamicRPNExp = "0.3*(1+A1)",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1104203,
		IsBaseAttribute = false,
		DynamicArgType = {
			102,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1601"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1104204] = {
		DynamicRPNExp = "0.4*(1+A1)",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1104204,
		IsBaseAttribute = false,
		DynamicArgType = {
			102,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1601"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1104205] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*A2*(1+A3)",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1104205,
		MaxFunctionRPN = 1104206,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			104,
			102,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"9"
			},
			{
				"2"
			},
			{
				"2",
				"1",
				"1601"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1104206] = {
		DynamicRPNExp = "A1*A2*(1+A3)",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1104206,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			104,
			102,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"7"
			},
			{
				"3"
			},
			{
				"2",
				"1",
				"1601"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1112101] = {
		DynamicRPNExp = "A1*0.2*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1112101,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			103,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"3",
				"111210"
			},
			{
				"2",
				"1",
				"1106"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1113201] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "(A1-A2)*A3",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1113201,
		DamageType = 1,
		DynamicArgType = {
			303,
			303,
			104,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"7"
			},
			{
				"2",
				"11"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1113202] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "(A1-A2)*A3*A4/1000",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1113202,
		DamageType = 1,
		DynamicArgType = {
			303,
			303,
			104,
			103,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"7"
			},
			{
				"2",
				"11"
			},
			{
				"1"
			},
			{
				"2",
				"1",
				"1113209"
			},
			{},
			{},
			{},
			{}
		}
	},
	[1113203] = {
		DynamicRPNExp = "(A1-A2)*1000",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1113203,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			303,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"26"
			},
			{
				"2",
				"27"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1114101] = {
		DynamicRPNExp = "(A1-A1%50)/50",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1114101,
		IsBaseAttribute = true,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1106"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1115201] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsIgnoreSheild = false,
		IsBaseAttribute = false,
		Id = 1115201,
		DynamicRPNExp = "A1*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true
	},
	[1121201] = {
		DynamicRPNExp = "A1*0.1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1121201,
		IsBaseAttribute = false,
		DynamicArgType = {
			311,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1121202] = {
		DynamicRPNExp = "A1*0.2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1121202,
		IsBaseAttribute = false,
		DynamicArgType = {
			311,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1124101] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "(A1-A2)/A1*0.4",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1124101,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			303,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"9"
			},
			{
				"1",
				"13"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1124102] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1124102,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"5",
				"17"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1124103] = {
		DynamicRPNExp = "A1*0.02",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1124103,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1124107"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1124104] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*A2",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1124104,
		DamageType = 6,
		DynamicArgType = {
			303,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1124201] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1124201,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1109"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1124202] = {
		DynamicRPNExp = "A1*A2*0.03",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 1124202,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			320,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1109"
			},
			{
				"2",
				"11"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1124203] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1124203,
		IsBaseAttribute = false,
		DynamicArgType = {
			311,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1124204] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 1124204,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1109"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1124205] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 1124205,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1109"
			},
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1124206] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "(A1/2)*A2*A3",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1124206,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			303,
			104,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"3",
				"112420"
			},
			{
				"2",
				"7"
			},
			{
				"3"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1124207] = {
		DynamicRPNExp = "A1/2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1124207,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"3",
				"112420"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1124208] = {
		DynamicRPNExp = "A1%2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1124208,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"1124216"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1124209] = {
		DynamicRPNExp = "(A1%2)+1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1124209,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"1124216"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1133201] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*A2*A3",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1133201,
		MaxFunctionRPN = 1133202,
		IsBaseAttribute = false,
		DynamicArgType = {
			312,
			320,
			104,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1109"
			},
			{
				"2",
				"7"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1133202] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1133202,
		IsBaseAttribute = false,
		DynamicArgType = {
			320,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"7"
			},
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1134101] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1134101,
		IsBaseAttribute = false,
		DynamicArgType = {
			312,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1102"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1134102] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "K*(1+A1*A2+A3*A4)",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1134102,
		SelfAtt = {
			9,
			0
		},
		SelfAttVal = {
			{
				0.4
			},
			{}
		},
		DynamicArgType = {
			103,
			104,
			102,
			104,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1134110"
			},
			{
				"3"
			},
			{
				"2",
				"1",
				"1134111"
			},
			{
				"4"
			},
			{},
			{},
			{},
			{}
		}
	},
	[1134103] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "K*(1+A1*A2+A3*A4)",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1134103,
		SelfAtt = {
			9,
			0
		},
		SelfAttVal = {
			{
				0.6
			},
			{}
		},
		DynamicArgType = {
			103,
			104,
			102,
			104,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1134110"
			},
			{
				"3"
			},
			{
				"2",
				"1",
				"1134111"
			},
			{
				"4"
			},
			{},
			{},
			{},
			{}
		}
	},
	[1134201] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1134201,
		MaxFunctionRPN = 1134202,
		IsBaseAttribute = false,
		DynamicArgType = {
			312,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1109"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1134202] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsIgnoreSheild = false,
		IsBaseAttribute = false,
		Id = 1134202,
		DynamicRPNExp = "1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true
	},
	[1135201] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1135201,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1109"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1144201] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.02",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 1144201,
		MaxFunctionRPN = 1144202,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1102"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1144202] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsIgnoreSheild = false,
		IsBaseAttribute = false,
		Id = 1144202,
		DynamicRPNExp = "0.2",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true
	},
	[1154101] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "K*(A2+A1*0.01+A3*0.05)",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1154101,
		DamageType = 3,
		SelfAtt = {
			9,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		DynamicArgType = {
			103,
			104,
			102,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"3",
				"115310"
			},
			{
				"1"
			},
			{
				"2",
				"1",
				"1154101"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1154102] = {
		DynamicRPNExp = "A1+A2-A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1154102,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			318,
			303,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1154104"
			},
			{},
			{
				"2",
				"9"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1154103] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1154103,
		DamageType = 5,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1154107"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1155101] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1155101,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1154107"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1155102] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1155102,
		DamageType = 5,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1155104"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1163101] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*(A2+A3*0.001)",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = true,
		MinDamage = 98,
		Id = 1163101,
		DamageType = 4,
		DynamicArgType = {
			303,
			104,
			103,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"7"
			},
			{
				"1"
			},
			{
				"1",
				"1",
				"1095102"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1163102] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*(A2+A3*0.001)",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = true,
		Id = 1163102,
		DamageType = 4,
		DynamicArgType = {
			303,
			104,
			103,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"7"
			},
			{
				"2"
			},
			{
				"1",
				"1",
				"1095102"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1163201] = {
		DynamicRPNExp = "A1/A2/5+A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1163201,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			303,
			104,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"13"
			},
			{
				"2",
				"9"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1164101] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1164101,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1102"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1164201] = {
		DynamicRPNExp = "A3-A1+A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1164201,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			103,
			318,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{
				"2",
				"1",
				"1164202"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1165201] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*A2*100",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1165201,
		MaxFunctionRPN = 1165202,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"24"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1165202] = {
		DynamicRPNExp = "A1*100",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1165202,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1166301] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "(A1-A2)/A1*A3/0.7",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1166301,
		MaxFunctionRPN = 1166302,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			303,
			104,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"9"
			},
			{
				"1",
				"13"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1166302] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1166302,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1174101] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*A2",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1174101,
		MaxFunctionRPN = 1174102,
		DamageType = 3,
		DynamicArgType = {
			318,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{},
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1174102] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1174102,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"7"
			},
			{
				"3"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1174201] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1174201,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1174210"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1174202] = {
		DynamicRPNExp = "A1*0.2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1174202,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1174208"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1175201] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*A2*A3",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1175201,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			104,
			103,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"7"
			},
			{
				"2"
			},
			{
				"2",
				"1",
				"1175201"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1175202] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1175202,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"3"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1181101] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*A2",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1181101,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"3",
				"118110"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1183201] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "K*0.05",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 1183201,
		SelfAtt = {
			11,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[1184201] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "K*A1*A2",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1184201,
		SelfAtt = {
			11,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		DynamicArgType = {
			310,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"3",
				"118320"
			},
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1184202] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*K*0.05",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1184202,
		DamageType = 5,
		SelfAtt = {
			9,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		DynamicArgType = {
			310,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"3",
				"118320"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1192101] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1192101,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1192101"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1192102] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "(K-A2)*A1*A3",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1192102,
		DamageType = 1,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		DynamicArgType = {
			103,
			303,
			104,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1192102"
			},
			{
				"2",
				"11"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1192103] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1192103,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1194104"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1194101] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1194101,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1192101"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1194102] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1194102,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1194104"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1194103] = {
		DynamicRPNExp = "A1*A2*1000",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1194103,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1194103"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1194104] = {
		DynamicRPNExp = "A1*A2*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1194104,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			320,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1194103"
			},
			{
				"2"
			},
			{
				"2",
				"7"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1194105] = {
		DynamicRPNExp = "A1*(A2+A3*A4)*1000",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1194105,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			102,
			104,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1194103"
			},
			{
				"1"
			},
			{
				"2",
				"1",
				"1193102"
			},
			{
				"3"
			},
			{},
			{},
			{},
			{}
		}
	},
	[1194201] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1194201,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"3",
				"119420"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1194202] = {
		DynamicRPNExp = "A1*A2*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1194202,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			320,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"3",
				"119420"
			},
			{
				"2"
			},
			{
				"2",
				"7"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1194203] = {
		DynamicRPNExp = "A1*0.2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1194203,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1193203"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1201101] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1201101,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1201101"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1203101] = {
		DynamicRPNExp = "(A1-A1%20)/20",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1203101,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"14"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1204101] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1/A2/10*K",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1204101,
		IsBaseAttribute = true,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		DynamicArgType = {
			303,
			303,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"13"
			},
			{
				"2",
				"9"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1204102] = {
		DynamicRPNExp = "A2-A1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1204102,
		IsBaseAttribute = true,
		DynamicArgType = {
			103,
			303,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1204106"
			},
			{
				"2",
				"14"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1204103] = {
		DynamicRPNExp = "A1*(A2/4)",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1204103,
		IsBaseAttribute = true,
		DynamicArgType = {
			104,
			103,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"2",
				"1",
				"1204111"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1204201] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1204201,
		IsBaseAttribute = false,
		DynamicArgType = {
			318,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		}
	},
	[1204202] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*0.1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1204202,
		MaxFunctionRPN = 1204203,
		DamageType = 1,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"3",
				"1",
				"1204206"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1204203] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "K*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1204203,
		IsBaseAttribute = false,
		SelfAtt = {
			9,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[1205101] = {
		DynamicRPNExp = "A1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1205101,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1212201] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "(A1-A2)*(A3+A4/1000)",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1212201,
		DamageType = 1,
		DynamicArgType = {
			303,
			303,
			104,
			103,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"7"
			},
			{
				"2",
				"11"
			},
			{
				"1"
			},
			{
				"2",
				"1",
				"1335207"
			},
			{},
			{},
			{},
			{}
		}
	},
	[1213201] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "((A2-A1)-(A2-A1)%8)/8",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1213201,
		MaxFunctionRPN = 1213202,
		IsBaseAttribute = true,
		DynamicArgType = {
			303,
			103,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"14"
			},
			{
				"2",
				"1",
				"1213202"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1213202] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1213202,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1213203] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		DynamicRPNExp = "K*(A1*A2+A3/1000)",
		IsIgnoreSheild = false,
		Id = 1213203,
		DamageType = 1,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		TargetAtt = {
			11,
			0
		},
		TargetAttVal = {
			{
				-1
			},
			{}
		},
		DynamicArgType = {
			104,
			103,
			103,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"1",
				"1",
				"1213204"
			},
			{
				"2",
				"1",
				"1335207"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1214101] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		DynamicRPNExp = "K*A1*0.1",
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1214101,
		DamageType = 1,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		TargetAtt = {
			11,
			0
		},
		TargetAttVal = {
			{
				-1
			},
			{}
		},
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"3",
				"1",
				"1214198"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1214102] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1214102,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1214103"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1214201] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.05",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1214201,
		MaxFunctionRPN = 1214202,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"13"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1214202] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.3",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1214202,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"7"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1214203] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "(A1-A2)*(A3+A4/1000)",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1214203,
		DamageType = 1,
		DynamicArgType = {
			303,
			303,
			104,
			103,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"7"
			},
			{
				"2",
				"11"
			},
			{
				"1"
			},
			{
				"2",
				"1",
				"1335207"
			},
			{},
			{},
			{},
			{}
		}
	},
	[1215201] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "(A1-A2)*(A3*A4+A5/1000)",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 1215201,
		DamageType = 1,
		DynamicArgType = {
			303,
			303,
			104,
			104,
			103,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"7"
			},
			{
				"2",
				"11"
			},
			{
				"2"
			},
			{
				"3"
			},
			{
				"2",
				"1",
				"1335207"
			},
			{},
			{},
			{}
		}
	},
	[1223101] = {
		DynamicRPNExp = "A1*A2*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1223101,
		IsBaseAttribute = false,
		DynamicArgType = {
			320,
			104,
			103,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"7"
			},
			{
				"1"
			},
			{
				"2",
				"1",
				"1223104"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1223201] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*A2*(1-A4/A3)",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1223201,
		DamageType = 6,
		DynamicArgType = {
			320,
			104,
			303,
			303,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{
				"1"
			},
			{
				"2",
				"9"
			},
			{
				"2",
				"13"
			},
			{},
			{},
			{},
			{}
		}
	},
	[1224101] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		DynamicRPNExp = "K*A1*A2",
		IsIgnoreSheild = true,
		MinDamage = 99,
		Id = 1224101,
		DamageType = 4,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		TargetAtt = {
			11,
			0
		},
		TargetAttVal = {
			{
				-1
			},
			{}
		},
		DynamicArgType = {
			103,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"3",
				"122410"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1224102] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		DynamicRPNExp = "K*(A1*(A2+A1*0.0001)+A3*A4)",
		IsIgnoreSheild = true,
		Id = 1224102,
		DamageType = 4,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		TargetAtt = {
			11,
			0
		},
		TargetAttVal = {
			{
				-1
			},
			{}
		},
		DynamicArgType = {
			103,
			104,
			102,
			104,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"3",
				"122410"
			},
			{
				"1"
			},
			{
				"1",
				"1",
				"1224117"
			},
			{
				"3"
			},
			{},
			{},
			{},
			{}
		}
	},
	[1224103] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1224103,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1224103"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1225201] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = true,
		IsIgnoreAbsorb = true,
		IsDamagePlus = false,
		IsIgnoreSheild = true,
		Id = 1225201,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"13"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1225202] = {
		DynamicRPNExp = "A1/A2-A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1225202,
		IsBaseAttribute = false,
		DynamicArgType = {
			312,
			311,
			303,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"1225205"
			},
			{
				"1"
			},
			{
				"2",
				"9"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1225203] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1/A2-A3",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1225203,
		DamageType = 6,
		DynamicArgType = {
			312,
			311,
			103,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"1225205"
			},
			{
				"1"
			},
			{
				"2",
				"1",
				"1225208"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1225204] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1/A2+A3",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1225204,
		DamageType = 6,
		DynamicArgType = {
			312,
			311,
			312,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"1225205"
			},
			{
				"1"
			},
			{
				"1",
				"1",
				"1225208"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1233101] = {
		DynamicRPNExp = "A1*A2*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1233101,
		IsBaseAttribute = true,
		DynamicArgType = {
			320,
			104,
			103,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"7"
			},
			{
				"1"
			},
			{
				"2",
				"1",
				"1233103"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1234101] = {
		DynamicRPNExp = "(A1+A2*A3)*100",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1234101,
		IsBaseAttribute = true,
		DynamicArgType = {
			104,
			104,
			103,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"3"
			},
			{
				"2",
				"1",
				"1234110"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1234102] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "K*A1/100",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1234102,
		DamageType = 3,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"3",
				"1",
				"1234102"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1234103] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = true,
		DynamicRPNExp = "A1*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1234103,
		DamageType = 6,
		DynamicArgType = {
			318,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		}
	},
	[1234201] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1234201,
		IsBaseAttribute = true,
		DynamicArgType = {
			104,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"4"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1234202] = {
		DynamicRPNExp = "A1*0.02",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1234202,
		IsBaseAttribute = true,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1234216"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1244101] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*(0.1-0.05*A2*(A3-4))",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = true,
		MinDamage = 99,
		Id = 1244101,
		DamageType = 2,
		DynamicArgType = {
			103,
			102,
			103,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1244102"
			},
			{
				"2",
				"1",
				"1244106"
			},
			{
				"2",
				"1",
				"1244103"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1244102] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*(0.2-0.05*A2*(A3-6))",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = true,
		MinDamage = 99,
		Id = 1244102,
		DamageType = 2,
		DynamicArgType = {
			103,
			102,
			103,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1244102"
			},
			{
				"2",
				"1",
				"1244107"
			},
			{
				"2",
				"1",
				"1244103"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1244103] = {
		DynamicRPNExp = "(A1+A2*A3)*100",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1244103,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			103,
			104,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"2",
				"1",
				"1244112"
			},
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1244104] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*A2/100",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = true,
		Id = 1244104,
		DamageType = 2,
		DynamicArgType = {
			103,
			103,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1244102"
			},
			{
				"2",
				"1",
				"1244110"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1253201] = {
		DynamicRPNExp = "A1*(A2+A3*A4)",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1253201,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			104,
			102,
			104,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"11"
			},
			{
				"1"
			},
			{
				"1",
				"1",
				"1254203"
			},
			{
				"3"
			},
			{},
			{},
			{},
			{}
		}
	},
	[1254201] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "K*A2+A1*A3",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1254201,
		SelfAtt = {
			9,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		DynamicArgType = {
			303,
			104,
			104,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"11"
			},
			{
				"1"
			},
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1273201] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1273201,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1273202"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1274101] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 1274101,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"3",
				"1101"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1274102] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1274102,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1101"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1274103] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 1274103,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"3",
				"127411"
			},
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1274104] = {
		DynamicRPNExp = "A1*A2*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 1274104,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			320,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"3",
				"127411"
			},
			{
				"3"
			},
			{
				"2",
				"11"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1274105] = {
		DynamicRPNExp = "A1*A2*(1+A3)",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 1274105,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			102,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"3",
				"127411"
			},
			{
				"2"
			},
			{
				"2",
				"1",
				"1274106"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1274106] = {
		DynamicRPNExp = "A1*A2*A3*(1+A4)",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 1274106,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			320,
			102,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"3",
				"127411"
			},
			{
				"3"
			},
			{
				"2",
				"11"
			},
			{
				"2",
				"1",
				"1274106"
			},
			{},
			{},
			{},
			{}
		}
	},
	[1274107] = {
		DynamicRPNExp = "A1*A2*A3*(1+A4)",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1274107,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			320,
			102,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"3",
				"127411"
			},
			{
				"4"
			},
			{
				"2",
				"7"
			},
			{
				"1",
				"1",
				"1274106"
			},
			{},
			{},
			{},
			{}
		}
	},
	[1274201] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "(A1-A2)*(A3+A4*0.001)",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = true,
		MinDamage = 99,
		Id = 1274201,
		DamageType = 4,
		DynamicArgType = {
			303,
			303,
			104,
			103,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"7"
			},
			{
				"2",
				"11"
			},
			{
				"4"
			},
			{
				"1",
				"1",
				"1095102"
			},
			{},
			{},
			{},
			{}
		}
	},
	[1275101] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*A2*A3",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1275101,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			103,
			103,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"2",
				"3",
				"127510"
			},
			{
				"2",
				"3",
				"1101"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1276101] = {
		DynamicRPNExp = "A1*A2*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 1276101,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			320,
			104,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1276103"
			},
			{
				"2",
				"11"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1282201] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 1282201,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			103,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"2",
				"1",
				"1282203"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1284101] = {
		DynamicRPNExp = "A1*1*(1+A2)",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1284101,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			102,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"2",
				"1",
				"1601"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1284102] = {
		DynamicRPNExp = "A1*1*(1+A2)",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1284102,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			102,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2"
			},
			{
				"2",
				"1",
				"1601"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1284103] = {
		DynamicRPNExp = "(A1-A2)*0.05",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1284103,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			320,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"7"
			},
			{
				"2",
				"7"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1284104] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.05",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1284104,
		MaxFunctionRPN = 1284105,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1284105] = {
		DynamicRPNExp = "A1*0.55",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1284105,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"3",
				"7"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1284106] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1284106,
		MaxFunctionRPN = 1284107,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1284107] = {
		DynamicRPNExp = "A1*1.1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1284107,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"3",
				"7"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1284108] = {
		DynamicRPNExp = "(A1-A2)*0.1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1284108,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			320,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"7"
			},
			{
				"2",
				"7"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1284201] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		DynamicRPNExp = "K*A1*(1-0.7*A2)",
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1284201,
		DamageType = 1,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		TargetAtt = {
			11,
			0
		},
		TargetAttVal = {
			{
				-1
			},
			{}
		},
		DynamicArgType = {
			104,
			102,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"3",
				"1",
				"1284214"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1284202] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1284202,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			103,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2"
			},
			{
				"1",
				"1",
				"1284216"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1284203] = {
		DynamicRPNExp = "A1*A2*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 1284203,
		IsBaseAttribute = false,
		DynamicArgType = {
			320,
			103,
			104,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"11"
			},
			{
				"1",
				"1",
				"1284221"
			},
			{
				"3"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1284204] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1284204,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1284221"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1292201] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1292201,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1292201"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1292202] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1292202,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1292203"
			},
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1293101] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 1293101,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			103,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"2",
				"1",
				"1293102"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1293102] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 1293102,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			103,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2"
			},
			{
				"2",
				"1",
				"1293102"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1293201] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		DynamicRPNExp = "K*A1*(1-0.6*A2)",
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1293201,
		DamageType = 1,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		TargetAtt = {
			11,
			0
		},
		TargetAttVal = {
			{
				-1
			},
			{}
		},
		DynamicArgType = {
			104,
			102,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"3",
				"1",
				"1293203"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1293202] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		DynamicRPNExp = "K*(A1*(0.6-0.3*A2)+A3/1000)",
		IsIgnoreSheild = false,
		Id = 1293202,
		DamageType = 1,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		TargetAtt = {
			11,
			0
		},
		TargetAttVal = {
			{
				-1
			},
			{}
		},
		DynamicArgType = {
			104,
			102,
			103,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"3",
				"1",
				"1294212"
			},
			{
				"2",
				"1",
				"1335207"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1293203] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		DynamicRPNExp = "K*(A1*(0.6-0.3*A2)+A5/1000)*(A3-A4)",
		IsIgnoreSheild = false,
		Id = 1293203,
		DamageType = 1,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		TargetAtt = {
			11,
			0
		},
		TargetAttVal = {
			{
				-1
			},
			{}
		},
		DynamicArgType = {
			104,
			102,
			303,
			303,
			103,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"3",
				"1",
				"1294212"
			},
			{
				"3",
				"26"
			},
			{
				"2",
				"27"
			},
			{
				"2",
				"1",
				"1335207"
			},
			{},
			{},
			{}
		}
	},
	[1294101] = {
		DynamicRPNExp = "A1*A2*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1294101,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			103,
			320,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"1",
				"1",
				"1294105"
			},
			{
				"2",
				"7"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1294102] = {
		DynamicRPNExp = "A1*(A2+A3)*A4",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 1294102,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			103,
			103,
			303,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"2",
				"1",
				"1294111"
			},
			{
				"2",
				"1",
				"1294113"
			},
			{
				"3",
				"7"
			},
			{},
			{},
			{},
			{}
		}
	},
	[1294201] = {
		DynamicRPNExp = "A1*1000",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1294201,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"24"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1294202] = {
		DynamicRPNExp = "((A1-1)*100)*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1294202,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"24"
			},
			{
				"3"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1294203] = {
		DynamicRPNExp = "(A1-A3)*25*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 1294203,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			104,
			303,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"3",
				"26"
			},
			{
				"2"
			},
			{
				"2",
				"27"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1295101] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1295101,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1295102"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1295102] = {
		DynamicRPNExp = "A1*A2*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1295102,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			303,
			104,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"1295104"
			},
			{
				"2",
				"7"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1295201] = {
		DynamicRPNExp = "A1*1000-A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1295201,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			103,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"24"
			},
			{
				"2",
				"1",
				"1294204"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1295202] = {
		DynamicRPNExp = "0.3-A1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1295202,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"24"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1295203] = {
		DynamicRPNExp = "A2*0.001-(A1-A3*0.001)",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1295203,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			103,
			103,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"24"
			},
			{
				"2",
				"1",
				"1295215"
			},
			{
				"2",
				"1",
				"1294204"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1296301] = {
		DynamicRPNExp = "A1*A2*10",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1296301,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			303,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"2",
				"24"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1302101] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1302101,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1302102"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1304101] = {
		DynamicRPNExp = "0.03*(A1+A2*A3)",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1304101,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			102,
			103,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1101"
			},
			{
				"2",
				"1",
				"1304107"
			},
			{
				"2",
				"3",
				"1101"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1304102] = {
		DynamicRPNExp = "A1*A2*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1304102,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			320,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"3",
				"130410"
			},
			{
				"2"
			},
			{
				"2",
				"7"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1304103] = {
		DynamicRPNExp = "A1*A2*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 1304103,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			320,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"3",
				"130410"
			},
			{
				"2"
			},
			{
				"2",
				"11"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1304201] = {
		DynamicRPNExp = "(0.1+0.15*A1)*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1304201,
		IsBaseAttribute = false,
		DynamicArgType = {
			102,
			103,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1601"
			},
			{
				"1",
				"3",
				"130420"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1304202] = {
		DynamicRPNExp = "(A2*0.25)*A1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 1304202,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			320,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"3",
				"130420"
			},
			{
				"2",
				"11"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1304203] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*(A3+0.02*A2)*A4",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = true,
		Id = 1304203,
		DamageType = 2,
		DynamicArgType = {
			318,
			103,
			104,
			103,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{},
			{
				"2",
				"1",
				"1304212"
			},
			{
				"1"
			},
			{
				"2",
				"1",
				"1304207"
			},
			{},
			{},
			{},
			{}
		}
	},
	[1314101] = {
		DynamicRPNExp = "A1*A2*A3*(1-A4/3)",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1314101,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			320,
			102,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"3",
				"131410"
			},
			{
				"1"
			},
			{
				"2",
				"7"
			},
			{
				"1",
				"1",
				"1314116"
			},
			{},
			{},
			{},
			{}
		}
	},
	[1314102] = {
		DynamicRPNExp = "A1*A2*(1-A3/3)",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1314102,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			102,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"3",
				"131410"
			},
			{
				"2"
			},
			{
				"1",
				"1",
				"1314116"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1314103] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1314103,
		IsBaseAttribute = false,
		DynamicArgType = {
			310,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"3",
				"1",
				"1314110"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1314104] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1314104,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			103,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"3"
			},
			{
				"1",
				"1",
				"1314110"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1314105] = {
		DynamicRPNExp = "A1-10",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1314105,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1314110"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1324201] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "(A1-A2)*(0.1+A3*A4+A5/1000)",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 1324202,
		Id = 1324201,
		DamageType = 1,
		DynamicArgType = {
			303,
			303,
			102,
			104,
			103,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"7"
			},
			{
				"2",
				"11"
			},
			{
				"2",
				"1",
				"1324225"
			},
			{
				"3"
			},
			{
				"2",
				"1",
				"1335207"
			},
			{},
			{},
			{}
		}
	},
	[1324202] = {
		DynamicRPNExp = "A1*0.1*(0.1+A2*A3)",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1324202,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			102,
			104,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"7"
			},
			{
				"2",
				"1",
				"1324225"
			},
			{
				"3"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1324203] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		DynamicRPNExp = "K*(A1+A2/1000)",
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1324203,
		DamageType = 1,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		TargetAtt = {
			11,
			0
		},
		TargetAttVal = {
			{
				-1
			},
			{}
		},
		DynamicArgType = {
			104,
			103,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"2",
				"1",
				"1335207"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1333101] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1333101,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1106"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1333102] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1333102,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1333106"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1334101] = {
		DynamicRPNExp = "A1/2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1334101,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1106"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1334102] = {
		DynamicRPNExp = "A1*1000",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1334102,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1334103] = {
		DynamicRPNExp = "(A1+A2*A3)*100",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1334103,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			104,
			102,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"3"
			},
			{
				"3",
				"1",
				"1334114"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1334201] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1-1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1334201,
		MaxFunctionRPN = 1334202,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"13"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1334202] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = true,
		Id = 1334202,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1334203] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1334203,
		MaxFunctionRPN = 1334204,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1334203"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1334204] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = true,
		Id = 1334204,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"7"
			},
			{
				"3"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1334205] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1334205,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1334204"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1334206] = {
		IsIgnoreShare = true,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*1",
		IsIgnoreAbsorb = true,
		IsDamagePlus = false,
		IsIgnoreSheild = true,
		Id = 1334206,
		DamageType = 2,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1334204"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1334207] = {
		DynamicRPNExp = "(1-A1/A2/A3)*10000",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1334207,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			303,
			104,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1334204"
			},
			{
				"2",
				"9"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1334208] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "(0.2+(A2-0.2)*A1/10000)*K",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1334208,
		DamageType = 3,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		DynamicArgType = {
			103,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"3",
				"1",
				"1334209"
			},
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1334209] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1334209,
		DamageType = 3,
		DynamicArgType = {
			324,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"3",
				"133420"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1335201] = {
		DynamicRPNExp = "A1*A2*1000",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1335201,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1335205"
			},
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1342101] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1342101,
		MaxFunctionRPN = 1342102,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1106"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1342102] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1342102,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1342103] = {
		DynamicRPNExp = "A1*0.01*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 1342103,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			320,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1342102"
			},
			{
				"2",
				"7"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1343101] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1343101,
		MaxFunctionRPN = 1343102,
		IsBaseAttribute = false,
		DynamicArgType = {
			310,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1106"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1343102] = {
		DynamicRPNExp = "A2-A1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1343102,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1343105"
			},
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1343103] = {
		DynamicRPNExp = "A1*A2*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1343103,
		IsBaseAttribute = false,
		DynamicArgType = {
			320,
			103,
			104,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"7"
			},
			{
				"1",
				"1",
				"1343105"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1344101] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "(A1-A2)*(1+A3*0.01)",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = true,
		Id = 1344101,
		DamageType = 4,
		DynamicArgType = {
			303,
			303,
			103,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"7"
			},
			{
				"2",
				"11"
			},
			{
				"2",
				"3",
				"11061"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1344102] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*A2",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 1344102,
		MaxFunctionRPN = 1344103,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			103,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"2",
				"1",
				"1106"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1344103] = {
		DynamicRPNExp = "A1*30",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1344103,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1344104] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "(A1-A2)*(A3+A4*A5)*(1+A6*0.01)",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = true,
		Id = 1344104,
		MaxFunctionRPN = 1344105,
		DamageType = 4,
		DynamicArgType = {
			303,
			303,
			104,
			104,
			103,
			103,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"7"
			},
			{
				"2",
				"11"
			},
			{
				"2"
			},
			{
				"3"
			},
			{
				"2",
				"1",
				"1106"
			},
			{
				"2",
				"3",
				"11061"
			},
			{},
			{}
		}
	},
	[1344105] = {
		DynamicRPNExp = "(A1-A2)*(A3+A4*30)",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1344105,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			303,
			104,
			104,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"7"
			},
			{
				"2",
				"11"
			},
			{
				"2"
			},
			{
				"3"
			},
			{},
			{},
			{},
			{}
		}
	},
	[1344201] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1344201,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"3",
				"134420"
			},
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1344202] = {
		DynamicRPNExp = "A1*A2*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1344202,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			320,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"3",
				"134420"
			},
			{
				"4"
			},
			{
				"2",
				"7"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1345101] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*A2*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1345101,
		DamageType = 2,
		DynamicArgType = {
			321,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"2"
			},
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1346301] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.01",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 1346301,
		MaxFunctionRPN = 1346302,
		IsBaseAttribute = false,
		DynamicArgType = {
			312,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"5",
				"26"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1346302] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsIgnoreSheild = false,
		IsBaseAttribute = false,
		Id = 1346302,
		DynamicRPNExp = "0.1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true
	},
	[1352101] = {
		DynamicRPNExp = "A1+1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1352101,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"1352105"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1353101] = {
		DynamicRPNExp = "A1+A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1353101,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			103,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"2",
				"1",
				"1352105"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1353102] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1353102,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			103,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2"
			},
			{
				"2",
				"1",
				"1353108"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1354101] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1354101,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1356201"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1354102] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1354102,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"3",
				"135620"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1354103] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1354103,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1356202"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1354201] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1354201,
		IsBaseAttribute = false,
		DynamicArgType = {
			312,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"3",
				"3",
				"135620"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1354202] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1354202,
		IsBaseAttribute = false,
		DynamicArgType = {
			312,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"3",
				"1",
				"1354211"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1354203] = {
		DynamicRPNExp = "A1*A2*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1354203,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			320,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1354218"
			},
			{
				"1"
			},
			{
				"2",
				"7"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1354204] = {
		DynamicRPNExp = "A1*A2*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 1354204,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			320,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"1354218"
			},
			{
				"2"
			},
			{
				"2",
				"11"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1356101] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*A2/25",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1356101,
		MaxFunctionRPN = 1356102,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"3",
				"135620"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1356102] = {
		DynamicRPNExp = "A1*4",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1356102,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1356201] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1356201,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1356201"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1356202] = {
		DynamicRPNExp = "A1*A2*0.002",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1356202,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			320,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"3",
				"135620"
			},
			{
				"2",
				"7"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1356211] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1356211,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1356211"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1356212] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1356212,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1356212"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1361101] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1361101,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"1366201"
			},
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1361102] = {
		DynamicRPNExp = "A1*A2*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1361102,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			320,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"1366201"
			},
			{
				"3"
			},
			{
				"2",
				"7"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1361103] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1361103,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"1366201"
			},
			{
				"4"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1361104] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1361104,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1356201"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1361105] = {
		DynamicRPNExp = "A1*A2*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1361105,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			303,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"1366201"
			},
			{
				"5"
			},
			{
				"2",
				"7"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1363101] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1363101,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"1366201"
			},
			{
				"3"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1364201] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 1364201,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"3",
				"136420"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1364202] = {
		DynamicRPNExp = "A1*A2*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 1364202,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			320,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"3",
				"136420"
			},
			{
				"2"
			},
			{
				"2",
				"11"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1364203] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 1364203,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"3",
				"136420"
			},
			{
				"3"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1365101] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1365101,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1366201"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1366201] = {
		DynamicRPNExp = "A1*0.01",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 1366201,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1366201"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1373201] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = true,
		Id = 1373201,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1373202"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1374201] = {
		DynamicRPNExp = "(A1+A3*A4)*(1+A2)",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = true,
		Id = 1374201,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			102,
			104,
			102,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"2",
				"3",
				"137420"
			},
			{
				"5"
			},
			{
				"2",
				"1",
				"1374224"
			},
			{},
			{},
			{},
			{}
		}
	},
	[1374202] = {
		DynamicRPNExp = "(A1+A4*A5)*(1+A2)*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = true,
		Id = 1374202,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			102,
			320,
			104,
			102,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2"
			},
			{
				"2",
				"3",
				"137420"
			},
			{
				"2",
				"7"
			},
			{
				"5"
			},
			{
				"2",
				"1",
				"1374224"
			},
			{},
			{},
			{}
		}
	},
	[1374203] = {
		DynamicRPNExp = "(A1+A3*A4)*(1+A2)",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = true,
		Id = 1374203,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			102,
			104,
			102,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"3"
			},
			{
				"2",
				"3",
				"137420"
			},
			{
				"5"
			},
			{
				"2",
				"1",
				"1374224"
			},
			{},
			{},
			{},
			{}
		}
	},
	[1374204] = {
		DynamicRPNExp = "(A1+A4*A5)*(1+A2)*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = true,
		Id = 1374204,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			102,
			320,
			104,
			102,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"4"
			},
			{
				"3",
				"3",
				"137420"
			},
			{
				"2",
				"11"
			},
			{
				"5"
			},
			{
				"3",
				"1",
				"1374224"
			},
			{},
			{},
			{}
		}
	},
	[1376301] = {
		DynamicRPNExp = "A1*A2*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = true,
		Id = 1376301,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			320,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1376302"
			},
			{
				"1"
			},
			{
				"2",
				"7"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1384101] = {
		DynamicRPNExp = "A1*A2*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 1384101,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			320,
			104,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"1384108"
			},
			{
				"2",
				"11"
			},
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1393201] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		DynamicRPNExp = "K*((A2+A3)*(A4+A5*A6)+A7*A8+A1/1000)",
		IsIgnoreSheild = false,
		Id = 1393201,
		DamageType = 4,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		TargetAtt = {
			11,
			0
		},
		TargetAttVal = {
			{
				-1
			},
			{}
		},
		DynamicArgType = {
			103,
			103,
			103,
			104,
			102,
			104,
			102,
			104
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1335207"
			},
			{
				"1",
				"1",
				"1395202"
			},
			{
				"1",
				"1",
				"1393207"
			},
			{
				"1"
			},
			{
				"1",
				"3",
				"139420"
			},
			{
				"2"
			},
			{
				"1",
				"1",
				"1394205"
			},
			{
				"3"
			}
		}
	},
	[1394201] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 1394201,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			310,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"3",
				"3",
				"139420"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1394202] = {
		DynamicRPNExp = "A1*A2*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 1394202,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			310,
			320,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2"
			},
			{
				"3",
				"3",
				"139420"
			},
			{
				"2",
				"11"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1394203] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		DynamicRPNExp = "K*(A1*A2+A3/1000)",
		IsIgnoreSheild = false,
		Id = 1394203,
		DamageType = 4,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		TargetAtt = {
			11,
			0
		},
		TargetAttVal = {
			{
				-1
			},
			{}
		},
		DynamicArgType = {
			104,
			103,
			103,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"3",
				"1",
				"1394213"
			},
			{
				"2",
				"1",
				"1335207"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1396301] = {
		DynamicRPNExp = "A1*A2*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1396301,
		IsBaseAttribute = false,
		DynamicArgType = {
			320,
			104,
			310,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"7"
			},
			{
				"1"
			},
			{
				"2",
				"1",
				"1109"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1403101] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = true,
		DynamicRPNExp = "A1*(A2+A3*0.3)*(A4+1)",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 1403101,
		DamageType = 2,
		DynamicArgType = {
			322,
			104,
			102,
			102,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{},
			{
				"1"
			},
			{
				"3",
				"1",
				"1404101"
			},
			{
				"2",
				"1",
				"1404105"
			},
			{},
			{},
			{},
			{}
		}
	},
	[1403201] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = true,
		DynamicRPNExp = "A1*0.05",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1403201,
		DamageType = 6,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1403202] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = true,
		DynamicRPNExp = "A1*0.05",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 1403202,
		DamageType = 2,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1403203] = {
		DynamicRPNExp = "A1*0.05",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1403203,
		IsBaseAttribute = true,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1404101] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*A2*A3",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1404101,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			104,
			103,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"7"
			},
			{
				"1"
			},
			{
				"2",
				"1",
				"1404106"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1404102] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1404102,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1404107"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1404201] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1404201,
		IsBaseAttribute = true,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1403203"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1404202] = {
		DynamicRPNExp = "A1*(A2+A3)*A4",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1404202,
		IsBaseAttribute = true,
		DynamicArgType = {
			320,
			103,
			103,
			104,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"11"
			},
			{
				"2",
				"1",
				"1404202"
			},
			{
				"2",
				"1",
				"1404204"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{}
		}
	},
	[1404203] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1404203,
		IsBaseAttribute = false,
		DynamicArgType = {
			320,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"11"
			},
			{
				"5"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1404204] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1404204,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"6"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1413101] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1413101,
		IsBaseAttribute = false,
		DynamicArgType = {
			310,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1109"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1414101] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1414101,
		IsBaseAttribute = false,
		DynamicArgType = {
			310,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1109"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1414102] = {
		DynamicRPNExp = "A1*A2*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1414102,
		IsBaseAttribute = false,
		DynamicArgType = {
			310,
			320,
			104,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1109"
			},
			{
				"2",
				"7"
			},
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1414103] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "(A1-A2)*(A3+A4/1000)",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 1414103,
		DamageType = 4,
		DynamicArgType = {
			303,
			303,
			104,
			103,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"7"
			},
			{
				"2",
				"11"
			},
			{
				"1"
			},
			{
				"2",
				"1",
				"1335207"
			},
			{},
			{},
			{},
			{}
		}
	},
	[1414104] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "(A1-A2)*(A3*0.36+A4/1000)",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 1414104,
		DamageType = 4,
		DynamicArgType = {
			303,
			303,
			103,
			103,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"7"
			},
			{
				"2",
				"11"
			},
			{
				"2",
				"1",
				"1414119"
			},
			{
				"2",
				"1",
				"1335207"
			},
			{},
			{},
			{},
			{}
		}
	},
	[1414201] = {
		DynamicRPNExp = "A1*A2*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1414201,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			303,
			104,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"1414209"
			},
			{
				"2",
				"7"
			},
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1414202] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1414202,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1414212"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1414203] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1414203,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"1414213"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1414204] = {
		DynamicRPNExp = "A1*A2*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1414204,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			320,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"1414213"
			},
			{
				"1"
			},
			{
				"2",
				"7"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1423101] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		DynamicRPNExp = "K*A1*(1+0.01*A2)",
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1423101,
		DamageType = 1,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		TargetAtt = {
			11,
			0
		},
		TargetAttVal = {
			{
				-1
			},
			{}
		},
		DynamicArgType = {
			104,
			103,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"1",
				"1",
				"4406101"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1423201] = {
		DynamicRPNExp = "A1*A2*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1423201,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			310,
			320,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"2",
				"1",
				"1109"
			},
			{
				"2",
				"7"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1424101] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		DynamicRPNExp = "K*A1*A2*(1+0.01*A3)",
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1424101,
		DamageType = 1,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		TargetAtt = {
			11,
			0
		},
		TargetAttVal = {
			{
				-1
			},
			{}
		},
		DynamicArgType = {
			103,
			104,
			103,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1424102"
			},
			{
				"2"
			},
			{
				"1",
				"1",
				"4406101"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1424102] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		DynamicRPNExp = "K*(A1*A2+A4*A5)*(1+0.01*A3)",
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1424102,
		DamageType = 1,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		TargetAtt = {
			11,
			0
		},
		TargetAttVal = {
			{
				-1
			},
			{}
		},
		DynamicArgType = {
			103,
			104,
			103,
			102,
			104,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1424102"
			},
			{
				"2"
			},
			{
				"1",
				"1",
				"4406101"
			},
			{
				"2",
				"1",
				"1424108"
			},
			{
				"3"
			},
			{},
			{},
			{}
		}
	},
	[1424201] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 1424201,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			310,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2"
			},
			{
				"2",
				"3",
				"142420"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1424202] = {
		DynamicRPNExp = "A1*A2*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 1424202,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			310,
			320,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"3"
			},
			{
				"2",
				"3",
				"142420"
			},
			{
				"2",
				"11"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1424203] = {
		DynamicRPNExp = "A1*A2*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1424203,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			310,
			320,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"4"
			},
			{
				"2",
				"3",
				"142420"
			},
			{
				"2",
				"7"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1424204] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "(A1-A2)*A3",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1424204,
		DamageType = 4,
		DynamicArgType = {
			303,
			303,
			104,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"7"
			},
			{
				"2",
				"11"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1432101] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1432101,
		MaxFunctionRPN = 1432102,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1432102] = {
		DynamicRPNExp = "30-A1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1432102,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"1436101"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1432103] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1432103,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1432102"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1433201] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1433201,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1433202"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1434201] = {
		DynamicRPNExp = "A1-A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1434201,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			103,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1106"
			},
			{
				"2",
				"1",
				"1434203"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1434202] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1434202,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1106"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1434203] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1434203,
		IsBaseAttribute = false,
		DynamicArgType = {
			312,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"3",
				"1",
				"1434202"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1434222] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1434222,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"6"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1434227] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1434227,
		IsBaseAttribute = true,
		DynamicArgType = {
			320,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"7"
			},
			{
				"5"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1436101] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "K*(0.15+A1*A2)",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1436101,
		DamageType = 3,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		DynamicArgType = {
			102,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"1434111"
			},
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1441101] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "(A1-A2)*A3",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1441101,
		DamageType = 4,
		DynamicArgType = {
			303,
			303,
			104,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"7"
			},
			{
				"2",
				"11"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1443101] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.005",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 1443101,
		MaxFunctionRPN = 1443102,
		IsBaseAttribute = false,
		DynamicArgType = {
			312,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"3",
				"1101"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1443102] = {
		DynamicRPNExp = "A1*0.005",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1443102,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1443201] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1443201,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1443202"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1444101] = {
		DynamicRPNExp = "A1*A2*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1444101,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			320,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"1444106"
			},
			{
				"2"
			},
			{
				"2",
				"7"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1444102] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1444102,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1444111"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1444103] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "3+A1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1444103,
		IsBaseAttribute = false,
		DynamicArgType = {
			312,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"3",
				"1",
				"1444118"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1444104] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 1444104,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"1444120"
			},
			{
				"3"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1444105] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 1444105,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"1444120"
			},
			{
				"4"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1444201] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1444201,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1444202"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1444202] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1444202,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1444204"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1444203] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1444203,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1444206"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1444204] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1444204,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1444208"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1444205] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1444205,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			311,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1444206] = {
		DynamicRPNExp = "A1*A2*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1444206,
		IsBaseAttribute = true,
		DynamicArgType = {
			320,
			104,
			311,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"7"
			},
			{
				"2"
			},
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1444207] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1444207,
		IsBaseAttribute = true,
		DynamicArgType = {
			104,
			311,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"3"
			},
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1453101] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1453101,
		IsBaseAttribute = false,
		DynamicArgType = {
			327,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"5",
				"0"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1453102] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1453102,
		IsBaseAttribute = false,
		DynamicArgType = {
			327,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"3",
				"0"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1453103] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1453103,
		IsBaseAttribute = false,
		DynamicArgType = {
			327,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"4",
				"0"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1453104] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1453104,
		IsBaseAttribute = false,
		DynamicArgType = {
			327,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"2",
				"0"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1453107] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		DynamicRPNExp = "K*A1",
		IsIgnoreSheild = false,
		Id = 1453107,
		DamageType = 4,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		TargetAtt = {
			11,
			0
		},
		TargetAttVal = {
			{
				-1
			},
			{}
		},
		DynamicArgType = {
			104,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1453109] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1453109,
		MaxFunctionRPN = 1453111,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1454101"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1453110] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1453110,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"14"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1453111] = {
		DynamicRPNExp = "8-A1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1453111,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1454101"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1454120] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1454120,
		MaxFunctionRPN = 1454121,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1454101"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1454121] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsIgnoreSheild = false,
		IsBaseAttribute = false,
		Id = 1454121,
		DynamicRPNExp = "4",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true
	},
	[1454126] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		DynamicRPNExp = "K*A2*(A3^A4)",
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1454126,
		DamageType = 4,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		TargetAtt = {
			11,
			0
		},
		TargetAttVal = {
			{
				-1
			},
			{}
		},
		DynamicArgType = {
			0,
			104,
			104,
			103,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{},
			{
				"1"
			},
			{
				"2"
			},
			{
				"1",
				"1",
				"1454127"
			},
			{},
			{},
			{},
			{}
		}
	},
	[1454201] = {
		DynamicRPNExp = "A1*0.05*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = true,
		Id = 1454201,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			102,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"3",
				"145420"
			},
			{
				"2",
				"1",
				"1454205"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1454202] = {
		DynamicRPNExp = "A1*0.02*A2*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = true,
		Id = 1454202,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			102,
			320,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"3",
				"145420"
			},
			{
				"2",
				"1",
				"1454205"
			},
			{
				"2",
				"11"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1454203] = {
		DynamicRPNExp = "A1*A4*A2*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = true,
		Id = 1454203,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			102,
			320,
			104,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"3",
				"145420"
			},
			{
				"1",
				"1",
				"1454205"
			},
			{
				"2",
				"7"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{}
		}
	},
	[1454204] = {
		DynamicRPNExp = "A1*A3*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = true,
		Id = 1454204,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			102,
			104,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"3",
				"145420"
			},
			{
				"2",
				"1",
				"1454205"
			},
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1463101] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.01",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1463101,
		MaxFunctionRPN = 1463102,
		IsBaseAttribute = false,
		DynamicArgType = {
			312,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"3",
				"1101"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1463102] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1463102,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1464101] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1464101,
		IsBaseAttribute = false,
		DynamicArgType = {
			317,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"2"
			},
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1464102] = {
		IsBaseAttribute = false,
		IsIgnoreShare = false,
		MaxFunctionRPN = 1464103,
		DynamicRPNExp = "K*A1*A2*A3",
		IsIgnoreInverted = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1464102,
		DamageType = 4,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		TargetAtt = {
			11,
			0
		},
		TargetAttVal = {
			{
				-1
			},
			{}
		},
		DynamicArgType = {
			103,
			104,
			312,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1464104"
			},
			{
				"1"
			},
			{
				"2",
				"3",
				"1101"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1464103] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "K*A1*A2*25",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1464103,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		TargetAtt = {
			11,
			0
		},
		TargetAttVal = {
			{
				-1
			},
			{}
		},
		DynamicArgType = {
			103,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1464104"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1464224] = {
		DynamicRPNExp = "A2*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 1464224,
		IsBaseAttribute = false,
		DynamicArgType = {
			0,
			104,
			320,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{},
			{
				"5"
			},
			{
				"2",
				"11"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1464225] = {
		DynamicRPNExp = "A2*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1464225,
		IsBaseAttribute = false,
		DynamicArgType = {
			0,
			104,
			320,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{},
			{
				"4"
			},
			{
				"2",
				"7"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1466201] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1466201,
		IsBaseAttribute = false,
		DynamicArgType = {
			102,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1464203"
			},
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1466202] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1466202,
		IsBaseAttribute = false,
		DynamicArgType = {
			102,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1464203"
			},
			{
				"3"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1466203] = {
		DynamicRPNExp = "A1*A2*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1466203,
		IsBaseAttribute = false,
		DynamicArgType = {
			102,
			104,
			303,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1464203"
			},
			{
				"4"
			},
			{
				"2",
				"7"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1466204] = {
		DynamicRPNExp = "A1*A2*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 1466204,
		IsBaseAttribute = false,
		DynamicArgType = {
			102,
			104,
			320,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"1464203"
			},
			{
				"5"
			},
			{
				"2",
				"11"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1473201] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1473201,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1473202"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1474101] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1474101,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1473101"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1474102] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*A2",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1474102,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1474103"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1474103] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		DynamicRPNExp = "K*(1+A1*A2*0.01)",
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1474103,
		DamageType = 1,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		TargetAtt = {
			11,
			0
		},
		TargetAttVal = {
			{
				-1
			},
			{}
		},
		DynamicArgType = {
			103,
			103,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"3",
				"1",
				"1474103"
			},
			{
				"3",
				"1",
				"1474199"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1474104] = {
		DynamicRPNExp = "A1*A2*0.03",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 1474104,
		IsBaseAttribute = true,
		DynamicArgType = {
			320,
			103,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"11"
			},
			{
				"1",
				"1",
				"1474121"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1474105] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1474105,
		IsBaseAttribute = true,
		DynamicArgType = {
			104,
			103,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2"
			},
			{
				"1",
				"1",
				"1474121"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1474201] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 1474201,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"1474203"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1474202] = {
		DynamicRPNExp = "A1*A2*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 1474202,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			320,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"1474203"
			},
			{
				"2"
			},
			{
				"2",
				"11"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1474203] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "3+A1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1474203,
		IsBaseAttribute = false,
		DynamicArgType = {
			312,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"3",
				"1",
				"1444118"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1474211] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 1474211,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"1474223"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1474212] = {
		DynamicRPNExp = "A1*A2*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 1474212,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			320,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"1474223"
			},
			{
				"2"
			},
			{
				"2",
				"11"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1474213] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 1474213,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"1474223"
			},
			{
				"4"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1482201] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1482201,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1102"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1482202] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "(A1-A2)*A3*A4",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1482202,
		DamageType = 4,
		DynamicArgType = {
			303,
			303,
			104,
			103,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"7"
			},
			{
				"2",
				"11"
			},
			{
				"1"
			},
			{
				"2",
				"1",
				"1482202"
			},
			{},
			{},
			{},
			{}
		}
	},
	[1483201] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "(A1-A2)*((0.015*A6)+(0.025*A7)+(0.035*A8)+(0.001*A4))*(A3+A5)",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = true,
		MinDamage = 99,
		Id = 1483201,
		DamageType = 4,
		DynamicArgType = {
			303,
			303,
			103,
			103,
			103,
			103,
			103,
			103
		},
		DynamicArgParams = {
			{
				"1",
				"7"
			},
			{
				"2",
				"11"
			},
			{
				"2",
				"1",
				"1102"
			},
			{
				"2",
				"1",
				"1483204"
			},
			{
				"2",
				"1",
				"1514103"
			},
			{
				"2",
				"1",
				"1483203"
			},
			{
				"2",
				"1",
				"1483208"
			},
			{
				"2",
				"1",
				"1483212"
			}
		}
	},
	[1484101] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1484101,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1484116"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1486301] = {
		DynamicRPNExp = "A1-A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1486301,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			103,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1102"
			},
			{
				"2",
				"1",
				"1486302"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1486302] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1486302,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1102"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1486303] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1486303,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1486303"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1493101] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*A2",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1493101,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			103,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"1",
				"1",
				"1493101"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1493201] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*A2",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1493201,
		MaxFunctionRPN = 1493202,
		IsBaseAttribute = false,
		DynamicArgType = {
			312,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"3",
				"1",
				"1102"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1493202] = {
		DynamicRPNExp = "50*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1493202,
		IsBaseAttribute = false,
		DynamicArgType = {
			312,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"3",
				"1",
				"1102"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1494201] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1494201,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1102"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1494202] = {
		DynamicRPNExp = "A1-A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1494202,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			103,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1102"
			},
			{
				"2",
				"1",
				"1494203"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1494203] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1494203,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1494204"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1494204] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "(A1-A2)*((0.015*A6)+(0.025*A7)+(0.035*A8)+(0.001*A5))*(A3+A4)",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1494204,
		DamageType = 4,
		DynamicArgType = {
			303,
			303,
			104,
			103,
			103,
			103,
			103,
			103
		},
		DynamicArgParams = {
			{
				"1",
				"7"
			},
			{
				"2",
				"11"
			},
			{
				"3"
			},
			{
				"2",
				"1",
				"1514103"
			},
			{
				"2",
				"1",
				"1483204"
			},
			{
				"2",
				"1",
				"1483203"
			},
			{
				"2",
				"1",
				"1483208"
			},
			{
				"2",
				"1",
				"1483212"
			}
		}
	},
	[1494205] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "(A1-A2)*0.005*(A3+A4)",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 97,
		Id = 1494205,
		MaxFunctionRPN = 1494206,
		DamageType = 4,
		DynamicArgType = {
			303,
			303,
			104,
			103,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{
				"2",
				"11"
			},
			{
				"3"
			},
			{
				"2",
				"1",
				"1514103"
			},
			{},
			{},
			{},
			{}
		}
	},
	[1494206] = {
		DynamicRPNExp = "A1*0.15*(A2+A3)",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1494206,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			104,
			103,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"4",
				"7"
			},
			{
				"3"
			},
			{
				"2",
				"1",
				"1514103"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1494207] = {
		DynamicRPNExp = "A1*A2*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1494207,
		IsBaseAttribute = true,
		DynamicArgType = {
			320,
			104,
			103,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"7"
			},
			{
				"1"
			},
			{
				"2",
				"1",
				"1494213"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1494208] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1494208,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			103,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2"
			},
			{
				"2",
				"1",
				"1494213"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1496301] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1496301,
		IsBaseAttribute = false,
		DynamicArgType = {
			310,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"1102"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1501101] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1501101,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			103,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"2",
				"1",
				"1501102"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1503101] = {
		DynamicRPNExp = "A1*A2*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 1503101,
		IsBaseAttribute = true,
		DynamicArgType = {
			320,
			104,
			312,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"11"
			},
			{
				"1"
			},
			{
				"1",
				"1",
				"1503106"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1503102] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 1503102,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			103,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2"
			},
			{
				"2",
				"1",
				"1503110"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1503103] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1503103,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"1503103"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1503201] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*A2",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1503201,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			103,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"1",
				"1",
				"1503202"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1504101] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1504101,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1503103"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1504102] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*A2",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1504102,
		IsBaseAttribute = true,
		DynamicArgType = {
			104,
			103,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"1",
				"1",
				"1504103"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1504103] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*A2",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1504103,
		IsBaseAttribute = true,
		DynamicArgType = {
			104,
			103,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2"
			},
			{
				"1",
				"1",
				"1504103"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1504104] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1504104,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"1504103"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1512201] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		DynamicRPNExp = "K*A1",
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1512201,
		DamageType = 1,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		TargetAtt = {
			11,
			0
		},
		TargetAttVal = {
			{
				-1
			},
			{}
		},
		DynamicArgType = {
			104,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1514101] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1514101,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1102"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1514201] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1514201,
		IsBaseAttribute = false,
		DynamicArgType = {
			327,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"2",
				"0"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1514202] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		DynamicRPNExp = "K*A1*(1+A2-A3)",
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1514202,
		DamageType = 1,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		TargetAtt = {
			11,
			0
		},
		TargetAttVal = {
			{
				-1
			},
			{}
		},
		DynamicArgType = {
			104,
			103,
			102,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"1",
				"3",
				"1513202"
			},
			{
				"1",
				"3",
				"1513202"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1514203] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1514203,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"3",
				"1513202"
			},
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1521201] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "(A1-A2)*(A3-A4*0.1-A5*0.05-A6*0.05)",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1521201,
		DamageType = 4,
		DynamicArgType = {
			303,
			303,
			104,
			102,
			102,
			102,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"7"
			},
			{
				"2",
				"11"
			},
			{
				"1"
			},
			{
				"1",
				"1",
				"1526301"
			},
			{
				"1",
				"1",
				"1526302"
			},
			{
				"1",
				"1",
				"1526303"
			},
			{},
			{}
		}
	},
	[1521202] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "(A1-A2)*(A3+A4*0.1+A5*0.05+A6*0.05)",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1521202,
		DamageType = 4,
		DynamicArgType = {
			303,
			303,
			104,
			102,
			102,
			102,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"7"
			},
			{
				"2",
				"11"
			},
			{
				"1"
			},
			{
				"1",
				"1",
				"1526301"
			},
			{
				"1",
				"1",
				"1526302"
			},
			{
				"1",
				"1",
				"1526303"
			},
			{},
			{}
		}
	},
	[1522201] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "(A1-A2)*(A3-A4*0.1-A5*0.05-A6*0.05)",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1522201,
		DamageType = 4,
		DynamicArgType = {
			303,
			303,
			104,
			102,
			102,
			102,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"7"
			},
			{
				"2",
				"11"
			},
			{
				"1"
			},
			{
				"1",
				"1",
				"1526301"
			},
			{
				"1",
				"1",
				"1526302"
			},
			{
				"1",
				"1",
				"1526303"
			},
			{},
			{}
		}
	},
	[1522202] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "(A1-A2)*(A3+A4*0.1+A5*0.05+A6*0.05)",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1522202,
		DamageType = 4,
		DynamicArgType = {
			303,
			303,
			104,
			102,
			102,
			102,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"7"
			},
			{
				"2",
				"11"
			},
			{
				"1"
			},
			{
				"1",
				"1",
				"1526301"
			},
			{
				"1",
				"1",
				"1526302"
			},
			{
				"1",
				"1",
				"1526303"
			},
			{},
			{}
		}
	},
	[1523201] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1523201,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			103,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"2",
				"1",
				"1523203"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1523202] = {
		DynamicRPNExp = "A1*A2*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1523202,
		IsBaseAttribute = true,
		DynamicArgType = {
			320,
			104,
			103,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"7"
			},
			{
				"2"
			},
			{
				"2",
				"1",
				"1523203"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1524101] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1524101,
		IsBaseAttribute = false,
		DynamicArgType = {
			327,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"2",
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1524201] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		DynamicRPNExp = "K*(A1+A2*0.1+A3*0.05+A4*0.05-A5*A6)",
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1524201,
		DamageType = 4,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		TargetAtt = {
			11,
			0
		},
		TargetAttVal = {
			{
				-1
			},
			{}
		},
		DynamicArgType = {
			104,
			102,
			102,
			102,
			102,
			104,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"1",
				"1",
				"1526301"
			},
			{
				"1",
				"1",
				"1526302"
			},
			{
				"1",
				"1",
				"1526303"
			},
			{
				"1",
				"1",
				"1524210"
			},
			{
				"4"
			},
			{},
			{}
		}
	},
	[1524202] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		DynamicRPNExp = "K*(A7+A1*A5+A2*0.1+A3*0.05+A4*0.05-A6*A8)",
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1524202,
		DamageType = 4,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		TargetAtt = {
			11,
			0
		},
		TargetAttVal = {
			{
				-1
			},
			{}
		},
		DynamicArgType = {
			104,
			102,
			102,
			102,
			103,
			102,
			104,
			104
		},
		DynamicArgParams = {
			{
				"2"
			},
			{
				"1",
				"1",
				"1526301"
			},
			{
				"1",
				"1",
				"1526302"
			},
			{
				"1",
				"1",
				"1526303"
			},
			{
				"1",
				"1",
				"1523203"
			},
			{
				"1",
				"1",
				"1524210"
			},
			{
				"3"
			},
			{
				"4"
			}
		}
	},
	[1524203] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1524203,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1523203"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1524211] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1524211,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			103,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"5"
			},
			{
				"2",
				"1",
				"1524211"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1524212] = {
		DynamicRPNExp = "A1*A2*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1524212,
		IsBaseAttribute = true,
		DynamicArgType = {
			320,
			104,
			103,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"7"
			},
			{
				"6"
			},
			{
				"2",
				"1",
				"1524211"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1524220] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		DynamicRPNExp = "K*(A7+A1*A5+A2*0.1+A3*0.05+A4*0.05-A6*A8)",
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1524220,
		DamageType = 4,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		TargetAtt = {
			11,
			0
		},
		TargetAttVal = {
			{
				-1
			},
			{}
		},
		DynamicArgType = {
			104,
			102,
			102,
			102,
			103,
			102,
			104,
			104
		},
		DynamicArgParams = {
			{
				"2"
			},
			{
				"1",
				"1",
				"1526301"
			},
			{
				"1",
				"1",
				"1526302"
			},
			{
				"1",
				"1",
				"1526303"
			},
			{
				"1",
				"1",
				"1524211"
			},
			{
				"1",
				"1",
				"1524210"
			},
			{
				"3"
			},
			{
				"4"
			}
		}
	},
	[1524221] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 1524221,
		IsBaseAttribute = true,
		DynamicArgType = {
			320,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"7"
			},
			{
				"7"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1544101] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 1544101,
		IsBaseAttribute = false,
		DynamicArgType = {
			327,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"2",
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1544102] = {
		DynamicRPNExp = "A1*(1+1.5*A3+2.5*A2*A3+2.5*A4+2.5*A2*A4)",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 1544102,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			102,
			102,
			102,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"1",
				"1",
				"1544107"
			},
			{
				"1",
				"1",
				"1544108"
			},
			{
				"1",
				"1",
				"1544109"
			},
			{},
			{},
			{},
			{}
		}
	},
	[1544103] = {
		DynamicRPNExp = "A1*A2*(1+1.5*A4+2.5*A3*A4+2.5*A5+2.5*A3*A5)",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 1544103,
		IsBaseAttribute = true,
		DynamicArgType = {
			320,
			104,
			102,
			102,
			102,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"11"
			},
			{
				"2"
			},
			{
				"1",
				"1",
				"1544107"
			},
			{
				"1",
				"1",
				"1544108"
			},
			{
				"1",
				"1",
				"1544109"
			},
			{},
			{},
			{}
		}
	},
	[3000001] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 3000001,
		DamageType = 5,
		SelfAtt = {
			9,
			0
		},
		SelfAttVal = {
			{
				0.02
			},
			{}
		}
	},
	[3000002] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		MinDamage = 99,
		IsIgnoreSheild = false,
		Id = 3000002,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false
	},
	[3000003] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 3000003,
		DamageType = 5,
		TargetAtt = {
			9,
			0
		},
		TargetAttVal = {
			{
				0.15
			},
			{}
		}
	},
	[3030741] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 3030741,
		DamageType = 1,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"7"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4300301] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*A2",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4300301,
		DamageType = 3,
		DynamicArgType = {
			303,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4301801] = {
		DynamicRPNExp = "0.02+A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4301801,
		IsBaseAttribute = false,
		DynamicArgType = {
			311,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4302201] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4302201,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4400201] = {
		DynamicRPNExp = "A1*(A3-A2)/A3*10",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4400201,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			303,
			303,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"2",
				"13"
			},
			{
				"2",
				"9"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4400301] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*A2",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4400301,
		DamageType = 3,
		DynamicArgType = {
			104,
			318,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4400701] = {
		DynamicRPNExp = "A1*10",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4400701,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4400702] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*A2",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4400702,
		MaxFunctionRPN = 4400701,
		IsBaseAttribute = false,
		DynamicArgType = {
			312,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"3",
				"1101"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4401001] = {
		DynamicRPNExp = "(A1/A2)*0.02",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4401001,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"14"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4401602] = {
		DynamicRPNExp = "A1*A2*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4401602,
		IsBaseAttribute = false,
		DynamicArgType = {
			310,
			104,
			320,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"3",
				"1",
				"4401601"
			},
			{
				"1"
			},
			{
				"2",
				"7"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4401700] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*K",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4401700,
		DamageType = 3,
		SelfAtt = {
			11,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		DynamicArgType = {
			104,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4401901] = {
		DynamicRPNExp = "A1-A2*(5-A3)",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4401901,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			104,
			311,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"2"
			},
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4402001] = {
		DynamicRPNExp = "A1-A2*(A3-1)",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4402001,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			104,
			311,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"2"
			},
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4402501] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4402501,
		IsBaseAttribute = false,
		DynamicArgType = {
			318,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4402601] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.01",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4402601,
		MaxFunctionRPN = 4402602,
		IsBaseAttribute = false,
		DynamicArgType = {
			312,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1106"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4402602] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4402602,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4402801] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4402801,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				0.08
			},
			{}
		}
	},
	[4403101] = {
		DynamicRPNExp = "A1*A2*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4403101,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			104,
			103,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"7"
			},
			{
				"1"
			},
			{
				"2",
				"1",
				"4403101"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4403201] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A2/A1/10*0.01*K",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4403201,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		DynamicArgType = {
			303,
			303,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{
				"2",
				"13"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4403301] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = true,
		DynamicRPNExp = "A1*(A2/A3*10)*K",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4403301,
		SelfAtt = {
			11,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		DynamicArgType = {
			104,
			303,
			303,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"2",
				"13"
			},
			{
				"2",
				"9"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4403701] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = true,
		DynamicRPNExp = "A1*((A3-A2)/A3*10)*K",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4403701,
		SelfAtt = {
			11,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		DynamicArgType = {
			104,
			303,
			303,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"2",
				"13"
			},
			{
				"2",
				"9"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4404201] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.01",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4404201,
		MaxFunctionRPN = 4404202,
		IsBaseAttribute = false,
		DynamicArgType = {
			312,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1102"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4404202] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4404202,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4404801] = {
		DynamicRPNExp = "A1*A2+A3*A4",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4404801,
		IsBaseAttribute = false,
		DynamicArgType = {
			311,
			104,
			102,
			104,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2"
			},
			{
				"1"
			},
			{
				"2",
				"1",
				"4404802"
			},
			{
				"2"
			},
			{},
			{},
			{},
			{}
		}
	},
	[4405401] = {
		DynamicRPNExp = "A1*(1+A2)",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4405401,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			102,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"2",
				"1",
				"1601"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4405701] = {
		DynamicRPNExp = "2-A1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4405701,
		IsBaseAttribute = false,
		DynamicArgType = {
			102,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"3",
				"1",
				"1903"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4405702] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4405702,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"4405703"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4405801] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4405801,
		MaxFunctionRPN = 4405802,
		IsBaseAttribute = false,
		DynamicArgType = {
			311,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4405802] = {
		DynamicRPNExp = "A2-A1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4405802,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"4405802"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4405803] = {
		DynamicRPNExp = "A1*0.01",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4405803,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"4405802"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4406501] = {
		DynamicRPNExp = "A1*A2*(1+A3+A4)",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4406501,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			303,
			303,
			303,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"1",
				"7"
			},
			{
				"1",
				"34"
			},
			{
				"2",
				"35"
			},
			{},
			{},
			{},
			{}
		}
	},
	[4406701] = {
		DynamicRPNExp = "A1-A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4406701,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			303,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"4406701"
			},
			{
				"2",
				"14"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4406702] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4406702,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"4406706"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4406703] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4406703,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"4406707"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4407300] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "(A1-A1%8)/8",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4407300,
		MaxFunctionRPN = 4407301,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"14"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4407301] = {
		DynamicRPNExp = "A1-A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4407301,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			103,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"2",
				"1",
				"4407301"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4407302] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4407302,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"4407301"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4407303] = {
		DynamicRPNExp = "A1*0.01",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 4407303,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"4407305"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4407401] = {
		DynamicRPNExp = "A1*0.02",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4407401,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"4407404"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4407800] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.01",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4407800,
		MaxFunctionRPN = 4407801,
		IsBaseAttribute = false,
		DynamicArgType = {
			312,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1109"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4407801] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4407801,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4407900] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4407900,
		MaxFunctionRPN = 4407901,
		IsBaseAttribute = false,
		DynamicArgType = {
			311,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4407901] = {
		DynamicRPNExp = "A1-A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4407901,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			103,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"2",
				"1",
				"4407901"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4408000] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4408000,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			103,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"2",
				"1",
				"4408001"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4408200] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4408200,
		MaxFunctionRPN = 4408201,
		IsBaseAttribute = true,
		DynamicArgType = {
			311,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4408201] = {
		DynamicRPNExp = "A1-A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4408201,
		IsBaseAttribute = true,
		DynamicArgType = {
			104,
			103,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"2",
				"1",
				"4408201"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4408202] = {
		DynamicRPNExp = "A1*0.012",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4408202,
		IsBaseAttribute = true,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"4408201"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4408300] = {
		DynamicRPNExp = "A1*0.01",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4408300,
		IsBaseAttribute = true,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"4408304"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4408600] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*A2/0.1*(1+A3)",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4408600,
		MaxFunctionRPN = 4408601,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			303,
			102,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"2",
				"24"
			},
			{
				"2",
				"1",
				"4408601"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4408601] = {
		DynamicRPNExp = "A1*10",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4408601,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4409000] = {
		DynamicRPNExp = "A1*0.01",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4409000,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"4409003"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4409600] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 4409600,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"4409602"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4409800] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4409800,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"4409802"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4409900] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4409900,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1106"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4409901] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1-A2",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4409901,
		MaxFunctionRPN = 4409902,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			103,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1106"
			},
			{
				"2",
				"1",
				"4409904"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4409902] = {
		DynamicRPNExp = "A1-A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4409902,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			103,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"1",
				"1",
				"4409906"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4409903] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4409903,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"4409906"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4410000] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4410000,
		MaxFunctionRPN = 4410001,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"4410000"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4410001] = {
		DynamicRPNExp = "A1-A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4410001,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			103,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"2",
				"1",
				"4410002"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4410002] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4410002,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"4410000"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4410003] = {
		DynamicRPNExp = "A1*0.01",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4410003,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"4410002"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4410201] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4410201,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"4410201"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4410301] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4410301,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			103,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"2",
				"1",
				"4410301"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4410701] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4410701,
		IsBaseAttribute = true,
		DynamicArgType = {
			320,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4410702] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 4410702,
		IsBaseAttribute = true,
		DynamicArgType = {
			320,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4411301] = {
		DynamicRPNExp = "0.02*A1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4411301,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"4411303"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4411401] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4411401,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"4411403"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4411402] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*A2",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 4411402,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			103,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"2",
				"1",
				"4411401"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4411801] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 4411801,
		MaxFunctionRPN = 10101,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1102"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4411802] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "0.01*A1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 4411802,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"4411803"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4411901] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "0.01*A1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 4411901,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"4411902"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4460101] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.08",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 4460101,
		IsBaseAttribute = false,
		DynamicArgType = {
			310,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"5",
				"18"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4460301] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 4460301,
		IsBaseAttribute = false,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[4460501] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 4460501,
		IsBaseAttribute = false,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				0.2
			},
			{}
		}
	},
	[4460601] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.5",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 4460601,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"11"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4460901] = {
		DynamicRPNExp = "A1*0.03",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4460901,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"1102"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4461001] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4461001,
		MaxFunctionRPN = 4461002,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1106"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4461002] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		BasicDamage = 0.2,
		IsIgnoreSheild = false,
		Id = 4461002,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true
	},
	[4461401] = {
		DynamicRPNExp = "A1*0.2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4461401,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"7"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4461501] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "(A2-A1)/A2*0.1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4461501,
		MaxFunctionRPN = 4461502,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			303,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"13"
			},
			{
				"1",
				"9"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[4461502] = {
		DynamicRPNExp = "A1*0.5",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 4461502,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"7"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[5010301] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 5010301,
		DamageType = 5,
		DynamicArgType = {
			318,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		}
	},
	[5401111] = {
		DynamicRPNExp = "A1*0.15",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 5401111,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[5403111] = {
		DynamicRPNExp = "(A2/A1)/0.1*0.03",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 5403111,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			303,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{
				"2",
				"13"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[6010801] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*A2",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = true,
		Id = 6010801,
		DamageType = 4,
		DynamicArgType = {
			303,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"13"
			},
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[6301101] = {
		DynamicRPNExp = "A1/4*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 6301101,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"14"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[6601101] = {
		DynamicRPNExp = "A1*A2*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 6601101,
		IsBaseAttribute = false,
		DynamicArgType = {
			320,
			311,
			104,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"7"
			},
			{
				"1"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[6602101] = {
		DynamicRPNExp = "A1*A2*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 6602101,
		IsBaseAttribute = false,
		DynamicArgType = {
			320,
			311,
			104,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"11"
			},
			{
				"1"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[6603101] = {
		DynamicRPNExp = "A1*A2*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 6603101,
		IsBaseAttribute = false,
		DynamicArgType = {
			320,
			311,
			104,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{
				"1"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[6707101] = {
		DynamicRPNExp = "(A2-A1)/A2/0.05*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 6707101,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			303,
			104,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"13"
			},
			{
				"2",
				"9"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[6709101] = {
		DynamicRPNExp = "(A2-A1)/A2/0.05*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 6709101,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			303,
			104,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"13"
			},
			{
				"1",
				"9"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[7402101] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 7402101,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[7405101] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 7405101,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			303,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"2",
				"7"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[7501101] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "K*0.02",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 7501101,
		MaxFunctionRPN = 7501102,
		IsBaseAttribute = false,
		TargetAtt = {
			9,
			0
		},
		TargetAttVal = {
			{
				1
			},
			{}
		}
	},
	[7501102] = {
		DynamicRPNExp = "A1*0.15",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 7501102,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"7"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[8010301] = {
		DynamicRPNExp = "30-A1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 8010301,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1106"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[8010302] = {
		DynamicRPNExp = "15-A1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 8010302,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1106"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[8010303] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*0.3",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 8010303,
		DamageType = 2,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"8010307"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10102401] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.02",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 10102401,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"1106"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10103401] = {
		DynamicRPNExp = "(A1-A2)/A1*0.01",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10103401,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			303,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"9"
			},
			{
				"1",
				"13"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10104401] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.03",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 10104401,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10104304"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10107301] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 10107301,
		IsBaseAttribute = false,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				0.05
			},
			{}
		}
	},
	[10107401] = {
		DynamicRPNExp = "A1*0.03",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10107401,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"1106"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10107402] = {
		DynamicRPNExp = "A1*0.1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10107402,
		IsBaseAttribute = false,
		DynamicArgType = {
			310,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10107405"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10204401] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.03",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 10204401,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10204302"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10206201] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "K*0.15",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 10206201,
		IsBaseAttribute = false,
		SelfAtt = {
			9,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[10209301] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.03",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 10209301,
		IsBaseAttribute = false,
		DynamicArgType = {
			310,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10209303"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10210301] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 10210301,
		DamageType = 3,
		SelfAtt = {
			9,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[10210801] = {
		DynamicRPNExp = "(A1-A2)/A1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10210801,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			303,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"9"
			},
			{
				"1",
				"13"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10211401] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "K*0.35",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 10211401,
		IsBaseAttribute = false,
		SelfAtt = {
			9,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[10211402] = {
		DynamicRPNExp = "(A1-1)*0.2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10211402,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10211403"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10211801] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.05",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 10211801,
		IsBaseAttribute = false,
		DynamicArgType = {
			310,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"10211801"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10211901] = {
		DynamicRPNExp = "(A1-1)*0.2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10211901,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10211903"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10212301] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 10212301,
		IsBaseAttribute = false,
		DynamicArgType = {
			310,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"3",
				"1",
				"10212301"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10212302] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "K*0.05",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 10212302,
		IsBaseAttribute = false,
		DynamicArgType = {
			310,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"3",
				"1",
				"10212301"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10212803] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "K*0.03",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 10212803,
		IsBaseAttribute = false,
		DynamicArgType = {
			310,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"10212801"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10213401] = {
		DynamicRPNExp = "A2/A1*0.4",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 10213401,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			303,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{
				"2",
				"13"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10213901] = {
		DynamicRPNExp = "A2/A1*0.8",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 10213901,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			303,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{
				"2",
				"13"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10214301] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.05",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 10214301,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10214302] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*0.05",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 10214302,
		DamageType = 3,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"9"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10214401] = {
		DynamicRPNExp = "(A2/A1)*0.3*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10214401,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			303,
			303,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"9"
			},
			{
				"1",
				"13"
			},
			{
				"2",
				"7"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10214801] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.05",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 10214801,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10214802] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*0.05",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 10214802,
		DamageType = 3,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"9"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10214901] = {
		DynamicRPNExp = "(A2/A1)*0.5*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10214901,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			303,
			303,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"9"
			},
			{
				"1",
				"13"
			},
			{
				"2",
				"7"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10215301] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 10215301,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"11"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10215302] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 10215302,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"12"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10215303] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 10215303,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"7"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10215304] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*0.1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 10215304,
		DamageType = 3,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"9"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10215401] = {
		DynamicRPNExp = "A2/A1*0.8",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 10215401,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			303,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{
				"2",
				"13"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10216301] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 10216301,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10216302] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*0.1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 10216302,
		DamageType = 3,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"9"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10216401] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "(A2/A1)*0.02",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 10216401,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			303,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"9"
			},
			{
				"1",
				"13"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10217301] = {
		DynamicRPNExp = "A1*0.05",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10217301,
		IsBaseAttribute = false,
		DynamicArgType = {
			313,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"4",
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10217401] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 10217401,
		IsBaseAttribute = false,
		DynamicArgType = {
			313,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"4",
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10217402] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 10217402,
		IsBaseAttribute = false,
		SelfAtt = {
			9,
			0
		},
		SelfAttVal = {
			{
				0.1
			},
			{}
		}
	},
	[10218401] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = true,
		MinDamage = 99,
		Id = 10218401,
		DamageType = 2,
		SelfAtt = {
			13,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		TargetAtt = {
			11,
			0
		},
		TargetAttVal = {
			{
				-1
			},
			{}
		}
	},
	[10219401] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A2*(0.8-A1*0.2)",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10219401,
		DamageType = 3,
		DynamicArgType = {
			103,
			303,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10218309"
			},
			{
				"2",
				"9"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10301201] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "K*0.1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 10301201,
		IsBaseAttribute = false,
		SelfAtt = {
			9,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[10301801] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "k*0.1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 10301801,
		IsBaseAttribute = false,
		SelfAtt = {
			11,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[10302801] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "K/A1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 10302801,
		IsBaseAttribute = false,
		SelfAtt = {
			9,
			13
		},
		SelfAttVal = {
			{
				1
			},
			{
				-1
			}
		},
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10303401] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.15",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 10303401,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"13"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10304401] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 10304401,
		IsBaseAttribute = false,
		DynamicArgType = {
			310,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10304402"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10304901] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 10304901,
		IsBaseAttribute = false,
		DynamicArgType = {
			310,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10304402"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10306201] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "K*0.05",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 10306201,
		IsBaseAttribute = false,
		SelfAtt = {
			9,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[10306701] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 10306701,
		IsBaseAttribute = false,
		SelfAtt = {
			9,
			0
		},
		SelfAttVal = {
			{
				0.05
			},
			{}
		}
	},
	[10307301] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "K*0.05",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 10307301,
		IsBaseAttribute = false,
		TargetAtt = {
			9,
			13
		},
		TargetAttVal = {
			{
				1
			},
			{
				-1
			}
		}
	},
	[10307401] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.03",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 10307401,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1106"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10308201] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 10308201,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"9"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10308211] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.05",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 10308211,
		IsBaseAttribute = false,
		DynamicArgType = {
			310,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10308212"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10308301] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 10308301,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10308302"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10308401] = {
		DynamicRPNExp = "A1*0.1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10308401,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"1102"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10309401] = {
		DynamicRPNExp = "A1*0.03",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10309401,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10309302"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10309402] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 10309402,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"13"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10310301] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "K*0.05",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10310301,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[10403401] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10403401,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10403403"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10405401] = {
		DynamicRPNExp = "(A1-1)*0.2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10405401,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10405402"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10405701] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "(A1-A2)*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 10405701,
		DamageType = 1,
		DynamicArgType = {
			303,
			303,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"7"
			},
			{
				"2",
				"11"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10405901] = {
		DynamicRPNExp = "(A1-1)*0.2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10405901,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10405902"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10406401] = {
		DynamicRPNExp = "A1*A3*((5-A2)*0.2+0.2)",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10406401,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			311,
			303,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"1"
			},
			{
				"2",
				"9"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10407301] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "K*(0.8-A1*0.2)",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10407301,
		DamageType = 6,
		SelfAtt = {
			9,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10407308"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10410301] = {
		DynamicRPNExp = "0.35+(A1-1-(A1-1)%5)/5*0.1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10410301,
		IsBaseAttribute = false,
		DynamicArgType = {
			309,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10411401] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		DynamicRPNExp = "K*0.5*A1",
		IsIgnoreSheild = true,
		MinDamage = 99,
		Id = 10411401,
		DamageType = 4,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		TargetAtt = {
			11,
			0
		},
		TargetAttVal = {
			{
				-1
			},
			{}
		},
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10411401"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10412301] = {
		DynamicRPNExp = "A1*0.05",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10412301,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10412303"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10412302] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10412302,
		IsBaseAttribute = false,
		DynamicArgType = {
			313,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"4",
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10413325] = {
		DynamicRPNExp = "A1*1+1000",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 10413325,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10413401] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10413401,
		IsBaseAttribute = false,
		DynamicArgType = {
			317,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10414101] = {
		DynamicRPNExp = "A1*A2*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10414101,
		IsBaseAttribute = true,
		DynamicArgType = {
			103,
			104,
			303,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10414101"
			},
			{
				"1"
			},
			{
				"2",
				"7"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10415301] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "K*A1*A2*(A3+1)",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10415301,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		DynamicArgType = {
			103,
			104,
			102,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10415302"
			},
			{
				"1"
			},
			{
				"2",
				"1",
				"10415304"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10417401] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*A2*0.05",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10417401,
		DamageType = 3,
		DynamicArgType = {
			103,
			303,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10417302"
			},
			{
				"2",
				"9"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10418301] = {
		DynamicRPNExp = "A1/10*A2*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10418301,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			303,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10418301"
			},
			{
				"1"
			},
			{
				"2",
				"7"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10501401] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		DynamicRPNExp = "K*A1*A2",
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 10501401,
		DamageType = 1,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		TargetAtt = {
			11,
			0
		},
		TargetAttVal = {
			{
				-1
			},
			{}
		},
		DynamicArgType = {
			103,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"3",
				"1",
				"10501401"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10504301] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10504301,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10504301"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10510301] = {
		DynamicRPNExp = "2+A1*3-A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10510301,
		IsBaseAttribute = false,
		DynamicArgType = {
			102,
			103,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"10510305"
			},
			{
				"2",
				"1",
				"10510304"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10512301] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A2-A1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10512301,
		DamageType = 6,
		DynamicArgType = {
			303,
			103,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"13"
			},
			{
				"2",
				"1",
				"10512308"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10512401] = {
		DynamicRPNExp = "(A2-A1)/A2*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10512401,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			303,
			104,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"13"
			},
			{
				"2",
				"9"
			},
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10601301] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10601301,
		MaxFunctionRPN = 10601303,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"5",
				"26"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10601302] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10601302,
		MaxFunctionRPN = 10601303,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"5",
				"26"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10601303] = {
		DynamicRPNExp = "A1*0.1*5",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10601303,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"5",
				"26"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10602301] = {
		DynamicRPNExp = "A1*A2*(1+A3)",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 10602301,
		IsBaseAttribute = false,
		DynamicArgType = {
			320,
			104,
			102,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"11"
			},
			{
				"1"
			},
			{
				"3",
				"1",
				"10602302"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10602302] = {
		DynamicRPNExp = "A1*(1+A2)",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10602302,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			102,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2"
			},
			{
				"3",
				"1",
				"10602302"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10602303] = {
		DynamicRPNExp = "A1*(1+A2)",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10602303,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			102,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"3"
			},
			{
				"2",
				"1",
				"10602311"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10602304] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10602304,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10602306"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10602401] = {
		DynamicRPNExp = "A1*(1+A2)",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10602401,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			102,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"3",
				"1",
				"10602302"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10603301] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "K*A1*A2",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = true,
		Id = 10603301,
		DamageType = 4,
		TargetAtt = {
			9,
			11
		},
		TargetAttVal = {
			{
				1
			},
			{
				-1
			}
		},
		DynamicArgType = {
			103,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10603305"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10604401] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "(((A1-A2)/A1)%0.1)*0.05",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10604401,
		MaxFunctionRPN = 10604402,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			303,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"9"
			},
			{
				"1",
				"13"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10604402] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10604402,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10605301] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = true,
		Id = 10605301,
		DamageType = 2,
		SelfAtt = {
			9,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[10607301] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsIgnoreSheild = false,
		IsBaseAttribute = false,
		Id = 10607301,
		DynamicRPNExp = "3",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false
	},
	[10607401] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		DynamicRPNExp = "K*(A1*(A2+A3*A4))",
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 10607401,
		DamageType = 1,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		TargetAtt = {
			11,
			0
		},
		TargetAttVal = {
			{
				-1
			},
			{}
		},
		DynamicArgType = {
			104,
			104,
			104,
			102,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"2"
			},
			{
				"4"
			},
			{
				"2",
				"1",
				"10607312"
			},
			{},
			{},
			{},
			{}
		}
	},
	[10607402] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		DynamicRPNExp = "K*(A1*(A2+A3*A4)*(A2+A3*A4))",
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 10607402,
		DamageType = 1,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		TargetAtt = {
			11,
			0
		},
		TargetAttVal = {
			{
				-1
			},
			{}
		},
		DynamicArgType = {
			104,
			104,
			104,
			102,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"2"
			},
			{
				"4"
			},
			{
				"2",
				"1",
				"10607312"
			},
			{},
			{},
			{},
			{}
		}
	},
	[10607403] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		DynamicRPNExp = "K*(A1*(A2+A3*A4)*(A2+A3*A4)*(A2+A3*A4))",
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 10607403,
		DamageType = 1,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		TargetAtt = {
			11,
			0
		},
		TargetAttVal = {
			{
				-1
			},
			{}
		},
		DynamicArgType = {
			104,
			104,
			104,
			102,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"2"
			},
			{
				"4"
			},
			{
				"2",
				"1",
				"10607312"
			},
			{},
			{},
			{},
			{}
		}
	},
	[10607404] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		DynamicRPNExp = "K*(A1*(A2+A3*A4)*(A2+A3*A4)*(A2+A3*A4)*(A2+A3*A4))",
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 10607404,
		DamageType = 1,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		TargetAtt = {
			11,
			0
		},
		TargetAttVal = {
			{
				-1
			},
			{}
		},
		DynamicArgType = {
			104,
			104,
			104,
			102,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"2"
			},
			{
				"4"
			},
			{
				"2",
				"1",
				"10607312"
			},
			{},
			{},
			{},
			{}
		}
	},
	[10609301] = {
		DynamicRPNExp = "1-(A2^A1)",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10609301,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10609328"
			},
			{
				"4"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10609302] = {
		DynamicRPNExp = "A1*A2*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 10609302,
		IsBaseAttribute = true,
		DynamicArgType = {
			303,
			104,
			103,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"7"
			},
			{
				"5"
			},
			{
				"2",
				"1",
				"10609333"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10609303] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 10609303,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			103,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"6"
			},
			{
				"2",
				"1",
				"10609333"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10609401] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10609401,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			103,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"1",
				"1",
				"10609333"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10609402] = {
		DynamicRPNExp = "A1*A2*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 10609402,
		IsBaseAttribute = true,
		DynamicArgType = {
			303,
			104,
			103,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"11"
			},
			{
				"2"
			},
			{
				"2",
				"1",
				"10609333"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10610301] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*0.02",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = true,
		Id = 10610301,
		DamageType = 2,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10610302] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*0.04",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = true,
		Id = 10610302,
		DamageType = 2,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10610303] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = true,
		Id = 10610303,
		DamageType = 2,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10610401] = {
		DynamicRPNExp = "A1*0.03",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10610401,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"10610309"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10611401] = {
		DynamicRPNExp = "A1*0.03",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10611401,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"10610308"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10612301] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10612301,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10612301"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10612302] = {
		DynamicRPNExp = "A1*5",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10612302,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10612301"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10612401] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*A2",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 10612401,
		MaxFunctionRPN = 10612402,
		IsBaseAttribute = true,
		DynamicArgType = {
			303,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"11"
			},
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10612402] = {
		DynamicRPNExp = "A1*0.5",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10612402,
		IsBaseAttribute = true,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"7"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10613101] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10613101,
		IsBaseAttribute = false,
		DynamicArgType = {
			311,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10701401] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = true,
		MinDamage = 99,
		Id = 10701401,
		DamageType = 1,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		TargetAtt = {
			11,
			0
		},
		TargetAttVal = {
			{
				-1
			},
			{}
		}
	},
	[10702301] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10702301,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10702302"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10702302] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10702302,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10702303"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10702401] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10702401,
		IsBaseAttribute = false,
		DynamicArgType = {
			313,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"5",
				"25"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10703301] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "(A1-A2)*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 10703301,
		DamageType = 1,
		DynamicArgType = {
			303,
			303,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"7"
			},
			{
				"2",
				"11"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10704401] = {
		DynamicRPNExp = "(A2/A1-(A2/A1)%0.1)/0.1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10704401,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			303,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{
				"2",
				"13"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10705701] = {
		DynamicRPNExp = "A1*0.02",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 10705701,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10706301] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "K*0.1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10706301,
		SelfAtt = {
			9,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[10706401] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "K*0.25",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10706401,
		SelfAtt = {
			9,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[10707301] = {
		DynamicRPNExp = "A1*0.1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 10707301,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10707302"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10707302] = {
		DynamicRPNExp = "A1*0.3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10707302,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10707303"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10707401] = {
		DynamicRPNExp = "(1.3)^A1-1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10707401,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10707303"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10708301] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10708301,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"13"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10708302] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10708302,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10708309"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10708303] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10708303,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10708307"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10708304] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10708304,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10708303"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10708305] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10708305,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10708303"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10708306] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10708306,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10708401] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10708401,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10708402"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10709301] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10709301,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10709305"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10709302] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10709302,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10709307"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10709401] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10709401,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10709403"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10710401] = {
		DynamicRPNExp = "A1/A2*100",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10710401,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			303,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"13"
			},
			{
				"2",
				"9"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10711401] = {
		DynamicRPNExp = "A1*0.03",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 10711401,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10711403"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[12995102] = {
		DynamicRPNExp = "A1*A2*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 12995102,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			103,
			104,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"7"
			},
			{
				"1",
				"1",
				"1295104"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[20101301] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.5",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 20101301,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"13"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[20201201] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.5",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 20201201,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"9"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[20401401] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.05",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 20401401,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1109"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[20501301] = {
		DynamicRPNExp = "1+(A1-A1%5)/5",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 20501301,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"20501302"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[20502401] = {
		DynamicRPNExp = "A1*A2*A3*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 20502401,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			303,
			104,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"20501302"
			},
			{
				"2",
				"7"
			},
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[20503403] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "K*(A1*0.01+A2*0.01)",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 20503403,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		DynamicArgType = {
			103,
			103,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"20501302"
			},
			{
				"2",
				"1",
				"20502303"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[20504401] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 20504401,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"5",
				"26"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[20505401] = {
		DynamicRPNExp = "A1*0.03",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 20505401,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"20501302"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[20507301] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "K*A1*A2",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 20507301,
		DamageType = 3,
		SelfAtt = {
			9,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		DynamicArgType = {
			103,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"20507302"
			},
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[20507302] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "K*A1*0.03",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 20507302,
		DamageType = 3,
		SelfAtt = {
			9,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"20507318"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[20507401] = {
		DynamicRPNExp = "A1*0.05",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 20507401,
		IsBaseAttribute = false,
		DynamicArgType = {
			102,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"3",
				"2050731"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[20601301] = {
		DynamicRPNExp = "A1/A2*0.2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 20601301,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			303,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"13"
			},
			{
				"1",
				"9"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[20601401] = {
		DynamicRPNExp = "A1*0.35",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 20601401,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"13"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[20602401] = {
		DynamicRPNExp = "A1*0.05",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 20602401,
		IsBaseAttribute = false,
		DynamicArgType = {
			312,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"5",
				"26"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[20603301] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "(A2-A1)/A2*0.8",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 20603301,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			303,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"13"
			},
			{
				"1",
				"9"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[20604401] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "K*0.25",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 20604401,
		SelfAtt = {
			9,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[20605401] = {
		DynamicRPNExp = "(A1-A2)/A1/2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 20605401,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			303,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{
				"2",
				"13"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[20605402] = {
		DynamicRPNExp = "(A1-A2)/A1/3+1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 20605402,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			303,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"9"
			},
			{
				"1",
				"13"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[20607301] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 20607301,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"20607304"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[20607302] = {
		DynamicRPNExp = "A1*0.05",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 20607302,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"7"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[20607401] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*A2*A3",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 20607401,
		MaxFunctionRPN = 20607402,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			104,
			103,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"11"
			},
			{
				"1"
			},
			{
				"1",
				"5",
				"26"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[20607402] = {
		DynamicRPNExp = "A1*0.2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 20607402,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"11"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[20607403] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 20607403,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"7"
			},
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[20608301] = {
		IsIgnoreShare = true,
		IsIgnoreInverted = true,
		IsBaseAttribute = false,
		DynamicRPNExp = "1",
		IsIgnoreAbsorb = true,
		IsDamagePlus = false,
		IsIgnoreSheild = true,
		Id = 20608301,
		DamageType = 2
	},
	[20608302] = {
		IsIgnoreShare = true,
		IsIgnoreInverted = true,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*1",
		IsIgnoreAbsorb = true,
		IsDamagePlus = true,
		IsIgnoreSheild = true,
		Id = 20608302,
		DamageType = 3,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[20616401] = {
		DynamicRPNExp = "A1*0.05",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 20616401,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"3",
				"1101"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[20618141] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "(A1-A2)*A3",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 20618141,
		DamageType = 4,
		DynamicArgType = {
			303,
			303,
			104,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"7"
			},
			{
				"2",
				"11"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[20618301] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1+A2*A3",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 20618301,
		MaxFunctionRPN = 20618302,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			103,
			104,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"1",
				"1",
				"20618301"
			},
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[20618302] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsIgnoreSheild = false,
		IsBaseAttribute = false,
		Id = 20618302,
		DynamicRPNExp = "0.6",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true
	},
	[20618331] = {
		DynamicRPNExp = "A1+A2*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 20618331,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			103,
			104,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"2",
				"1",
				"20618301"
			},
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[20618411] = {
		DynamicRPNExp = "(1+A1)*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 20618411,
		IsBaseAttribute = false,
		DynamicArgType = {
			102,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"20608308"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[20618431] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 20618431,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"20618434"
			},
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30101301] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 30101301,
		SelfAtt = {
			9,
			0
		},
		SelfAttVal = {
			{
				0.001
			},
			{}
		}
	},
	[30101401] = {
		DynamicRPNExp = "(1-A1/A2)*0.2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 30101401,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			303,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"13"
			},
			{
				"2",
				"9"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30101708] = {
		DynamicRPNExp = "A1*2-A1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 30101708,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"30101702"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30102401] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "(K-A1)*A2*0.4",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = true,
		MinDamage = 98,
		Id = 30102401,
		DamageType = 4,
		SelfAtt = {
			7,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		DynamicArgType = {
			303,
			103,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"11"
			},
			{
				"2",
				"1",
				"30102401"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30104401] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "(1-A2/A1)*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 30104401,
		MaxFunctionRPN = 30104402,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			303,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"9"
			},
			{
				"1",
				"13"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30104402] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsIgnoreSheild = false,
		IsBaseAttribute = false,
		Id = 30104402,
		DynamicRPNExp = "0.7",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true
	},
	[30105801] = {
		DynamicRPNExp = "(1-0.85)+(1-0.85)*A1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 30105801,
		IsBaseAttribute = false,
		DynamicArgType = {
			102,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10022"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30105802] = {
		DynamicRPNExp = "(1-0.85*0.85)+(1-0.85*0.85)*A1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 30105802,
		IsBaseAttribute = false,
		DynamicArgType = {
			102,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10022"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30105803] = {
		DynamicRPNExp = "(1-0.85*0.85*0.85)+(1-0.85*0.85*0.85)*A1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 30105803,
		IsBaseAttribute = false,
		DynamicArgType = {
			102,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10022"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30105804] = {
		DynamicRPNExp = "(1-0.85*0.85*0.85*0.85)+(1-0.85*0.85*0.85*0.85)*A1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 30105804,
		IsBaseAttribute = false,
		DynamicArgType = {
			102,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10022"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30105805] = {
		DynamicRPNExp = "(1-0.85*0.85*0.85*0.85*0.85)+(1-0.85*0.85*0.85*0.85*0.85)*A1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 30105805,
		IsBaseAttribute = false,
		DynamicArgType = {
			102,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10022"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30105806] = {
		DynamicRPNExp = "(1-0.85*0.85*0.85*0.85*0.85*0.85)+(1-0.85*0.85*0.85*0.85*0.85*0.85)*A1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 30105806,
		IsBaseAttribute = false,
		DynamicArgType = {
			102,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10022"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30105807] = {
		DynamicRPNExp = "(1-0.85*0.85*0.85*0.85*0.85*0.85*0.85)+(1-0.85*0.85*0.85*0.85*0.85*0.85*0.85)*A1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 30105807,
		IsBaseAttribute = false,
		DynamicArgType = {
			102,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10022"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30105808] = {
		DynamicRPNExp = "(1-0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85)+(1-0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85)*A1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 30105808,
		IsBaseAttribute = false,
		DynamicArgType = {
			102,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10022"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30105809] = {
		DynamicRPNExp = "(1-0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85)+(1-0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85)*A1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 30105809,
		IsBaseAttribute = false,
		DynamicArgType = {
			102,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10022"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30105810] = {
		DynamicRPNExp = "(1-0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85)+(1-0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85)*A1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 30105810,
		IsBaseAttribute = false,
		DynamicArgType = {
			102,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10022"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30105811] = {
		DynamicRPNExp = "(1-0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85)+(1-0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85)*A1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 30105811,
		IsBaseAttribute = false,
		DynamicArgType = {
			102,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10022"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30105812] = {
		DynamicRPNExp = "(1-0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85)+(1-0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85)*A1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 30105812,
		IsBaseAttribute = false,
		DynamicArgType = {
			102,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10022"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30105813] = {
		DynamicRPNExp = "(1-0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85)+(1-0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85)*A1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 30105813,
		IsBaseAttribute = false,
		DynamicArgType = {
			102,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10022"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30105814] = {
		DynamicRPNExp = "(1-0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85)+(1-0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85)*A1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 30105814,
		IsBaseAttribute = false,
		DynamicArgType = {
			102,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10022"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30105815] = {
		DynamicRPNExp = "(1-0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85)+(1-0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85)*A1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 30105815,
		IsBaseAttribute = false,
		DynamicArgType = {
			102,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10022"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30105816] = {
		DynamicRPNExp = "(1-0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85)+(1-0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85*0.85)*A1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 30105816,
		IsBaseAttribute = false,
		DynamicArgType = {
			102,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10022"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30106201] = {
		DynamicRPNExp = "A1*0.15",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 30106201,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30106301] = {
		DynamicRPNExp = "A1*0.2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 30106301,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"30106402"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30106401] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 30106401,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30107301] = {
		DynamicRPNExp = "A1*A2*0.05",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 30107301,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			103,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"7"
			},
			{
				"2",
				"1",
				"30107304"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30107302] = {
		DynamicRPNExp = "A1*A2*0.03",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 30107302,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			103,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"11"
			},
			{
				"1",
				"1",
				"30107304"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30107401] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 30107401,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"30107304"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30108401] = {
		DynamicRPNExp = "A1*0.03",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 30108401,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1106"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30108801] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "K*0.03",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 30108801,
		SelfAtt = {
			9,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[30108802] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "(A1-A2-A3)*0.05",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 30108802,
		DamageType = 1,
		DynamicArgType = {
			303,
			303,
			303,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"13"
			},
			{
				"2",
				"9"
			},
			{
				"2",
				"11"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30108803] = {
		DynamicRPNExp = "A1*0.15",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 30108803,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"7"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30108804] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*0.03/(1-0.03*(A2-1))",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = true,
		Id = 30108804,
		DamageType = 2,
		DynamicArgType = {
			303,
			103,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"13"
			},
			{
				"2",
				"1",
				"30108816"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30201901] = {
		DynamicRPNExp = "A1*A2*0.2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 30201901,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			303,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"5",
				"26"
			},
			{
				"2",
				"7"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30202801] = {
		DynamicRPNExp = "A1*0.05",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 30202801,
		IsBaseAttribute = false,
		DynamicArgType = {
			313,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"5",
				"25"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30203803] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "(A1-A2)*A3*0.02",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 30203803,
		DamageType = 1,
		DynamicArgType = {
			303,
			303,
			103,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"7"
			},
			{
				"2",
				"11"
			},
			{
				"2",
				"1",
				"30203804"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30203901] = {
		DynamicRPNExp = "A1*0.1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 30203901,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"30203804"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30206901] = {
		DynamicRPNExp = "0.5+A1*0.5",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 30206901,
		IsBaseAttribute = false,
		DynamicArgType = {
			102,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10022"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30304401] = {
		DynamicRPNExp = "(1+A2-A3)/(2+A2-A3)*100",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 30304401,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			104,
			103,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"2"
			},
			{
				"2",
				"1",
				"30304401"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30305301] = {
		DynamicRPNExp = "A1*A2/40",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 30305301,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			320,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2"
			},
			{
				"2",
				"7"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30305401] = {
		DynamicRPNExp = "(0.25+A1*0.25)*100",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 30305401,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"30305410"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30402401] = {
		DynamicRPNExp = "A1*0.05",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 30402401,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"30402307"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30403401] = {
		DynamicRPNExp = "A1*0.15",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 30403401,
		IsBaseAttribute = true,
		DynamicArgType = {
			311,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30404301] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*0.1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 30404301,
		IsBaseAttribute = false,
		SelfAttVal = {
			{
				1
			},
			{}
		},
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30406301] = {
		DynamicRPNExp = "(A1-A2)*1",
		IsIgnoreInverted = true,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 30406301,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			303,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{
				"2",
				"13"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30406302] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = true,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = true,
		Id = 30406302,
		DamageType = 2,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"30407316"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30406303] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = true,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 30406303,
		DamageType = 6,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"30407328"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30407301] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 30407301,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"30407302"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30407302] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = true,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*0.25",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = true,
		Id = 30407302,
		DamageType = 2,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"30406315"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30407303] = {
		DynamicRPNExp = "(A1-A2)*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 30407303,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			303,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{
				"2",
				"13"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30407304] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 30407304,
		IsBaseAttribute = false,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"13"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30501201] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "K*0.1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 30501201,
		SelfAtt = {
			9,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[30501401] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 30501401,
		IsBaseAttribute = true,
		DynamicArgType = {
			311,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30502401] = {
		DynamicRPNExp = "A1*0.05",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 30502401,
		IsBaseAttribute = true,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"30502402"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30503301] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*(A2-A3)*0.03",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 30503301,
		DamageType = 4,
		DynamicArgType = {
			103,
			303,
			303,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"30503302"
			},
			{
				"2",
				"9"
			},
			{
				"2",
				"11"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30504301] = {
		DynamicRPNExp = "A1*0.02",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 30504301,
		IsBaseAttribute = true,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"30504301"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30506301] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "(A1-A2)*0.3",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = true,
		MinDamage = 98,
		Id = 30506301,
		DamageType = 4,
		DynamicArgType = {
			303,
			303,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"7"
			},
			{
				"2",
				"11"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30506401] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 30506401,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"30505301"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30506402] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 30506402,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"30505301"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30507401] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*0.05",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = true,
		MinDamage = 98,
		Id = 30507401,
		DamageType = 4,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"9"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30601301] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		Id = 30601301,
		DamageType = 1,
		DynamicArgType = {
			321,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"0"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30601401] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 30601401,
		IsBaseAttribute = false,
		DynamicArgType = {
			310,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"30601302"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30701301] = {
		DynamicRPNExp = "A1*A2*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 30701301,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			320,
			104,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1102"
			},
			{
				"2",
				"11"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30702301] = {
		DynamicRPNExp = "A1*A2*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 30702301,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			320,
			104,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1102"
			},
			{
				"2",
				"7"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30702302] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		IsBaseAttribute = false,
		DynamicRPNExp = "A1*A2*A3",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 30702302,
		DamageType = 3,
		DynamicArgType = {
			103,
			303,
			104,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1102"
			},
			{
				"2",
				"9"
			},
			{
				"2"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30702401] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 30702401,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			104,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1102"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30703301] = {
		DynamicRPNExp = "A1*A2*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 30703301,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			320,
			104,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1102"
			},
			{
				"2",
				"7"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30703302] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 30703302,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1102"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30703303] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 30703303,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"3",
				"1",
				"1102"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30703304] = {
		DynamicRPNExp = "A1-A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 30703304,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			103,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1102"
			},
			{
				"2",
				"1",
				"30703307"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30703401] = {
		DynamicRPNExp = "A1*A2*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 30703401,
		IsBaseAttribute = false,
		DynamicArgType = {
			320,
			103,
			104,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"7"
			},
			{
				"2",
				"1",
				"30703404"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30704301] = {
		DynamicRPNExp = "A1*A2*A3",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 30704301,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			320,
			104,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1102"
			},
			{
				"2",
				"7"
			},
			{
				"1"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30704401] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 30704401,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1102"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30704402] = {
		DynamicRPNExp = "A1*1",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 30704402,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"3",
				"1",
				"30704402"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30705301] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 30705301,
		IsBaseAttribute = false,
		DynamicArgType = {
			325,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		}
	},
	[30705302] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 30705302,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"30705313"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30705303] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "A1*1",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 30705303,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1102"
			},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30705304] = {
		IsIgnoreShare = false,
		IsIgnoreInverted = false,
		DynamicRPNExp = "(A1+A2)*A3",
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		MinDamage = 99,
		Id = 30705304,
		IsBaseAttribute = false,
		DynamicArgType = {
			103,
			103,
			104,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"30705322"
			},
			{
				"1",
				"1",
				"30705313"
			},
			{
				"4"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[30706401] = {
		DynamicRPNExp = "A1*A2",
		IsIgnoreInverted = false,
		IsIgnoreShare = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = true,
		IsIgnoreSheild = false,
		Id = 30706401,
		IsBaseAttribute = false,
		DynamicArgType = {
			104,
			103,
			0,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"2",
				"1",
				"30706402"
			},
			{},
			{},
			{},
			{},
			{},
			{}
		}
	}
}

setmetatable(CfgSkillFunctionTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgSkillFunctionTable]")
	end
})

local defaultMetaTable = {
	__index = {
		MaxDamage = 0,
		DamageType = 0,
		IsIgnoreShare = false,
		BasicDamage = 0,
		MaxFunctionRPN = 0,
		DynamicRPNExp = "",
		IsIgnoreInverted = false,
		IsIgnoreAbsorb = false,
		IsDamagePlus = false,
		IsIgnoreSheild = false,
		MinDamage = 0,
		IsBaseAttribute = false,
		SelfAttVal = {
			{},
			{}
		},
		DynamicArgType = {
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		TargetAtt = {
			0,
			0
		},
		DynamicArgParams = {
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		},
		SelfAtt = {
			0,
			0
		},
		TargetAttVal = {
			{},
			{}
		}
	}
}

for i, data in pairs(CfgSkillFunctionTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgSkillFunctionTable
