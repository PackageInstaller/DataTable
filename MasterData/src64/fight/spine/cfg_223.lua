local var_0_0 = {
	xpeffect = {},
	attack = {
		totalframe = 34,
		animation = "attack",
		exe_tbl = {
			{
				id = 22310001,
				frame = 14,
				sound = {
					"huiwu",
					0.6
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
		turnbacklimit = true,
		totalframe = 47,
		animation = "skill",
		action_on_start = {
			{
				startframe = 17,
				action = {
					{
						method = "rush_to_target",
						param = {
							frame = 2,
							posx = 80
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				behitted = "hitdown",
				id = 22320001,
				frame = 23,
				shake = {
					x = 2,
					y = 2
				},
				sound = {
					"huiwu",
					0.6
				}
			}
		}
	},
	usexp = {
		totalframe = 78,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"xp",
					0.6
				}
			},
			{
				frame = 54,
				id = 22330001,
				shake = {
					x = 2,
					y = 2
				},
				sound = {
					"nengliang",
					0.6
				}
			},
			{
				frame = 56,
				id = 22330001,
				shake = {
					x = 2,
					y = 2
				},
				sound = {
					"nengliang",
					0.6
				}
			},
			{
				frame = 58,
				id = 22330001,
				shake = {
					x = 2,
					y = 2
				},
				sound = {
					"nengliang",
					0.6
				}
			},
			{
				frame = 60,
				id = 22330001,
				shake = {
					x = 2,
					y = 2
				},
				sound = {
					"nengliang",
					0.6
				}
			},
			{
				frame = 62,
				id = 22330001,
				shake = {
					x = 2,
					y = 2
				},
				sound = {
					"nengliang",
					0.6
				}
			},
			{
				frame = 64,
				id = 22330001,
				shake = {
					x = 2,
					y = 2
				},
				sound = {
					"nengliang",
					0.6
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	focusoffset = 150,
	initpos = -150,
	bgfile = "44000_bg",
	totalframe = 77,
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
			texture = "role/22320.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	lockframe = {
		{
			totalframe = 5,
			startframe = 55,
			timescale = 0.15
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.8,
				totalframe = 22,
				startframe = 48
			}
		},
		move = {
			{
				distance = 50,
				totalframe = 27,
				startframe = 43,
				time = 0.1
			}
		}
	}
}
var_0_0.usexp1 = {
	totalframe = 78,
	xpeffect = "xp_effect1",
	turnbacklimit = true,
	animation = "xp",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"xp",
				0.6
			}
		},
		{
			frame = 54,
			id = 22350001,
			shake = {
				x = 2,
				y = 2
			},
			sound = {
				"nengliang",
				0.6
			}
		},
		{
			frame = 56,
			id = 22350001,
			shake = {
				x = 2,
				y = 2
			},
			sound = {
				"nengliang",
				0.6
			}
		},
		{
			frame = 58,
			id = 22350001,
			shake = {
				x = 2,
				y = 2
			},
			sound = {
				"nengliang",
				0.6
			}
		},
		{
			frame = 60,
			id = 22350001,
			shake = {
				x = 2,
				y = 2
			},
			sound = {
				"nengliang",
				0.6
			}
		},
		{
			frame = 62,
			id = 22350001,
			shake = {
				x = 2,
				y = 2
			},
			sound = {
				"nengliang",
				0.6
			}
		},
		{
			frame = 64,
			id = 22350001,
			shake = {
				x = 2,
				y = 2
			},
			sound = {
				"nengliang",
				0.6
			}
		}
	}
}
var_0_0.xpeffect.xp_effect1 = {
	focusoffset = 150,
	initpos = -150,
	bgfile = "44000_bg",
	totalframe = 77,
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
			texture = "role/22320.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	lockframe = {
		{
			totalframe = 5,
			startframe = 55,
			timescale = 0.15
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.8,
				totalframe = 22,
				startframe = 48
			}
		},
		move = {
			{
				distance = 50,
				totalframe = 27,
				startframe = 43,
				time = 0.1
			}
		}
	}
}

return var_0_0
