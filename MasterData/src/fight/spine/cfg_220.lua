local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack1 = {
		totalframe = 24,
		animation = "attack1",
		exe_tbl = {
			{
				id = 22010001,
				frame = 10,
				effect = {
					{
						ani = "attack",
						name = "22000_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"huiwu",
					0.6
				}
			}
		}
	},
	attack2 = {
		totalframe = 25,
		animation = "attack2",
		exe_tbl = {
			{
				id = 22010001,
				frame = 9,
				effect = {
					{
						ani = "attack",
						name = "22000_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
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
		totalframe = 45,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 14,
				bullet = "skill1",
				sound = {
					"huiwu",
					0.6
				}
			},
			{
				frame = 28,
				bullet = "skill1",
				sound = {
					"huiwu",
					0.6
				}
			},
			{
				frame = 38,
				bullet = "skill1",
				sound = {
					"huiwu",
					0.6
				}
			}
		}
	},
	usexp = {
		totalframe = 99,
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
				frame = 47,
				bullet = "xp"
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 98,
	bgfile = "22000_bg",
	locktarget = {
		locktarget = true
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
			texture = "role/22020.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	lockframe = {
		{
			totalframe = 3,
			startframe = 40,
			timescale = 0.1
		},
		{
			totalframe = 4,
			startframe = 44,
			timescale = 2
		},
		{
			totalframe = 3,
			startframe = 77,
			timescale = 0.1
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.8,
				totalframe = 30,
				startframe = 38
			},
			{
				scale = 0.7,
				totalframe = 5,
				startframe = 70
			}
		},
		move = {
			{
				pos = "target",
				time = 0.1,
				distance = 150,
				totalframe = 60,
				startframe = 38
			}
		}
	}
}
var_0_0.usexp1 = {
	totalframe = 99,
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
			frame = 47,
			bullet = "xp1"
		}
	}
}
var_0_0.xpeffect.xp_effect1 = {
	totalframe = 98,
	bgfile = "22000_bg",
	locktarget = {
		locktarget = true
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
			texture = "role/22020.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	lockframe = {
		{
			totalframe = 3,
			startframe = 40,
			timescale = 0.1
		},
		{
			totalframe = 4,
			startframe = 44,
			timescale = 2
		},
		{
			totalframe = 3,
			startframe = 77,
			timescale = 0.1
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.8,
				totalframe = 30,
				startframe = 38
			},
			{
				scale = 0.7,
				totalframe = 5,
				startframe = 70
			}
		},
		move = {
			{
				pos = "target",
				time = 0.1,
				distance = 150,
				totalframe = 60,
				startframe = 38
			}
		}
	}
}
var_0_0.extra.skill1 = {
	movingani = "skill_run",
	maxdistance = 480,
	movingtype = "lockdirection",
	speed = 1000,
	offsetZ = 1,
	filename = "22000_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		targettype = "oponent",
		crashtype = "once",
		direction = 1
	},
	attack = {
		totalframe = 10,
		animation = "skill_attack",
		exe_tbl = {
			{
				id = 22020001,
				frame = 1,
				sound = {
					"nengliang",
					0.6
				}
			}
		}
	}
}
var_0_0.extra.xp = {
	movingani = "xp_attack",
	maxdistance = 480,
	movingtype = "locktarget",
	speed = 3000,
	offsetZ = 1,
	filename = "22000_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 37,
		animation = "xp_attack",
		exe_tbl = {
			{
				id = 22030001,
				frame = 2,
				shake = {
					x = 2,
					y = 0
				}
			},
			{
				id = 22030001,
				frame = 7,
				shake = {
					x = 2,
					y = 0
				}
			},
			{
				id = 22030001,
				frame = 10,
				shake = {
					x = 2,
					y = 0
				}
			},
			{
				id = 22030001,
				frame = 13,
				shake = {
					x = 2,
					y = 0
				}
			},
			{
				id = 22030001,
				frame = 18,
				shake = {
					x = 2,
					y = 0
				}
			},
			{
				id = 22030001,
				frame = 24,
				shake = {
					x = 6,
					y = 0
				}
			}
		}
	}
}
var_0_0.extra.xp1 = {
	movingani = "xp_attack",
	maxdistance = 480,
	movingtype = "locktarget",
	speed = 3000,
	offsetZ = 1,
	filename = "22000_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 37,
		animation = "xp_attack",
		exe_tbl = {
			{
				id = 22050001,
				frame = 2,
				shake = {
					x = 2,
					y = 0
				}
			},
			{
				id = 22050001,
				frame = 7,
				shake = {
					x = 2,
					y = 0
				}
			},
			{
				id = 22050001,
				frame = 10,
				shake = {
					x = 2,
					y = 0
				}
			},
			{
				id = 22050001,
				frame = 13,
				shake = {
					x = 2,
					y = 0
				}
			},
			{
				id = 22050001,
				frame = 18,
				shake = {
					x = 2,
					y = 0
				}
			},
			{
				id = 22050001,
				frame = 24,
				shake = {
					x = 6,
					y = 0
				}
			}
		}
	}
}

return var_0_0
