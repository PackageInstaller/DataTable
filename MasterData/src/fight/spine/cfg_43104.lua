local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 22,
		animation = "attack",
		exe_tbl = {
			{
				frame = 6,
				bullet = "attack"
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
	skill1 = {
		{
			{
				method = "useSkill",
				param = "useskill1"
			}
		}
	},
	skill2 = {
		{
			{
				method = "useSkill",
				param = "useskill2"
			}
		}
	},
	useskill1 = {
		totalframe = 35,
		animation = "skill1",
		exe_tbl = {
			{
				id = 43120001,
				frame = 20,
				shake = {
					x = 0,
					y = 2
				},
				effect = {
					{
						ani = "skill",
						name = "21100_effect",
						offsetZ = 0,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	useskill2 = {
		totalframe = 35,
		animation = "skill2",
		exe_tbl = {
			{
				frame = 24,
				bullet = "skill2",
				shake = {
					x = 2,
					y = 0
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 66,
	bgfile = "44000_bg",
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
			texture = "role/43104.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	}
}
var_0_0.usexp = {
	turnbacklimit = true,
	xpeffect = "xp_effect",
	totalframe = 101,
	animation = "xp",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"21100_skill"
			}
		},
		{
			id = 43130001,
			frame = 66,
			shake = {
				x = 0,
				y = 5
			},
			effect = {
				{
					ani = "skill",
					name = "21100_effect",
					offsetZ = 0,
					offsetY = 0,
					offsetX = 0,
					object = "target"
				}
			},
			sound = {
				"21100_heal",
				0.8
			}
		},
		{
			id = 43130001,
			frame = 70,
			shake = {
				x = 0,
				y = 5
			},
			effect = {
				{
					ani = "skill",
					name = "21100_effect",
					offsetZ = 0,
					offsetY = 0,
					offsetX = 0,
					object = "target"
				}
			},
			sound = {
				"21100_heal",
				0.8
			}
		},
		{
			id = 43130001,
			frame = 74,
			shake = {
				x = 0,
				y = 5
			},
			effect = {
				{
					ani = "skill",
					name = "21100_effect",
					offsetZ = 0,
					offsetY = 0,
					offsetX = 0,
					object = "target"
				}
			},
			sound = {
				"21100_heal",
				0.8
			}
		},
		{
			id = 43130001,
			frame = 78,
			shake = {
				x = 0,
				y = 5
			},
			effect = {
				{
					ani = "skill",
					name = "21100_effect",
					offsetZ = 0,
					offsetY = 0,
					offsetX = 0,
					object = "target"
				}
			},
			sound = {
				"21100_heal",
				0.8
			}
		},
		{
			id = 43130001,
			frame = 82,
			shake = {
				x = 0,
				y = 5
			},
			effect = {
				{
					ani = "skill",
					name = "21100_effect",
					offsetZ = 0,
					offsetY = 0,
					offsetX = 0,
					object = "target"
				}
			},
			sound = {
				"21100_heal",
				0.8
			}
		},
		{
			id = 43130001,
			frame = 86,
			shake = {
				x = 0,
				y = 5
			},
			effect = {
				{
					ani = "skill",
					name = "21100_effect",
					offsetZ = 0,
					offsetY = 0,
					offsetX = 0,
					object = "target"
				}
			},
			sound = {
				"21100_heal",
				0.8
			}
		},
		{
			id = 43130001,
			frame = 90,
			shake = {
				x = 0,
				y = 5
			},
			effect = {
				{
					ani = "skill",
					name = "21100_effect",
					offsetZ = 0,
					offsetY = 0,
					offsetX = 0,
					object = "target"
				}
			},
			sound = {
				"21100_heal",
				0.8
			}
		}
	}
}
var_0_0.extra.attack = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 800,
	offsetZ = 1,
	filename = "43104_effect",
	initpos = {
		offsetY = 0.45,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.45,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 10,
		animation = "attack",
		exe_tbl = {
			{
				frame = 4,
				id = 43110001,
				force = {
					{
						time = 0.05,
						shutdown = false,
						distance = 10,
						object = "target"
					}
				}
			}
		}
	}
}
var_0_0.extra.skill2 = {
	movingani = "skill_run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 800,
	offsetZ = 1,
	filename = "43104_effect",
	initpos = {
		offsetY = 0.45,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.45,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 10,
		animation = "attack",
		exe_tbl = {
			{
				frame = 4,
				id = 43121001,
				force = {
					{
						time = 0.05,
						shutdown = false,
						distance = 10,
						object = "target"
					}
				}
			}
		}
	}
}

return var_0_0
