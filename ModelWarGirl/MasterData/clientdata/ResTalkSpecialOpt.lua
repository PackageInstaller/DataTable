-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\ResTalkSpecialOpt.lua

local Data = {
	{
		opt_delay = 0.1,
		end_special = "50,2",
		opt_efx = "Effects/UI/efx_Ui_AvgFingeRollTrail.prefab",
		opt_in_anim = "Pen_idle03",
		opt_out_anim = "Pen_idle03",
		notice_efx = "Effects/UI/efx_Ui_AvgFingeRoll.prefab",
		end_anim = "Pen_idle03_over",
		target_npc = 5,
		opt_period = 0.2,
		opt_anim = "Pen_idle02",
		opt_type = 1,
		id = 1,
		wait_end_delay = 1,
		process_step = 0.35,
		efx_pos = {
			0,
			-100
		}
	},
	{
		notice_efx = "Effects/UI/efx_Ui_AvgFingePoint_01.prefab",
		opt_anim = "Click01",
		combo_judge = 0.1,
		id = 2,
		opt_type = 2,
		combo_count = 1,
		target_npc = 30,
		efx_pos = {
			20,
			-85
		}
	},
	{
		notice_efx = "Effects/UI/efx_Ui_AvgFingePoint_02.prefab",
		opt_anim = "Click02",
		combo_judge = 1,
		id = 3,
		opt_type = 2,
		combo_count = 3,
		target_npc = 29,
		efx_pos = {
			-560,
			-85
		}
	}
}

return Data
