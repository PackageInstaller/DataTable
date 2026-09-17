local var_0_0 = {
	xpeffect = {},
	attack = {
		totalframe = 28,
		animation = "attack",
		exe_tbl = {
			{
				frame = 9,
				id = 22510001,
				effect = {
					{
						ani = "attack",
						name = "22520_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				frame = 12,
				id = 22510001,
				effect = {
					{
						ani = "attack",
						name = "22520_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	xp = {
		{
			{
				method = "useSkill",
				param = "usexp"
			}
		}
	},
	xp1 = {
		{
			{
				method = "useSkill",
				param = "usexp1"
			}
		}
	},
	skill1 = {
		{
			{
				method = "useSkill",
				param = "useskill1"
			}
		}
	},
	useskill1 = {
		totalframe = 50,
		animation = "skill",
		exe_tbl = {
			{
				id = 22520001,
				frame = 14,
				sound = {
					"huiwu_z",
					0.6
				}
			},
			{
				id = 22520001,
				frame = 30,
				sound = {
					"huiwu_z",
					0.6
				}
			}
		}
	},
	usexp = {
		totalframe = 96,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		action_on_start = {
			{
				startframe = 34,
				action = {
					{
						method = "rush_to_target",
						param = {
							frame = 2,
							posx = 100
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 1,
				sound = "xp"
			},
			{
				id = 22530001,
				frame = 36,
				sound = {
					"huiwu_z",
					0.6
				}
			},
			{
				id = 22530002,
				frame = 48,
				sound = {
					"huiwu_z",
					0.6
				}
			},
			{
				frame = 66,
				id = 22530003,
				shake = {
					x = 0,
					y = 6
				},
				sound = {
					"huiwu_z",
					0.6
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 94,
	bgfile = "22500_bg",
	locktarget = {
		locktargetpool = "oponent"
	},
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "BG"
		}
	},
	inserteffect = {
		{
			texture = "role/22520.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	lockframe = {
		{
			totalframe = 3,
			startframe = 36,
			timescale = 0.1
		},
		{
			totalframe = 3,
			startframe = 51,
			timescale = 0.1
		}
	},
	camera = {
		zoom = {
			{
				scale = 1.2,
				totalframe = 30,
				startframe = 10
			},
			{
				scale = 0.8,
				totalframe = 10,
				startframe = 64
			}
		},
		move = {
			{
				pos = "target",
				totalframe = 22,
				startframe = 42,
				time = 0.1
			}
		}
	}
}
var_0_0.usexp1 = {
	totalframe = 96,
	xpeffect = "xp_effect1",
	turnbacklimit = true,
	animation = "xp",
	action_on_start = {
		{
			startframe = 34,
			action = {
				{
					method = "rush_to_target",
					param = {
						frame = 2,
						posx = 100
					}
				}
			}
		}
	},
	exe_tbl = {
		{
			frame = 1,
			sound = "xp"
		},
		{
			id = 22550001,
			frame = 36,
			sound = {
				"huiwu_z",
				0.6
			}
		},
		{
			id = 22550002,
			frame = 48,
			sound = {
				"huiwu_z",
				0.6
			}
		},
		{
			frame = 66,
			id = 22550003,
			shake = {
				x = 0,
				y = 6
			},
			sound = {
				"huiwu_z",
				0.6
			}
		}
	}
}
var_0_0.xpeffect.xp_effect1 = {
	totalframe = 94,
	bgfile = "22500_bg",
	locktarget = {
		locktargetpool = "oponent"
	},
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "BG"
		}
	},
	inserteffect = {
		{
			texture = "role/22520.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	lockframe = {
		{
			totalframe = 3,
			startframe = 36,
			timescale = 0.1
		},
		{
			totalframe = 3,
			startframe = 51,
			timescale = 0.1
		}
	},
	camera = {
		zoom = {
			{
				scale = 1.2,
				totalframe = 30,
				startframe = 10
			},
			{
				scale = 0.8,
				totalframe = 10,
				startframe = 64
			}
		},
		move = {
			{
				distance = 100,
				totalframe = 30,
				startframe = 34,
				time = 0.1
			}
		}
	}
}

return var_0_0
