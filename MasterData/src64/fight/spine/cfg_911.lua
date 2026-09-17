local var_0_0 = {
	xpeffect = {},
	extra = {},
	attack1 = {
		totalframe = 20,
		animation = "attack1",
		exe_tbl = {
			{
				id = 60210001,
				frame = 10,
				effect = {
					{
						offsetX = 0,
						name = "91100_effect",
						offsetZ = 1,
						offsetY = 0.5,
						method = "target",
						ani = "attack"
					}
				}
			}
		}
	},
	attack2 = {
		totalframe = 20,
		animation = "attack2",
		exe_tbl = {
			{
				id = 60210002,
				frame = 10,
				effect = {
					{
						offsetX = 0,
						name = "91100_effect",
						offsetZ = 1,
						offsetY = 0.5,
						method = "target",
						ani = "attack"
					}
				}
			}
		}
	},
	attack3 = {
		totalframe = 40,
		animation = "attack3",
		exe_tbl = {
			{
				behitted = "hitdown",
				id = 60210003,
				frame = 30,
				effect = {
					{
						offsetX = 0,
						name = "91100_effect",
						offsetZ = 1,
						offsetY = 0.5,
						method = "target",
						ani = "attack"
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
	xp = {
		{
			{
				method = "useSkill",
				param = "usexp"
			}
		}
	},
	useskill1 = {
		totalframe = 25,
		animation = "skill",
		action_on_complete = {
			{
				method = "useSkill",
				param = "useskill2"
			}
		}
	},
	useskill2 = {
		totalframe = 25,
		animation = "skill2",
		action_on_start = {
			{
				startframe = 1,
				action = {
					{
						method = "rush_to_target",
						param = {
							frame = 20,
							posx = -20
						}
					}
				}
			}
		},
		action_on_complete = {
			{
				method = "useSkill",
				param = "useskill3"
			}
		}
	},
	useskill3 = {
		totalframe = 40,
		animation = "skill3",
		exe_tbl = {
			{
				id = 9112001,
				frame = 25,
				effect = {
					{
						offsetX = 0,
						name = "91100_effect",
						offsetZ = 1,
						offsetY = 0.5,
						method = "target",
						ani = "skill"
					}
				}
			}
		}
	}
}

var_0_0.xpeffect.xpeffect = {
	totalframe = 120,
	bgfile = "44000_bg",
	locktarget = {
		locktargetpool = "oponent"
	},
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "BG"
		}
	}
}
var_0_0.usexp = {
	totalframe = 120,
	xpeffect = "xpeffect",
	turnbacklimit = true,
	animation = "xp",
	exe_tbl = {
		{
			frame = 100,
			bullet = "xp"
		}
	}
}
var_0_0.extra.xp = {
	movingani = "xp_run",
	maxdistance = 640,
	movingtype = "locktime",
	speed = 1200,
	offsetZ = 1,
	filename = "91100_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 2,
		object = "self"
	},
	finalpos = {
		offsetY = 0,
		time = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 18,
		animation = "xp",
		exe_tbl = {
			{
				behitted = "hitdown",
				id = 9115001,
				frame = 5,
				forceY = {
					speed = 500
				}
			}
		}
	}
}

return var_0_0
