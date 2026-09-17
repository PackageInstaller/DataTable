return {
	extra = {},
	xpeffect = {},
	attack = {
		{
			{
				operator = ">=",
				method = "random",
				param = {
					num = 5,
					range = 10
				}
			},
			{
				method = "useSkill",
				param = "attack1"
			}
		},
		{
			{
				method = "useSkill",
				param = "attack2"
			}
		}
	},
	attack1 = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				frame = 15,
				id = 10098121
			}
		}
	},
	attack2 = {
		totalframe = 30,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 15,
				id = 10098121
			}
		}
	}
}
