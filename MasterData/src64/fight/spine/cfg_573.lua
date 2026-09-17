local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 35,
		animation = "attack",
		exe_tbl = {
			{
				id = 77410001,
				frame = 19
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
		totalframe = 35,
		animation = "skill",
		exe_tbl = {
			{
				frame = 23,
				id = 77420001
			}
		}
	},
	usexp = {
		totalframe = 45,
		animation = "xp",
		exe_tbl = {
			{
				frame = 26,
				id = 77430001
			},
			{
				frame = 31,
				id = 77430001
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 45,
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
	},
	camera = {
		move = {
			{
				pos = "target",
				totalframe = 10,
				startframe = 22,
				time = 0.2
			}
		}
	}
}

return var_0_0
