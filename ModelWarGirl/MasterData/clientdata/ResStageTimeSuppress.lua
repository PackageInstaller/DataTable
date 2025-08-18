-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\ResStageTimeSuppress.lua

local RT = {}

RT[1] = {
	max_level = 48,
	min_level = 24,
	suppress_state = 9800091,
	weaken_hour = 0
}
RT[2] = {
	max_level = 72,
	min_level = 48,
	suppress_state = 9800092,
	weaken_hour = 24
}
RT[3] = {
	max_level = 96,
	min_level = 72,
	suppress_state = 9800093,
	weaken_hour = 48
}
RT[4] = {
	{
		max_level = 2,
		min_level = 1,
		suppress_state = 9800081,
		weaken_hour = 0
	},
	{
		max_level = 3,
		min_level = 2,
		suppress_state = 9800082,
		weaken_hour = 1
	},
	{
		max_level = 4,
		min_level = 3,
		suppress_state = 9800083,
		weaken_hour = 2
	},
	{
		max_level = 1000,
		min_level = 4,
		suppress_state = 9800084,
		weaken_hour = 3
	}
}

local Data = {
	{
		suppress_id = 1,
		suppress_group = {
			{
				max_level = 6,
				min_level = 3,
				suppress_state = 9800081,
				weaken_hour = 0
			},
			{
				max_level = 9,
				min_level = 6,
				suppress_state = 9800082,
				weaken_hour = 3
			},
			{
				max_level = 12,
				min_level = 9,
				suppress_state = 9800083,
				weaken_hour = 6
			},
			{
				max_level = 1000,
				min_level = 12,
				suppress_state = 9800084,
				weaken_hour = 9
			}
		}
	},
	{
		suppress_id = 2,
		suppress_group = {
			{
				max_level = 12,
				min_level = 6,
				suppress_state = 9800081,
				weaken_hour = 0
			},
			{
				max_level = 18,
				min_level = 12,
				suppress_state = 9800082,
				weaken_hour = 6
			},
			{
				max_level = 24,
				min_level = 18,
				suppress_state = 9800083,
				weaken_hour = 12
			},
			{
				max_level = 1000,
				min_level = 24,
				suppress_state = 9800084,
				weaken_hour = 18
			}
		}
	},
	{
		suppress_id = 3,
		suppress_group = {
			{
				max_level = 18,
				min_level = 9,
				suppress_state = 9800081,
				weaken_hour = 0
			},
			{
				max_level = 27,
				min_level = 18,
				suppress_state = 9800082,
				weaken_hour = 9
			},
			{
				max_level = 36,
				min_level = 27,
				suppress_state = 9800083,
				weaken_hour = 18
			},
			{
				max_level = 1000,
				min_level = 36,
				suppress_state = 9800084,
				weaken_hour = 27
			}
		}
	},
	{
		suppress_id = 4,
		suppress_group = {
			{
				max_level = 24,
				min_level = 12,
				suppress_state = 9800091,
				weaken_hour = 0
			},
			{
				max_level = 36,
				min_level = 24,
				suppress_state = 9800092,
				weaken_hour = 12
			},
			{
				max_level = 48,
				min_level = 36,
				suppress_state = 9800093,
				weaken_hour = 24
			},
			{
				max_level = 1000,
				min_level = 48,
				suppress_state = 9800094,
				weaken_hour = 36
			}
		}
	},
	{
		suppress_id = 5,
		suppress_group = {
			{
				max_level = 36,
				min_level = 18,
				suppress_state = 9800091,
				weaken_hour = 0
			},
			{
				max_level = 54,
				min_level = 36,
				suppress_state = 9800092,
				weaken_hour = 18
			},
			{
				max_level = 72,
				min_level = 54,
				suppress_state = 9800093,
				weaken_hour = 36
			},
			{
				max_level = 1000,
				min_level = 72,
				suppress_state = 9800094,
				weaken_hour = 54
			}
		}
	},
	{
		suppress_id = 6,
		suppress_group = {
			RT[1],
			RT[2],
			RT[3],
			{
				max_level = 1000,
				min_level = 96,
				suppress_state = 9800094,
				weaken_hour = 72
			}
		}
	},
	{
		suppress_id = 7,
		suppress_group = {
			{
				max_level = 48,
				min_level = 24,
				suppress_state = 9800101,
				weaken_hour = 0
			},
			{
				max_level = 72,
				min_level = 48,
				suppress_state = 9800102,
				weaken_hour = 24
			},
			{
				max_level = 96,
				min_level = 72,
				suppress_state = 9800103,
				weaken_hour = 48
			},
			{
				max_level = 1000,
				min_level = 96,
				suppress_state = 9800104,
				weaken_hour = 72
			}
		}
	},
	{
		suppress_id = 8,
		suppress_group = {
			{
				max_level = 2000,
				min_level = 1000,
				suppress_state = 9800101,
				weaken_hour = 0
			},
			{
				max_level = 3000,
				min_level = 2000,
				suppress_state = 9800102,
				weaken_hour = 1000
			},
			{
				max_level = 4000,
				min_level = 3000,
				suppress_state = 9800103,
				weaken_hour = 2000
			},
			{
				max_level = 8000,
				min_level = 4000,
				suppress_state = 9800104,
				weaken_hour = 3000
			}
		}
	},
	{
		suppress_id = 9,
		suppress_group = RT[4]
	},
	{
		suppress_id = 10,
		suppress_group = RT[4]
	},
	{
		suppress_id = 11,
		suppress_group = {
			{
				max_level = 2,
				min_level = 1,
				suppress_state = 9800061,
				weaken_hour = 0
			},
			{
				max_level = 3,
				min_level = 2,
				suppress_state = 9800062,
				weaken_hour = 1
			},
			{
				max_level = 4,
				min_level = 3,
				suppress_state = 9800063,
				weaken_hour = 2
			},
			{
				max_level = 1000,
				min_level = 4,
				suppress_state = 9800064,
				weaken_hour = 3
			}
		}
	},
	{
		suppress_id = 12,
		suppress_group = {
			{
				max_level = 6,
				min_level = 3,
				suppress_state = 9800061,
				weaken_hour = 0
			},
			{
				max_level = 9,
				min_level = 6,
				suppress_state = 9800062,
				weaken_hour = 3
			},
			{
				max_level = 12,
				min_level = 9,
				suppress_state = 9800063,
				weaken_hour = 6
			},
			{
				max_level = 1000,
				min_level = 12,
				suppress_state = 9800064,
				weaken_hour = 9
			}
		}
	},
	{
		suppress_id = 13,
		suppress_group = {
			{
				max_level = 18,
				min_level = 9,
				suppress_state = 9800061,
				weaken_hour = 0
			},
			{
				max_level = 27,
				min_level = 18,
				suppress_state = 9800062,
				weaken_hour = 9
			},
			{
				max_level = 36,
				min_level = 27,
				suppress_state = 9800063,
				weaken_hour = 18
			},
			{
				max_level = 1000,
				min_level = 36,
				suppress_state = 9800064,
				weaken_hour = 27
			}
		}
	},
	{
		suppress_id = 14,
		suppress_group = {
			{
				max_level = 24,
				min_level = 12,
				suppress_state = 9800081,
				weaken_hour = 0
			},
			{
				max_level = 36,
				min_level = 24,
				suppress_state = 9800082,
				weaken_hour = 12
			},
			{
				max_level = 48,
				min_level = 36,
				suppress_state = 9800083,
				weaken_hour = 24
			},
			{
				max_level = 1000,
				min_level = 48,
				suppress_state = 9800084,
				weaken_hour = 36
			}
		}
	},
	{
		suppress_id = 15,
		suppress_group = {
			{
				max_level = 36,
				min_level = 18,
				suppress_state = 9800071,
				weaken_hour = 0
			},
			{
				max_level = 54,
				min_level = 36,
				suppress_state = 9800072,
				weaken_hour = 18
			},
			{
				max_level = 72,
				min_level = 54,
				suppress_state = 9800073,
				weaken_hour = 36
			},
			{
				max_level = 1000,
				min_level = 72,
				suppress_state = 9800074,
				weaken_hour = 54
			}
		}
	},
	{
		suppress_id = 16,
		suppress_group = {
			{
				max_level = 36,
				min_level = 18,
				suppress_state = 9800081,
				weaken_hour = 0
			},
			{
				max_level = 54,
				min_level = 36,
				suppress_state = 9800082,
				weaken_hour = 18
			},
			{
				max_level = 72,
				min_level = 54,
				suppress_state = 9800083,
				weaken_hour = 36
			},
			{
				max_level = 1000,
				min_level = 72,
				suppress_state = 9800084,
				weaken_hour = 54
			}
		}
	},
	{
		suppress_id = 17,
		suppress_group = {
			{
				max_level = 48,
				min_level = 24,
				suppress_state = 9800081,
				weaken_hour = 0
			},
			{
				max_level = 72,
				min_level = 48,
				suppress_state = 9800082,
				weaken_hour = 24
			},
			{
				max_level = 96,
				min_level = 72,
				suppress_state = 9800083,
				weaken_hour = 48
			},
			{
				max_level = 1000,
				min_level = 96,
				suppress_state = 9800084,
				weaken_hour = 72
			}
		}
	},
	{
		suppress_id = 18,
		suppress_group = {
			{
				max_level = 48,
				min_level = 24,
				suppress_state = 9800071,
				weaken_hour = 0
			},
			{
				max_level = 72,
				min_level = 48,
				suppress_state = 9800072,
				weaken_hour = 24
			},
			{
				max_level = 96,
				min_level = 72,
				suppress_state = 9800073,
				weaken_hour = 48
			},
			{
				max_level = 1000,
				min_level = 96,
				suppress_state = 9800074,
				weaken_hour = 72
			}
		}
	},
	[100] = {
		suppress_id = 100,
		suppress_group = {
			RT[1],
			RT[2],
			RT[3],
			{
				max_level = 10000,
				min_level = 96,
				suppress_state = 9800094,
				weaken_hour = 72
			}
		}
	},
	[200] = {
		suppress_id = 200,
		suppress_group = {
			RT[1],
			{
				max_level = 72,
				min_level = 48,
				suppress_state = 9800092,
				weaken_hour = 0
			},
			{
				max_level = 96,
				min_level = 72,
				suppress_state = 9800093,
				weaken_hour = 24
			},
			{
				max_level = 144,
				min_level = 96,
				suppress_state = 9800094,
				weaken_hour = 48
			},
			{
				max_level = 216,
				min_level = 144,
				suppress_state = 9800095,
				weaken_hour = 72
			},
			{
				max_level = 312,
				min_level = 216,
				suppress_state = 9800096,
				weaken_hour = 96
			},
			{
				max_level = 432,
				min_level = 312,
				suppress_state = 9800097,
				weaken_hour = 144
			},
			{
				max_level = 10000,
				min_level = 432,
				suppress_state = 9800098,
				weaken_hour = 216
			}
		}
	}
}

return Data
