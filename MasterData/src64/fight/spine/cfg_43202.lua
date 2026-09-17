local var_0_0 = {
	xpeffect = {},
	attack = {
		totalframe = 23,
		animation = "attack",
		exe_tbl = {
			{
				id = 43210001,
				frame = 7,
				effect = {
					{
						ani = "attack",
						name = "43202_effect",
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
		totalframe = 42,
		animation = "skill1",
		exe_tbl = {
			{
				id = 43220001,
				frame = 7,
				effect = {
					{
						ani = "skill_attack1",
						name = "43202_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				frame = 26,
				id = 43220002,
				effect = {
					{
						ani = "skill_attack2",
						name = "43202_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	useskill2 = {
		totalframe = 60,
		animation = "skill2",
		exe_tbl = {
			{
				frame = 10,
				id = 43221001
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 64,
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
			texture = "role/43202.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	lockframe = {
		{
			totalframe = 3,
			startframe = 45,
			timescale = 0.1
		},
		{
			totalframe = 1,
			startframe = 50,
			timescale = 0.3
		},
		{
			totalframe = 1,
			startframe = 52,
			timescale = 0.3
		},
		{
			totalframe = 1,
			startframe = 54,
			timescale = 0.3
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.8,
				totalframe = 30,
				startframe = 30
			}
		},
		move = {
			{
				pos = "target",
				totalframe = 30,
				startframe = 30,
				time = 0.1
			}
		}
	}
}
var_0_0.usexp = {
	totalframe = 65,
	xpeffect = "xp_effect",
	animation = "xp",
	exe_tbl = {
		{
			frame = 1,
			sound = "20600_skill"
		},
		{
			id = 43230001,
			sound = "20120_skill",
			frame = 50,
			effect = {
				{
					ani = "attack",
					name = "43201_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			},
			shake = {
				x = 0,
				y = 4
			},
			force = {
				{
					time = 0.05,
					shutdown = false,
					distance = 100,
					object = "target"
				}
			}
		},
		{
			id = 43230001,
			sound = "20120_skill",
			frame = 52,
			effect = {
				{
					ani = "attack",
					name = "43201_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			},
			shake = {
				x = 0,
				y = 4
			},
			force = {
				{
					time = 0.05,
					shutdown = false,
					distance = 100,
					object = "target"
				}
			}
		},
		{
			id = 43230001,
			sound = "20120_skill",
			frame = 54,
			effect = {
				{
					ani = "attack",
					name = "43201_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			},
			shake = {
				x = 0,
				y = 4
			},
			force = {
				{
					time = 0.05,
					shutdown = false,
					distance = 100,
					object = "target"
				}
			}
		}
	}
}

return var_0_0
