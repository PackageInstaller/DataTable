-- chunkname: @IQIGame\\Config\\CfgSkillAITable.lua

local CfgSkillAITable = {
	{
		Id = 1,
		Priority = 30,
		DynamicRPNExp = "A1>0",
		DynamicArgType = {
			102,
			0,
			0
		}
	},
	{
		Id = 2,
		Priority = 100,
		DynamicRPNExp = "A1>0",
		DynamicArgType = {
			102,
			0,
			0
		}
	},
	{
		Id = 3,
		Priority = 50,
		DynamicRPNExp = "A1>0",
		DynamicArgType = {
			102,
			0,
			0
		}
	},
	{
		DynamicRPNExp = "A1>=60",
		Priority = 100,
		Id = 4,
		DynamicArgType = {
			105,
			0,
			0
		},
		DynamicArgParams = {
			{
				"7"
			},
			{},
			{}
		}
	},
	{
		DynamicRPNExp = "A1>=2",
		Priority = 100,
		Id = 5,
		DynamicArgType = {
			103,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"22210"
			},
			{},
			{}
		}
	},
	[11] = {
		DynamicRPNExp = "A1>=1",
		Priority = 100,
		Id = 11,
		DynamicArgType = {
			104,
			0,
			0
		},
		DynamicArgParams = {
			{
				"0.7"
			},
			{},
			{}
		}
	},
	[12] = {
		DynamicRPNExp = "A1>=2",
		Priority = 100,
		Id = 12,
		DynamicArgType = {
			104,
			0,
			0
		},
		DynamicArgParams = {
			{
				"0.85"
			},
			{},
			{}
		}
	},
	[13] = {
		DynamicRPNExp = "A1>=1",
		Priority = 100,
		Id = 13,
		DynamicArgType = {
			104,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{},
			{}
		}
	},
	[101] = {
		Id = 101,
		Priority = 30,
		DynamicRPNExp = "A1>0",
		DynamicArgType = {
			102,
			0,
			0
		}
	},
	[102] = {
		Id = 102,
		Priority = 50,
		DynamicRPNExp = "A1>0",
		DynamicArgType = {
			102,
			0,
			0
		}
	},
	[103] = {
		Id = 103,
		Priority = 50,
		DynamicRPNExp = "A1>0",
		DynamicArgType = {
			102,
			0,
			0
		}
	},
	[104] = {
		Id = 104,
		Priority = 100,
		DynamicRPNExp = "A1>0",
		DynamicArgType = {
			102,
			0,
			0
		}
	},
	[110] = {
		Id = 110,
		Priority = 5,
		DynamicRPNExp = "A1>0",
		DynamicArgType = {
			102,
			0,
			0
		}
	},
	[111] = {
		DynamicRPNExp = "A1>=1",
		Priority = 140,
		Id = 111,
		DynamicArgType = {
			104,
			0,
			0
		},
		DynamicArgParams = {
			{
				"0.8"
			},
			{},
			{}
		}
	},
	[123] = {
		Id = 123,
		Priority = 50,
		DynamicRPNExp = "A1>1",
		DynamicArgType = {
			102,
			0,
			0
		}
	},
	[211] = {
		DynamicRPNExp = "A1>=1",
		Priority = 300,
		Id = 211,
		DynamicArgType = {
			103,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"211"
			},
			{},
			{}
		}
	},
	[212] = {
		DynamicRPNExp = "A1>=2",
		Priority = 300,
		Id = 212,
		DynamicArgType = {
			103,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"211"
			},
			{},
			{}
		}
	},
	[213] = {
		DynamicRPNExp = "A1>=3",
		Priority = 300,
		Id = 213,
		DynamicArgType = {
			103,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"211"
			},
			{},
			{}
		}
	},
	[1101] = {
		DynamicRPNExp = "A1>=1",
		Priority = 200,
		Id = 1101,
		DynamicArgType = {
			103,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"51075002"
			},
			{},
			{}
		}
	},
	[1201] = {
		DynamicRPNExp = "A1/A2>0.75",
		Priority = 50,
		Id = 1201,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[1202] = {
		DynamicRPNExp = "A1/A2>0.75",
		Priority = 100,
		Id = 1202,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[1203] = {
		DynamicRPNExp = "A1/A2<=0.75",
		Priority = 80,
		Id = 1203,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[1211] = {
		DynamicRPNExp = "A1/A2>0.2&&A1/A2<=0.75",
		Priority = 50,
		Id = 1211,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[1212] = {
		DynamicRPNExp = "A1/A2>0.2&&A1/A2<=0.75",
		Priority = 100,
		Id = 1212,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[1231] = {
		DynamicRPNExp = "A1/A2<=0.2",
		Priority = 50,
		Id = 1231,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[1232] = {
		DynamicRPNExp = "A1/A2<=0.2",
		Priority = 100,
		Id = 1232,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[1301] = {
		DynamicRPNExp = "A1==0",
		Priority = 200,
		Id = 1301,
		DynamicArgType = {
			101,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"1202"
			},
			{},
			{}
		}
	},
	[1302] = {
		DynamicRPNExp = "A1/A2<=0.2",
		Priority = 999,
		Id = 1302,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[1311] = {
		DynamicRPNExp = "A1/A2>0.65",
		Priority = 50,
		Id = 1311,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[1312] = {
		DynamicRPNExp = "A1/A2>0.65",
		Priority = 80,
		Id = 1312,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[1313] = {
		DynamicRPNExp = "A1/A2<=0.65",
		Priority = 80,
		Id = 1313,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[1314] = {
		DynamicRPNExp = "A1/A2>0.2&&A1/A2<=0.65",
		Priority = 50,
		Id = 1314,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[1315] = {
		DynamicRPNExp = "A1/A2>0.2&&A1/A2<=0.65",
		Priority = 100,
		Id = 1315,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[1316] = {
		DynamicRPNExp = "A1/A2<=0.2",
		Priority = 50,
		Id = 1316,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[1317] = {
		DynamicRPNExp = "A1/A2<=0.2",
		Priority = 100,
		Id = 1317,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[1318] = {
		DynamicRPNExp = "A1=1",
		Priority = 999,
		Id = 1318,
		DynamicArgType = {
			103,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"63022211"
			},
			{},
			{}
		}
	},
	[1319] = {
		DynamicRPNExp = "A1/A2>0.6",
		Priority = 200,
		Id = 1319,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[1320] = {
		DynamicRPNExp = "A1/A2>60",
		Priority = 100,
		Id = 1320,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[1321] = {
		DynamicRPNExp = "A1/A2>0.1&&A1/A2<=0.6",
		Priority = 50,
		Id = 1321,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[1322] = {
		DynamicRPNExp = "A1/A2>0.1&&A1/A2<=0.6",
		Priority = 100,
		Id = 1322,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[1323] = {
		DynamicRPNExp = "A1/A2<=0.1",
		Priority = 50,
		Id = 1323,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[1324] = {
		DynamicRPNExp = "A1/A2<=0.1",
		Priority = 100,
		Id = 1324,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[1331] = {
		DynamicRPNExp = "A1>=2&&A2/A3<=0.5",
		Priority = 150,
		Id = 1331,
		DynamicArgType = {
			107,
			105,
			105
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"1"
			},
			{
				"8"
			}
		}
	},
	[1501] = {
		DynamicRPNExp = "A1/A2<=0.3",
		Priority = 50,
		Id = 1501,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[1520] = {
		DynamicRPNExp = "A1/A2<=0.5",
		Priority = 50,
		Id = 1520,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[1521] = {
		DynamicRPNExp = "A1/A2<=0.5",
		Priority = 100,
		Id = 1521,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2010] = {
		DynamicRPNExp = "A1/A2=1",
		Priority = 50,
		Id = 2010,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2011] = {
		DynamicRPNExp = "A1/A2=1",
		Priority = 100,
		Id = 2011,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2012] = {
		DynamicRPNExp = "A1/A2=1",
		Priority = 200,
		Id = 2012,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2020] = {
		DynamicRPNExp = "A1/A2>0.8",
		Priority = 50,
		Id = 2020,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2021] = {
		DynamicRPNExp = "A1/A2>0.8",
		Priority = 100,
		Id = 2021,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2022] = {
		DynamicRPNExp = "A1/A2>0.8",
		Priority = 200,
		Id = 2022,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2030] = {
		DynamicRPNExp = "A1/A2>0.7",
		Priority = 50,
		Id = 2030,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2031] = {
		DynamicRPNExp = "A1/A2>0.7",
		Priority = 100,
		Id = 2031,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2032] = {
		DynamicRPNExp = "A1/A2>0.7",
		Priority = 200,
		Id = 2032,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2040] = {
		DynamicRPNExp = "A1/A2>0.6",
		Priority = 50,
		Id = 2040,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2041] = {
		DynamicRPNExp = "A1/A2>0.6",
		Priority = 100,
		Id = 2041,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2042] = {
		DynamicRPNExp = "A1/A2>0.6",
		Priority = 200,
		Id = 2042,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2050] = {
		DynamicRPNExp = "A1/A2>0.5",
		Priority = 50,
		Id = 2050,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2051] = {
		DynamicRPNExp = "A1/A2>0.5",
		Priority = 100,
		Id = 2051,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2052] = {
		DynamicRPNExp = "A1/A2>0.5",
		Priority = 200,
		Id = 2052,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2060] = {
		DynamicRPNExp = "A1/A2>0.4",
		Priority = 50,
		Id = 2060,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2061] = {
		DynamicRPNExp = "A1/A2>0.4",
		Priority = 100,
		Id = 2061,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2062] = {
		DynamicRPNExp = "A1/A2>0.4",
		Priority = 200,
		Id = 2062,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2070] = {
		DynamicRPNExp = "A1/A2>0.3",
		Priority = 50,
		Id = 2070,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2071] = {
		DynamicRPNExp = "A1/A2>0.3",
		Priority = 100,
		Id = 2071,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2072] = {
		DynamicRPNExp = "A1/A2>0.3",
		Priority = 200,
		Id = 2072,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2080] = {
		DynamicRPNExp = "A1/A2>0.2",
		Priority = 50,
		Id = 2080,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2081] = {
		DynamicRPNExp = "A1/A2>0.2",
		Priority = 100,
		Id = 2081,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2082] = {
		DynamicRPNExp = "A1/A2>0.2",
		Priority = 200,
		Id = 2082,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2090] = {
		DynamicRPNExp = "A1/A2>0.1",
		Priority = 50,
		Id = 2090,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2091] = {
		DynamicRPNExp = "A1/A2>0.1",
		Priority = 100,
		Id = 2091,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2092] = {
		DynamicRPNExp = "A1/A2>0.1",
		Priority = 200,
		Id = 2092,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2100] = {
		DynamicRPNExp = "A1/A2>0",
		Priority = 50,
		Id = 2100,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2101] = {
		DynamicRPNExp = "A1/A2>0",
		Priority = 100,
		Id = 2101,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2102] = {
		DynamicRPNExp = "A1/A2>0",
		Priority = 200,
		Id = 2102,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2110] = {
		DynamicRPNExp = "A1/A2>0.8&&A1/A2<=0.9",
		Priority = 50,
		Id = 2110,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2111] = {
		DynamicRPNExp = "A1/A2>0.8&&A1/A2<=0.9",
		Priority = 100,
		Id = 2111,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2112] = {
		DynamicRPNExp = "A1/A2>0.8&&A1/A2<=0.9",
		Priority = 200,
		Id = 2112,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2120] = {
		DynamicRPNExp = "A1/A2>0.7&&A1/A2<=0.9",
		Priority = 50,
		Id = 2120,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2121] = {
		DynamicRPNExp = "A1/A2>0.7&&A1/A2<=0.9",
		Priority = 100,
		Id = 2121,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2122] = {
		DynamicRPNExp = "A1/A2>0.7&&A1/A2<=0.9",
		Priority = 200,
		Id = 2122,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2130] = {
		DynamicRPNExp = "A1/A2>0.6&&A1/A2<=0.9",
		Priority = 50,
		Id = 2130,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2131] = {
		DynamicRPNExp = "A1/A2>0.6&&A1/A2<=0.9",
		Priority = 100,
		Id = 2131,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2132] = {
		DynamicRPNExp = "A1/A2>0.6&&A1/A2<=0.9",
		Priority = 200,
		Id = 2132,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2140] = {
		DynamicRPNExp = "A1/A2>0.5&&A1/A2<=0.9",
		Priority = 50,
		Id = 2140,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2141] = {
		DynamicRPNExp = "A1/A2>0.5&&A1/A2<=0.9",
		Priority = 100,
		Id = 2141,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2142] = {
		DynamicRPNExp = "A1/A2>0.5&&A1/A2<=0.9",
		Priority = 200,
		Id = 2142,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2150] = {
		DynamicRPNExp = "A1/A2>0.4&&A1/A2<=0.9",
		Priority = 50,
		Id = 2150,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2151] = {
		DynamicRPNExp = "A1/A2>0.4&&A1/A2<=0.9",
		Priority = 100,
		Id = 2151,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2152] = {
		DynamicRPNExp = "A1/A2>0.4&&A1/A2<=0.9",
		Priority = 200,
		Id = 2152,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2160] = {
		DynamicRPNExp = "A1/A2>0.3&&A1/A2<=0.9",
		Priority = 50,
		Id = 2160,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2161] = {
		DynamicRPNExp = "A1/A2>0.3&&A1/A2<=0.9",
		Priority = 100,
		Id = 2161,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2162] = {
		DynamicRPNExp = "A1/A2>0.3&&A1/A2<=0.9",
		Priority = 200,
		Id = 2162,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2170] = {
		DynamicRPNExp = "A1/A2>0.2&&A1/A2<=0.9",
		Priority = 50,
		Id = 2170,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2171] = {
		DynamicRPNExp = "A1/A2>0.2&&A1/A2<=0.9",
		Priority = 100,
		Id = 2171,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2172] = {
		DynamicRPNExp = "A1/A2>0.2&&A1/A2<=0.9",
		Priority = 200,
		Id = 2172,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2180] = {
		DynamicRPNExp = "A1/A2>0.1&&A1/A2<=0.9",
		Priority = 50,
		Id = 2180,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2181] = {
		DynamicRPNExp = "A1/A2>0.1&&A1/A2<=0.9",
		Priority = 100,
		Id = 2181,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2182] = {
		DynamicRPNExp = "A1/A2>0.1&&A1/A2<=0.9",
		Priority = 200,
		Id = 2182,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2190] = {
		DynamicRPNExp = "A1/A2>0&&A1/A2<=0.9",
		Priority = 50,
		Id = 2190,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2191] = {
		DynamicRPNExp = "A1/A2>0&&A1/A2<=0.9",
		Priority = 100,
		Id = 2191,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2192] = {
		DynamicRPNExp = "A1/A2>0&&A1/A2<=0.9",
		Priority = 200,
		Id = 2192,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2200] = {
		DynamicRPNExp = "A1/A2>0.7&&A1/A2<=0.8",
		Priority = 50,
		Id = 2200,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2201] = {
		DynamicRPNExp = "A1/A2>0.7&&A1/A2<=0.8",
		Priority = 100,
		Id = 2201,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2202] = {
		DynamicRPNExp = "A1/A2>0.7&&A1/A2<=0.8",
		Priority = 200,
		Id = 2202,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2210] = {
		DynamicRPNExp = "A1/A2>0.6&&A1/A2<=0.8",
		Priority = 50,
		Id = 2210,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2211] = {
		DynamicRPNExp = "A1/A2>0.6&&A1/A2<=0.8",
		Priority = 100,
		Id = 2211,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2212] = {
		DynamicRPNExp = "A1/A2>0.6&&A1/A2<=0.8",
		Priority = 200,
		Id = 2212,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2220] = {
		DynamicRPNExp = "A1/A2>0.5&&A1/A2<=0.8",
		Priority = 50,
		Id = 2220,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2221] = {
		DynamicRPNExp = "A1/A2>0.5&&A1/A2<=0.8",
		Priority = 100,
		Id = 2221,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2222] = {
		DynamicRPNExp = "A1/A2>0.5&&A1/A2<=0.8",
		Priority = 200,
		Id = 2222,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2230] = {
		DynamicRPNExp = "A1/A2>0.4&&A1/A2<=0.8",
		Priority = 50,
		Id = 2230,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2231] = {
		DynamicRPNExp = "A1/A2>0.4&&A1/A2<=0.8",
		Priority = 100,
		Id = 2231,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2232] = {
		DynamicRPNExp = "A1/A2>0.4&&A1/A2<=0.8",
		Priority = 200,
		Id = 2232,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2240] = {
		DynamicRPNExp = "A1/A2>0.3&&A1/A2<=0.8",
		Priority = 50,
		Id = 2240,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2241] = {
		DynamicRPNExp = "A1/A2>0.3&&A1/A2<=0.8",
		Priority = 100,
		Id = 2241,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2242] = {
		DynamicRPNExp = "A1/A2>0.3&&A1/A2<=0.8",
		Priority = 200,
		Id = 2242,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2250] = {
		DynamicRPNExp = "A1/A2>0.2&&A1/A2<=0.8",
		Priority = 50,
		Id = 2250,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2251] = {
		DynamicRPNExp = "A1/A2>0.2&&A1/A2<=0.8",
		Priority = 100,
		Id = 2251,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2252] = {
		DynamicRPNExp = "A1/A2>0.2&&A1/A2<=0.8",
		Priority = 200,
		Id = 2252,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2260] = {
		DynamicRPNExp = "A1/A2>0.1&&A1/A2<=0.8",
		Priority = 50,
		Id = 2260,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2261] = {
		DynamicRPNExp = "A1/A2>0.1&&A1/A2<=0.8",
		Priority = 100,
		Id = 2261,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2262] = {
		DynamicRPNExp = "A1/A2>0.1&&A1/A2<=0.8",
		Priority = 200,
		Id = 2262,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2270] = {
		DynamicRPNExp = "A1/A2>0&&A1/A2<=0.8",
		Priority = 50,
		Id = 2270,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2271] = {
		DynamicRPNExp = "A1/A2>0&&A1/A2<=0.8",
		Priority = 100,
		Id = 2271,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2272] = {
		DynamicRPNExp = "A1/A2>0&&A1/A2<=0.8",
		Priority = 200,
		Id = 2272,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2280] = {
		DynamicRPNExp = "A1/A2>0.6&&A1/A2<=0.7",
		Priority = 50,
		Id = 2280,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2281] = {
		DynamicRPNExp = "A1/A2>0.6&&A1/A2<=0.7",
		Priority = 100,
		Id = 2281,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2282] = {
		DynamicRPNExp = "A1/A2>0.6&&A1/A2<=0.7",
		Priority = 200,
		Id = 2282,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2290] = {
		DynamicRPNExp = "A1/A2>0.5&&A1/A2<=0.7",
		Priority = 50,
		Id = 2290,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2291] = {
		DynamicRPNExp = "A1/A2>0.5&&A1/A2<=0.7",
		Priority = 100,
		Id = 2291,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2292] = {
		DynamicRPNExp = "A1/A2>0.5&&A1/A2<=0.7",
		Priority = 200,
		Id = 2292,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2300] = {
		DynamicRPNExp = "A1/A2>0.4&&A1/A2<=0.7",
		Priority = 50,
		Id = 2300,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2301] = {
		DynamicRPNExp = "A1/A2>0.4&&A1/A2<=0.7",
		Priority = 100,
		Id = 2301,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2302] = {
		DynamicRPNExp = "A1/A2>0.4&&A1/A2<=0.7",
		Priority = 200,
		Id = 2302,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2310] = {
		DynamicRPNExp = "A1/A2>0.3&&A1/A2<=0.7",
		Priority = 50,
		Id = 2310,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2311] = {
		DynamicRPNExp = "A1/A2>0.3&&A1/A2<=0.7",
		Priority = 100,
		Id = 2311,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2312] = {
		DynamicRPNExp = "A1/A2>0.3&&A1/A2<=0.7",
		Priority = 200,
		Id = 2312,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2320] = {
		DynamicRPNExp = "A1/A2>0.2&&A1/A2<=0.7",
		Priority = 50,
		Id = 2320,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2321] = {
		DynamicRPNExp = "A1/A2>0.2&&A1/A2<=0.7",
		Priority = 100,
		Id = 2321,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2322] = {
		DynamicRPNExp = "A1/A2>0.2&&A1/A2<=0.7",
		Priority = 200,
		Id = 2322,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2330] = {
		DynamicRPNExp = "A1/A2>0.1&&A1/A2<=0.7",
		Priority = 50,
		Id = 2330,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2331] = {
		DynamicRPNExp = "A1/A2>0.1&&A1/A2<=0.7",
		Priority = 100,
		Id = 2331,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2332] = {
		DynamicRPNExp = "A1/A2>0.1&&A1/A2<=0.7",
		Priority = 200,
		Id = 2332,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2340] = {
		DynamicRPNExp = "A1/A2>0&&A1/A2<=0.7",
		Priority = 50,
		Id = 2340,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2341] = {
		DynamicRPNExp = "A1/A2>0&&A1/A2<=0.7",
		Priority = 100,
		Id = 2341,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2342] = {
		DynamicRPNExp = "A1/A2>0&&A1/A2<=0.7",
		Priority = 200,
		Id = 2342,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2350] = {
		DynamicRPNExp = "A1/A2>0.5&&A1/A2<=0.6",
		Priority = 50,
		Id = 2350,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2351] = {
		DynamicRPNExp = "A1/A2>0.5&&A1/A2<=0.6",
		Priority = 100,
		Id = 2351,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2352] = {
		DynamicRPNExp = "A1/A2>0.5&&A1/A2<=0.6",
		Priority = 200,
		Id = 2352,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2360] = {
		DynamicRPNExp = "A1/A2>0.4&&A1/A2<=0.6",
		Priority = 50,
		Id = 2360,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2361] = {
		DynamicRPNExp = "A1/A2>0.4&&A1/A2<=0.6",
		Priority = 100,
		Id = 2361,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2362] = {
		DynamicRPNExp = "A1/A2>0.4&&A1/A2<=0.6",
		Priority = 200,
		Id = 2362,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2370] = {
		DynamicRPNExp = "A1/A2>0.3&&A1/A2<=0.6",
		Priority = 50,
		Id = 2370,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2371] = {
		DynamicRPNExp = "A1/A2>0.3&&A1/A2<=0.6",
		Priority = 100,
		Id = 2371,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2372] = {
		DynamicRPNExp = "A1/A2>0.3&&A1/A2<=0.6",
		Priority = 200,
		Id = 2372,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2380] = {
		DynamicRPNExp = "A1/A2>0.2&&A1/A2<=0.6",
		Priority = 50,
		Id = 2380,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2381] = {
		DynamicRPNExp = "A1/A2>0.2&&A1/A2<=0.6",
		Priority = 100,
		Id = 2381,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2382] = {
		DynamicRPNExp = "A1/A2>0.2&&A1/A2<=0.6",
		Priority = 200,
		Id = 2382,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2390] = {
		DynamicRPNExp = "A1/A2>0.1&&A1/A2<=0.6",
		Priority = 50,
		Id = 2390,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2391] = {
		DynamicRPNExp = "A1/A2>0.1&&A1/A2<=0.6",
		Priority = 100,
		Id = 2391,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2392] = {
		DynamicRPNExp = "A1/A2>0.1&&A1/A2<=0.6",
		Priority = 200,
		Id = 2392,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2400] = {
		DynamicRPNExp = "A1/A2>0&&A1/A2<=0.6",
		Priority = 50,
		Id = 2400,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2401] = {
		DynamicRPNExp = "A1/A2>0&&A1/A2<=0.6",
		Priority = 100,
		Id = 2401,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2402] = {
		DynamicRPNExp = "A1/A2>0&&A1/A2<=0.6",
		Priority = 200,
		Id = 2402,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2410] = {
		DynamicRPNExp = "A1/A2>0.4&&A1/A2<=0.5",
		Priority = 50,
		Id = 2410,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2411] = {
		DynamicRPNExp = "A1/A2>0.4&&A1/A2<=0.5",
		Priority = 100,
		Id = 2411,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2412] = {
		DynamicRPNExp = "A1/A2>0.4&&A1/A2<=0.5",
		Priority = 200,
		Id = 2412,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2420] = {
		DynamicRPNExp = "A1/A2>0.3&&A1/A2<=0.5",
		Priority = 50,
		Id = 2420,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2421] = {
		DynamicRPNExp = "A1/A2>0.3&&A1/A2<=0.5",
		Priority = 100,
		Id = 2421,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2422] = {
		DynamicRPNExp = "A1/A2>0.3&&A1/A2<=0.5",
		Priority = 200,
		Id = 2422,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2430] = {
		DynamicRPNExp = "A1/A2>0.2&&A1/A2<=0.5",
		Priority = 50,
		Id = 2430,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2431] = {
		DynamicRPNExp = "A1/A2>0.2&&A1/A2<=0.5",
		Priority = 100,
		Id = 2431,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2432] = {
		DynamicRPNExp = "A1/A2>0.2&&A1/A2<=0.5",
		Priority = 200,
		Id = 2432,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2440] = {
		DynamicRPNExp = "A1/A2>0.1&&A1/A2<=0.5",
		Priority = 50,
		Id = 2440,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2441] = {
		DynamicRPNExp = "A1/A2>0.1&&A1/A2<=0.5",
		Priority = 100,
		Id = 2441,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2442] = {
		DynamicRPNExp = "A1/A2>0.1&&A1/A2<=0.5",
		Priority = 200,
		Id = 2442,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2450] = {
		DynamicRPNExp = "A1/A2>0&&A1/A2<=0.5",
		Priority = 50,
		Id = 2450,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2451] = {
		DynamicRPNExp = "A1/A2>0&&A1/A2<=0.5",
		Priority = 100,
		Id = 2451,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2452] = {
		DynamicRPNExp = "A1/A2>0&&A1/A2<=0.5",
		Priority = 200,
		Id = 2452,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2460] = {
		DynamicRPNExp = "A1/A2>0.3&&A1/A2<=0.4",
		Priority = 50,
		Id = 2460,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2461] = {
		DynamicRPNExp = "A1/A2>0.3&&A1/A2<=0.4",
		Priority = 100,
		Id = 2461,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2462] = {
		DynamicRPNExp = "A1/A2>0.3&&A1/A2<=0.4",
		Priority = 200,
		Id = 2462,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2470] = {
		DynamicRPNExp = "A1/A2>0.2&&A1/A2<=0.4",
		Priority = 50,
		Id = 2470,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2471] = {
		DynamicRPNExp = "A1/A2>0.2&&A1/A2<=0.4",
		Priority = 100,
		Id = 2471,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2472] = {
		DynamicRPNExp = "A1/A2>0.2&&A1/A2<=0.4",
		Priority = 200,
		Id = 2472,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2480] = {
		DynamicRPNExp = "A1/A2>0.1&&A1/A2<=0.4",
		Priority = 50,
		Id = 2480,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2481] = {
		DynamicRPNExp = "A1/A2>0.1&&A1/A2<=0.4",
		Priority = 100,
		Id = 2481,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2482] = {
		DynamicRPNExp = "A1/A2>0.1&&A1/A2<=0.4",
		Priority = 200,
		Id = 2482,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2490] = {
		DynamicRPNExp = "A1/A2>0&&A1/A2<=0.4",
		Priority = 50,
		Id = 2490,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2491] = {
		DynamicRPNExp = "A1/A2>0&&A1/A2<=0.4",
		Priority = 100,
		Id = 2491,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2492] = {
		DynamicRPNExp = "A1/A2>0&&A1/A2<=0.4",
		Priority = 200,
		Id = 2492,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2500] = {
		DynamicRPNExp = "A1/A2>0.2&&A1/A2<=0.3",
		Priority = 50,
		Id = 2500,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2501] = {
		DynamicRPNExp = "A1/A2>0.2&&A1/A2<=0.3",
		Priority = 100,
		Id = 2501,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2502] = {
		DynamicRPNExp = "A1/A2>0.2&&A1/A2<=0.3",
		Priority = 200,
		Id = 2502,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2510] = {
		DynamicRPNExp = "A1/A2>0.1&&A1/A2<=0.3",
		Priority = 50,
		Id = 2510,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2511] = {
		DynamicRPNExp = "A1/A2>0.1&&A1/A2<=0.3",
		Priority = 100,
		Id = 2511,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2512] = {
		DynamicRPNExp = "A1/A2>0.1&&A1/A2<=0.3",
		Priority = 200,
		Id = 2512,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2520] = {
		DynamicRPNExp = "A1/A2>0&&A1/A2<=0.3",
		Priority = 50,
		Id = 2520,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2521] = {
		DynamicRPNExp = "A1/A2>0&&A1/A2<=0.3",
		Priority = 100,
		Id = 2521,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2522] = {
		DynamicRPNExp = "A1/A2>0&&A1/A2<=0.3",
		Priority = 200,
		Id = 2522,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2530] = {
		DynamicRPNExp = "A1/A2>0.1&&A1/A2<=0.2",
		Priority = 50,
		Id = 2530,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2531] = {
		DynamicRPNExp = "A1/A2>0.1&&A1/A2<=0.2",
		Priority = 100,
		Id = 2531,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2532] = {
		DynamicRPNExp = "A1/A2>0.1&&A1/A2<=0.2",
		Priority = 200,
		Id = 2532,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2540] = {
		DynamicRPNExp = "A1/A2>0&&A1/A2<=0.2",
		Priority = 50,
		Id = 2540,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2541] = {
		DynamicRPNExp = "A1/A2>0&&A1/A2<=0.2",
		Priority = 100,
		Id = 2541,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2542] = {
		DynamicRPNExp = "A1/A2<=0.2",
		Priority = 200,
		Id = 2542,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2550] = {
		DynamicRPNExp = "A1/A2<=0.1",
		Priority = 50,
		Id = 2550,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2551] = {
		DynamicRPNExp = "A1/A2>0&&A1/A2<=0.1",
		Priority = 100,
		Id = 2551,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[2552] = {
		DynamicRPNExp = "A1/A2>0&&A1/A2<=0.1",
		Priority = 200,
		Id = 2552,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[8001] = {
		DynamicRPNExp = "A1>0&&A2==0",
		Priority = 100,
		Id = 8001,
		DynamicArgType = {
			102,
			103,
			0
		},
		DynamicArgParams = {
			{},
			{
				"5",
				"9811"
			},
			{}
		}
	},
	[32031] = {
		DynamicRPNExp = "A1==0",
		Priority = 999,
		Id = 32031,
		DynamicArgType = {
			101,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"420"
			},
			{},
			{}
		}
	},
	[41031] = {
		Id = 41031,
		Priority = 100,
		DynamicRPNExp = "A1<5",
		DynamicArgType = {
			102,
			0,
			0
		}
	},
	[62011] = {
		DynamicRPNExp = "A1<2",
		Priority = 101,
		Id = 62011,
		DynamicArgType = {
			107,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{},
			{}
		}
	},
	[62012] = {
		DynamicRPNExp = "A1>1",
		Priority = 100,
		Id = 62012,
		DynamicArgType = {
			107,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{},
			{}
		}
	},
	[66011] = {
		DynamicRPNExp = "A1>=1",
		Priority = 300,
		Id = 66011,
		DynamicArgType = {
			103,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"66015010"
			},
			{},
			{}
		}
	},
	[66012] = {
		DynamicRPNExp = "A1>=1",
		Priority = 400,
		Id = 66012,
		DynamicArgType = {
			103,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"66015010"
			},
			{},
			{}
		}
	},
	[10041000] = {
		Id = 10041000,
		Priority = 40,
		DynamicRPNExp = "A1>0",
		DynamicArgType = {
			102,
			0,
			0
		}
	},
	[10271100] = {
		Id = 10271100,
		Priority = 40,
		DynamicRPNExp = "A1>0",
		DynamicArgType = {
			102,
			0,
			0
		}
	},
	[10063000] = {
		DynamicRPNExp = "A1>=0",
		Priority = 100,
		Id = 10063000,
		DynamicArgType = {
			103,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"10062000"
			},
			{},
			{}
		}
	},
	[10333000] = {
		DynamicRPNExp = "A1==0",
		Priority = 100,
		Id = 10333000,
		DynamicArgType = {
			103,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"10333001"
			},
			{},
			{}
		}
	},
	[10343000] = {
		DynamicRPNExp = "A1==0",
		Priority = 100,
		Id = 10343000,
		DynamicArgType = {
			103,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"10343002"
			},
			{},
			{}
		}
	},
	[107101300] = {
		DynamicRPNExp = "A1/A2<=0.3",
		Priority = 50,
		Id = 107101300,
		DynamicArgType = {
			105,
			105,
			0
		},
		DynamicArgParams = {
			{
				"1"
			},
			{
				"8"
			},
			{}
		}
	},
	[201301500] = {
		DynamicRPNExp = "A1>=3",
		Priority = 999,
		Id = 201301500,
		DynamicArgType = {
			103,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"201301502"
			},
			{},
			{}
		}
	},
	[201302500] = {
		DynamicRPNExp = "A1>=4||A2==1",
		Priority = 999,
		Id = 201302500,
		GoalType = 1,
		DynamicArgType = {
			103,
			103,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"201302211"
			},
			{
				"1",
				"201302223"
			},
			{}
		}
	},
	[201303400] = {
		DynamicRPNExp = "A1==1",
		Priority = 999,
		Id = 201303400,
		DynamicArgType = {
			103,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"67012006"
			},
			{},
			{}
		}
	},
	[202301500] = {
		DynamicRPNExp = "A1>=3",
		Priority = 99999,
		Id = 202301500,
		DynamicArgType = {
			103,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"202301402"
			},
			{},
			{}
		}
	},
	[202303300] = {
		DynamicRPNExp = "A1>0&&A2>0",
		Priority = 100,
		Id = 202303300,
		DynamicArgType = {
			102,
			103,
			0
		},
		DynamicArgParams = {
			{},
			{
				"1",
				"202303205"
			},
			{}
		}
	},
	[202303400] = {
		DynamicRPNExp = "A1==1",
		Priority = 200,
		Id = 202303400,
		DynamicArgType = {
			103,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"202303205"
			},
			{},
			{}
		}
	},
	[202303401] = {
		DynamicRPNExp = "A1==1",
		Priority = 300,
		Id = 202303401,
		DynamicArgType = {
			103,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"202303404"
			},
			{},
			{}
		}
	},
	[202304300] = {
		DynamicRPNExp = "A1>0&&A2>0",
		Priority = 100,
		Id = 202304300,
		DynamicArgType = {
			102,
			103,
			0
		},
		DynamicArgParams = {
			{},
			{
				"1",
				"202303205"
			},
			{}
		}
	},
	[203302300] = {
		DynamicRPNExp = "A1==0",
		Priority = 999,
		Id = 203302300,
		DynamicArgType = {
			103,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"203302306"
			},
			{},
			{}
		}
	},
	[203302600] = {
		DynamicRPNExp = "A1>=1",
		Priority = 500,
		Id = 203302600,
		DynamicArgType = {
			103,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"203302602"
			},
			{},
			{}
		}
	},
	[302302500] = {
		DynamicRPNExp = "A1>=1",
		Priority = 999,
		Id = 302302500,
		DynamicArgType = {
			103,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"302302502"
			},
			{},
			{}
		}
	},
	[302303500] = {
		DynamicRPNExp = "A1>=3",
		Priority = 99999,
		Id = 302303500,
		DynamicArgType = {
			103,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"302303402"
			},
			{},
			{}
		}
	},
	[302402500] = {
		DynamicRPNExp = "A1>=4||A2==1",
		Priority = 999,
		Id = 302402500,
		GoalType = 1,
		DynamicArgType = {
			103,
			103,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"302402211"
			},
			{
				"1",
				"302402223"
			},
			{}
		}
	},
	[302305600] = {
		DynamicRPNExp = "A1>=1",
		Priority = 500,
		Id = 302305600,
		DynamicArgType = {
			103,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"302305601"
			},
			{},
			{}
		}
	},
	[401103100] = {
		DynamicRPNExp = "A1>0&&A2==0",
		Priority = 30,
		Id = 401103100,
		DynamicArgType = {
			102,
			103,
			0
		},
		DynamicArgParams = {
			{},
			{
				"1",
				"401103304"
			},
			{}
		}
	},
	[401103300] = {
		DynamicRPNExp = "A2==0",
		Priority = 50,
		Id = 401103300,
		DynamicArgType = {
			0,
			103,
			0
		},
		DynamicArgParams = {
			{},
			{
				"1",
				"401103304"
			},
			{}
		}
	},
	[401103400] = {
		DynamicRPNExp = "A1>0&&A2==1",
		Priority = 30,
		Id = 401103400,
		DynamicArgType = {
			102,
			103,
			0
		},
		DynamicArgParams = {
			{},
			{
				"1",
				"401103304"
			},
			{}
		}
	},
	[401103500] = {
		DynamicRPNExp = "A1>0&&A2==1",
		Priority = 50,
		Id = 401103500,
		DynamicArgType = {
			102,
			103,
			0
		},
		DynamicArgParams = {
			{},
			{
				"1",
				"401103304"
			},
			{}
		}
	},
	[401201300] = {
		DynamicRPNExp = "A1==0",
		Priority = 100,
		Id = 401201300,
		DynamicArgType = {
			103,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"401201300"
			},
			{},
			{}
		}
	},
	[401301310] = {
		DynamicRPNExp = "A1>0&&A2==0",
		Priority = 50,
		Id = 401301310,
		DynamicArgType = {
			102,
			103,
			0
		},
		DynamicArgParams = {
			{},
			{
				"1",
				"401301314"
			},
			{}
		}
	},
	[401301400] = {
		DynamicRPNExp = "A1>0&&A2==0",
		Priority = 50,
		Id = 401301400,
		DynamicArgType = {
			102,
			103,
			0
		},
		DynamicArgParams = {
			{},
			{
				"1",
				"401301312"
			},
			{}
		}
	},
	[401301530] = {
		DynamicRPNExp = "A1==1",
		Priority = 500,
		Id = 401301530,
		DynamicArgType = {
			101,
			0,
			0
		},
		DynamicArgParams = {
			{
				"1",
				"401301202"
			},
			{},
			{}
		}
	}
}

setmetatable(CfgSkillAITable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgSkillAITable]")
	end
})

local defaultMetaTable = {
	__index = {
		DynamicRPNExp = "",
		Priority = 0,
		GoalType = 0,
		DynamicArgType = {
			0,
			0,
			0
		},
		DynamicArgParams = {
			{},
			{},
			{}
		}
	}
}

for i, data in pairs(CfgSkillAITable) do
	setmetatable(data, defaultMetaTable)
end

return CfgSkillAITable
