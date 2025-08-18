-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\ResNewMazeRandEvent.lua

local RT = {}

RT[1] = {
	{
		param_type = 3,
		description = Lang.get(66334),
		param = {
			1
		}
	},
	{
		param_type = 2,
		description = Lang.get(650)
	}
}
RT[2] = {
	1,
	10,
	4000,
	30018
}
RT[3] = {
	1,
	20,
	4000,
	30019
}
RT[4] = {
	1,
	40002
}
RT[5] = {
	param_type = 4,
	description = Lang.get(101864),
	param = {
		1,
		20013
	}
}
RT[6] = {
	param_type = 1,
	description = Lang.get(101865),
	param = {
		1,
		10,
		10000,
		30031
	}
}
RT[7] = {
	1,
	15,
	10000,
	30001
}
RT[8] = {
	param_type = 2,
	description = Lang.get(66801)
}
RT[9] = {
	{
		param_type = 1,
		description = Lang.get(68791),
		param = {
			1,
			40,
			10000,
			10014
		}
	},
	{
		param_type = 5,
		description = Lang.get(68792),
		param = {
			1,
			10014
		}
	},
	{
		param_type = 2,
		description = Lang.get(68793)
	}
}
RT[10] = {
	{
		param_type = 6,
		description = Lang.get(65733),
		lose_desc = Lang.get(61318),
		param = {
			3,
			30019,
			5000,
			1
		},
		wim_desc = Lang.get(61319)
	},
	{
		param_type = 2,
		description = Lang.get(66805),
		lose_desc = Lang.get(66806),
		wim_desc = Lang.get(66807)
	}
}
RT[11] = {
	{
		param_type = 7,
		description = Lang.get(66808),
		param = {
			1,
			5000,
			30030,
			80001
		}
	},
	{
		param_type = 2,
		description = Lang.get(66809)
	}
}
RT[12] = {
	param_type = 2,
	description = Lang.get(75909)
}
RT[13] = {
	{
		param_type = 9,
		description = Lang.get(102780),
		param = {
			20018
		}
	},
	{
		param_type = 1,
		description = Lang.get(102781),
		param = {
			1,
			0,
			10000,
			30014
		}
	}
}

