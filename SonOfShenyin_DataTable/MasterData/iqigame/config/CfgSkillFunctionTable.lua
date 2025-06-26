-- chunkname: @IQIGame\\Config\\CfgSkillFunctionTable.lua

local CfgSkillFunctionTable = {
	[98] = {
		IsDamagePlus = true,
		IsBaseAttribute = false,
		BasicDamage = 1,
		Id = 98,
		DamageType = 1,
		SelfAtt = {
			2,
			0
		},
		SelfAttVal = {
			{
				0.01
			},
			{}
		}
	},
	[99] = {
		IsDamagePlus = true,
		IsBaseAttribute = false,
		BasicDamage = 1,
		Id = 99,
		DamageType = 1,
		SelfAtt = {
			2,
			0
		},
		SelfAttVal = {
			{
				0.03
			},
			{}
		}
	},
	[101] = {
		DynamicRPNExp = "K*1",
		IsDamagePlus = false,
		IsBaseAttribute = false,
		Id = 101,
		DamageType = 4,
		SelfAtt = {
			2,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[102] = {
		IsDamagePlus = false,
		MinDamage = 99,
		Id = 102,
		IsBaseAttribute = false,
		DamageType = 1,
		TargetAtt = {
			8,
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
		DynamicRPNExp = "A1",
		IsDamagePlus = false,
		IsBaseAttribute = false,
		Id = 103,
		DamageType = 4,
		DynamicArgType = {
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
				"2"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[107] = {
		IsDamagePlus = true,
		MinDamage = 99,
		BasicDamage = 999999,
		IsBaseAttribute = false,
		Id = 107,
		DamageType = 3
	},
	[112] = {
		DynamicRPNExp = "A1*1.3+A2*1.2+A3*1.1+A4*1-2",
		IsBaseAttribute = false,
		Id = 112,
		IsDamagePlus = true,
		DynamicArgType = {
			314,
			314,
			314,
			314,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"0"
			},
			{
				"2",
				"2",
				"0"
			},
			{
				"2",
				"3",
				"0"
			},
			{
				"2",
				"4",
				"0"
			},
			{},
			{}
		}
	},
	[198] = {
		DynamicRPNExp = "A1*5",
		IsBaseAttribute = false,
		MinDamage = 99,
		Id = 198,
		IsDamagePlus = true,
		DynamicArgType = {
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
				"300"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[300] = {
		DynamicRPNExp = "A1*1",
		IsBaseAttribute = false,
		MinDamage = 99,
		Id = 300,
		IsDamagePlus = true,
		DynamicArgType = {
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
				"300"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[301] = {
		DynamicRPNExp = "0.5*K",
		BasicDamage = 1,
		IsBaseAttribute = false,
		Id = 301,
		IsDamagePlus = true,
		SelfAtt = {
			2,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[302] = {
		DynamicRPNExp = "1*K",
		IsBaseAttribute = false,
		BasicDamage = 1,
		Id = 302,
		IsDamagePlus = false,
		DamageType = 1,
		SelfAtt = {
			2,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[303] = {
		DynamicRPNExp = "1.6*K",
		IsBaseAttribute = false,
		IsDamagePlus = false,
		BasicDamage = 1,
		Id = 303,
		DamageType = 1,
		SelfAtt = {
			2,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		DynamicArgType = {
			328,
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
			{}
		}
	},
	[304] = {
		DynamicRPNExp = "2*K",
		IsBaseAttribute = false,
		BasicDamage = 1,
		Id = 304,
		IsDamagePlus = true,
		DamageType = 1,
		SelfAtt = {
			2,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[305] = {
		DynamicRPNExp = "2.5*K",
		IsBaseAttribute = false,
		BasicDamage = 1,
		Id = 305,
		IsDamagePlus = false,
		DamageType = 1,
		SelfAtt = {
			2,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[306] = {
		DynamicRPNExp = "10*K",
		IsBaseAttribute = false,
		BasicDamage = 1,
		Id = 306,
		IsDamagePlus = true,
		DamageType = 1,
		SelfAtt = {
			8,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[307] = {
		DynamicRPNExp = "4*K",
		IsBaseAttribute = false,
		BasicDamage = 1,
		Id = 307,
		IsDamagePlus = true,
		DamageType = 1,
		SelfAtt = {
			2,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[308] = {
		DynamicRPNExp = "0.3*K",
		IsBaseAttribute = false,
		IsDamagePlus = false,
		BasicDamage = 1,
		Id = 308,
		DamageType = 1,
		SelfAtt = {
			2,
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
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"3"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[309] = {
		DynamicRPNExp = "K",
		IsBaseAttribute = false,
		BasicDamage = 1,
		Id = 309,
		IsDamagePlus = true,
		DamageType = 1,
		SelfAtt = {
			8,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[310] = {
		DynamicRPNExp = "2*K",
		IsBaseAttribute = false,
		BasicDamage = 1,
		Id = 310,
		IsDamagePlus = true,
		DamageType = 1,
		SelfAtt = {
			8,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[400] = {
		DynamicRPNExp = "K*(500+50*A2)/(A1+500+50*A2)",
		IsBaseAttribute = false,
		IsDamagePlus = false,
		MinDamage = 99,
		Id = 400,
		DamageType = 1,
		SelfAtt = {
			2,
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
			318,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"3"
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
	[401] = {
		DynamicRPNExp = "A1*A1/K",
		IsBaseAttribute = false,
		Id = 401,
		IsDamagePlus = false,
		MinDamage = 99,
		DamageType = 1,
		SelfAtt = {
			2,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		TargetAtt = {
			3,
			0
		},
		TargetAttVal = {
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
			0
		},
		DynamicArgParams = {
			{
				"3",
				"1",
				"2"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[402] = {
		Id = 402,
		IsBaseAttribute = false,
		IsDamagePlus = false,
		MinDamage = 99,
		DamageType = 1,
		SelfAtt = {
			2,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		TargetAtt = {
			3,
			0
		},
		TargetAttVal = {
			{
				-1
			},
			{}
		}
	},
	[403] = {
		DynamicRPNExp = "K*1000/(A1+1000)",
		IsBaseAttribute = false,
		IsDamagePlus = false,
		MinDamage = 99,
		Id = 403,
		DamageType = 1,
		SelfAtt = {
			2,
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
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"3"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[501] = {
		DynamicRPNExp = "A1*(1+3*(A2-A3)/(A2-A3+1000)*(1+0.5*(A4-A5)/(A4+A5)))",
		IsBaseAttribute = false,
		MinDamage = 99,
		Id = 501,
		IsDamagePlus = false,
		DamageType = 4,
		DynamicArgType = {
			303,
			303,
			303,
			318,
			318,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"103"
			},
			{
				"1",
				"1",
				"63"
			},
			{
				"2",
				"1",
				"64"
			},
			{
				"1"
			},
			{
				"2"
			},
			{}
		}
	},
	[502] = {
		DynamicRPNExp = "(A1+A6*0.102)*(1+2.4864*(A2-A3)/(A2-A3+200)*(1+0.5*(A4-A5)/(A4+A5)))",
		IsBaseAttribute = false,
		MinDamage = 99,
		Id = 502,
		IsDamagePlus = false,
		DamageType = 4,
		DynamicArgType = {
			325,
			303,
			303,
			318,
			318,
			303
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"1",
				"1",
				"63"
			},
			{
				"2",
				"1",
				"64"
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
				"102"
			}
		}
	},
	[503] = {
		DynamicRPNExp = "A1",
		IsBaseAttribute = false,
		MinDamage = 99,
		Id = 503,
		IsDamagePlus = false,
		DamageType = 4,
		DynamicArgType = {
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
				"102"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[504] = {
		DynamicRPNExp = "A1",
		IsBaseAttribute = false,
		MinDamage = 99,
		Id = 504,
		IsDamagePlus = true,
		DamageType = 4,
		DynamicArgType = {
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
				"102"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[505] = {
		DynamicRPNExp = "A1*0.13",
		IsBaseAttribute = false,
		Id = 505,
		IsDamagePlus = true,
		DynamicArgType = {
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
				"5",
				"601"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[506] = {
		DynamicRPNExp = "A1*120/A2",
		IsBaseAttribute = false,
		Id = 506,
		IsDamagePlus = true,
		DynamicArgType = {
			303,
			303,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"102"
			},
			{
				"1",
				"1",
				"8"
			},
			{},
			{},
			{},
			{}
		}
	},
	[507] = {
		DynamicRPNExp = "(A1+A6*0.5)*(1+2.4864*(A2-A3)/(A2-A3+200)*(1+0.5*(A4-A5)/(A4+A5)))",
		IsBaseAttribute = false,
		MinDamage = 99,
		Id = 507,
		IsDamagePlus = false,
		DamageType = 4,
		DynamicArgType = {
			325,
			303,
			303,
			318,
			318,
			303
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"1",
				"1",
				"63"
			},
			{
				"2",
				"1",
				"64"
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
				"102"
			}
		}
	},
	[508] = {
		DynamicRPNExp = "(A1+A6*0.475)*(1+2.4864*(A2-A3)/(A2-A3+200)*(1+0.5*(A4-A5)/(A4+A5)))",
		IsBaseAttribute = false,
		MinDamage = 99,
		Id = 508,
		IsDamagePlus = false,
		DamageType = 4,
		DynamicArgType = {
			325,
			303,
			303,
			318,
			318,
			303
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"1",
				"1",
				"63"
			},
			{
				"2",
				"1",
				"64"
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
				"102"
			}
		}
	},
	[509] = {
		DynamicRPNExp = "(A1+A6*0.443)*(1+2.4864*(A2-A3)/(A2-A3+200)*(1+0.5*(A4-A5)/(A4+A5)))",
		IsBaseAttribute = false,
		MinDamage = 99,
		Id = 509,
		IsDamagePlus = false,
		DamageType = 4,
		DynamicArgType = {
			325,
			303,
			303,
			318,
			318,
			303
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"1",
				"1",
				"63"
			},
			{
				"2",
				"1",
				"64"
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
				"102"
			}
		}
	},
	[510] = {
		DynamicRPNExp = "(A1+A6*0.102)*(1+2.4864*(A2-A3)/(A2-A3+200)*(1+0.5*(A4-A5)/(A4+A5)))",
		IsBaseAttribute = false,
		MinDamage = 99,
		Id = 510,
		IsDamagePlus = false,
		DamageType = 4,
		DynamicArgType = {
			325,
			303,
			303,
			318,
			318,
			303
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"1",
				"1",
				"63"
			},
			{
				"2",
				"1",
				"64"
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
				"102"
			}
		}
	},
	[511] = {
		DynamicRPNExp = "(A1*0.4+A6*0.0408)*(1+2.4864*(A2-A3)/(A2-A3+200)*(1+0.5*(A4-A5)/(A4+A5)))",
		IsBaseAttribute = false,
		MinDamage = 99,
		Id = 511,
		IsDamagePlus = false,
		DamageType = 4,
		DynamicArgType = {
			325,
			303,
			303,
			318,
			318,
			303
		},
		DynamicArgParams = {
			{
				"3"
			},
			{
				"3",
				"1",
				"63"
			},
			{
				"2",
				"1",
				"64"
			},
			{
				"3"
			},
			{
				"2"
			},
			{
				"1",
				"1",
				"102"
			}
		}
	},
	[512] = {
		DynamicRPNExp = "(A1+A6*0.102)*(1+2.4864*(A2-A3)/(A2-A3+200)*(1+0.5*(A4-A5)/(A4+A5)))",
		IsBaseAttribute = false,
		MinDamage = 99,
		Id = 512,
		IsDamagePlus = false,
		DamageType = 4,
		DynamicArgType = {
			325,
			303,
			303,
			318,
			318,
			303
		},
		DynamicArgParams = {
			{
				"3"
			},
			{
				"3",
				"1",
				"63"
			},
			{
				"2",
				"1",
				"64"
			},
			{
				"3"
			},
			{
				"2"
			},
			{
				"1",
				"1",
				"102"
			}
		}
	},
	[600] = {
		Id = 600,
		IsBaseAttribute = false,
		IsDamagePlus = true
	},
	[601] = {
		DynamicRPNExp = "K/(K+A2*(1-A1)*5/3)*K*1.3",
		IsBaseAttribute = false,
		IsDamagePlus = false,
		MinDamage = 99,
		Id = 601,
		DamageType = 1,
		SelfAtt = {
			2,
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
			0
		},
		DynamicArgParams = {
			{
				"3",
				"1",
				"16"
			},
			{
				"6",
				"1",
				"3"
			},
			{},
			{},
			{},
			{}
		}
	},
	[602] = {
		DynamicRPNExp = "K",
		IsBaseAttribute = false,
		MinDamage = 99,
		Id = 602,
		IsDamagePlus = false,
		DamageType = 1,
		SelfAtt = {
			2,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[603] = {
		DynamicRPNExp = "K",
		IsBaseAttribute = false,
		MinDamage = 99,
		Id = 603,
		IsDamagePlus = true,
		DamageType = 3,
		SelfAtt = {
			2,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[604] = {
		Id = 604,
		IsDamagePlus = false,
		IsBaseAttribute = false,
		DamageType = 3
	},
	[605] = {
		DynamicRPNExp = "K",
		IsBaseAttribute = false,
		MinDamage = 99,
		Id = 605,
		IsDamagePlus = true,
		DamageType = 3,
		SelfAtt = {
			8,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[606] = {
		DynamicRPNExp = "K+A4*A3*0.0125-A2*(1-A1)",
		IsBaseAttribute = false,
		IsDamagePlus = false,
		MinDamage = 99,
		Id = 606,
		DamageType = 1,
		SelfAtt = {
			2,
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
			303,
			303,
			0,
			0
		},
		DynamicArgParams = {
			{
				"3",
				"1",
				"16"
			},
			{
				"6",
				"1",
				"3"
			},
			{
				"3",
				"1",
				"7"
			},
			{
				"3",
				"3",
				"2"
			},
			{},
			{}
		}
	},
	[607] = {
		DynamicRPNExp = "(K-A2*(1-A1))*(1+A3*0.25)",
		IsBaseAttribute = false,
		IsDamagePlus = false,
		MinDamage = 99,
		Id = 607,
		DamageType = 1,
		SelfAtt = {
			2,
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
			103,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"3",
				"1",
				"16"
			},
			{
				"6",
				"1",
				"3"
			},
			{
				"3",
				"5",
				"601"
			},
			{},
			{},
			{}
		}
	},
	[608] = {
		DynamicRPNExp = "A1*1",
		IsDamagePlus = false,
		IsBaseAttribute = false,
		Id = 608,
		DamageType = 1,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"6",
				"1",
				"8"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[609] = {
		DynamicRPNExp = "K/(K+A2*(1-A1)*5/3)*K*1.3",
		IsBaseAttribute = false,
		IsDamagePlus = false,
		Id = 609,
		DamageType = 1,
		SelfAtt = {
			2,
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
			0
		},
		DynamicArgParams = {
			{
				"3",
				"1",
				"16"
			},
			{
				"6",
				"1",
				"3"
			},
			{},
			{},
			{},
			{}
		}
	},
	[610] = {
		DynamicRPNExp = "K",
		IsDamagePlus = true,
		IsBaseAttribute = false,
		Id = 610,
		DamageType = 3,
		SelfAtt = {
			2,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[611] = {
		DynamicRPNExp = "K*1",
		IsDamagePlus = false,
		IsBaseAttribute = false,
		Id = 611,
		DamageType = 1,
		SelfAtt = {
			3,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[612] = {
		DynamicRPNExp = "K/(K+A2*(1-A1)*5/3)*K",
		IsBaseAttribute = false,
		IsDamagePlus = false,
		MinDamage = 99,
		Id = 612,
		DamageType = 1,
		SelfAtt = {
			2,
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
			0
		},
		DynamicArgParams = {
			{
				"3",
				"1",
				"16"
			},
			{
				"6",
				"1",
				"3"
			},
			{},
			{},
			{},
			{}
		}
	},
	[613] = {
		DynamicRPNExp = "A1*1",
		IsDamagePlus = false,
		IsBaseAttribute = false,
		Id = 613,
		DamageType = 2,
		DynamicArgType = {
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
				"8"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[701] = {
		DynamicRPNExp = "A1*1",
		IsDamagePlus = true,
		IsBaseAttribute = false,
		Id = 701,
		DamageType = 5,
		DynamicArgType = {
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
				"8"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[702] = {
		DynamicRPNExp = "A1*1",
		IsDamagePlus = true,
		IsBaseAttribute = false,
		Id = 702,
		DamageType = 5,
		DynamicArgType = {
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
				"2"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[703] = {
		DynamicRPNExp = "A1*1",
		IsDamagePlus = true,
		IsBaseAttribute = false,
		Id = 703,
		DamageType = 5,
		DynamicArgType = {
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
				"3"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[704] = {
		DynamicRPNExp = "K",
		IsDamagePlus = true,
		IsBaseAttribute = false,
		Id = 704,
		DamageType = 5,
		SelfAtt = {
			8,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[705] = {
		DynamicRPNExp = "K*1",
		IsDamagePlus = true,
		IsBaseAttribute = false,
		Id = 705,
		DamageType = 4,
		SelfAtt = {
			2,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[706] = {
		DynamicRPNExp = "K*1",
		IsDamagePlus = true,
		IsBaseAttribute = false,
		Id = 706,
		DamageType = 4,
		SelfAtt = {
			3,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[707] = {
		DynamicRPNExp = "A1*1",
		IsDamagePlus = false,
		IsBaseAttribute = false,
		Id = 707,
		DamageType = 4,
		DynamicArgType = {
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
				"8"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[708] = {
		DynamicRPNExp = "A1*1",
		IsDamagePlus = false,
		IsBaseAttribute = false,
		Id = 708,
		DamageType = 4,
		DynamicArgType = {
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
				"2"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[709] = {
		DynamicRPNExp = "A1*1",
		IsDamagePlus = false,
		IsBaseAttribute = false,
		Id = 709,
		DamageType = 4,
		DynamicArgType = {
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
				"3"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[710] = {
		DynamicRPNExp = "A1*1",
		IsDamagePlus = false,
		IsBaseAttribute = false,
		Id = 710,
		DamageType = 4,
		DynamicArgType = {
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
				"8"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[711] = {
		DynamicRPNExp = "A1*1",
		IsDamagePlus = false,
		IsBaseAttribute = false,
		Id = 711,
		DamageType = 4,
		DynamicArgType = {
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
				"1"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[712] = {
		DynamicRPNExp = "A1*1",
		IsDamagePlus = false,
		IsBaseAttribute = false,
		Id = 712,
		DamageType = 4,
		DynamicArgType = {
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
				"2"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[713] = {
		DynamicRPNExp = "A1*1",
		IsDamagePlus = false,
		IsBaseAttribute = false,
		Id = 713,
		DamageType = 4,
		DynamicArgType = {
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
				"3"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[714] = {
		DynamicRPNExp = "A1*1",
		IsBaseAttribute = false,
		Id = 714,
		IsDamagePlus = true,
		DynamicArgType = {
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
				"2"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[715] = {
		DynamicRPNExp = "A1*1",
		IsDamagePlus = true,
		IsBaseAttribute = false,
		Id = 715,
		DamageType = 5,
		DynamicArgType = {
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
				"8"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[716] = {
		DynamicRPNExp = "A1*1",
		IsDamagePlus = true,
		IsBaseAttribute = false,
		Id = 716,
		DamageType = 5,
		DynamicArgType = {
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
				"2"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[717] = {
		DynamicRPNExp = "A1*1",
		IsDamagePlus = true,
		IsBaseAttribute = false,
		Id = 717,
		DamageType = 5,
		DynamicArgType = {
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
				"3"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[718] = {
		DynamicRPNExp = "A1*1",
		IsBaseAttribute = false,
		Id = 718,
		IsDamagePlus = true,
		DynamicArgType = {
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
				"8"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[719] = {
		DynamicRPNExp = "(A2-A1)*0.4",
		IsDamagePlus = true,
		IsBaseAttribute = false,
		Id = 719,
		DamageType = 5,
		DynamicArgType = {
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
				"1",
				"1"
			},
			{
				"2",
				"1",
				"8"
			},
			{},
			{},
			{},
			{}
		}
	},
	[720] = {
		DynamicRPNExp = "A1*1",
		IsDamagePlus = true,
		IsBaseAttribute = false,
		Id = 720,
		DamageType = 5,
		DynamicArgType = {
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
				"8"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10000] = {
		DynamicRPNExp = "A1*1",
		IsBaseAttribute = false,
		Id = 10000,
		IsDamagePlus = true,
		DynamicArgType = {
			332,
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
			{}
		}
	},
	[10001] = {
		DynamicRPNExp = "A1*1",
		IsBaseAttribute = false,
		Id = 10001,
		IsDamagePlus = false,
		DynamicArgType = {
			332,
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
			{}
		}
	},
	[10002] = {
		DynamicRPNExp = "A1*1",
		IsBaseAttribute = false,
		Id = 10002,
		IsDamagePlus = true,
		DynamicArgType = {
			332,
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
			{}
		}
	},
	[10003] = {
		DynamicRPNExp = "A1*1",
		IsBaseAttribute = false,
		Id = 10003,
		IsDamagePlus = false,
		DynamicArgType = {
			332,
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
			{}
		}
	},
	[10004] = {
		DynamicRPNExp = "A1*1",
		IsBaseAttribute = false,
		Id = 10004,
		IsDamagePlus = true,
		DynamicArgType = {
			332,
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
			{}
		}
	},
	[10005] = {
		DynamicRPNExp = "A1*1",
		IsBaseAttribute = false,
		Id = 10005,
		IsDamagePlus = false,
		DynamicArgType = {
			332,
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
			{}
		}
	},
	[10006] = {
		DynamicRPNExp = "A1*1",
		IsBaseAttribute = false,
		Id = 10006,
		IsDamagePlus = true,
		DynamicArgType = {
			332,
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
			{}
		}
	},
	[10007] = {
		DynamicRPNExp = "A1*1",
		IsBaseAttribute = false,
		Id = 10007,
		IsDamagePlus = false,
		DynamicArgType = {
			332,
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
			{}
		}
	},
	[10008] = {
		DynamicRPNExp = "A1*1",
		IsBaseAttribute = false,
		Id = 10008,
		IsDamagePlus = true,
		DynamicArgType = {
			332,
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
			{}
		}
	},
	[10009] = {
		DynamicRPNExp = "A1*1",
		IsBaseAttribute = false,
		Id = 10009,
		IsDamagePlus = false,
		DynamicArgType = {
			332,
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
			{}
		}
	},
	[10100] = {
		DynamicRPNExp = "A1*A2",
		IsDamagePlus = true,
		IsBaseAttribute = false,
		Id = 10100,
		DamageType = 5,
		DynamicArgType = {
			332,
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
				"1"
			},
			{},
			{},
			{},
			{}
		}
	},
	[10101] = {
		DynamicRPNExp = "A1*A2",
		IsDamagePlus = false,
		IsBaseAttribute = false,
		Id = 10101,
		DamageType = 4,
		DynamicArgType = {
			332,
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
				"1"
			},
			{},
			{},
			{},
			{}
		}
	},
	[10150] = {
		DynamicRPNExp = "A1*A2",
		IsDamagePlus = false,
		IsBaseAttribute = false,
		Id = 10150,
		DamageType = 4,
		DynamicArgType = {
			332,
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
				"1"
			},
			{},
			{},
			{},
			{}
		}
	},
	[10200] = {
		DynamicRPNExp = "A1*A2",
		IsBaseAttribute = false,
		Id = 10200,
		IsDamagePlus = true,
		DynamicArgType = {
			332,
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
				"2",
				"2"
			},
			{},
			{},
			{},
			{}
		}
	},
	[10201] = {
		DynamicRPNExp = "A1*A2",
		IsBaseAttribute = false,
		Id = 10201,
		IsDamagePlus = false,
		DynamicArgType = {
			332,
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
				"2",
				"2"
			},
			{},
			{},
			{},
			{}
		}
	},
	[10202] = {
		DynamicRPNExp = "A1*A2",
		IsBaseAttribute = false,
		Id = 10202,
		IsDamagePlus = true,
		DynamicArgType = {
			332,
			303,
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
				"2",
				"2"
			},
			{},
			{},
			{},
			{}
		}
	},
	[10204] = {
		DynamicRPNExp = "A1*A2",
		IsBaseAttribute = false,
		Id = 10204,
		IsDamagePlus = true,
		DynamicArgType = {
			332,
			303,
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
				"2",
				"2"
			},
			{},
			{},
			{},
			{}
		}
	},
	[10210] = {
		DynamicRPNExp = "A1*A2",
		IsBaseAttribute = false,
		Id = 10210,
		IsDamagePlus = true,
		DynamicArgType = {
			332,
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
				"2"
			},
			{},
			{},
			{},
			{}
		}
	},
	[10300] = {
		DynamicRPNExp = "A1*A2",
		IsBaseAttribute = false,
		Id = 10300,
		IsDamagePlus = true,
		DynamicArgType = {
			332,
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
				"2",
				"3"
			},
			{},
			{},
			{},
			{}
		}
	},
	[10301] = {
		DynamicRPNExp = "A1*A2",
		IsBaseAttribute = false,
		Id = 10301,
		IsDamagePlus = false,
		DynamicArgType = {
			332,
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
				"2",
				"3"
			},
			{},
			{},
			{},
			{}
		}
	},
	[10302] = {
		DynamicRPNExp = "A1*A2",
		IsBaseAttribute = false,
		Id = 10302,
		IsDamagePlus = true,
		DynamicArgType = {
			332,
			303,
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
				"2",
				"3"
			},
			{},
			{},
			{},
			{}
		}
	},
	[10303] = {
		DynamicRPNExp = "A1*A2",
		IsBaseAttribute = false,
		Id = 10303,
		IsDamagePlus = false,
		DynamicArgType = {
			332,
			303,
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
				"2",
				"3"
			},
			{},
			{},
			{},
			{}
		}
	},
	[10310] = {
		DynamicRPNExp = "A1*A2",
		IsBaseAttribute = false,
		Id = 10310,
		IsDamagePlus = true,
		DynamicArgType = {
			332,
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
				"3"
			},
			{},
			{},
			{},
			{}
		}
	},
	[10312] = {
		DynamicRPNExp = "A1*A2",
		IsBaseAttribute = false,
		Id = 10312,
		IsDamagePlus = true,
		DynamicArgType = {
			332,
			303,
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
				"3"
			},
			{},
			{},
			{},
			{}
		}
	},
	[10313] = {
		DynamicRPNExp = "A1*A2",
		IsBaseAttribute = false,
		Id = 10313,
		IsDamagePlus = false,
		DynamicArgType = {
			332,
			303,
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
				"3"
			},
			{},
			{},
			{},
			{}
		}
	},
	[10800] = {
		DynamicRPNExp = "A1*A2",
		IsBaseAttribute = false,
		Id = 10800,
		IsDamagePlus = true,
		DynamicArgType = {
			332,
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
				"2",
				"8"
			},
			{},
			{},
			{},
			{}
		}
	},
	[10802] = {
		DynamicRPNExp = "A1*A2",
		IsBaseAttribute = false,
		Id = 10802,
		IsDamagePlus = true,
		DynamicArgType = {
			332,
			303,
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
				"2",
				"8"
			},
			{},
			{},
			{},
			{}
		}
	},
	[10804] = {
		DynamicRPNExp = "A1*A2",
		IsBaseAttribute = false,
		Id = 10804,
		IsDamagePlus = true,
		DynamicArgType = {
			332,
			303,
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
				"2",
				"8"
			},
			{},
			{},
			{},
			{}
		}
	},
	[10810] = {
		DynamicRPNExp = "A1*A2",
		IsBaseAttribute = false,
		Id = 10810,
		IsDamagePlus = true,
		DynamicArgType = {
			332,
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
				"8"
			},
			{},
			{},
			{},
			{}
		}
	},
	[10812] = {
		DynamicRPNExp = "A1*A2",
		IsBaseAttribute = false,
		Id = 10812,
		IsDamagePlus = true,
		DynamicArgType = {
			332,
			303,
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
				"8"
			},
			{},
			{},
			{},
			{}
		}
	},
	[10890] = {
		DynamicRPNExp = "A1*A2",
		IsDamagePlus = true,
		IsBaseAttribute = false,
		Id = 10890,
		DamageType = 5,
		DynamicArgType = {
			332,
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
				"8"
			},
			{},
			{},
			{},
			{}
		}
	},
	[10892] = {
		DynamicRPNExp = "A1*A2",
		IsDamagePlus = true,
		IsBaseAttribute = false,
		Id = 10892,
		DamageType = 5,
		DynamicArgType = {
			332,
			303,
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
				"8"
			},
			{},
			{},
			{},
			{}
		}
	},
	[20210] = {
		DynamicRPNExp = "A1*A2",
		IsBaseAttribute = false,
		Id = 20210,
		IsDamagePlus = true,
		DynamicArgType = {
			332,
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
				"1",
				"2"
			},
			{},
			{},
			{},
			{}
		}
	},
	[20212] = {
		DynamicRPNExp = "A1*A2",
		IsBaseAttribute = false,
		Id = 20212,
		IsDamagePlus = true,
		DynamicArgType = {
			332,
			303,
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
				"2"
			},
			{},
			{},
			{},
			{}
		}
	},
	[20230] = {
		DynamicRPNExp = "A1*A2",
		IsDamagePlus = false,
		IsBaseAttribute = false,
		Id = 20230,
		DamageType = 1,
		DynamicArgType = {
			332,
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
				"1",
				"2"
			},
			{},
			{},
			{},
			{}
		}
	},
	[20232] = {
		DynamicRPNExp = "A1*A2",
		IsDamagePlus = false,
		IsBaseAttribute = false,
		Id = 20232,
		DamageType = 1,
		DynamicArgType = {
			332,
			303,
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
				"2"
			},
			{},
			{},
			{},
			{}
		}
	},
	[20290] = {
		DynamicRPNExp = "A1*A2",
		IsDamagePlus = true,
		IsBaseAttribute = false,
		Id = 20290,
		DamageType = 5,
		DynamicArgType = {
			332,
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
				"1",
				"2"
			},
			{},
			{},
			{},
			{}
		}
	},
	[20330] = {
		DynamicRPNExp = "A1*A2",
		IsDamagePlus = false,
		IsBaseAttribute = false,
		Id = 20330,
		DamageType = 1,
		DynamicArgType = {
			332,
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
				"1",
				"3"
			},
			{},
			{},
			{},
			{}
		}
	},
	[20810] = {
		DynamicRPNExp = "A1*A2",
		IsBaseAttribute = false,
		Id = 20810,
		IsDamagePlus = true,
		DynamicArgType = {
			332,
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
				"1",
				"8"
			},
			{},
			{},
			{},
			{}
		}
	},
	[20890] = {
		DynamicRPNExp = "A1*A2",
		IsDamagePlus = true,
		IsBaseAttribute = false,
		Id = 20890,
		DamageType = 5,
		DynamicArgType = {
			332,
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
				"1",
				"8"
			},
			{},
			{},
			{},
			{}
		}
	},
	[31000] = {
		DynamicRPNExp = "A1*1",
		IsBaseAttribute = false,
		Id = 31000,
		IsDamagePlus = true,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"4",
				"1",
				"10"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[70101] = {
		DynamicRPNExp = "A1*(A2+1)*1",
		IsDamagePlus = true,
		IsBaseAttribute = false,
		Id = 70101,
		DamageType = 5,
		DynamicArgType = {
			303,
			303,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"8"
			},
			{
				"1",
				"1",
				"77"
			},
			{},
			{},
			{},
			{}
		}
	},
	[70501] = {
		DynamicRPNExp = "K*0.08",
		IsDamagePlus = true,
		IsBaseAttribute = false,
		Id = 70501,
		DamageType = 4,
		SelfAtt = {
			8,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[70502] = {
		DynamicRPNExp = "K*0.12",
		IsDamagePlus = true,
		IsBaseAttribute = false,
		Id = 70502,
		DamageType = 4,
		SelfAtt = {
			8,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[70503] = {
		DynamicRPNExp = "K*2",
		IsDamagePlus = true,
		IsBaseAttribute = false,
		Id = 70503,
		DamageType = 4,
		SelfAtt = {
			2,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[70504] = {
		DynamicRPNExp = "K*0.2",
		IsDamagePlus = true,
		IsBaseAttribute = false,
		Id = 70504,
		DamageType = 5,
		SelfAtt = {
			8,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[70601] = {
		DynamicRPNExp = "K*0.5",
		IsDamagePlus = true,
		IsBaseAttribute = false,
		Id = 70601,
		DamageType = 4,
		SelfAtt = {
			3,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[70701] = {
		DynamicRPNExp = "A1*0.01+500",
		IsDamagePlus = false,
		IsBaseAttribute = false,
		Id = 70701,
		DamageType = 4,
		DynamicArgType = {
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
				"8"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[71001] = {
		MaxDamage = 306,
		IsDamagePlus = false,
		IsBaseAttribute = false,
		Id = 71001,
		DynamicRPNExp = "A1*1",
		DamageType = 4,
		DynamicArgType = {
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
				"8"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[71002] = {
		DynamicRPNExp = "A1*1",
		IsBaseAttribute = false,
		IsDamagePlus = false,
		Id = 71002,
		MaxFunctionRPN = 304,
		DamageType = 4,
		DynamicArgType = {
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
				"8"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[71101] = {
		DynamicRPNExp = "A1*1",
		IsBaseAttribute = false,
		IsDamagePlus = false,
		Id = 71101,
		MaxFunctionRPN = 304,
		DamageType = 4,
		DynamicArgType = {
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
				"1"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[71102] = {
		DynamicRPNExp = "A1*1",
		IsBaseAttribute = false,
		IsDamagePlus = false,
		Id = 71102,
		MaxFunctionRPN = 306,
		DamageType = 4,
		DynamicArgType = {
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
				"1"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[71103] = {
		DynamicRPNExp = "A1*1",
		IsBaseAttribute = false,
		IsDamagePlus = false,
		Id = 71103,
		MaxFunctionRPN = 306,
		DamageType = 4,
		DynamicArgType = {
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
				"1"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[71401] = {
		DynamicRPNExp = "A1*0.03",
		IsBaseAttribute = false,
		Id = 71401,
		IsDamagePlus = true,
		DynamicArgType = {
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
				"2"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[71402] = {
		DynamicRPNExp = "A1*0.05",
		IsBaseAttribute = false,
		Id = 71402,
		IsDamagePlus = true,
		DynamicArgType = {
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
				"2"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[71801] = {
		DynamicRPNExp = "A1*0.01+1",
		IsBaseAttribute = false,
		Id = 71801,
		IsDamagePlus = true,
		DynamicArgType = {
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
				"8"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[71802] = {
		DynamicRPNExp = "A1*0.02+3",
		IsBaseAttribute = false,
		Id = 71802,
		IsDamagePlus = true,
		DynamicArgType = {
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
				"8"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[71803] = {
		DynamicRPNExp = "A1*0.03+5",
		IsBaseAttribute = false,
		Id = 71803,
		IsDamagePlus = true,
		DynamicArgType = {
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
				"8"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[71804] = {
		DynamicRPNExp = "A1*0.05+5",
		IsBaseAttribute = false,
		Id = 71804,
		IsDamagePlus = true,
		DynamicArgType = {
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
				"8"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[80001] = {
		DynamicRPNExp = "A1*0.2",
		IsBaseAttribute = false,
		Id = 80001,
		IsDamagePlus = true,
		DynamicArgType = {
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
				"14"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[80002] = {
		DynamicRPNExp = "A1*0.3",
		IsBaseAttribute = false,
		Id = 80002,
		IsDamagePlus = true,
		DynamicArgType = {
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
				"14"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[80019] = {
		DynamicRPNExp = "A1*0.2",
		IsBaseAttribute = false,
		Id = 80019,
		MaxFunctionRPN = 309,
		IsDamagePlus = true,
		DynamicArgType = {
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
				"106"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[80020] = {
		DynamicRPNExp = "A1*0.4",
		IsBaseAttribute = false,
		Id = 80020,
		MaxFunctionRPN = 310,
		IsDamagePlus = true,
		DynamicArgType = {
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
				"106"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[80207] = {
		DynamicRPNExp = "0.12*A1",
		IsBaseAttribute = false,
		Id = 80207,
		IsDamagePlus = true,
		DynamicArgType = {
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
				"80207070"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[81003] = {
		DynamicRPNExp = "A1*0.1",
		IsBaseAttribute = false,
		Id = 81003,
		IsDamagePlus = true,
		DynamicArgType = {
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
				"103"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[81005] = {
		DynamicRPNExp = "(A2-A1)*0.1",
		IsBaseAttribute = false,
		Id = 81005,
		IsDamagePlus = true,
		DynamicArgType = {
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
				"1",
				"1"
			},
			{
				"2",
				"1",
				"8"
			},
			{},
			{},
			{},
			{}
		}
	},
	[81006] = {
		DynamicRPNExp = "(A2-A1)*0.2",
		IsBaseAttribute = false,
		Id = 81006,
		IsDamagePlus = true,
		DynamicArgType = {
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
				"1",
				"1"
			},
			{
				"2",
				"1",
				"8"
			},
			{},
			{},
			{},
			{}
		}
	},
	[100201] = {
		DynamicRPNExp = "A1*A2",
		IsDamagePlus = true,
		IsBaseAttribute = false,
		Id = 100201,
		DamageType = 5,
		DynamicArgType = {
			303,
			332,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"8"
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
	[100801] = {
		DynamicRPNExp = "A1*1",
		IsBaseAttribute = false,
		Id = 100801,
		IsDamagePlus = true,
		DynamicArgType = {
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
				"109"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[100802] = {
		DynamicRPNExp = "A1",
		IsBaseAttribute = false,
		Id = 100802,
		IsDamagePlus = true,
		DynamicArgType = {
			103,
			332,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10083001"
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
	[100803] = {
		DynamicRPNExp = "A1*A2",
		IsBaseAttribute = false,
		Id = 100803,
		IsDamagePlus = true,
		DynamicArgType = {
			103,
			332,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"10083001"
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
	[101001] = {
		DynamicRPNExp = "A1*0.05",
		IsBaseAttribute = false,
		Id = 101001,
		MaxFunctionRPN = 308,
		IsDamagePlus = true,
		DynamicArgType = {
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
				"8"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[101002] = {
		DynamicRPNExp = "A1*A2",
		IsDamagePlus = false,
		Id = 101002,
		DamageType = 4,
		DynamicArgType = {
			303,
			332,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
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
	[110500] = {
		DynamicRPNExp = "A1*A2",
		IsBaseAttribute = false,
		Id = 110500,
		IsDamagePlus = true,
		DynamicArgType = {
			303,
			332,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"105"
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
	[300830] = {
		DynamicRPNExp = "(A2-A1)/A2*K*0.5",
		IsBaseAttribute = false,
		Id = 300830,
		IsDamagePlus = true,
		SelfAtt = {
			2,
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
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1"
			},
			{
				"2",
				"1",
				"8"
			},
			{},
			{},
			{},
			{}
		}
	},
	[302030] = {
		DynamicRPNExp = "100+A1*0.03",
		IsBaseAttribute = false,
		IsDamagePlus = false,
		MinDamage = 99,
		Id = 302030,
		DamageType = 1,
		SelfAtt = {
			2,
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
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"8"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[600000] = {
		DynamicRPNExp = "(A2-A1)/A2*10000",
		IsBaseAttribute = false,
		Id = 600000,
		IsDamagePlus = true,
		DynamicArgType = {
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
				"1",
				"1"
			},
			{
				"2",
				"1",
				"8"
			},
			{},
			{},
			{},
			{}
		}
	},
	[600001] = {
		DynamicRPNExp = "(A2-A1)/A2*15556",
		IsBaseAttribute = false,
		Id = 600001,
		IsDamagePlus = true,
		DynamicArgType = {
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
				"1",
				"1"
			},
			{
				"2",
				"1",
				"8"
			},
			{},
			{},
			{},
			{}
		}
	},
	[600002] = {
		DynamicRPNExp = "A1*2",
		IsBaseAttribute = false,
		Id = 600002,
		IsDamagePlus = true,
		DynamicArgType = {
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
				"101"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[803071] = {
		DynamicRPNExp = "K*0.165",
		IsBaseAttribute = false,
		Id = 803071,
		IsDamagePlus = true,
		SelfAtt = {
			1,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[803072] = {
		DynamicRPNExp = "K*0.185",
		IsBaseAttribute = false,
		Id = 803072,
		IsDamagePlus = true,
		SelfAtt = {
			1,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[803073] = {
		DynamicRPNExp = "K*0.205",
		IsBaseAttribute = false,
		Id = 803073,
		IsDamagePlus = true,
		SelfAtt = {
			1,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[803074] = {
		DynamicRPNExp = "K*0.224",
		IsBaseAttribute = false,
		Id = 803074,
		IsDamagePlus = true,
		SelfAtt = {
			1,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[803075] = {
		DynamicRPNExp = "K*0.244",
		IsBaseAttribute = false,
		Id = 803075,
		IsDamagePlus = true,
		SelfAtt = {
			1,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[804031] = {
		DynamicRPNExp = "K*2.025",
		IsBaseAttribute = false,
		Id = 804031,
		IsDamagePlus = true,
		SelfAtt = {
			3,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[804032] = {
		DynamicRPNExp = "K*2.268",
		IsBaseAttribute = false,
		Id = 804032,
		IsDamagePlus = true,
		SelfAtt = {
			3,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[804033] = {
		DynamicRPNExp = "K*2.511",
		IsBaseAttribute = false,
		Id = 804033,
		IsDamagePlus = true,
		SelfAtt = {
			3,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[804034] = {
		DynamicRPNExp = "K*2.754",
		IsBaseAttribute = false,
		Id = 804034,
		IsDamagePlus = true,
		SelfAtt = {
			3,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[804035] = {
		DynamicRPNExp = "K*2.997",
		IsBaseAttribute = false,
		Id = 804035,
		IsDamagePlus = true,
		SelfAtt = {
			3,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[805221] = {
		DynamicRPNExp = "K*0.05",
		IsBaseAttribute = false,
		IsDamagePlus = true,
		Id = 805221,
		DamageType = 5,
		SelfAtt = {
			2,
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
				"8"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[805222] = {
		DynamicRPNExp = "K*0.06",
		IsBaseAttribute = false,
		IsDamagePlus = true,
		Id = 805222,
		DamageType = 5,
		SelfAtt = {
			2,
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
				"8"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[805223] = {
		DynamicRPNExp = "K*0.07",
		IsBaseAttribute = false,
		IsDamagePlus = true,
		Id = 805223,
		DamageType = 5,
		SelfAtt = {
			2,
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
				"8"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[805224] = {
		DynamicRPNExp = "K*0.08",
		IsBaseAttribute = false,
		IsDamagePlus = true,
		Id = 805224,
		DamageType = 5,
		SelfAtt = {
			2,
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
				"8"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[805225] = {
		DynamicRPNExp = "K*0.10",
		IsBaseAttribute = false,
		IsDamagePlus = true,
		Id = 805225,
		DamageType = 5,
		SelfAtt = {
			2,
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
				"8"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[810017] = {
		DynamicRPNExp = "K*2",
		IsDamagePlus = true,
		IsBaseAttribute = false,
		Id = 810017,
		DamageType = 4,
		SelfAtt = {
			3,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[810018] = {
		DynamicRPNExp = "K*5",
		IsDamagePlus = true,
		IsBaseAttribute = false,
		Id = 810018,
		DamageType = 4,
		SelfAtt = {
			3,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[810019] = {
		DynamicRPNExp = "A1*1",
		IsDamagePlus = false,
		IsBaseAttribute = false,
		Id = 810019,
		DamageType = 1,
		DynamicArgType = {
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
				"106"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[820001] = {
		DynamicRPNExp = "A1*0.2",
		IsBaseAttribute = false,
		Id = 820001,
		IsDamagePlus = true,
		DynamicArgType = {
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
				"14"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[820002] = {
		DynamicRPNExp = "A1*0.5",
		IsBaseAttribute = false,
		Id = 820002,
		IsDamagePlus = true,
		DynamicArgType = {
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
				"14"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[820015] = {
		DynamicRPNExp = "A1*0.1",
		IsBaseAttribute = false,
		Id = 820015,
		IsDamagePlus = true,
		DynamicArgType = {
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
			{},
			{},
			{},
			{},
			{}
		}
	},
	[820016] = {
		DynamicRPNExp = "A1*0.1",
		IsBaseAttribute = false,
		Id = 820016,
		IsDamagePlus = true,
		DynamicArgType = {
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
			{},
			{},
			{},
			{},
			{}
		}
	},
	[820017] = {
		DynamicRPNExp = "A1*0.08",
		IsBaseAttribute = false,
		Id = 820017,
		IsDamagePlus = true,
		DynamicArgType = {
			311,
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
			{}
		}
	},
	[820018] = {
		DynamicRPNExp = "A1*0.05",
		IsBaseAttribute = false,
		Id = 820018,
		IsDamagePlus = true,
		DynamicArgType = {
			311,
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
			{}
		}
	},
	[900001] = {
		DynamicRPNExp = "K*0.35",
		IsDamagePlus = true,
		IsBaseAttribute = false,
		Id = 900001,
		DamageType = 5,
		SelfAtt = {
			8,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		}
	},
	[1103200] = {
		DynamicRPNExp = "A1*0.2",
		IsDamagePlus = true,
		IsBaseAttribute = false,
		Id = 1103200,
		DamageType = 3,
		DynamicArgType = {
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
				"8"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1103210] = {
		DynamicRPNExp = "A2*(0.15+0.1*A1)",
		IsBaseAttribute = false,
		Id = 1103210,
		IsDamagePlus = true,
		DynamicArgType = {
			102,
			303,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1103213"
			},
			{
				"2",
				"2",
				"3"
			},
			{},
			{},
			{},
			{}
		}
	},
	[1103220] = {
		DynamicRPNExp = "A1*0.03",
		IsDamagePlus = true,
		IsBaseAttribute = false,
		Id = 1103220,
		DamageType = 3,
		DynamicArgType = {
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
				"8"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1103300] = {
		DynamicRPNExp = "A1*0.2",
		IsBaseAttribute = false,
		Id = 1103300,
		IsDamagePlus = true,
		DynamicArgType = {
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
				"8"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1203100] = {
		DynamicRPNExp = "(1-A1)*0.15",
		IsBaseAttribute = false,
		BasicDamage = 1,
		Id = 1203100,
		IsDamagePlus = true,
		DynamicArgType = {
			321,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"8",
				"4"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1203110] = {
		DynamicRPNExp = "(1-A1)*0.3*A2",
		IsBaseAttribute = false,
		BasicDamage = 1,
		Id = 1203110,
		IsDamagePlus = true,
		DynamicArgType = {
			321,
			303,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"8",
				"4"
			},
			{
				"2",
				"2",
				"3"
			},
			{},
			{},
			{},
			{}
		}
	},
	[1203120] = {
		DynamicRPNExp = "(1-A1)*0.1*A2",
		IsBaseAttribute = false,
		BasicDamage = 1,
		Id = 1203120,
		IsDamagePlus = true,
		DynamicArgType = {
			321,
			303,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"8",
				"4"
			},
			{
				"2",
				"2",
				"2"
			},
			{},
			{},
			{},
			{}
		}
	},
	[1203200] = {
		DynamicRPNExp = "(1-A1)*0.2",
		IsBaseAttribute = false,
		BasicDamage = 1,
		Id = 1203200,
		IsDamagePlus = true,
		DynamicArgType = {
			321,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"8",
				"4"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1203210] = {
		DynamicRPNExp = "(1-A1)*0.4",
		IsBaseAttribute = false,
		BasicDamage = 1,
		Id = 1203210,
		IsDamagePlus = true,
		DynamicArgType = {
			321,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"8",
				"4"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1203220] = {
		DynamicRPNExp = "(1-A1)*0.4",
		IsBaseAttribute = false,
		BasicDamage = 1,
		Id = 1203220,
		IsDamagePlus = true,
		DynamicArgType = {
			321,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"8",
				"4"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1203310] = {
		DynamicRPNExp = "A1*0.2",
		IsBaseAttribute = false,
		BasicDamage = 1,
		Id = 1203310,
		IsDamagePlus = true,
		DamageType = 5,
		DynamicArgType = {
			321,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"8",
				"1",
				"2"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[1203420] = {
		DynamicRPNExp = "A1*1.25",
		IsBaseAttribute = false,
		BasicDamage = 1,
		Id = 1203420,
		IsDamagePlus = true,
		DynamicArgType = {
			321,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"8",
				"1",
				"2"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10012000] = {
		DynamicRPNExp = "A1*A2",
		IsBaseAttribute = false,
		Id = 10012000,
		IsDamagePlus = true,
		DynamicArgType = {
			103,
			332,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10012003"
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
	[10052000] = {
		DynamicRPNExp = "K/(K+A2*(1-A1)*5/3)*K*1.3*A3*A4",
		IsBaseAttribute = false,
		IsDamagePlus = false,
		Id = 10052000,
		DamageType = 1,
		SelfAtt = {
			2,
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
			332,
			103,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"16"
			},
			{
				"2",
				"1",
				"3"
			},
			{
				"1"
			},
			{
				"2",
				"1",
				"10052001"
			},
			{},
			{}
		}
	},
	[10052001] = {
		DynamicRPNExp = "K/(K+A2*(1-A1)*5/3)*K*1.3*A3*A4",
		IsBaseAttribute = false,
		IsDamagePlus = false,
		Id = 10052001,
		DamageType = 1,
		SelfAtt = {
			2,
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
			332,
			103,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"16"
			},
			{
				"2",
				"1",
				"3"
			},
			{
				"1"
			},
			{
				"2",
				"1",
				"10052012"
			},
			{},
			{}
		}
	},
	[10063000] = {
		DynamicRPNExp = "K/(K+A2*(1-A1)*5/3)*K*1.3*(A3+A4*A5)",
		IsBaseAttribute = false,
		IsDamagePlus = false,
		Id = 10063000,
		DamageType = 1,
		SelfAtt = {
			2,
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
			332,
			103,
			332,
			0
		},
		DynamicArgParams = {
			{
				"3",
				"1",
				"16"
			},
			{
				"6",
				"1",
				"3"
			},
			{
				"1"
			},
			{
				"3",
				"1",
				"10062000"
			},
			{
				"2"
			},
			{}
		}
	},
	[10063001] = {
		DynamicRPNExp = "A1*A2",
		IsBaseAttribute = false,
		Id = 10063001,
		IsDamagePlus = true,
		DynamicArgType = {
			103,
			332,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10062000"
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
	[10073000] = {
		DynamicRPNExp = "A1*1",
		IsBaseAttribute = false,
		Id = 10073000,
		IsDamagePlus = true,
		DynamicArgType = {
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
				"10072001"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10111000] = {
		DynamicRPNExp = "K/(K+A2*(1-A1)*5/3)*K*1.3*A3",
		IsBaseAttribute = false,
		IsDamagePlus = false,
		MinDamage = 99,
		Id = 10111000,
		DamageType = 1,
		SelfAtt = {
			2,
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
			332,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"16"
			},
			{
				"2",
				"1",
				"3"
			},
			{
				"2"
			},
			{},
			{},
			{}
		}
	},
	[10112000] = {
		DynamicRPNExp = "K/(K+A2*(1-A1)*5/3)*K*1.3*A3*A4",
		IsBaseAttribute = false,
		IsDamagePlus = false,
		Id = 10112000,
		DamageType = 1,
		SelfAtt = {
			2,
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
			332,
			103,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"16"
			},
			{
				"2",
				"1",
				"3"
			},
			{
				"1"
			},
			{
				"1",
				"1",
				"10112001"
			},
			{},
			{}
		}
	},
	[10113000] = {
		DynamicRPNExp = "A1*A2*0.02",
		IsBaseAttribute = false,
		Id = 10113000,
		IsDamagePlus = true,
		DynamicArgType = {
			103,
			303,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10112001"
			},
			{
				"2",
				"1",
				"2"
			},
			{},
			{},
			{},
			{}
		}
	},
	[10113001] = {
		DynamicRPNExp = "A1*0.05",
		IsBaseAttribute = false,
		Id = 10113001,
		IsDamagePlus = true,
		DynamicArgType = {
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
				"10112001"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10142000] = {
		DynamicRPNExp = "A1*1",
		IsDamagePlus = true,
		IsBaseAttribute = false,
		Id = 10142000,
		DamageType = 5,
		DynamicArgType = {
			317,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10142001"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10152000] = {
		DynamicRPNExp = "A1*1",
		IsBaseAttribute = false,
		Id = 10152000,
		MaxFunctionRPN = 10152001,
		IsDamagePlus = true,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"4",
				"1",
				"10"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10152001] = {
		DynamicRPNExp = "5",
		IsBaseAttribute = false,
		Id = 10152001,
		IsDamagePlus = true,
		DynamicArgType = {
			303,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"4",
				"1",
				"10"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10163000] = {
		DynamicRPNExp = "A1*A2",
		IsDamagePlus = false,
		IsBaseAttribute = false,
		Id = 10163000,
		DamageType = 2,
		DynamicArgType = {
			303,
			332,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"101"
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
	[10193000] = {
		DynamicRPNExp = "A1*A2",
		IsBaseAttribute = false,
		Id = 10193000,
		IsDamagePlus = true,
		DynamicArgType = {
			103,
			332,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10193001"
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
	[10223000] = {
		DynamicRPNExp = "A1*A2+A3*A4",
		IsDamagePlus = true,
		IsBaseAttribute = false,
		Id = 10223000,
		DamageType = 3,
		DynamicArgType = {
			303,
			332,
			303,
			332,
			0,
			0
		},
		DynamicArgParams = {
			{
				"3",
				"1",
				"8"
			},
			{
				"2"
			},
			{
				"3",
				"2",
				"2"
			},
			{
				"1"
			},
			{},
			{}
		}
	},
	[10233000] = {
		DynamicRPNExp = "A1*A2*A3",
		IsBaseAttribute = false,
		Id = 10233000,
		MaxFunctionRPN = 10233010,
		IsDamagePlus = true,
		DynamicArgType = {
			332,
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
				"2",
				"2",
				"2"
			},
			{
				"2",
				"4",
				"1"
			},
			{},
			{},
			{}
		}
	},
	[10233001] = {
		DynamicRPNExp = "A1*A2",
		IsBaseAttribute = false,
		Id = 10233001,
		MaxFunctionRPN = 10233011,
		IsDamagePlus = true,
		DynamicArgType = {
			332,
			103,
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
				"4",
				"1"
			},
			{},
			{},
			{},
			{}
		}
	},
	[10233002] = {
		DynamicRPNExp = "A1*A2",
		IsBaseAttribute = false,
		Id = 10233002,
		MaxFunctionRPN = 10233012,
		IsDamagePlus = true,
		DynamicArgType = {
			332,
			103,
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
				"4",
				"1"
			},
			{},
			{},
			{},
			{}
		}
	},
	[10233010] = {
		DynamicRPNExp = "A1*A2*A3",
		IsBaseAttribute = false,
		Id = 10233010,
		IsDamagePlus = true,
		DynamicArgType = {
			332,
			303,
			332,
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
				"2",
				"2"
			},
			{
				"4"
			},
			{},
			{},
			{}
		}
	},
	[10233011] = {
		DynamicRPNExp = "A1*A2",
		IsBaseAttribute = false,
		Id = 10233011,
		IsDamagePlus = true,
		DynamicArgType = {
			332,
			332,
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
				"4"
			},
			{},
			{},
			{},
			{}
		}
	},
	[10233012] = {
		DynamicRPNExp = "A1*A2",
		IsBaseAttribute = false,
		Id = 10233012,
		IsDamagePlus = true,
		DynamicArgType = {
			332,
			332,
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
				"4"
			},
			{},
			{},
			{},
			{}
		}
	},
	[10253000] = {
		DynamicRPNExp = "A1*A2",
		IsBaseAttribute = false,
		Id = 10253000,
		IsDamagePlus = true,
		DynamicArgType = {
			303,
			332,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"3"
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
	[10262000] = {
		DynamicRPNExp = "A1*1",
		IsBaseAttribute = false,
		Id = 10262000,
		IsDamagePlus = true,
		DynamicArgType = {
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
				"10262001"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10262001] = {
		DynamicRPNExp = "A2",
		IsBaseAttribute = false,
		Id = 10262001,
		IsDamagePlus = true,
		DynamicArgType = {
			103,
			332,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10262002"
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
	[10262002] = {
		DynamicRPNExp = "A1*1",
		IsBaseAttribute = false,
		Id = 10262002,
		IsDamagePlus = true,
		DynamicArgType = {
			310,
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
				"10262005"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[10263000] = {
		DynamicRPNExp = "K/(K+A2*(1-A1)*5/3)*K*1.3*A3*(1+A4*0.2)",
		IsBaseAttribute = false,
		IsDamagePlus = false,
		MinDamage = 99,
		Id = 10263000,
		DamageType = 1,
		SelfAtt = {
			2,
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
			332,
			102,
			0,
			0
		},
		DynamicArgParams = {
			{
				"3",
				"1",
				"16"
			},
			{
				"6",
				"1",
				"3"
			},
			{
				"1"
			},
			{
				"1",
				"1",
				"10263002"
			},
			{},
			{}
		}
	},
	[10271000] = {
		DynamicRPNExp = "A1*1",
		IsBaseAttribute = false,
		Id = 10271000,
		MaxFunctionRPN = 10271001,
		IsDamagePlus = true,
		DynamicArgType = {
			332,
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
			{}
		}
	},
	[10271001] = {
		DynamicRPNExp = "A2-A1",
		IsBaseAttribute = false,
		Id = 10271001,
		IsDamagePlus = true,
		DynamicArgType = {
			103,
			332,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"10272014"
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
	[10271002] = {
		DynamicRPNExp = "A1*A2",
		IsDamagePlus = false,
		IsBaseAttribute = false,
		Id = 10271002,
		DamageType = 1,
		DynamicArgType = {
			332,
			303,
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
				"2"
			},
			{},
			{},
			{},
			{}
		}
	},
	[10272000] = {
		DynamicRPNExp = "A1*A2",
		IsBaseAttribute = false,
		MinDamage = 10272001,
		Id = 10272000,
		IsDamagePlus = false,
		DynamicArgType = {
			313,
			332,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"5",
				"41"
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
	[10272001] = {
		DynamicRPNExp = "A1*3",
		IsBaseAttribute = false,
		Id = 10272001,
		IsDamagePlus = false,
		DynamicArgType = {
			332,
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
			{}
		}
	},
	[10273001] = {
		DynamicRPNExp = "K*A1*A2",
		IsBaseAttribute = false,
		IsDamagePlus = false,
		Id = 10273001,
		DamageType = 4,
		SelfAtt = {
			2,
			0
		},
		SelfAttVal = {
			{
				1
			},
			{}
		},
		DynamicArgType = {
			332,
			103,
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
				"10273004"
			},
			{},
			{},
			{},
			{}
		}
	},
	[10341001] = {
		DynamicRPNExp = "(A2-A1)*A3",
		IsDamagePlus = true,
		IsBaseAttribute = false,
		Id = 10341001,
		DamageType = 5,
		DynamicArgType = {
			303,
			303,
			332,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1"
			},
			{
				"2",
				"1",
				"8"
			},
			{
				"1"
			},
			{},
			{},
			{}
		}
	},
	[10342001] = {
		DynamicRPNExp = "A1-A2*0.05",
		IsBaseAttribute = false,
		Id = 10342001,
		IsDamagePlus = true,
		DynamicArgType = {
			332,
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
				"1",
				"10343002"
			},
			{},
			{},
			{},
			{}
		}
	},
	[10342002] = {
		DynamicRPNExp = "A1*A2",
		IsDamagePlus = true,
		IsBaseAttribute = false,
		Id = 10342002,
		DamageType = 5,
		DynamicArgType = {
			332,
			303,
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
				"8"
			},
			{},
			{},
			{},
			{}
		}
	},
	[40000810] = {
		DynamicRPNExp = "A1*0.2",
		IsBaseAttribute = false,
		Id = 40000810,
		IsDamagePlus = true,
		DynamicArgType = {
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
				"109"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[56012001] = {
		DynamicRPNExp = "A1*0.3",
		IsDamagePlus = true,
		IsBaseAttribute = false,
		Id = 56012001,
		DamageType = 3,
		DynamicArgType = {
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
				"8"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[80005000] = {
		DynamicRPNExp = "A1*A2",
		IsDamagePlus = false,
		IsBaseAttribute = false,
		Id = 80005000,
		DamageType = 2,
		DynamicArgType = {
			303,
			332,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"103"
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
	[80005001] = {
		DynamicRPNExp = "A1*A2",
		IsDamagePlus = false,
		IsBaseAttribute = false,
		Id = 80005001,
		DamageType = 2,
		DynamicArgType = {
			303,
			332,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"103"
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
	[80005002] = {
		DynamicRPNExp = "A1*A2",
		IsDamagePlus = false,
		IsBaseAttribute = false,
		Id = 80005002,
		DamageType = 2,
		DynamicArgType = {
			303,
			332,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1",
				"103"
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
	[80008000] = {
		DynamicRPNExp = "A1*A2",
		IsBaseAttribute = false,
		IsDamagePlus = false,
		Id = 80008000,
		MaxFunctionRPN = 80008001,
		DamageType = 2,
		DynamicArgType = {
			303,
			332,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1"
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
	[80008001] = {
		DynamicRPNExp = "A1*0.2",
		IsBaseAttribute = false,
		Id = 80008001,
		IsDamagePlus = true,
		DynamicArgType = {
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
				"2"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[80011000] = {
		DynamicRPNExp = "(0.8-A1)/0.02*A2",
		IsBaseAttribute = false,
		Id = 80011000,
		IsDamagePlus = true,
		DynamicArgType = {
			321,
			332,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"8",
				"4"
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
	[80115000] = {
		DynamicRPNExp = "A1*A2",
		IsBaseAttribute = false,
		IsDamagePlus = false,
		Id = 80115000,
		MaxFunctionRPN = 80115001,
		DamageType = 4,
		DynamicArgType = {
			332,
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
				"1"
			},
			{},
			{},
			{},
			{}
		}
	},
	[80115001] = {
		DynamicRPNExp = "A1*0.8",
		IsBaseAttribute = false,
		Id = 80115001,
		IsDamagePlus = true,
		DynamicArgType = {
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
				"2"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[80117000] = {
		DynamicRPNExp = "(5-A1)*A2*0.02",
		IsBaseAttribute = false,
		Id = 80117000,
		IsDamagePlus = true,
		DynamicArgType = {
			311,
			303,
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
				"2",
				"3"
			},
			{},
			{},
			{},
			{}
		}
	},
	[80119000] = {
		DynamicRPNExp = "(A1-1)*A2*0.02",
		IsBaseAttribute = false,
		Id = 80119000,
		MaxFunctionRPN = 80119001,
		IsDamagePlus = true,
		DynamicArgType = {
			311,
			303,
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
				"2",
				"3"
			},
			{},
			{},
			{},
			{}
		}
	},
	[80119001] = {
		DynamicRPNExp = "A1*0.08",
		IsBaseAttribute = false,
		Id = 80119001,
		IsDamagePlus = true,
		DynamicArgType = {
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
				"2",
				"3"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[80217000] = {
		DynamicRPNExp = "A1-A2",
		IsBaseAttribute = false,
		Id = 80217000,
		IsDamagePlus = true,
		DynamicArgType = {
			103,
			303,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"4",
				"1",
				"80217001"
			},
			{
				"4",
				"1",
				"10"
			},
			{},
			{},
			{},
			{}
		}
	},
	[80224000] = {
		DynamicRPNExp = "5-A1",
		IsBaseAttribute = false,
		Id = 80224000,
		MaxFunctionRPN = 80224001,
		IsDamagePlus = true,
		DynamicArgType = {
			323,
			0,
			0,
			0,
			0,
			0
		}
	},
	[80224001] = {
		Id = 80224001,
		IsBaseAttribute = false,
		DynamicRPNExp = "4",
		IsDamagePlus = true
	},
	[80225000] = {
		DynamicRPNExp = "A1*A2",
		IsBaseAttribute = false,
		MinDamage = 80225001,
		Id = 80225000,
		IsDamagePlus = false,
		DynamicArgType = {
			332,
			313,
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
				"5",
				"40"
			},
			{},
			{},
			{},
			{}
		}
	},
	[80225001] = {
		DynamicRPNExp = "A1*3",
		IsBaseAttribute = false,
		Id = 80225001,
		IsDamagePlus = false,
		DynamicArgType = {
			332,
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
			{}
		}
	},
	[80228000] = {
		DynamicRPNExp = "A1*A2",
		IsDamagePlus = false,
		IsBaseAttribute = false,
		Id = 80228000,
		DamageType = 4,
		DynamicArgType = {
			332,
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
				"1",
				"2"
			},
			{},
			{},
			{},
			{}
		}
	},
	[80228001] = {
		DynamicRPNExp = "A1*0.05",
		IsBaseAttribute = false,
		IsDamagePlus = false,
		Id = 80228001,
		MaxFunctionRPN = 80228002,
		DamageType = 4,
		DynamicArgType = {
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
				"8"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[80228002] = {
		DynamicRPNExp = "A1*2.4",
		IsBaseAttribute = false,
		Id = 80228002,
		IsDamagePlus = true,
		DynamicArgType = {
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
				"2"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[80228003] = {
		DynamicRPNExp = "A1*A2*5",
		IsDamagePlus = false,
		IsBaseAttribute = false,
		Id = 80228003,
		DamageType = 4,
		DynamicArgType = {
			332,
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
				"1",
				"2"
			},
			{},
			{},
			{},
			{}
		}
	},
	[101201200] = {
		DynamicRPNExp = "A1*A2*A3",
		IsBaseAttribute = false,
		Id = 101201200,
		IsDamagePlus = true,
		DynamicArgType = {
			310,
			332,
			303,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"3",
				"1",
				"101000000"
			},
			{
				"1"
			},
			{
				"2",
				"2",
				"3"
			},
			{},
			{},
			{}
		}
	},
	[101202200] = {
		DynamicRPNExp = "A1*A2*A3",
		IsBaseAttribute = false,
		Id = 101202200,
		IsDamagePlus = true,
		DynamicArgType = {
			310,
			332,
			303,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"3",
				"1",
				"101000000"
			},
			{
				"1"
			},
			{
				"2",
				"2",
				"2"
			},
			{},
			{},
			{}
		}
	},
	[101203200] = {
		DynamicRPNExp = "A1*A2",
		IsBaseAttribute = false,
		Id = 101203200,
		IsDamagePlus = true,
		DynamicArgType = {
			310,
			332,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"3",
				"1",
				"101000000"
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
	[101204200] = {
		DynamicRPNExp = "A1*A2",
		IsBaseAttribute = false,
		Id = 101204200,
		IsDamagePlus = true,
		DynamicArgType = {
			310,
			332,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"3",
				"1",
				"101000000"
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
	[102103300] = {
		DynamicRPNExp = "0.6*(A2-A1)/A2*A3",
		IsBaseAttribute = false,
		Id = 102103300,
		IsDamagePlus = true,
		DynamicArgType = {
			303,
			303,
			303,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"1"
			},
			{
				"2",
				"1",
				"8"
			},
			{
				"2",
				"2",
				"2"
			},
			{},
			{},
			{}
		}
	},
	[201301400] = {
		DynamicRPNExp = "A1+1",
		IsBaseAttribute = false,
		Id = 201301400,
		IsDamagePlus = true,
		DynamicArgType = {
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
			{},
			{},
			{},
			{},
			{}
		}
	},
	[201302100] = {
		DynamicRPNExp = "((A2-A1)/A2)*0.3",
		IsBaseAttribute = false,
		Id = 201302100,
		IsDamagePlus = true,
		DynamicArgType = {
			303,
			303,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"6",
				"1",
				"1"
			},
			{
				"6",
				"1",
				"8"
			},
			{},
			{},
			{},
			{}
		}
	},
	[201302500] = {
		DynamicRPNExp = "A1*1",
		IsDamagePlus = false,
		IsBaseAttribute = false,
		Id = 201302500,
		DamageType = 1,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"6",
				"1",
				"201302501"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[202301500] = {
		DynamicRPNExp = "K*(0.3+A1*0.1)",
		IsBaseAttribute = false,
		IsDamagePlus = false,
		Id = 202301500,
		DamageType = 2,
		TargetAtt = {
			1,
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
			0
		},
		DynamicArgParams = {
			{
				"3",
				"1",
				"202301405"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[202302200] = {
		DynamicRPNExp = "K/(K+A2*(1-A1)*5/3)*K*0.8",
		IsBaseAttribute = false,
		IsDamagePlus = false,
		MinDamage = 99,
		Id = 202302200,
		DamageType = 1,
		SelfAtt = {
			2,
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
			0
		},
		DynamicArgParams = {
			{
				"3",
				"1",
				"16"
			},
			{
				"2",
				"1",
				"3"
			},
			{},
			{},
			{},
			{}
		}
	},
	[202303400] = {
		DynamicRPNExp = "A1*0.1-A2*0.1",
		IsBaseAttribute = false,
		Id = 202303400,
		IsDamagePlus = true,
		DynamicArgType = {
			103,
			103,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"3",
				"1",
				"202303406"
			},
			{
				"3",
				"1",
				"202303409"
			},
			{},
			{},
			{},
			{}
		}
	},
	[203301500] = {
		DynamicRPNExp = "A1*0.15",
		IsBaseAttribute = false,
		Id = 203301500,
		IsDamagePlus = true,
		DynamicArgType = {
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
				"203301402"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[203302210] = {
		DynamicRPNExp = "(A1+1)/2",
		IsBaseAttribute = false,
		Id = 203302210,
		IsDamagePlus = true,
		DynamicArgType = {
			322,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"0"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[203302211] = {
		DynamicRPNExp = "K/(K+A2*(1-A1)*5/3)*K*(0.3+0.02*A3)",
		IsBaseAttribute = false,
		IsDamagePlus = false,
		MinDamage = 99,
		Id = 203302211,
		DamageType = 1,
		SelfAtt = {
			2,
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
			103,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"3",
				"1",
				"16"
			},
			{
				"6",
				"1",
				"3"
			},
			{
				"2",
				"1",
				"203302202"
			},
			{},
			{},
			{}
		}
	},
	[301301200] = {
		DynamicRPNExp = "A1*0.2",
		IsBaseAttribute = false,
		BasicDamage = 1,
		Id = 301301200,
		IsDamagePlus = false,
		DynamicArgType = {
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
				"301301300"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[302302500] = {
		DynamicRPNExp = "A1*A2",
		IsDamagePlus = false,
		IsBaseAttribute = false,
		Id = 302302500,
		DamageType = 2,
		DynamicArgType = {
			303,
			332,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"2",
				"1",
				"8"
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
	[302402100] = {
		DynamicRPNExp = "((A2-A1)/A2)*0.3",
		IsBaseAttribute = false,
		Id = 302402100,
		IsDamagePlus = true,
		DynamicArgType = {
			303,
			303,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"6",
				"1",
				"1"
			},
			{
				"6",
				"1",
				"8"
			},
			{},
			{},
			{},
			{}
		}
	},
	[302402500] = {
		DynamicRPNExp = "A1*1",
		IsDamagePlus = false,
		IsBaseAttribute = false,
		Id = 302402500,
		DamageType = 1,
		DynamicArgType = {
			103,
			0,
			0,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"6",
				"1",
				"302402501"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[302305500] = {
		DynamicRPNExp = "K/(K+A2*(1-A1)*5/3)*K*(1+0.05*A3)",
		IsBaseAttribute = false,
		IsDamagePlus = false,
		MinDamage = 99,
		Id = 302305500,
		DamageType = 1,
		SelfAtt = {
			2,
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
			103,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"3",
				"1",
				"16"
			},
			{
				"6",
				"1",
				"3"
			},
			{
				"2",
				"1",
				"302305200"
			},
			{},
			{},
			{}
		}
	},
	[401301500] = {
		DynamicRPNExp = "K/(K+A2*(1-A1)*5/3)*K*(1+0.05*A3)",
		IsBaseAttribute = false,
		IsDamagePlus = false,
		MinDamage = 99,
		Id = 401301500,
		DamageType = 1,
		SelfAtt = {
			2,
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
			103,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"3",
				"1",
				"16"
			},
			{
				"6",
				"1",
				"3"
			},
			{
				"2",
				"1",
				"305"
			},
			{},
			{},
			{}
		}
	},
	[401301530] = {
		DynamicRPNExp = "K/(K+A2*(1-A1)*5/3)*K*(1+0.05*(10+A3))",
		IsBaseAttribute = false,
		IsDamagePlus = false,
		MinDamage = 99,
		Id = 401301530,
		DamageType = 1,
		SelfAtt = {
			2,
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
			103,
			0,
			0,
			0
		},
		DynamicArgParams = {
			{
				"3",
				"1",
				"16"
			},
			{
				"6",
				"1",
				"3"
			},
			{
				"2",
				"1",
				"305"
			},
			{},
			{},
			{}
		}
	},
	[401302210] = {
		DynamicRPNExp = "A1",
		IsBaseAttribute = false,
		Id = 401302210,
		IsDamagePlus = true,
		DynamicArgType = {
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
				"305"
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[401302211] = {
		DynamicRPNExp = "2*A1",
		IsBaseAttribute = false,
		Id = 401302211,
		IsDamagePlus = true,
		DynamicArgType = {
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
				"305"
			},
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
		DynamicRPNExp = "",
		MinDamage = 0,
		DamageType = 0,
		MaxDamage = 0,
		IsBaseAttribute = false,
		IsDamagePlus = false,
		BasicDamage = 0,
		MaxFunctionRPN = 0,
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
