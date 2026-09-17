local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				id = 60056021,
				frame = 22,
				effect = {
					{
						ani = "attack",
						name = "600560_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0.8,
						object = "target"
					}
				}
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
		totalframe = 30,
		animation = "skill1",
		action_on_start = {
			{
				startframe = 0,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = 600,
							time = 1
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 1,
				id = 60056032
			},
			{
				frame = 17,
				id = 60056031
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
	useskill2 = {
		totalframe = 30,
		animation = "skill2",
		exe_tbl = {
			{
				frame = 1,
				id = 60056032
			},
			{
				frame = 12,
				bullet = "skill2"
			},
			{
				frame = 18,
				bullet = "skill2"
			}
		}
	}
}

var_0_0.extra.skill2 = {
	movingani = "run",
	maxdistance = 1000,
	movingtype = "locktarget",
	speed = 600,
	offsetZ = 1,
	filename = "600520_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 15,
		animation = "skill",
		exe_tbl = {
			{
				id = 60056041,
				behitted = "hitdown",
				frame = 1
			}
		}
	}
}
var_0_0.xp = {
	{
		{
			method = "useSkill",
			param = "usexp"
		}
	}
}
var_0_0.usexp = {
	totalframe = 40,
	xpeffect = "xp_effect",
	animation = "xp",
	exe_tbl = {
		{
			frame = 1,
			id = 60056032
		},
		{
			id = 60056061,
			frame = 15,
			force = {
				{
					shotdown = false,
					time = 0.1,
					distance = 100,
					object = "target"
				}
			},
			effect = {
				{
					ani = "attack",
					name = "100200_effect",
					offsetZ = 1,
					offsetY = 0,
					offsetX = 1,
					object = "target"
				}
			}
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	totalframe = 40,
	bgfile = "20120_bg",
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
	lockframe = {
		{
			totalframe = 21,
			startframe = 10,
			timescale = 0.5
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.75,
				totalframe = 78,
				startframe = 10
			}
		},
		move = {
			{
				distance = 250,
				totalframe = 55,
				startframe = 10,
				time = 0.3
			}
		}
	}
}

return var_0_0