local Data = {
	[1306] = {
		{
			[901] = {
				detail_id = 1306,
				subject_type = 1,
				id = 901,
				times = 3,
				description = Lang.get(64336),
				event_choices = {
					{
						param_type = 1,
						description = Lang.get(66810),
						lose_desc = Lang.get(68678),
						param = {
							3,
							15,
							6000,
							30030
						},
						wim_desc = Lang.get(61301)
					},
					{
						param_type = 2,
						description = Lang.get(66811),
						lose_desc = Lang.get(61302),
						wim_desc = Lang.get(66812)
					}
				},
				name = Lang.get(61326)
			},
			[902] = {
				detail_id = 1306,
				subject_type = 1,
				id = 902,
				times = 1,
				description = Lang.get(65729),
				event_choices = RT[1],
				name = Lang.get(56489)
			},
			[903] = {
				detail_id = 1306,
				subject_type = 1,
				id = 903,
				times = 1,
				description = Lang.get(65730),
				event_choices = {
					{
						param_type = 1,
						description = Lang.get(101868),
						param = RT[2]
					},
					{
						param_type = 1,
						description = Lang.get(101869),
						param = RT[3]
					},
					{
						param_type = 2,
						description = Lang.get(66815)
					}
				},
				name = Lang.get(61329)
			},
			[904] = {
				detail_id = 1306,
				subject_type = 1,
				id = 904,
				times = 1,
				description = Lang.get(66816),
				event_choices = {
					{
						param_type = 4,
						description = Lang.get(61308),
						param = RT[4]
					},
					RT[5]
				},
				name = Lang.get(61331)
			},
			[905] = {
				detail_id = 1306,
				subject_type = 1,
				id = 905,
				times = 1,
				description = Lang.get(61332),
				event_choices = {
					RT[6],
					{
						param_type = 1,
						description = Lang.get(101870),
						param = RT[7]
					},
					RT[8]
				},
				name = Lang.get(61333)
			},
			[906] = {
				detail_id = 1306,
				subject_type = 1,
				id = 906,
				times = 1,
				description = Lang.get(61334),
				event_choices = RT[9],
				name = Lang.get(61335)
			},
			[907] = {
				detail_id = 1306,
				subject_type = 1,
				id = 907,
				times = 3,
				description = Lang.get(64340),
				event_choices = RT[10],
				name = Lang.get(61337)
			},
			[908] = {
				detail_id = 1306,
				subject_type = 1,
				id = 908,
				times = 1,
				description = Lang.get(61338),
				event_choices = RT[11],
				name = Lang.get(6576)
			},
			[909] = {
				detail_id = 1306,
				subject_type = 1,
				id = 909,
				times = 1,
				description = Lang.get(75910),
				event_choices = {
					{
						param_type = 8,
						description = Lang.get(75911),
						param = {
							1,
							2,
							3
						}
					},
					RT[12]
				},
				name = Lang.get(75912)
			},
			[910] = {
				detail_id = 1306,
				subject_type = 1,
				id = 910,
				times = 1,
				description = Lang.get(102782),
				event_choices = RT[13],
				name = Lang.get(102783)
			}
		},
		{
			[901] = {
				detail_id = 1306,
				subject_type = 2,
				id = 901,
				times = 3,
				description = Lang.get(64341),
				event_choices = {
					{
						param_type = 1,
						description = Lang.get(66818),
						lose_desc = Lang.get(68678),
						param = {
							3,
							15,
							5000,
							30030
						},
						wim_desc = Lang.get(64343)
					},
					{
						param_type = 2,
						description = Lang.get(66819),
						lose_desc = Lang.get(61302),
						wim_desc = Lang.get(66812)
					}
				},
				name = Lang.get(64345)
			},
			[902] = {
				detail_id = 1306,
				subject_type = 2,
				id = 902,
				times = 1,
				description = Lang.get(61327),
				event_choices = RT[1],
				name = Lang.get(56489)
			},
			[903] = {
				detail_id = 1306,
				subject_type = 2,
				id = 903,
				times = 1,
				description = Lang.get(68794),
				event_choices = {
					{
						param_type = 1,
						description = Lang.get(68795),
						param = RT[2]
					},
					{
						param_type = 1,
						description = Lang.get(68796),
						param = RT[3]
					},
					{
						param_type = 2,
						description = Lang.get(64349)
					}
				},
				name = Lang.get(64350)
			},
			[904] = {
				detail_id = 1306,
				subject_type = 2,
				id = 904,
				times = 1,
				description = Lang.get(102784),
				event_choices = {
					{
						param_type = 4,
						description = Lang.get(66823),
						param = RT[4]
					},
					RT[5]
				},
				name = Lang.get(64354)
			},
			[905] = {
				detail_id = 1306,
				subject_type = 2,
				id = 905,
				times = 1,
				description = Lang.get(65734),
				event_choices = {
					RT[6],
					{
						param_type = 1,
						description = Lang.get(101872),
						param = RT[7]
					},
					RT[8]
				},
				name = Lang.get(64357)
			},
			[906] = {
				detail_id = 1306,
				subject_type = 2,
				id = 906,
				times = 1,
				description = Lang.get(61334),
				event_choices = RT[9],
				name = Lang.get(61335)
			},
			[907] = {
				detail_id = 1306,
				subject_type = 2,
				id = 907,
				times = 3,
				description = Lang.get(64340),
				event_choices = RT[10],
				name = Lang.get(61337)
			},
			[908] = {
				detail_id = 1306,
				subject_type = 2,
				id = 908,
				times = 1,
				description = Lang.get(61338),
				event_choices = RT[11],
				name = Lang.get(6576)
			},
			[909] = {
				detail_id = 1306,
				subject_type = 2,
				id = 909,
				times = 1,
				description = Lang.get(75910),
				event_choices = {
					{
						param_type = 8,
						description = Lang.get(75911),
						param = {
							4,
							5,
							6
						}
					},
					RT[12]
				},
				name = Lang.get(75912)
			},
			[910] = {
				detail_id = 1306,
				subject_type = 2,
				id = 910,
				times = 1,
				description = Lang.get(102782),
				event_choices = RT[13],
				name = Lang.get(102783)
			}
		}
	}
}

return Data
