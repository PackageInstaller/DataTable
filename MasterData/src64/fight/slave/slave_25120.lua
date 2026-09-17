return {
	slave_zorder = -1,
	modelconf = {
		passive0 = 251098,
		spine_model = "25120_drones",
		modelheight = 80,
		modelweight = 80,
		modelscale = 1,
		behavior = "ai_25120_slave",
		spinecfg = "cfg_25320_slave",
		slave_attr = {
			max_range = 400,
			range = 300,
			force = 0,
			attackspeed = 1
		},
		slave_attr_fac = {
			damage = 0
		}
	},
	slave_offset = cc.p(0, 0)
}
