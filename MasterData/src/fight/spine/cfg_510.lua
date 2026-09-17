return {
	extra = {},
	attack = {
		totalframe = 20,
		animation = "attack",
		exe_tbl = {
			{
				frame = 10,
				id = 51010001,
				force = {
					{
						time = 0.1,
						shutdown = false,
						distance = 50,
						object = "target"
					}
				},
				sound = {
					"fire1",
					0.3
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
	usexp = {
		totalframe = 10,
		nextani = true,
		animation = "xp",
		action_on_complete = {
			{
				method = "useSkill",
				param = "xp_attack"
			}
		},
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"xp",
					0.4
				}
			}
		}
	},
	xp_attack = {
		totalframe = 27,
		turnbacklimit = true,
		animation = "xp2",
		exe_tbl = {
			{
				frame = 19,
				id = 51030001,
				shake = {
					x = 2,
					y = 2
				},
				sound = {
					"boom",
					0.3
				}
			}
		}
	}
}
