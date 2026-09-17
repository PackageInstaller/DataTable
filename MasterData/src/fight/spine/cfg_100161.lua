return {
	attack = {
		totalframe = 20,
		animation = "idle",
		exe_tbl = {
			{
				frame = 0
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
		exe_type = "crash",
		exe_crash_bound = 20,
		exe_crash_type = "carry",
		totalframe = 37,
		animation = "skill",
		action_on_start = {
			{
				startframe = 17,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = 200,
							time = 0.6
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				id = 10016171,
				frame = 18
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
		totalframe = 45,
		animation = "xp",
		exe_tbl = {
			{
				frame = 21,
				id = 10016191,
				shake = {
					x = 4,
					y = 5
				}
			},
			{
				id = 30610003,
				frame = 44
			}
		}
	}
}
